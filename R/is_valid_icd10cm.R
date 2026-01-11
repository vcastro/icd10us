#' Check if a string is a valid ICD-10-CM code format
#'
#' @description
#' `is_valid_icd10cm()` checks to see if a string conforms to the valid
#' format for an ICD-10-CM code. This validates the structure but does not
#' check if the code exists in the official code set.
#' 
#' A valid ICD-10-CM code must:
#' * Have between 3 and 8 characters (including optional dot)
#' * Start with a letter (A-Z)
#' * Have the second character be a number (0-9)
#' * Contain at least one number overall
#'
#' @param x A string to validate
#'
#' @return Logical value: TRUE if the format is valid, FALSE otherwise
#' 
#' @details
#' This function only validates the format/structure of an ICD-10-CM code.
#' It does not verify that the code exists in the official code set. To check
#' if a code actually exists, filter the `icd10cm` dataset.
#' 
#' Valid examples: "F32", "F320", "F32.0", "E11.9"
#' Invalid examples: "296" (ICD-9 format), "F" (too short), "ABCDEFGHI" (too long)
#'
#' @export
#'
#' @examples
#' is_valid_icd10cm("F320")  # TRUE - valid format
#' is_valid_icd10cm("F32")   # TRUE - valid format
#' is_valid_icd10cm("F32.0") # TRUE - valid format with dot
#' is_valid_icd10cm("296")   # FALSE - ICD-9 format (starts with number)
#' is_valid_icd10cm("F")     # FALSE - too short
#' is_valid_icd10cm("ABCDEF") # FALSE - no numbers
#'
is_valid_icd10cm <- function(x) {

  dplyr::case_when(
    stringr::str_length(x) < 3 ~ FALSE, # has at least 3 characters
    stringr::str_length(x) > 8 ~ FALSE, # has less than 8 characters (incl dot)
    !stringr::str_starts(x, "[A-Z][0-9|Ax]") ~ FALSE, # starts with letter & number or A
    stringr::str_count(x, "[0-9]") < 1 ~ FALSE, # has at least 1 number
    TRUE ~ TRUE
  )
}
