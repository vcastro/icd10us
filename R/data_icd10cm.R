#' ICD-10-CM Codes.
#'
#' ICD-10-CM diagnosis codes
#'
#' @format A data frame with seven variables:
#' \describe{
#' \item{\code{order_number}}{file order from source data}
#' \item{\code{icd10cm_code}}{ICD-10-CM code without a dot}
#' \item{\code{valid_billing_code}}{Is the code a valid billing
#' code 1=Yes, 0=No}
#' \item{\code{icd10cm_short_description}}{ICD-10-CM short description}
#' \item{\code{icd10cm_long_description}}{ICD-10-CM long description}
#' \item{\code{poa_exempt}}{Flag to indicate if code is exempt from present
#'  on admission (POA) rules}
#' \item{\code{chronic_indicator}}{Flag to indicate if code is acute or
#'  chronic based on HCUP Chronic Care Indicator data}
#' }
#'
#' @source \url{ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/
#' ICD10CM/2022/Code Descriptions zip.zip}
#' @source \url{ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/
#' ICD10CM/2022/POAexemptCodesFY22.zip}
#' @source \url{https://www.hcup-us.ahrq.gov/toolssoftware/chronic_icd10/
#' CCI-ICD10CM-v2021-1.zip}
"icd10cm"



#' ICD-10-CM Chapters
#'
#' ICD-10-cM diagnosis code chapters (body systems)
#'
#' @format A data frame with 5 variables:
#' \describe{
#' \item{\code{chapter_num}}{number of chapter}
#' \item{\code{chapter_abbr}}{chapter abbreviation}
#' \item{\code{chapter_desc}}{chapter long description}
#' \item{\code{code_start}}{first code in the chapter}
#' \item{\code{code_end}}{last code in the chapter}
#' }
"icd10cm_chapters"
