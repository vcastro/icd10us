#' Generate sample ICD-10-CM diagnosis data
#'
#'#' @description
#' `sample_icd10cm()` returns a tibble of randomly sampled ICD-10-CM diagnoses
#' with synthetic patient IDs and dates. This is useful for generating test
#' data, examples, or demonstrations.
#' 
#' Currently performs uniform sampling across all billable ICD-10 codes within
#' the specified range. Dates and patient IDs are randomly generated.
#'
#' @param n Number of diagnosis records to generate (default: 100)
#' @param p Number of distinct patients to include in the sample (default: 10)
#' @param start_code Lowest ICD-10-CM code to sample from (default: "A00")
#' @param end_code Highest ICD-10-CM code to sample from (default: "Z99")
#'
#' @return A tibble with three columns:
#'   * `patient_id`: Integer patient identifier (1 to p)
#'   * `icd10cm_code`: Randomly sampled valid billing ICD-10-CM code
#'   * `code_date`: Randomly sampled date between 2015-10-01 and today
#'   
#' @details
#' The function only samples from valid billing codes (codes with 
#' `valid_billing_code == 1`), as these are the codes that would typically
#' appear in actual healthcare data.
#' 
#' Patient IDs are sampled with replacement, so patients may have multiple
#' diagnoses in the generated dataset.
#' 
#' The default date range starts from October 1, 2015 (when ICD-10 was
#' implemented in the U.S.) through the current date.
#'
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' # Generate 100 records for 10 patients
#' sample_icd10cm(n = 100)
#' 
#' # Generate more records with more patients
#' sample_icd10cm(n = 1000, p = 50)
#' 
#' # Sample only from mental health codes (F codes)
#' sample_icd10cm(n = 100, start_code = "F00", end_code = "F99")
#' 
#' # Sample from diabetes codes
#' sample_icd10cm(n = 50, start_code = "E08", end_code = "E13")
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
