cp <- function(x) Filter(Negate(is.null), x)
`%||%` <- function(x, y) if (is.null(x)) y else x

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
          paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

assert_len <- function(x, y) {
  if (!is.null(x)) {
    if (length(x) != y) {
      stop(deparse(substitute(x)), " must be of length ", y,
        call. = FALSE)
    }
  }
}

lst2df <- function(x) {  
  (z <- data.table::setDF(
      data.table::rbindlist(x, fill = TRUE, use.names = TRUE)))
}

lst2df_tbl <- function(x) {  
  structure(lst2df(x), class = c("tbl_df", "tbl", "data.frame"))
}

