
#' Replace common off-list words
#'
#' @param data output of `udpipe()`
#' @param groups dataframe of words/lemmas with vocab groups attatched
#'
#' @return a dataframe of words not on the list
#' @export
#'
replace_off_list <- function(data, groups){

  lemma<-
    upos<-
    token<-



 if(!"word_e" %in% colnames(groups)) groups <- groups %>% dplyr::rename(word_e = lemma)


off <- data %>%
  dplyr::filter(upos != "PROPN" & upos != "PUNCT" & upos != "PART" & upos != "NUM") %>%
  dplyr::anti_join(groups, by = c("lemma" = "word_e")) %>%
  dplyr::mutate(token = stringr::str_to_lower(token)) %>%
  dplyr::mutate(token = stringr::str_replace(token, "breek", "bring")) %>%
  dplyr::anti_join(groups, by = c("token" = "word_e")) %>%
  dplyr::mutate(token1= str_replace(token, "ie[r|s]$", "y"),
         token1 = stringr::str_remove(token1, "s$")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove(token1, "r$")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove(token, "er$"),
         token1 = stringr::str_remove(token1, "es$"),
         token1 = stringr::str_remove(token1, "ing$")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = str_replace(token, "ing$", "e")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove(token, "d$")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove(token, "ed$")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove(token, "est$")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove(token, "^un")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove(token, "^un")) %>%
  dplyr::mutate(token1 = stringr::str_remove(token1, "ed$")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove_all(token, "[^A-Za-z]")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = str_replace(token, "ably$", "able")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove(lemma, "-")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::mutate(token1 = stringr::str_remove(lemma, "ly")) %>%
  dplyr::anti_join(groups, by = c("token1" = "word_e")) %>%
  dplyr::filter(stringr::str_detect(lemma, "..")) %>%
  dplyr::filter(stringr::str_detect(lemma, "[A-Za-z]")) %>%
  dplyr::filter(lemma != "would" & lemma != "cause") %>%
  dplyr::filter(!stringr::str_detect(token, "ans?$") & upos != "ADJ") %>%
  dplyr::filter(token != "chosen" & token != "drawn") %>%
  dplyr::filter(lemma != "'s") %>%
  dplyr::filter(!stringr::str_detect(lemma, "\\.")) %>%
  dplyr::filter(upos != "X") %>%
  dplyr::filter(!stringr::str_detect(token, "self|selves")) %>%
  dplyr::filter(lemma != "internet") %>%
  dplyr::filter(!stringr::str_detect(lemma, "[0-9]")) %>%
  dplyr::filter(!stringr::str_detect(lemma, "[A-Z]")) %>%
  dplyr::filter(stringr::str_detect(lemma, "....")) %>%
  dplyr::filter(token != "brought")


}

#' get basic text analytics
#'
#' use udpipe's pos and dependency parsing to get some basic analytics on texts
#'
#' @param data output of `udpipe()`
#' @param group_list dataframe of words/lemmas with vocab groups attatched
#' @param off_list if true, `replace_off_list()` will be called on `data` and `group_list`
#'
#' @return
#' @export
#'
piped_text_analytics <- function(data, group_list, off_list = TRUE ) {

  text<-
    upos<-
    doc_id<-
    token<-
    sentence_id<-
    sentence_count<-
    group<-
    piped_dif<-
    piped_wc<-
    piped_DM<-
    n<-
    feats<-
    lemma<-
    head_token_id<-
    sentence<-
    paragraph_id<-
    fk<-
    cl<-
    ari<-




  piped <- data

  if(off_list) off_list <- replace_off_list(data = piped, groups = group_list)

  word_count <- piped %>%
    dplyr::filter(upos != "PUNCT")  %>%
    dplyr::group_by(doc_id) %>%
    dplyr::summarise(word_count = dplyr::n(),
              char_count = sum(nchar(token)),
              sentence_count = max(sentence_id),
              avg_sentence_length = word_count/sentence_count
    )

  dm <- piped %>%
    dplyr::filter(upos != "PUNCT") %>%
    dplyr::left_join(group_list, by = c("lemma" = "word_e")) %>%
    dplyr::mutate(group = dplyr::if_else(is.na(group), 1, group)) %>%
    dplyr::group_by(doc_id, sentence_id) %>%
    dplyr::summarise (piped_dif = mean(group, na.rm = TRUE),
               piped_wc = (dplyr::n()),
               piped_DM = piped_dif^3*piped_wc) %>%
    dplyr::group_by(doc_id) %>%
    dplyr::summarise(avg_sentence_difficulty = mean(piped_DM))

  verbs <- piped %>%
    dplyr::group_by(doc_id) %>%
    dplyr::filter(upos == "VERB") %>%
    dplyr::count(doc_id, sentence_id) %>%
    dplyr::summarise(verbs_per_sentence = mean(n)
    )

  # irreg_verbs <- piped %>%
  #   dplyr::group_by(doc_id) %>%
  #   dplyr::filter(upos == "VERB" & stringr::str_detect(feats, "Tense=Past")) %>%
  #   dplyr::distinct(doc_id, sentence_id) %>%
  #   dplyr::summarise(irreg_verbs_per_passage = dplyr::n(),
  #             #   irreg_verbs_per_sentence = verbs_per_passage/max(sentence_id)
  #   )

  aux <- piped %>%
    dplyr::group_by(doc_id) %>%
    dplyr::filter(upos == "AUX" & lemma != "be") %>%
    dplyr::summarise(aux_per_passage = dplyr::n(),
              #   aux_per_sentence = aux_per_passage/max(sentence_id)
    )

  passives <- piped %>%
    dplyr::group_by(doc_id) %>%
    dplyr::filter(stringr::str_detect(feats, "Voice=Pass")) %>%
    dplyr::summarise(passives_per_passage = dplyr::n(),
              #   passives_per_sentence = passives_per_passage/max(sentence_id)
    )


  connectives <- piped %>%
    dplyr::group_by(doc_id) %>%
    dplyr::filter(upos == "CCONJ") %>%
    dplyr::summarise(con_conj_per_passage = dplyr::n(),
              #   con_conj_per_sentence = con_conj_per_passage/max(sentence_id)
    )

  subordinates <- piped %>%
    dplyr::group_by(doc_id) %>%
    dplyr::filter(upos == "SCONJ") %>%
    dplyr::summarise(sub_conj_per_passage = dplyr::n(),
              #  sub_conj_per_sentence = sub_conj_per_passage/max(sentence_id)
    )


  interrogatives <- piped %>%
    dplyr::group_by(doc_id) %>%
    dplyr::filter(stringr::str_detect(feats, "PronType=Int")) %>%
    dplyr::summarise(interrogatives_per_passage = dplyr::n(),
              #   interrogatives_per_sentence = interrogatives_per_passage/max(sentence_id)
    )

  rel_prons <-  piped %>%
    dplyr::group_by(doc_id) %>%
    dplyr::filter(stringr::str_detect(feats, "PronType=Rel")) %>%
    dplyr::summarise(rel_prons_per_passage = dplyr::n(),
              #   rel_prons_per_sentence = rel_prons_per_passage/max(sentence_id)
    )


  clusters <- piped %>%
    dplyr::group_by(doc_id) %>% dplyr::add_count(doc_id, sentence_id, head_token_id) %>%
    dplyr::filter(n>1) %>%
    dplyr::select(-n) %>%
    dplyr::distinct(doc_id, sentence_id, head_token_id, .keep_all = TRUE) %>%
    dplyr::count(doc_id, sentence_id) %>%
    dplyr::summarise(word_clusters_per_sentence = mean(n)
    )

  off <- off_list %>%
    dplyr::group_by(doc_id) %>%
    dplyr::summarise(off_list_per_passage = dplyr::n()
    )


  # getting this to be safe has been a pain
  fk_safe <- purrr::possibly(qdap::flesch_kincaid, otherwise = list(Readability = list(all = "all", FK_read.ease = NA_real_)))
  cl_safe <- purrr::possibly(qdap::coleman_liau, otherwise =  list(Readability =list(all = "all", Coleman_Liau = NA_real_)))
  ari_safe <- purrr::possibly(qdap::automated_readability_index, otherwise =  list(Readability =list(all = "all", Automated_Readability_Index = NA_real_)))

  readability <-
    piped %>%
    dplyr::distinct(doc_id, paragraph_id, sentence_id, sentence) %>%
    dplyr::group_by(doc_id) %>%
    dplyr::mutate(fk = purrr::map_dbl(sentence, ~fk_safe(.x)$Readability$FK_read.ease),
           cl = purrr::map_dbl(sentence, ~cl_safe(.x)$Readability$Coleman_Liau),
           ari = purrr::map_dbl(sentence, ~ari_safe(.x)$Readability$Automated_Readability_Index)) %>%
    dplyr::summarise(flesh_kincaid = mean(fk, na.rm = TRUE),
              coleman_liau = mean(cl, na.rm = TRUE),
              automated_readability_index = mean(ari, na.rm = TRUE))




  Reduce(function(x,y) dplyr::full_join(x = x, y = y, by = "doc_id"),
         list(word_count,
              dm,
              verbs,
              # irreg_verbs,
              passives,
              aux,
              interrogatives,
              rel_prons,
              subordinates,
              connectives,
              clusters,
              readability,
              off))


}


