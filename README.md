
# icd10us

<!-- badges: start -->
[![R-CMD-check](https://github.com/vcastro/icd10us/workflows/R-CMD-check/badge.svg)](https://github.com/vcastro/icd10us/actions)
<!-- badges: end -->

The goal of icd10us is to make it easier to work with ICD-10 codes typically found in U.S. electronic health record (EHR) and insurance claims datasets.  This is primarily a data package that includes the most recent ICD-10-CM diagnosis and ICD-10-PRC procedure codes provided by the U.S. Centers for Medicare and Medicaid Services (CMS).  The version of the package reflects the version of the CMS ICD-10 codes.

## Installation

You can install the development version of icd10us from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("vcastro/icd10us")
```

## Examples

``` r
library(icd10us)
library(dplyr)

#display ICD-10-CM codes
icd10cm 

#show only chronic diagnosis codes (based on AHRQ chronic indicator)
icd10cm %>% 
  filter(chronic_indicator == "C")
  
#show all ICD-10 codes between two codes
codes_between("F32", "F33")

```

<!-- TODO:

Add functions for PCS

Add MEDPar file?
Add Census mortality
Add more tests

Make pkgdown site
Add GH actions
-->


