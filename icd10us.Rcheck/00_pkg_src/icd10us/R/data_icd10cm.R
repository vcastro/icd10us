#' ICD-10-CM Codes.
#'
#' A comprehensive dataset of ICD-10-CM diagnosis codes used in the United States.
#' ICD-10-CM (International Classification of Diseases, 10th Revision, Clinical
#' Modification) is the standard diagnostic coding system used by healthcare 
#' providers and payers.
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
#'  on admission (POA) rules. Y=Exempt, N=Not exempt, NA=Not applicable}
#' \item{\code{chronic_indicator}}{Flag to indicate if code is acute or
#'  chronic based on HCUP Chronic Care Indicator data. C=Chronic, A=Acute,
#'  NA=Not applicable}
#' }
#'
#' @details
#' This dataset combines data from multiple public domain sources:
#' 
#' * **ICD-10-CM codes and descriptions**: From CMS, representing the official
#'   U.S. clinical modification of the WHO's ICD-10
#' * **POA (Present on Admission) exemptions**: From CDC/NCHS, indicating which
#'   codes are exempt from POA reporting requirements
#' * **Chronic condition indicators**: From AHRQ HCUP, classifying conditions
#'   as chronic or acute based on their typical duration
#'
#' All data sources are in the **public domain** and freely available for use.
#'
#' @source \url{ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/
#' ICD10CM/2022/Code Descriptions zip.zip}
#' @source \url{ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/
#' ICD10CM/2022/POAexemptCodesFY22.zip}
#' @source \url{https://www.hcup-us.ahrq.gov/toolssoftware/chronic_icd10/
#' CCI-ICD10CM-v2021-1.zip}
#' 
#' @examples
#' # View the first few rows
#' head(icd10cm)
#' 
#' # Filter to valid billing codes only
#' library(dplyr)
#' icd10cm %>% filter(valid_billing_code == 1)
#' 
#' # Find all chronic conditions
#' icd10cm %>% filter(chronic_indicator == "C")
"icd10cm"



#' ICD-10-CM Chapters
#'
#' Classification of ICD-10-CM diagnosis codes into chapters representing
#' different body systems or conditions. This provides a high-level organization
#' of the diagnosis code structure.
#'
#' @format A data frame with 5 variables:
#' \describe{
#' \item{\code{chapter_num}}{number of chapter (1-22)}
#' \item{\code{chapter_abbr}}{chapter abbreviation for easy reference}
#' \item{\code{chapter_desc}}{chapter long description}
#' \item{\code{code_start}}{first ICD-10-CM code in the chapter}
#' \item{\code{code_end}}{last ICD-10-CM code in the chapter}
#' }
#' 
#' @details
#' ICD-10-CM codes are organized into 22 chapters, each representing a major
#' body system or type of condition (e.g., Infectious diseases, Neoplasms,
#' Mental and behavioral disorders, etc.). This dataset helps users understand
#' the overall structure and filter codes by chapter.
#' 
#' This data is derived from the official ICD-10-CM structure and is in the
#' **public domain**.
#' 
#' @examples
#' # View all chapters
#' icd10cm_chapters
#' 
#' # Find the chapter for mental health conditions
#' library(dplyr)
#' icd10cm_chapters %>% filter(chapter_abbr == "Mental")
"icd10cm_chapters"
