#' Retrieves a header code for a given ICD-10-CM code
#'
#' @description
#' `header_code` returns a tibble of the code that corresponds
#' to the header for a given ICD-10-CM code.  If the input code
#' is a header code, the same code is returned.
#'
#' @param x a valid ICD-10-CM code
#'
#' @return Tibble of all matching ICD-10-CM rows from icd10cm
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr pull
#' @importFrom dplyr slice_max
#' @importFrom dplyr str_length
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' header_code("F320")
#'
#' # you can also pass a vector of codes and then get the distinct
#' # header codes using purrr
#' icd10cm::icd10cm %>%
#'   filter(stringr::str_starts(icd10cm_code, "F32")) %>%
#'   pull(icd10cm_code) %>%
#'   purrr::map_dfr(header_code) %>%
#'   unique()
#'
header_code <- function(x) {

  code_order_num <- icd10cm::icd10cm %>%
    filter(.data$icd10cm_code == x) %>%
    pull(.data$order_number)

  icd10cm::icd10cm %>%
    filter(.data$order_number <= .data$code_order_num &
             (.data$valid_billing_code == 0 | str_length(.data$icd10cm_code) == 3)) %>%
    slice_max(.data$order_number)

}
