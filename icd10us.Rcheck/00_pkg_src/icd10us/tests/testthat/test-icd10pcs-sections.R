library(stringr)

test_that("icd10pcs_sections has expected structure", {
  expect_true(exists("icd10pcs_sections"))
  expect_s3_class(icd10pcs_sections, "data.frame")
})

test_that("icd10pcs_sections has required columns", {
  expected_cols <- c("section_digit", "section_description")
  expect_true(all(expected_cols %in% names(icd10pcs_sections)))
})

test_that("icd10pcs_sections has no missing values", {
  expect_false(any(is.na(icd10pcs_sections$section_digit)))
  expect_false(any(is.na(icd10pcs_sections$section_description)))
})

test_that("icd10pcs_sections has unique section digits", {
  expect_equal(length(unique(icd10pcs_sections$section_digit)), nrow(icd10pcs_sections))
})

test_that("icd10pcs_sections section_digit is single character", {
  expect_true(all(str_length(icd10pcs_sections$section_digit) == 1))
})

test_that("icd10pcs_sections has valid alphanumeric section digits", {
  # Section digits should be alphanumeric (0-9, A-Z)
  expect_true(all(str_detect(icd10pcs_sections$section_digit, "^[0-9A-Z]$")))
})
