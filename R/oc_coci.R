#' COCI: OpenCitations Index of Crossref open
#' DOI-to-DOI references
#'
#' @name oc_coci
#' @param doi (character) one or more Digital Object Identifiers
#' @param oci (character) a single Open Citation Identifier (OCI)
#' @param ... curl options passed on to [crul::verb-GET]
#' @return data.frame
#' @examples
#' doi1 <- "10.1108/jd-12-2013-0166"
#' doi2 <- "10.6084/m9.figshare.3443876"
#' oci1 <- "02001010806360107050663080702026306630509-0200101080636102704000806" 
#' 
#' # references
#' oc_coci_refs(doi1)
#' oc_coci_refs(doi2)
#' 
#' # citations
#' oc_coci_cites(doi1)
#' oc_coci_cites(doi2)
#' 
#' # metadata
#' oc_coci_meta(doi1)
#' oc_coci_meta(doi2)
#' oc_coci_meta(c(doi1, doi2))
#' 
#' # citation - an OCI instead of a DOI
#' oc_coci_citation(oci1)

#' @export
#' @name oc_coci
oc_coci_refs <- function(doi, ...) {
  doi <- paste0(doi, collapse = "__")
  x <- oc_GET(coci_base, file.path(coci_meta, "references", doi), ...)
  oc_coci_parser(x)
}

#' @export
#' @name oc_coci
oc_coci_cites <- function(doi, ...) {
  doi <- paste0(doi, collapse = "__")
  x <- oc_GET(coci_base, file.path(coci_meta, "citations", doi), ...)
  oc_coci_parser(x)
}

#' @export
#' @name oc_coci
oc_coci_meta <- function(doi, ...) {
  doi <- paste0(doi, collapse = "__")
  x <- oc_GET(coci_base, file.path(coci_meta, "metadata", doi), ...)
  oc_coci_parser(x)
}

#' @export
#' @name oc_coci
oc_coci_citation <- function(oci, ...) {
  x <- oc_GET(coci_base, file.path(coci_meta, "citation", oci), ...)
  oc_coci_parser(x)
}


# helpers
oc_coci_parser <- function(x) {
  x <- jsonlite::fromJSON(x, FALSE)
  (z <- data.table::setDF(
    data.table::rbindlist(x, fill = TRUE, use.names = TRUE)))
  structure(z, class = c("tbl_df", "tbl", "data.frame"))
}

coci_base <- "http://opencitations.net"
coci_meta <- "index/coci/api/v1"
