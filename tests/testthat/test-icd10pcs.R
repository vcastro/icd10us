library(dplyr)
library(stringr)

test_that("icd10pcs has expected structure", {
  expect_true(exists("icd10pcs"))
  expect_s3_class(icd10pcs, "data.frame")
})

test_that("icd10pcs has required columns", {
  expected_cols <- c("order_number", "icd10pcs_code", "valid_billing_code",
                     "icd10pcs_short_description", "icd10pcs_long_description",
                     "procedure_class")
  expect_true(all(expected_cols %in% names(icd10pcs)))
})

test_that("icd10pcs data has no duplicate icd10pcs_codes", {
  expect_equal(
    icd10pcs %>%
      group_by(icd10pcs_code) %>%
      count() %>%
      filter(n > 1) %>%
      nrow(),
    0
  )
})

test_that("icd10pcs has no missing values in key columns", {
  expect_false(any(is.na(icd10pcs$order_number)))
  expect_false(any(is.na(icd10pcs$icd10pcs_code)))
  expect_false(any(is.na(icd10pcs$valid_billing_code)))
})

test_that("icd10pcs valid_billing_code is binary", {
  expect_true(all(icd10pcs$valid_billing_code %in% c(0, 1)))
})

test_that("icd10pcs codes have correct format", {
  # ICD-10-PCS codes are 7 characters long
  code_lengths <- str_length(icd10pcs$icd10pcs_code)
  expect_true(all(code_lengths == 7))
})

test_that("icd10pcs order numbers are unique", {
  expect_equal(
    icd10pcs %>%
      group_by(order_number) %>%
      count() %>%
      filter(n > 1) %>%
      nrow(),
    0
  )
})

test_that("icd10pcs procedure_class has valid values", {
  valid_classes <- c("Minor Diagnostic", "Minor Therapeutic", 
                     "Major Diagnostic", "Major Therapeutic", NA)
  expect_true(all(icd10pcs$procedure_class %in% valid_classes))
})
