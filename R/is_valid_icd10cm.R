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
#' is_valid_icd10cm("F320") #invalid
#' is_valid_icd10cm("F32")  # valid
#' is_valid_icd10cm("296")  $invalid
#'
#' icd10cm %>% mutate(valid = is_valid_icd10cm(icd10cm_code))
is_valid_icd10cm <- function (x) {

  case_when(
    str_length(x) < 3 ~ FALSE,   # has at least 3 characters
    str_length(x) > 8 ~ FALSE,   # has less than 8 characters (incl dot)
    !str_starts(x, "[A-Z][0-9]") ~ FALSE,  # starts with a letter and number
    str_count(x, '[0-9]') < 1 ~ FALSE, # has at least 1 number
    TRUE ~ TRUE
  )
}
