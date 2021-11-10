#
# ## build_sample_data
#
#

#   #vignette table: chapter, desc, range,
#
# # https://www.cms.gov/files/zip/icd-10-cm-diagnosis-codes-impact-resource-use-file-fy2019-and-fy2020-medpar.zip
# # ICD_10_CM_Diagnosis_Codes_Impact_on_Resource_Use_File___FY2019_and_FY2020_MedPAR.xlsx.xlsx
#
#
#
# ## check all icd10cm_codes are unique
# icd10cm %>%
#   group_by(icd10cm_code) %>%
#   count() %>%
#   filter(n > 1) %>%
#   nrow()
