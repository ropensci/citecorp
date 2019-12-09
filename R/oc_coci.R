#' COCI: OpenCitations Index of Crossref open
#' DOI-to-DOI references
#'
#' AFAICT this API is a REST wrapper around the SPARQL service
#'
#' @name oc_coci
#' @param doi (character) one or more Digital Object Identifiers
#' @param oci (character) a single Open Citation Identifier (OCI)
#' @param exclude (character) a field_name; all the rows that have an empty
#' value in the field_name specified are removed from the result set
#' @param filter `=<field_name>:<operator><value>:` only the rows compliant
#' with `<value>` are kept in the result set. The parameter `<operation>`
#' is not mandatory. If `<operation>` is not specified, `<value>` is
#' interpreted as a regular expression, otherwise it is compared by means
#' of the specified operation. Possible operators are "=", "<", and ">".
#' For instance, `filter=title:semantics?` returns all the rows that
#' contain the string "semantic" or "semantics" in the field title,
#' while `filter=date:>2016-05` returns all the rows that have a date
#' greater than May 2016.
#' @param sort `=<order>(<field_name>):` sort in ascending (`<order>` set to
#' "asc") or descending (`<order>` set to "desc") order the rows in the
#' result set according to the values in `<field_name>`. For instance,
#' `sort=desc(date)` sorts all the rows according to the value specified
#' in the field date in descending order.
#' @param ... curl options passed on to [crul::verb-GET]
#' @return data.frame, see http://opencitations.net/index/coci/api/v1 for
#' explanation of the resulting columns
#' @references http://opencitations.net/index/coci/api/v1,
#' https://github.com/opencitations/api-coci
#' @examples
#' doi1 <- "10.1108/jd-12-2013-0166"
#' doi2 <- "10.1371/journal.pgen.1005937"
#' oci1 <-
#'  "02001010806360107050663080702026306630509-0200101080636102704000806"
#' 
#' if (
#' crul::ok(
#' "http://opencitations.net/index/coci/api/v1/references/10.1108/jd-12-2013-0166",
#' timeout_ms = 1000L)
#' ) {
#' oc_coci_cites(doi1)
#' }
#' 
#' ### More examples
#' \donttest{
#' # references
#' oc_coci_refs(doi1, exclude = "oci")
#' oc_coci_refs(doi1, filter = "date:>2016-05", verbose = TRUE)
#' oc_coci_refs(doi2)
#'
#' # citations
#' oc_coci_cites(doi1, exclude = "oci")
#' oc_coci_cites(doi2)
#'
#' # metadata
#' oc_coci_meta(doi2)
#' oc_coci_meta(c(doi1, doi2))
#'
#' # citation - an OCI instead of a DOI
#' oc_coci_citation(oci1)
#' }

#' @export
#' @rdname oc_coci
oc_coci_refs <- function(doi, exclude=NULL, filter=NULL, sort=NULL, ...) {
  oc_coci_stub("references", doi, exclude, filter, sort, ...)
}

#' @export
#' @rdname oc_coci
oc_coci_cites <- function(doi, exclude=NULL, filter=NULL, sort=NULL, ...) {
  oc_coci_stub("citations", doi, exclude, filter, sort, ...)
}

#' @export
#' @rdname oc_coci
oc_coci_meta <- function(doi, exclude=NULL, filter=NULL, sort=NULL, ...) {
  oc_coci_stub("metadata", doi, exclude, filter, sort, ...)
}

#' @export
#' @rdname oc_coci
oc_coci_citation <- function(oci, ...) {
  assert(oci, "character")
  x <- oc_GET(coci_base, file.path(coci_meta, "citation", oci), ...)
  oc_coci_parser(x)
}


# helpers
oc_coci_stub <- function(path, doi, exclude, filter, sort, ...) {
  assert(doi, "character")
  assert(exclude, "character")
  assert(filter, "character")
  assert(sort, "character")
  args <- cp(list(exclude = exclude, filter = filter, sort = sort))
  doi <- paste0(doi, collapse = "__")
  x <- oc_GET(coci_base, file.path(coci_meta, path, doi),
    args = args, ...)
  oc_coci_parser(x)
}

oc_coci_parser <- function(x) {
  x <- jsonlite::fromJSON(x, FALSE)
  (z <- data.table::setDF(
    data.table::rbindlist(x, fill = TRUE, use.names = TRUE)))
  structure(z, class = c("tbl_df", "tbl", "data.frame"))
}

coci_meta <- "index/coci/api/v1"
