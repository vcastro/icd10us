icd10cm_chapters <- tribble(
  ~chapter_num, ~chapter_abbr, ~chapter_desc, ~code_start, ~code_end,
  1, "INF",   "Certain infectious and parasitic diseases", "A00", "B99",
  2, "ONC",   "Neoplasms", "C00", "D49",
  3, "BLOOD", "Diseases of the blood and blood-forming organs and certain disorders involving the immune mechanism", "D50", "D89",
  4, "METAB", "Endocrine, nutritional and metabolic diseases", "E00", "E89",
  5, "PSYCH", "Mental, behavioral and neurodevelopmental disorders", "F01", "F99",
  6, "NEURO", "Diseases of the nervous system", "G00", "G99",
  7, "EYE",   "Diseases of the eye and adnexa", "H00", "H59",
  8, "ENT",   "Diseases of the ear and mastoid process", "H60", "H95",
  9, "CARDIO","Diseases of the circulatory system", "I00", "I99",
  10, "PULM", "Diseases of the respiratory system", "J00", "J99",
  11, "GI",   "Diseases of the digestive system", "K00", "K95",
  12, "DERM", "Diseases of the skin and subcutaneous tissue", "L00", "L99",
  13, "ORTHO","Diseases of the musculoskeletal system and connective tissue", "M00", "M99",
  14, "URO",  "Diseases of the genitourinary system", "N00", "N99",
  15, "OB",   "Pregnancy, childbirth and the puerperium", "O00", "O9A",
  16, "BIRTH","Certain conditions originating in the perinatal period", "P00", "P96",
  17, "CONG", "Congenital malformations, deformations and chromosomal abnormalities", "Q00", "Q99",
  18, "SYMP", "Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified", "R00", "R99",
  19, "INJ",  "Injury, poisoning and certain other consequences of external causes", "S00", "T88",
  20, "EXT",  "External causes of morbidity", "V00", "Y99",
  21, "STAT", "Factors influencing health status and contact with health services", "Z00", "Z99",
  22, "SPEC", "Codes for special purposes", "U00", "U85"
)



usethis::use_data(icd10cm_chapters, overwrite = TRUE, compress = "bzip2")
