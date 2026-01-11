#' List all ICD-10-CM codes between two codes
#'
#' @description
#' `codes_between()` returns a tibble of all ICD-10-CM codes occurring
#' between two codes, inclusive. The function uses the order number included
#' in the source data from the CDC, which represents the hierarchical ordering
#' of codes in the official ICD-10-CM classification.
#'
#' @param start_code A string with the starting ICD-10-CM code (minimum 3 characters)
#' @param end_code A string with the ending ICD-10-CM code (minimum 3 characters)
#' @param expand_end_code Boolean indicating whether to include all
#'   children of the end code. When TRUE (default), includes all more specific
#'   versions of the end code. When FALSE, stops at the exact end code.
#'
#' @return A tibble containing all matching ICD-10-CM rows from the icd10cm
#'   dataset, ordered by their position in the official classification.
#'   
#' @details
#' This function is useful for identifying ranges of related codes, such as
#' all codes within a particular disease category or chapter. The ordering
#' follows the official ICD-10-CM structure maintained by CDC/NCHS.
#' 
#' When `expand_end_code = TRUE`, the function includes not just the end code
#' but also all its child codes, ensuring you capture the complete range.
#'
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' # Get all codes from F32 to F33 (depression disorders)
#' codes_between("F32", "F33")
#' 
#' # Get codes without expanding the end code
#' codes_between("F32", "F33", expand_end_code = FALSE)
#' 
#' # Get a broader range
#' codes_between("F30", "F39")
#' 
#' # Can be combined with other operations
#' library(dplyr)
#' codes_between("F32", "F33") %>%
#'   filter(valid_billing_code == 1) %>%
#'   select(icd10cm_code, icd10cm_short_description)
codes_between <-
  function(start_code, end_code, expand_end_code = TRUE) {
    stopifnot(end_code >= start_code)
    stopifnot(stringr::str_length(start_code) >= 3)
    stopifnot(stringr::str_length(end_code) >= 3)

    icd10cm <- NULL
    utils::data(icd10cm, envir = environment())

    start_num <- icd10cm %>%
      dplyr::filter(.data$icd10cm_code == start_code) %>%
      dplyr::pull(.data$order_number)


    if (expand_end_code) {
      end_num <- expand_code(end_code) %>%
        dplyr::summarize(max_order_num = max(.data$order_number)) %>%
        dplyr::pull(.data$max_order_num)
    } else {
      end_num <- icd10cm %>%
        dplyr::filter(.data$icd10cm_code == end_code) %>%
        dplyr::pull(.data$order_number)
    }

    icd10cm %>%
      dplyr::filter(.data$order_number >= start_num &
                      .data$order_number <= end_num)

  }
