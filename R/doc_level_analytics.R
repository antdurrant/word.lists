#' get document level analytics
#'
#' for things that can't be done with `udpipe()` output
#' this is very much a WIP
#'
#' @param data a dataframe with entire texts in one column
#' @param text_col the column with the texts in
#'
#' @return
#' @export
#'
doc_level_analytics <- function(data, text_col = text){

  safe_formal <- purrr::possibly(qdap::formality, otherwise = list(formality = list(formality = NA_real_)))
  formality <-
    data %>%
    dplyr::mutate(formality = purrr::map_dbl({{text_col}}, ~safe_formal(.x, order.by.formality = FALSE)$formality$formality))

  formality
}
