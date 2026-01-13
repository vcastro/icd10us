#' Add a dot to an ICD-10 code
#'
#' @description
#' `add_dot()` adds a dot (decimal point) to an ICD-10 code in the 
#' appropriate position (after the first 3 characters) where one does not exist.
#' This converts codes to the "dotted" format commonly used in clinical documentation.
#'
#' @param x A valid ICD-10 code without a dot
#'
#' @return A valid ICD-10 code with a dot included (if applicable).
#'   Codes with only 3 characters are returned unchanged since they don't
#'   require a dot.
#'   
#' @details
#' ICD-10 codes can be represented with or without a decimal point. The
#' decimal is always placed after the first 3 characters (e.g., "F32.0"
#' not "F3.20"). This function performs that conversion.
#' 
#' Codes with 3 or fewer characters don't need a dot and are returned unchanged.
#' The input code must not already contain a dot.
#'
#' @export
#'
#' @examples
#' add_dot("F320")     # Returns "F32.0"
#' add_dot("E119")     # Returns "E11.9"
#' add_dot("F32")      # Returns "F32" (no dot added for 3-character codes)
#' add_dot("A0101")    # Returns "A01.01"
#'
add_dot <- function(x) {

  stopifnot(!stringr::str_detect(x, stringr::fixed(".")))

  ifelse(stringr::str_length(x) > 3,
         gsub("^(.{3})(.*)$", paste0("\\1.\\2"), x),
         x)
}


#' Remove dot from an ICD-10 code
#'
#' @description
#' `remove_dot()` removes a dot (decimal point) from an ICD-10 code if it exists.
#' This converts codes to the "undotted" format which is used in many electronic
#' health record systems and datasets.
#'
#' @param x A valid ICD-10 code (with or without a dot)
#'
#' @return A valid ICD-10 code without a dot included
#' 
#' @details
#' ICD-10 codes can be represented with or without a decimal point. Many
#' electronic systems store codes without dots for consistency. This function
#' removes any dots if present.
#' 
#' If the code doesn't contain a dot, it is returned unchanged.
#'
#' @export
#'
#' @examples
#' remove_dot("F32.0")   # Returns "F320"
#' remove_dot("E11.9")   # Returns "E119"
#' remove_dot("F32")     # Returns "F32" (no dot to remove)
#' remove_dot("A01.01")  # Returns "A0101"
#'
remove_dot <- function(x) {
  stringr::str_remove(x, stringr::fixed("."))
}
