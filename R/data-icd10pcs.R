#' ICD-10-PCS Codes.
#'
#' ICD-10-PCS procedure codes
#'
#' @format A data frame with 6 variables:
#' \describe{
#' \item{\code{order_number}}{file order from source data}
#' \item{\code{icd10pcs_code}}{ICD-10-PCS code}
#' \item{\code{valid_billing_code}}{Is the code a valid billing
#' code 1=Yes, 0=No}
#' \item{\code{icd10pcs_short_description}}{ICD-10-PCS short description}
#' \item{\code{icd10pcs_long_description}}{ICD-10-PCS long description}
#' \item{\code{procedure_class}}{class of procedure based on HCUP Procedure
#' Class data}
#' }
#'
#' @details
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
#'
#' @source \url{https://www.cms.gov/files/zip/2022-icd-10-pcs-order-file-long-
#' and-abbreviated-titles.zip}
#' @source \url{https://www.hcup-us.ahrq.gov/toolssoftware/procedureicd10
#' /ProcedureClasses_v2021-2.zip}
"icd10pcs"



#' ICD-10-PCS Code Sections.
#'
#' ICD-10-PCS procedure code top-level sections
#'
#' @format A data frame with 2 variables:
#' \describe{
#' \item{\code{section_digit}}{first digit from ICD-10-PCS codes}
#' \item{\code{section_description}}{ICD-10-PCS section description}
#' }
#'
"icd10pcs_sections"
