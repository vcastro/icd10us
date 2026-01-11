library(dplyr)

test_that("icd10cm_chapters has expected structure", {
  expect_true(exists("icd10cm_chapters"))
  expect_s3_class(icd10cm_chapters, "data.frame")
})

test_that("icd10cm_chapters has required columns", {
  expected_cols <- c("chapter_num", "chapter_abbr", "chapter_desc", 
                     "code_start", "code_end")
  expect_true(all(expected_cols %in% names(icd10cm_chapters)))
})

test_that("icd10cm_chapters has no missing values in key columns", {
  expect_false(any(is.na(icd10cm_chapters$chapter_num)))
  expect_false(any(is.na(icd10cm_chapters$chapter_abbr)))
  expect_false(any(is.na(icd10cm_chapters$chapter_desc)))
  expect_false(any(is.na(icd10cm_chapters$code_start)))
  expect_false(any(is.na(icd10cm_chapters$code_end)))
})

test_that("icd10cm_chapters has valid code ranges", {
  # code_end should be greater than or equal to code_start
  expect_true(all(icd10cm_chapters$code_end >= icd10cm_chapters$code_start))
})

test_that("icd10cm_chapters has unique chapter numbers", {
  expect_equal(length(unique(icd10cm_chapters$chapter_num)), nrow(icd10cm_chapters))
})

test_that("icd10cm_chapters has positive chapter numbers", {
  expect_true(all(icd10cm_chapters$chapter_num > 0))
})
