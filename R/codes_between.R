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
#' @export
#'
#' @examples
#' codes_between("F32", "F33")
codes_between <-
  function(start_code, end_code, expand_end_code = TRUE) {
    stopifnot(end_code > start_code)
    stopifnot(str_length(start_code) >= 3)
    stopifnot(str_length(end_code) >= 3)

    start_num <- icd10cm %>%
      filter(icd10cm_code == start_code) %>%
      pull(order_number)


    if (expand_end_code) {
      end_num <- expand_code(end_code) %>%
        summarize(max_order_num = max(order_number)) %>%
        pull(max_order_num)
    } else {
      start_num <- icd10cm %>%
        filter(icd10cm_code == end_code) %>%
        pull(order_number)
    }

    icd10cm %>%
      filter(order_number >= start_num &
               order_number <= end_num)

  }
