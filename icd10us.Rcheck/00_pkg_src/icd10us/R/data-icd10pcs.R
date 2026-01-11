#' ICD-10-PCS Codes.
#'
#' A comprehensive dataset of ICD-10-PCS procedure codes used in the United States.
#' ICD-10-PCS (International Classification of Diseases, 10th Revision, Procedure
#' Coding System) is used for coding inpatient procedures in U.S. hospitals.
#'
#' @format A data frame with 6 variables:
#' \describe{
#' \item{\code{order_number}}{file order from source data}
#' \item{\code{icd10pcs_code}}{ICD-10-PCS code (7 characters)}
#' \item{\code{valid_billing_code}}{Is the code a valid billing
#' code 1=Yes, 0=No}
#' \item{\code{icd10pcs_short_description}}{ICD-10-PCS short description}
#' \item{\code{icd10pcs_long_description}}{ICD-10-PCS long description}
#' \item{\code{procedure_class}}{class of procedure based on HCUP Procedure
#' Class data: "Minor Diagnostic", "Minor Therapeutic", "Major Diagnostic",
#' or "Major Therapeutic"}
#' }
#'
#' @details
#' This dataset combines data from multiple public domain sources:
#' 
#' * **ICD-10-PCS codes and descriptions**: From CMS, representing the official
#'   U.S. procedure coding system used for inpatient procedures
#' * **Procedure classifications**: From AHRQ HCUP, categorizing procedures by
#'   their clinical characteristics
#'
#' Procedure class is derived from the HCUP Procedure Class file.  From the
#' user guide, codes are divided into 4 classes:
#'
#' - **Minor Diagnostic**: Nonoperating room procedures that are diagnostic
#' (e.g., B244ZZZ, Ultrasonography of Right Heart)
#' - **Minor Therapeutic**: Nonoperating room procedures that are therapeutic
#' (e.g., 02HQ33Z, Insertion of Infusion Device into Right Pulmonary Artery,
#' Percutaneous Approach)
#' - **Major Diagnostic**: Procedures that are considered operating room
#' procedures that are performed for diagnostic reasons (e.g., 02BV0ZX, Excision
#'  of Superior Vena Cava, Open Approach, Diagnostic)
#' - **Major Therapeutic**: Procedures that are considered operating room
#' procedures that are performed for therapeutic reasons (e.g., 0210093, Bypass
#' Coronary Artery, One Site from Coronary Artery with Autologous Venous Tissue,
#'  Open Approach).
#'
#' All data sources are in the **public domain** and freely available for use.
#'
#' @source \url{https://www.cms.gov/files/zip/2022-icd-10-pcs-order-file-long-
#' and-abbreviated-titles.zip}
#' @source \url{https://www.hcup-us.ahrq.gov/toolssoftware/procedureicd10
#' /ProcedureClasses_v2021-2.zip}
#' 
#' @examples
#' # View the first few rows
#' head(icd10pcs)
#' 
#' # Filter to valid billing codes only
#' library(dplyr)
#' icd10pcs %>% filter(valid_billing_code == 1)
#' 
#' # Find all major therapeutic procedures
#' icd10pcs %>% filter(procedure_class == "Major Therapeutic")
"icd10pcs"



#' ICD-10-PCS Code Sections.
#'
#' Classification of ICD-10-PCS procedure codes into top-level sections.
#' ICD-10-PCS codes are 7 characters long, with the first character indicating
#' the section (e.g., Medical and Surgical, Obstetrics, Imaging, etc.).
#'
#' @format A data frame with 2 variables:
#' \describe{
#' \item{\code{section_digit}}{first digit from ICD-10-PCS codes (0-9, B-H, X)}
#' \item{\code{section_description}}{ICD-10-PCS section description}
#' }
#'
#' @details
#' ICD-10-PCS codes follow a standardized structure where the first character
#' defines the section. This dataset provides a reference for understanding
#' what type of procedure a code represents based on its first character.
#' 
#' Common sections include:
#' * 0 - Medical and Surgical
#' * 1 - Obstetrics
#' * 2 - Placement
#' * 3-9 - Administration, Measurement and Monitoring, Extracorporeal, etc.
#' * B-H - Imaging, Nuclear Medicine, Radiation Therapy, etc.
#' * X - New Technology
#' 
#' This data is derived from the official ICD-10-PCS structure and is in the
#' **public domain**.
#' 
#' @examples
#' # View all sections
#' icd10pcs_sections
#' 
#' # Find the Medical and Surgical section
#' library(dplyr)
#' icd10pcs_sections %>% filter(section_digit == "0")
"icd10pcs_sections"
