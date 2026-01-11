library(readr)

## Load 2026 version

download.file(url = "https://www.cms.gov/files/zip/2026-code-descriptions-tabular-order.zip",
              destfile = "data-raw/2026-code-descriptions-tabular-order.zip",
              method = "libcurl")


unzip(
  "data-raw/2026-code-descriptions-tabular-order.zip",
  files = "icd10cm_order_2026.txt",
  exdir = "data-raw",
  junkpaths = TRUE
)


icd10cm <- read_fwf(
  "data-raw/icd10cm_order_2026.txt",
  fwf_cols(
      order_number = c(1,5),
      icd10cm_code = c(7,13),
      valid_billing_code = c(14,15),
      icd10cm_short_description = c(17,77),
      icd10cm_long_description = c(78,500)
    ),
  col_types = c("i", "c", "l", "c", "c")
)

### add POA

download.file(url = "https://ftp.cdc.gov/pub/health_statistics/nchs/publications/ICD10CM/2026/POAexemptCodesFY26.zip",
              destfile = "data-raw/POAexemptCodesFY26.zip",
              method = "libcurl")

unzip(
  "data-raw/POAexemptCodesFY26.zip",
  files = "POAexemptCodesFY26.txt",
  exdir = "data-raw",
  junkpaths = TRUE
)

icd10cm_poa <- read_tsv("data-raw/POAexemptCodesFY26.txt",
                        col_types = c("i", "c", "c")) %>%
               rename(order_number = Order26,
                      poa_exempt_code = POAexemptCode)




icd10cm <- icd10cm %>%
  left_join(icd10cm_poa, by = "order_number") %>%
  mutate(poa_exempt = case_when(
    valid_billing_code == 1 & !is.na(poa_exempt_code) ~ "Y",
    valid_billing_code == 1 & is.na(poa_exempt_code) ~ "N")) %>%
  select(-Description,-poa_exempt_code)


### add HCUP chronic_indicator

download.file(url = "https://hcup-us.ahrq.gov/toolssoftware/chronic_icd10/CCIR_v2026-1.zip",
              destfile = "data-raw/CCIR_v2026-1.zip",
              method = "libcurl")

unzip(
  "data-raw/CCIR-2026-1.zip",
  files = "CCIR_v2026-1.csv",
  exdir = "data-raw",
  junkpaths = TRUE
)

icd10cm_cci <- read_csv("data-raw/CCIR_v2026-1.csv",
                        skip = 2,
                        col_types = c("c", "c", "c")) %>%
               select(icd10cm_code = `'ICD-10-CM CODE'`,
                      chronic_indicator = `'CHRONIC INDICATOR'`) %>%
               mutate(icd10cm_code = str_replace_all(icd10cm_code, "'", ""),
                      chronic_indicator = str_replace_all(chronic_indicator, "'", ""))


icd10cm <- icd10cm %>%
  left_join(icd10cm_cci, by = "icd10cm_code")


usethis::use_data(icd10cm, overwrite = TRUE, compress = "bzip2")



## Maybe add MEDPAR counts
# # https://www.cms.gov/files/zip/icd-10-cm-diagnosis-codes-impact-resource-use-file-fy2019-and-fy2020-medpar.zip
# # ICD_10_CM_Diagnosis_Codes_Impact_on_Resource_Use_File___FY2019_and_FY2020_MedPAR.xlsx.xlsx


## Maybe add Mortality from CDC WONDER - separate data with conditions
