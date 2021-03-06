% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/header_code.R
\name{header_code}
\alias{header_code}
\title{Retrieves a header code for a given ICD-10-CM code}
\usage{
header_code(x)
}
\arguments{
\item{x}{a valid ICD-10-CM code}
}
\value{
Tibble of all matching ICD-10-CM rows from icd10cm
}
\description{
\code{header_code} returns a tibble of the code that corresponds
to the header for a given ICD-10-CM code.  If the input code
is a header code, the same code is returned.
}
\examples{
header_code("F320")

# you can also pass a vector of codes and then get the distinct
# header codes using purrr
icd10cm \%>\%
  dplyr::filter(stringr::str_starts(icd10cm_code, "F32")) \%>\%
  dplyr::pull(icd10cm_code) \%>\%
  purrr::map_dfr(header_code) \%>\%
  unique()

}
