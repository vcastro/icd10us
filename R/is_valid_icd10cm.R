#' Check if an ICD-10-CM code is in a valid format
#'
#' @description
#' `is_valid_icd10cm` checks to see if the ICD-10-CM code is valid
#' and has between 3 and 8 characters, and starts with a letter and number.
#'
#' @param x A string
#'
#' @return Boolean
#' @export
#'
#' @examples
#' is_valid_icd10cm("F320") # valid
#' is_valid_icd10cm("F32")  # valid
#' is_valid_icd10cm("296")  # invalid
#'
is_valid_icd10cm <- function(x) {

  dplyr::case_when(
    stringr::str_length(x) < 3 ~ FALSE, # has at least 3 characters
    stringr::str_length(x) > 8 ~ FALSE, # has less than 8 characters (incl dot)
    !stringr::str_starts(x, "[A-Z][0-9]") ~ FALSE, # starts with letter & number
    stringr::str_count(x, "[0-9]") < 1 ~ FALSE, # has at least 1 number
    TRUE ~ TRUE
  )
}
