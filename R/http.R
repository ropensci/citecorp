coci_base <- "http://opencitations.net"

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

oc_sparql_GET <- function(url, path, query, flatten = FALSE, ...) {
  cli <- crul::HttpClient$new(
    url = url, opts = list(...),
    headers = list(
      Accept = "application/sparql-results+json",
      "User-Agent" = oc_ua(),
      "X-USER-AGENT" = oc_ua()
    )
  )
  qry <- list(query = query, format = "json")
  res <- cli$get(path, query = qry)
  res$raise_for_status()
  jsonlite::fromJSON(res$parse("UTF-8"), flatten = flatten)
}

oc_sparql_OK <- function(query) {
  cli <- crul::HttpClient$new(
    url = coci_base, opts = list(timeout_ms = 1000L),
    headers = list(
      Accept = "application/sparql-results+json",
      "User-Agent" = oc_ua(),
      "X-USER-AGENT" = oc_ua()
    )
  )
  url <- cli$url_fetch("sparql", query = list(query = query, format = "json"))
  crul::ok(url)
}

cp_query <- function(query, flatten = TRUE, ...) {
  oc_sparql_GET(coci_base, "meta/sparql", query, flatten = flatten, ...)
}
