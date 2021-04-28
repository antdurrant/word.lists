#' Add off-list groups to generated word-lists
#'
#' Provides "number", "proper-noun", "pronoun", & "off-list" groupings for words that do not appear in the word lists you are using as a reference.
#' This should be used after producing wordlists with `word.lists::get_wordlists`, `tidytext::unnest_tokens` etc. AND
#' joining it to a word list with `lemma` and `group` variables
#'
#' @param data
#'
#' @return a dataframe with a mutated group variable
#' @export
#'
add_off_list_groups <- function(data){
  data %>%
    dplyr::mutate(group = dplyr::case_when(
      is.na(group) & stringr::str_detect(lemma, "[0-9]") ~ "NUMBER",
      is.na(group) & upos == "PROPN"                     ~ "PROPER-NOUN",
      is.na(group) & upos == "PRON"                      ~ "PRONOUN",
      is.na(group)                                       ~ "OFF-LIST",
      TRUE                                               ~ as.character(group))
    )
}
