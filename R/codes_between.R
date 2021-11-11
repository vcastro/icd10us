#' List all codes between two sets of codes
#'
#' @description
#' `codes_between` returns a tibble of all ICD-10-CM codes occuring
#' between two codes.  The function uses the order number included
#' in the source data from the CDC.
#'
#' @param start_code A string with the starting ICD-10-CM code
#' @param end_code A string with the ending ICD-10-CM code
#' @param expand_end_code Boolean indicating whether to include all
#'   children of the end code
#'
#' @return Tibble of all matching ICD-10-CM rows from icd10cm
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' codes_between("F32", "F33")
codes_between <-
  function(start_code, end_code, expand_end_code = TRUE) {
    stopifnot(end_code > start_code)
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
