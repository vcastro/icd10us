## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(icd10us)
library(dplyr)

## -----------------------------------------------------------------------------
# View the structure of the dataset
str(icd10cm)

# See first few rows
head(icd10cm)

## -----------------------------------------------------------------------------
# Find all valid billing codes for diabetes
diabetes_codes <- icd10cm %>%
  filter(
    icd10cm_code >= "E08" & icd10cm_code <= "E13",
    valid_billing_code == 1
  )

head(diabetes_codes)

## -----------------------------------------------------------------------------
# Find all chronic conditions
chronic_conditions <- icd10cm %>%
  filter(chronic_indicator == "C")

# Count chronic vs acute conditions
icd10cm %>%
  filter(!is.na(chronic_indicator)) %>%
  count(chronic_indicator)

## -----------------------------------------------------------------------------
# View all chapters
icd10cm_chapters

# Find mental health chapter
icd10cm_chapters %>%
  filter(chapter_abbr == "Mental")

## -----------------------------------------------------------------------------
# Get all depression codes (F32-F33)
depression_codes <- codes_between("F32", "F33")

# View billable codes only
depression_codes %>%
  filter(valid_billing_code == 1) %>%
  select(icd10cm_code, icd10cm_short_description)

## -----------------------------------------------------------------------------
# With expansion (default)
codes_with_expansion <- codes_between("F32", "F33", expand_end_code = TRUE)
nrow(codes_with_expansion)

# Without expansion
codes_without_expansion <- codes_between("F32", "F33", expand_end_code = FALSE)
nrow(codes_without_expansion)

## -----------------------------------------------------------------------------
# Expand F32 to see all subtypes
f32_codes <- expand_code("F32")

# Show billable codes
f32_codes %>%
  filter(valid_billing_code == 1) %>%
  select(icd10cm_code, icd10cm_short_description)

## -----------------------------------------------------------------------------
# Get header for a specific code
header_code("F320")

# Get header for an already-header code
header_code("F32")

## -----------------------------------------------------------------------------
# Valid ICD-10-CM codes
is_valid_icd10cm("F320")    # TRUE
is_valid_icd10cm("E119")    # TRUE
is_valid_icd10cm("F32")     # TRUE

# Invalid codes
is_valid_icd10cm("296")     # FALSE - ICD-9 format
is_valid_icd10cm("F")       # FALSE - too short
is_valid_icd10cm("ABCD")    # FALSE - no numbers

## -----------------------------------------------------------------------------
# Add dots
add_dot("F320")     # Returns "F32.0"
add_dot("E1165")    # Returns "E11.65"
add_dot("F32")      # Returns "F32" (3-char codes don't need dots)

# Remove dots
remove_dot("F32.0")   # Returns "F320"
remove_dot("E11.65")  # Returns "E1165"
remove_dot("F32")     # Returns "F32" (no dot to remove)

## -----------------------------------------------------------------------------
# View the structure
str(icd10pcs)

# See first few rows
head(icd10pcs)

## -----------------------------------------------------------------------------
# Count procedures by class
icd10pcs %>%
  filter(!is.na(procedure_class)) %>%
  count(procedure_class, sort = TRUE)

## -----------------------------------------------------------------------------
# View all sections
icd10pcs_sections

# Medical and Surgical is the largest section
icd10pcs %>%
  filter(stringr::str_starts(icd10pcs_code, "0")) %>%
  nrow()

## -----------------------------------------------------------------------------
# Generate 100 records for 10 patients
sample_data <- sample_icd10cm(n = 100, p = 10)
head(sample_data)

# Summary of the sample
sample_data %>%
  summarize(
    n_records = n(),
    n_patients = n_distinct(patient_id),
    n_unique_codes = n_distinct(icd10cm_code),
    date_range = paste(min(code_date), "to", max(code_date))
  )

## -----------------------------------------------------------------------------
# Sample only mental health codes
mental_health_sample <- sample_icd10cm(
  n = 50, 
  p = 10,
  start_code = "F00",
  end_code = "F99"
)

# Verify all codes are F codes
mental_health_sample %>%
  pull(icd10cm_code) %>%
  head()

## -----------------------------------------------------------------------------
# Create a function to identify chronic conditions in patient data
identify_chronic <- function(patient_codes) {
  patient_codes %>%
    left_join(
      icd10cm %>% select(icd10cm_code, chronic_indicator),
      by = "icd10cm_code"
    ) %>%
    filter(chronic_indicator == "C")
}

# Example with sample data
sample_patients <- sample_icd10cm(n = 50, p = 5)
chronic_diagnoses <- identify_chronic(sample_patients)

chronic_diagnoses %>%
  count(patient_id, sort = TRUE)

## -----------------------------------------------------------------------------
# Assign chapter to diagnosis codes
assign_chapter <- function(codes_df) {
  # Create a helper function to find chapter
  find_chapter <- function(code) {
    icd10cm_chapters %>%
      filter(code_start <= code & code_end >= code) %>%
      pull(chapter_desc) %>%
      first()
  }
  
  codes_df %>%
    rowwise() %>%
    mutate(chapter = find_chapter(icd10cm_code)) %>%
    ungroup()
}

# Example
sample_with_chapters <- assign_chapter(sample_icd10cm(n = 30, p = 5))

sample_with_chapters %>%
  count(chapter, sort = TRUE)

## -----------------------------------------------------------------------------
# Suppose you have codes from an external source
external_codes <- c("F320", "E119", "Z99", "296", "INVALID")

# Validate format
validation_results <- tibble(
  code = external_codes,
  valid_format = is_valid_icd10cm(code),
  exists_in_codeset = code %in% icd10cm$icd10cm_code
)

validation_results

## -----------------------------------------------------------------------------
sessionInfo()

