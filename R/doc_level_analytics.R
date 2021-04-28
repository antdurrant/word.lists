#' get document level analytics
#'
#' for things that can't be done with `udpipe()` output
#'
#' @param data a dataframe with entire texts in one column
#' @param text_col the column with the texts in
#'
#' @return
#' @export
#'
#' @examples
doc_level_analytics <- function(data, text_col = text){

  formality <-
    data %>%
    dplyr::mutate(formality = purrr::map_dbl({{text_col}}, ~qdap::formality(.x, order.by.formality = FALSE)$formality$formality))

  formality
}
