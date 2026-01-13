
# icd10us

<!-- badges: start -->
[![R-CMD-check](https://github.com/vcastro/icd10us/workflows/R-CMD-check/badge.svg)](https://github.com/vcastro/icd10us/actions)
<!-- badges: end -->

The goal of icd10us is to make it easier to work with ICD-10 codes typically found in U.S. electronic health record (EHR) and insurance claims datasets.  This is primarily a data package that includes the most recent ICD-10-CM diagnosis and ICD-10-PCS procedure codes provided by the U.S. Centers for Medicare and Medicaid Services (CMS).  The version of the package reflects the version of the CMS ICD-10 codes.

## Data Sources and Public Domain

All datasets included in this package are in the **public domain**:

- **ICD-10-CM codes**: Provided by CMS and CDC. These codes are used for diagnosis coding in the United States.
- **ICD-10-PCS codes**: Provided by CMS. These codes are used for inpatient procedure coding.
- **HCUP metadata**: Including the Chronic Condition Indicator (CCI) and Procedure Class data, provided by the Healthcare Cost and Utilization Project (HCUP), Agency for Healthcare Research and Quality (AHRQ).

All data sources are publicly available and free to use without restrictions.

## Installation

You can install the development version of icd10us from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("vcastro/icd10us")
```

## Examples

This package provides both datasets and functions for working with ICD-10 codes.

### Working with ICD-10-CM Diagnosis Codes

```r
library(icd10us)
library(dplyr)

# Display ICD-10-CM codes dataset
icd10cm 

# Show only chronic diagnosis codes (based on AHRQ chronic indicator, 1=chronic)
icd10cm %>% 
  filter(chronic_indicator == 1)

# Get all codes between two codes (includes children of end code)
codes_between("F32", "F33")

# Expand a code to show all its child codes
expand_code("F32")

# Check if a code is valid
is_valid_icd10cm("F320")  # Returns TRUE
is_valid_icd10cm("296")   # Returns FALSE (ICD-9 code)

# Add or remove dots from codes
add_dot("F320")     # Returns "F32.0"
remove_dot("F32.0") # Returns "F320"

# Get the header code for a specific code
header_code("F320")

# Generate sample diagnosis data for testing
sample_icd10cm(n = 100, p = 10)
```

### Working with ICD-10-PCS Procedure Codes

```r
# Display ICD-10-PCS codes dataset
icd10pcs

# Filter by procedure class (HCUP classification)
icd10pcs %>% 
  filter(procedure_class == "Major Therapeutic")

# View procedure sections
icd10pcs_sections
```

### Using Chapter Information

```r
# View ICD-10-CM chapters (body systems)
icd10cm_chapters

# Get all codes from a specific chapter (e.g., Mental health - PSYCH)
icd10cm %>%
  semi_join(
    icd10cm_chapters %>% filter(chapter_abbr == "PSYCH"),
    by = character()
  ) %>%
  filter(icd10cm_code >= "F01" & icd10cm_code <= "F99")
```

<!-- TODO:

Add functions for PCS

Add MEDPar file?
Add Census mortality
Add more tests

Make pkgdown site
Add GH actions
sample data
-->


