#' List all codes between two sets of codes
#'
#' @description
#' `expand_code` returns a tibble of all ICD-10-CM codes that
#' are child codes of the provided code.
#'
#' @param x a valid ICD-10-CM code
#'
#' @return Tibble of all matching ICD-10-CM rows from icd10cm
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' expand_code("F32")
expand_code <- function(x) {

  icd10us::icd10cm %>%
    dplyr::filter(stringr::str_starts(.data$icd10cm_code, x))

}
