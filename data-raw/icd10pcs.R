library(readr)

## Load 2022 version

download.file(url = "https://www.cms.gov/files/zip/2022-icd-10-pcs-order-file-long-and-abbreviated-titles.zip",
              destfile = "data-raw/2022-icd-10-pcs-order-file-long-and-abbreviated-titles.zip",
              method = "libcurl")


unzip(
  "data-raw/2022-icd-10-pcs-order-file-long-and-abbreviated-titles.zip",
  files = "Zip File 4 2022 ICD-10-PCS Order File (Long and Abbreviated Titles)/icd10pcs_order_2022.txt",
  exdir = "data-raw",
  junkpaths = TRUE
)


icd10pcs <- read_fwf(
  "data-raw/icd10pcs_order_2022.txt",
  fwf_cols(
    order_number = c(1,5),
    icd10pcs_code = c(7,13),
    valid_billing_code = c(15,15),
    icd10pcs_short_description = c(17,77),
    icd10pcs_long_description = c(78,500)
  ),
  col_types = c("i", "c", "l", "c", "c")
)

## HCUP Procedure Classes


download.file(url = "https://www.hcup-us.ahrq.gov/toolssoftware/procedureicd10/ProcedureClasses_v2021-2.zip",
              destfile = "data-raw/ProcedureClasses_v2021-2.zip",
              method = "libcurl")


unzip(
  "data-raw/ProcedureClasses_v2021-2.zip",
  files = "PClass_ICD10PCS_v2021-2.csv",
  exdir = "data-raw",
  junkpaths = TRUE
)


icd10pcs_class <- read_csv(
    "data-raw/PClass_ICD10PCS_v2021-2.csv",
    skip = 1,
    col_types = c("c", "c", "i", "c")) %>%
  select(icd10pcs_code = `ICD-10-PCS CODE'`,
         procedure_class = `'PROCEDURE CLASS NAME'`) %>%
  mutate(icd10pcs_code = str_replace_all(icd10pcs_code, "'", ""))



icd10pcs <- icd10pcs %>%
  left_join(icd10pcs_class, by = "icd10pcs_code")


usethis::use_data(icd10pcs, overwrite = TRUE, compress = "bzip2")



icd10pcs_sections <-
tribble(~section_digit, ~section_description,
"0", "Medical and Surgical",
"1", "Obstetrics",
"2", "Placement",
"3", "Administration",
"4", "Measurement and Monitoring",
"5", "Extracorporeal or Systemic Assistance and Performance",
"6", "Extracorporeal or Systemic Therapies",
"7", "Osteopathic",
"8", "Other Procedures",
"9", "Chiropractic",
"B", "Imaging",
"C", "Nuclear Medicine",
"D", "Radiation Therapy",
"F", "Physical Rehabilitation and Diagnostic Audiology",
"G", "Mental Health",
"H", "Substance Abuse Treatment",
"X", "New Technology")



usethis::use_data(icd10pcs_sections, overwrite = TRUE, compress = "bzip2")
