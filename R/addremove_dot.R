#' Add a dot to an ICD-10 code
#'
#' @description
#' `add_dot()` adds a dot to the ICD-10 code in the appropriate position
#'  where one does not exist
#'
#' @param x A valid ICD-10 code without a dot
#'
#' @return A valid ICD-10 code with a dot included
#'
#' @export
#'
#' @examples
#' add_dot("F320")
#'
#' add_dot("F32")  # no dot added if code is only 3-digits
add_dot <- function(x) {

  stopifnot(!stringr::str_detect(x, stringr::fixed(".")))

  ifelse(stringr::str_length(x) > 3,
         gsub("^(.{3})(.*)$", paste0("\\1.\\2"), x),
         x)
}


#' Remove dot from an ICD-10 code
#'
#' @description
#' `remove_dot()` removes a dot from the ICD-10 code if it exists
#'
#' @param x A valid ICD-10 code with a dot
#'
#' @return A valid ICD-10 code without a dot included
#' @export
#'
#' @examples
#' remove_dot("F32.0")
#'
#' remove_dot("F32")
remove_dot <- function(x) {
  stringr::str_remove(x, stringr::fixed("."))
}
