
#' Install nltk if you don't have it
#'
#' While reticulate is capable of binding to any Python environment available on
#' a system, it’s much more straightforward for users if there is a common
#' environment used by R packages with convenient high-level functions provided
#' for installation. We therefore strongly recommend that R package developers
#' use the approach described here.
#'
#' https://rstudio.github.io/reticulate/articles/package.html#installing-python-dependencies
#'
#' @param method the method
#' @param conda the conda environment
#'
#' @export
#'
install_nltk <- function(method = "auto", conda = "auto") {
  reticulate::py_install("nltk", method = method, conda = conda)
}


# global reference to scipy (will be initialized in .onLoad)
synsets <- NULL


# .onLoad <- function(libname, pkgname) {
#   # use superassignment to update global reference to scipy
#   synsets <<- reticulate::import("nltk", delay_load = TRUE)$wordnet$wordnet$synsets
# }






#' Get translations of individual words from nltk
#'
#' This will match up to 4 meanings where the requested word and part of speech match.
#' The first 2 results from each meaning-set are returned, then the first four unique
#' translations are selected. This means there is a fairly strong tendency towards the
#' most common two or three synsets. For more information on synsets, see the
#' Open Multilingual Wordnet documentation.
#'
#' @param token an English word to pass to nltk's synset search
#' @param part_of_speech one of "v" -verb, "a" - adjective, "n" - noun, or "r" - adverb
#' @param language check the list of options with wordlists::ntlk_languages. Defaults to japanese
#'
#' @return a character vector of length one
#' @export
#'
get_translation <-  function(token, part_of_speech, language = "jpn"){
  # get the first two lemmas of a given language
  # for every synset that contains the token and matches the part_of_speech
  if(!language %in% word.lists::nltk_languages$lang){
    stop(
    glue::glue("Language not available.
    Available languages are:
    {stringr::str_flatten(word.lists::nltk_languages$lang, collapse = ' || ')}"))
  }

  if(length(synsets(token, pos = part_of_speech)) == 0) {
    NA_character_
  } else{
    purrr::map(
      1:length(synsets(token, pos = part_of_speech)) ,
      ~synsets(token, pos = part_of_speech)[[.x]]$lemma_names(lang = language)[1:2]
    ) %>%
      # lose anything that did not return a value
      # return the top four unique entries
      # lose all results with capitals (they are probably unwanted proper nouns)
      purrr::discard(is.null) %>%
      unlist() %>%
      unique() %>%
      stringr::str_remove("[A-Z].+") %>%
      dplyr::na_if("") %>%
      purrr::discard(is.na) %>%
      utils::head(4) %>%
      stringr::str_flatten(collapse = " || ") %>%
      stringr::str_replace_all("_", " ")
  }
}

#' Get English definitions of individual words from nltk
#'
#' This will match up to 3 meanings where the requested word and part of speech match.
#' For more information on synsets, see the
#' Open Multilingual Wordnet documentation.
#'
#' @param token an English word to pass to nltk's synset search
#' @param part_of_speech one of "v" -verb, "a" - adjective, "n" - noun, or "r" - adverb
#'
#' @return a character vector of length one, with definitions separated by ";\n"
#' @export
#'
get_definition <- function(token, part_of_speech){

  if(length(synsets(token, pos = part_of_speech)) == 0) {
    NA_character_
  } else{
    purrr::map(
      1:length(synsets(token, pos = part_of_speech)) ,
      ~synsets(token, pos = part_of_speech)[[.x]]$definition()
    ) %>%
      # lose anything that did not return a value
      # return the top four unique entries
      # lose all results with capitals (they are probably unwanted proper nouns)
      purrr::discard(is.null) %>%
      unlist() %>%
      unique() %>%
      stringr::str_remove("(?=;).+") %>%
      dplyr::na_if("") %>%
      purrr::discard(is.na) %>%
      utils::head(3) %>%
      stringr::str_flatten(collapse = ";\n ") %>%
      stringr::str_replace_all("_", " ")
  }
}


#' Make wordlists from udpiped dataframes
#'
#' This will add the first four unique translations that match the words and pos provided.
#' Anything that is not a verb, adjective, noun, or adverb will return blanks, as will anything
#' that does not have a translation in OMW for the language requested.
#' It will not look for proper nouns; udpipe does a great job of parsing pos, with the exception of Title Case.
#' Consider pre-processing if you have a lot of Title Case.
#' This is intended to be used in conjunction with the word frequency lists to aid in building wordlists for ESL teachers.
#'
#' @param data a dataframe containing doc_id, sentence_id, token_id, token, lemma, upos. Should be piped from udpipe.
#' @param language three-character abbreviation of language to find translations for. Refer to `wordlists::nltk_languages`.
#' @param def TRUE will add a definition column, anything else will leave it out. Defaults to TRUE
#'
#' @return a dataframe
#' @export
#'
get_wordlist <- function(data, language, def = TRUE){

  pos_trans <- tibble::tribble(
    ~upos, ~pos,
    "AUX",  "v",
    "ADJ",  "a",
    "NOUN",  "n",
    "VERB",  "v",
    "ADV",  "r"
  )

  base <- data %>%
    dplyr::select(doc_id, sentence_id, token_id, token, lemma, upos) %>%
    dplyr::left_join(pos_trans)

  nope <- base %>%
    dplyr::filter(is.na(pos))

  yep <- base %>%
    dplyr::filter(!is.na(pos))

  res <- yep %>%
    dplyr::mutate(translation = purrr::map2_chr(token, pos, ~get_translation(.x, .y, lang = language)))

  if (def == TRUE){
    res <- res %>%
      dplyr::mutate(definition = purrr::map2_chr(token, pos, ~get_definition(.x, .y)))
  }

  res %>%
    dplyr::bind_rows(nope) %>%
    dplyr::mutate(token_id = as.numeric(token_id)) %>%
    dplyr::arrange(doc_id, sentence_id, token_id) %>%
    dplyr::filter(upos != "PUNCT")
}


