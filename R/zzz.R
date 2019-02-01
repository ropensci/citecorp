cp <- function(x) Filter(Negate(is.null), x)
`%||%` <- function(x, y) if (is.null(x)) y else x
