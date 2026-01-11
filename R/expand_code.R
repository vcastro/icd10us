#' Expand an ICD-10-CM code to show all child codes
#'
#' @description
#' `expand_code()` returns a tibble of all ICD-10-CM codes that
#' are child codes of the provided code. Child codes are more specific
#' versions of a parent code, adding additional detail through extra digits.
#'
#' @param x A valid ICD-10-CM code (3 or more characters)
#'
#' @return A tibble containing all matching ICD-10-CM rows from the icd10cm
#'   dataset. Returns an empty tibble if no matching codes are found.
#'   
#' @details
#' In ICD-10-CM, codes become more specific as you add digits. For example:
#' * F32 - Major depressive disorder, single episode
#' * F320 - Major depressive disorder, single episode, mild
#' * F321 - Major depressive disorder, single episode, moderate
#' 
#' This function finds all codes that start with the provided code string,
#' effectively expanding a code to show all its more specific variations.
#'
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' # Expand F32 to see all depression subtypes
#' expand_code("F32")
#' 
#' # Expand a more specific code
#' expand_code("F320")
#' 
#' # Can be used with other functions
#' library(dplyr)
#' expand_code("F32") %>%
#'   filter(valid_billing_code == 1) %>%
#'   select(icd10cm_code, icd10cm_short_description)
expand_code <- function(x) {

  icd10us::icd10cm %>%
    dplyr::filter(stringr::str_starts(.data$icd10cm_code, x))

}
