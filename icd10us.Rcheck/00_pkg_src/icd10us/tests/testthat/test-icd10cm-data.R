library(dplyr)
library(stringr)

test_that("icd10cm data has no duplicate icd10cm_codes", {
  expect_equal(icd10cm %>%
                 group_by(icd10cm_code) %>%
                 count() %>%
                 filter(n > 1) %>%
                 nrow(),
               0)
})


test_that("icd10cm data has no invalid icd10cm_codes", {
  expect_equal(icd10cm %>%
                 mutate(valid = is_valid_icd10cm(icd10cm_code)) %>%
                 filter(valid == FALSE) %>%
                 nrow(),
               0)
})
