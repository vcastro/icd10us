#' Sample ICD-10-CM diagnosis codes
#'
#'#' @description
#' `sample_icd10cm` returns a tibble of a random sample of ICD-10-CM diagnosis.
#' Currently there is uniform sampling across all billable ICD-10 codes.  Dates
#' and patient IDs are also randomly generated
#'
#' @param n number of ICD-10-CM to sample
#' @param p number of distinct patients to sample
#' @param start_code Lowest ICD-10-CM code to sample (default: A00)
#' @param end_code Highest ICD-10-CM code to sample (default: Z99)
#'
#' @return tibble
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' sample_icd10cm(n=1000)
sample_icd10cm <- function(n=100, p=10, start_code = "A00", end_code = "Z99") {

  utils::data(icd10cm, envir = environment())

  icd10cm <- icd10cm %>%
    dplyr::filter(
      .data$icd10cm_code >= start_code &
        .data$icd10cm_code <= end_code &
        .data$valid_billing_code == 1
    )

  tibble::tibble(
    patient_id = sample(
      x = seq(1:p),
      size = n,
      replace = TRUE
    ),
    icd10cm_code = sample(
      x = icd10cm$icd10cm_code,
      size = n,
      replace = TRUE
    ),
    code_date = sample(seq(
      as.Date("2015/10/01"), as.Date(Sys.Date()), by = "day"
    ), n)
  )

}
