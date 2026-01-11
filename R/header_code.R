#' Retrieve the header code for a given ICD-10-CM code
#'
#' @description
#' `header_code()` returns a tibble of the code that corresponds
#' to the header for a given ICD-10-CM code.  If the input code
#' is already a header code, the same code is returned.
#' 
#' Header codes in ICD-10-CM are non-billable codes that serve as 
#' category headers in the classification. They provide a broader
#' classification for more specific (billable) codes.
#'
#' @param x A valid ICD-10-CM code
#'
#' @return A tibble with one row from the icd10cm dataset representing
#'   the header code for the given input code. Returns the closest
#'   preceding header code based on the order number.
#'   
#' @details
#' In the ICD-10-CM structure, header codes are typically 3-character codes
#' or codes marked as non-billable (`valid_billing_code == 0`). These serve
#' to organize and categorize more specific diagnosis codes.
#' 
#' For example, for code "F320" (Major depressive disorder, single episode, mild),
#' the header code would be "F32" (Major depressive disorder, single episode).
#'
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' # Get header code for a specific diagnosis
#' header_code("F320")
#'
#' # Header code returns itself if already a header
#' header_code("F32")
#' 
#' # You can also pass a vector of codes and get distinct header codes
#' library(dplyr)
#' library(purrr)
#' icd10cm %>%
#'   dplyr::filter(stringr::str_starts(icd10cm_code, "F32")) %>%
#'   dplyr::pull(icd10cm_code) %>%
#'   purrr::map_dfr(header_code) %>%
#'   unique()
#'
header_code <- function(x) {

  icd10cm <- NULL
  utils::data(icd10cm, envir = environment())

    code_order_num <- icd10cm %>%
    dplyr::filter(.data$icd10cm_code == x) %>%
    dplyr::pull(.data$order_number)

  icd10cm %>%
    dplyr::filter(
      .data$order_number <= code_order_num &
        (
          .data$valid_billing_code == 0 |
            stringr::str_length(.data$icd10cm_code) == 3
        )
    ) %>%
    dplyr::slice_max(.data$order_number)

}
