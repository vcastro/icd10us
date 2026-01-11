library(dplyr)
library(stringr)

# Tests for expand_code()
test_that("expand_code returns all child codes", {
  result <- expand_code("F32")
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)
  expect_true(all(str_starts(result$icd10cm_code, "F32")))
})

test_that("expand_code returns codes from icd10cm dataset", {
  result <- expand_code("A00")
  expected_cols <- c("order_number", "icd10cm_code", "valid_billing_code",
                     "icd10cm_short_description", "icd10cm_long_description")
  expect_true(all(expected_cols %in% names(result)))
})

test_that("expand_code returns empty tibble for non-existent code", {
  result <- expand_code("ZZZ")
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 0)
})

test_that("expand_code works with 3-character codes", {
  result <- expand_code("F32")
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)
})

test_that("expand_code works with longer codes", {
  result <- expand_code("F328")
  expect_s3_class(result, "data.frame")
  expect_true(all(str_starts(result$icd10cm_code, "F328")))
})

# Tests for codes_between()
test_that("codes_between returns codes in range", {
  result <- codes_between("F32", "F33")
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)
  expect_true(all(result$icd10cm_code >= "F32"))
  expect_true(all(result$icd10cm_code <= "F339"))  # with expand_end_code=TRUE
})

test_that("codes_between respects expand_end_code parameter", {
  result_expanded <- codes_between("F32", "F33", expand_end_code = TRUE)
  result_not_expanded <- codes_between("F32", "F33", expand_end_code = FALSE)
  expect_true(nrow(result_expanded) >= nrow(result_not_expanded))
})

test_that("codes_between throws error if end_code < start_code", {
  expect_error(codes_between("F33", "F32"))
})

test_that("codes_between throws error for codes shorter than 3 characters", {
  expect_error(codes_between("F3", "F4"))
  expect_error(codes_between("F32", "F3"))
})

test_that("codes_between returns single code range correctly", {
  result <- codes_between("A00", "A00", expand_end_code = FALSE)
  expect_equal(nrow(result), 1)
  expect_equal(result$icd10cm_code[1], "A00")
})

# Tests for is_valid_icd10cm()
test_that("is_valid_icd10cm accepts valid codes", {
  expect_true(is_valid_icd10cm("F320"))
  expect_true(is_valid_icd10cm("F32"))
  expect_true(is_valid_icd10cm("A001"))
  expect_true(is_valid_icd10cm("Z99"))
})

test_that("is_valid_icd10cm rejects codes shorter than 3 characters", {
  expect_false(is_valid_icd10cm("F3"))
  expect_false(is_valid_icd10cm("A"))
  expect_false(is_valid_icd10cm("12"))
})

test_that("is_valid_icd10cm rejects codes longer than 8 characters", {
  expect_false(is_valid_icd10cm("F32012345"))
})

test_that("is_valid_icd10cm rejects codes not starting with letter and number", {
  expect_false(is_valid_icd10cm("296"))
  expect_false(is_valid_icd10cm("123"))
})

test_that("is_valid_icd10cm rejects codes without numbers", {
  expect_false(is_valid_icd10cm("ABC"))
})

test_that("is_valid_icd10cm works with vectors", {
  codes <- c("F320", "296", "A001", "XY")
  result <- is_valid_icd10cm(codes)
  expect_equal(length(result), 4)
  expect_true(result[1])
  expect_false(result[2])
  expect_true(result[3])
  expect_false(result[4])
})

# Tests for sample_icd10cm()
test_that("sample_icd10cm returns correct number of rows", {
  result <- sample_icd10cm(n = 50, p = 10)
  expect_equal(nrow(result), 50)
})

test_that("sample_icd10cm returns tibble with required columns", {
  result <- sample_icd10cm(n = 10, p = 5)
  expect_s3_class(result, "data.frame")
  expect_true(all(c("patient_id", "icd10cm_code", "code_date") %in% names(result)))
})

test_that("sample_icd10cm respects patient count parameter", {
  result <- sample_icd10cm(n = 100, p = 5)
  unique_patients <- length(unique(result$patient_id))
  expect_true(unique_patients <= 5)
})

test_that("sample_icd10cm returns valid ICD-10-CM codes", {
  result <- sample_icd10cm(n = 20, p = 5)
  expect_true(all(is_valid_icd10cm(result$icd10cm_code)))
})

test_that("sample_icd10cm respects code range", {
  result <- sample_icd10cm(n = 50, p = 10, start_code = "E10", end_code = "E14")
  expect_true(all(result$icd10cm_code >= "E10"))
  expect_true(all(result$icd10cm_code <= "E14"))
})

test_that("sample_icd10cm returns date objects", {
  result <- sample_icd10cm(n = 10, p = 5)
  expect_s3_class(result$code_date, "Date")
})

# Tests for add_dot()
test_that("add_dot adds dot to codes longer than 3 characters", {
  expect_equal(add_dot("F320"), "F32.0")
  expect_equal(add_dot("A0010"), "A00.10")
})

test_that("add_dot does not add dot to 3-character codes", {
  expect_equal(add_dot("F32"), "F32")
  expect_equal(add_dot("A00"), "A00")
})

test_that("add_dot throws error if dot already exists", {
  expect_error(add_dot("F32.0"))
})

test_that("add_dot works with vectors", {
  codes <- c("F320", "A001", "Z99")
  result <- add_dot(codes)
  expect_equal(result, c("F32.0", "A00.1", "Z99"))
})

# Tests for remove_dot()
test_that("remove_dot removes dot from codes", {
  expect_equal(remove_dot("F32.0"), "F320")
  expect_equal(remove_dot("A00.10"), "A0010")
})

test_that("remove_dot works on codes without dots", {
  expect_equal(remove_dot("F320"), "F320")
  expect_equal(remove_dot("A00"), "A00")
})

test_that("remove_dot works with vectors", {
  codes <- c("F32.0", "A00.1", "Z99")
  result <- remove_dot(codes)
  expect_equal(result, c("F320", "A001", "Z99"))
})

test_that("add_dot and remove_dot are inverse operations", {
  original <- "F320"
  expect_equal(remove_dot(add_dot(original)), original)
})

# Tests for header_code()
test_that("header_code returns a data frame", {
  result <- header_code("F320")
  expect_s3_class(result, "data.frame")
})

test_that("header_code returns header code for detailed code", {
  result <- header_code("F320")
  expect_equal(nrow(result), 1)
  expect_true(result$order_number <= icd10cm %>%
                filter(icd10cm_code == "F320") %>%
                pull(order_number))
})

test_that("header_code returns same code for header codes", {
  # Get a known header code (3-character or non-billable)
  header <- icd10cm %>%
    filter(valid_billing_code == 0 | str_length(icd10cm_code) == 3) %>%
    slice(1) %>%
    pull(icd10cm_code)

  result <- header_code(header)
  expect_equal(nrow(result), 1)
  expect_equal(result$icd10cm_code, header)
})

test_that("header_code returns valid icd10cm structure", {
  result <- header_code("F320")
  expected_cols <- c("order_number", "icd10cm_code", "valid_billing_code")
  expect_true(all(expected_cols %in% names(result)))
})
