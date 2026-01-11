pkgname <- "icd10us"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('icd10us')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("add_dot")
### * add_dot

flush(stderr()); flush(stdout())

### Name: add_dot
### Title: Add a dot to an ICD-10 code
### Aliases: add_dot

### ** Examples

add_dot("F320")     # Returns "F32.0"
add_dot("E119")     # Returns "E11.9"
add_dot("F32")      # Returns "F32" (no dot added for 3-character codes)
add_dot("A0101")    # Returns "A01.01"




cleanEx()
nameEx("codes_between")
### * codes_between

flush(stderr()); flush(stdout())

### Name: codes_between
### Title: List all ICD-10-CM codes between two codes
### Aliases: codes_between

### ** Examples

# Get all codes from F32 to F33 (depression disorders)
codes_between("F32", "F33")

# Get codes without expanding the end code
codes_between("F32", "F33", expand_end_code = FALSE)

# Get a broader range
codes_between("F30", "F39")

# Can be combined with other operations
library(dplyr)
codes_between("F32", "F33") %>%
  filter(valid_billing_code == 1) %>%
  select(icd10cm_code, icd10cm_short_description)



cleanEx()
nameEx("expand_code")
### * expand_code

flush(stderr()); flush(stdout())

### Name: expand_code
### Title: Expand an ICD-10-CM code to show all child codes
### Aliases: expand_code

### ** Examples

# Expand F32 to see all depression subtypes
expand_code("F32")

# Expand a more specific code
expand_code("F320")

# Can be used with other functions
library(dplyr)
expand_code("F32") %>%
  filter(valid_billing_code == 1) %>%
  select(icd10cm_code, icd10cm_short_description)



cleanEx()
nameEx("header_code")
### * header_code

flush(stderr()); flush(stdout())

### Name: header_code
### Title: Retrieve the header code for a given ICD-10-CM code
### Aliases: header_code

### ** Examples

# Get header code for a specific diagnosis
header_code("F320")

# Header code returns itself if already a header
header_code("F32")

# You can also pass a vector of codes and get distinct header codes
library(dplyr)
library(purrr)
icd10cm %>%
  dplyr::filter(stringr::str_starts(icd10cm_code, "F32")) %>%
  dplyr::pull(icd10cm_code) %>%
  purrr::map_dfr(header_code) %>%
  unique()




cleanEx()
nameEx("icd10cm")
### * icd10cm

flush(stderr()); flush(stdout())

### Name: icd10cm
### Title: ICD-10-CM Codes.
### Aliases: icd10cm
### Keywords: datasets

### ** Examples

# View the first few rows
head(icd10cm)

# Filter to valid billing codes only
library(dplyr)
icd10cm %>% filter(valid_billing_code == 1)

# Find all chronic conditions
icd10cm %>% filter(chronic_indicator == "C")



cleanEx()
nameEx("icd10cm_chapters")
### * icd10cm_chapters

flush(stderr()); flush(stdout())

### Name: icd10cm_chapters
### Title: ICD-10-CM Chapters
### Aliases: icd10cm_chapters
### Keywords: datasets

### ** Examples

# View all chapters
icd10cm_chapters

# Find the chapter for mental health conditions
library(dplyr)
icd10cm_chapters %>% filter(chapter_abbr == "Mental")



cleanEx()
nameEx("icd10pcs")
### * icd10pcs

flush(stderr()); flush(stdout())

### Name: icd10pcs
### Title: ICD-10-PCS Codes.
### Aliases: icd10pcs
### Keywords: datasets

### ** Examples

# View the first few rows
head(icd10pcs)

# Filter to valid billing codes only
library(dplyr)
icd10pcs %>% filter(valid_billing_code == 1)

# Find all major therapeutic procedures
icd10pcs %>% filter(procedure_class == "Major Therapeutic")



cleanEx()
nameEx("icd10pcs_sections")
### * icd10pcs_sections

flush(stderr()); flush(stdout())

### Name: icd10pcs_sections
### Title: ICD-10-PCS Code Sections.
### Aliases: icd10pcs_sections
### Keywords: datasets

### ** Examples

# View all sections
icd10pcs_sections

# Find the Medical and Surgical section
library(dplyr)
icd10pcs_sections %>% filter(section_digit == "0")



cleanEx()
nameEx("is_valid_icd10cm")
### * is_valid_icd10cm

flush(stderr()); flush(stdout())

### Name: is_valid_icd10cm
### Title: Check if a string is a valid ICD-10-CM code format
### Aliases: is_valid_icd10cm

### ** Examples

is_valid_icd10cm("F320")  # TRUE - valid format
is_valid_icd10cm("F32")   # TRUE - valid format
is_valid_icd10cm("F32.0") # TRUE - valid format with dot
is_valid_icd10cm("296")   # FALSE - ICD-9 format (starts with number)
is_valid_icd10cm("F")     # FALSE - too short
is_valid_icd10cm("ABCDEF") # FALSE - no numbers




cleanEx()
nameEx("remove_dot")
### * remove_dot

flush(stderr()); flush(stdout())

### Name: remove_dot
### Title: Remove dot from an ICD-10 code
### Aliases: remove_dot

### ** Examples

remove_dot("F32.0")   # Returns "F320"
remove_dot("E11.9")   # Returns "E119"
remove_dot("F32")     # Returns "F32" (no dot to remove)
remove_dot("A01.01")  # Returns "A0101"




cleanEx()
nameEx("sample_icd10cm")
### * sample_icd10cm

flush(stderr()); flush(stdout())

### Name: sample_icd10cm
### Title: Generate sample ICD-10-CM diagnosis data
### Aliases: sample_icd10cm

### ** Examples

# Generate 100 records for 10 patients
sample_icd10cm(n = 100)

# Generate more records with more patients
sample_icd10cm(n = 1000, p = 50)

# Sample only from mental health codes (F codes)
sample_icd10cm(n = 100, start_code = "F00", end_code = "F99")

# Sample from diabetes codes
sample_icd10cm(n = 50, start_code = "E08", end_code = "E13")



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
