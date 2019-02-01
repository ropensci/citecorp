errs <- function(x) {
  if (x$status_code > 201) {
    fun <- fauxpas::find_error_class(x$status_code)$new()
    fun$do_verbose(x)
  }
}

oc_GET <- function(base, path = NULL, args = list(), ...) {
  cli <- crul::HttpClient$new(
    base,
    headers = list("User-Agent" = oc_ua(), "X-USER-AGENT" = oc_ua()),
    opts = list(...)
  )
  res <- cli$get(path, query = args)
  errs(res)
  res$parse("UTF-8")
}

oc_ua <- function() {
  versions <- c(
    paste0("r-curl/", utils::packageVersion("curl")),
    paste0("crul/", utils::packageVersion("crul")),
    sprintf("rOpenSci(citecorp/%s)",
            utils::packageVersion("citecorp"))
  )
  paste0(versions, collapse = " ")
}
