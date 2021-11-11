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
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' header_code("F320")
#'
#' # you can also pass a vector of codes and then get the distinct
#' # header codes using purrr
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
