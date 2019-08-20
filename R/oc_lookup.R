oc_2ids_template <- function(template_string, id_name) {
  function(id, ...) {
    assert(id, c("character", "integer", "numeric"))
    stopifnot(length(id) == 1)
    qry <- sprintf(template_string, id)
    tmp <- cp_query(qry, ...)$results$bindings
    if (length(tmp) == 0) return(data.frame(NULL))
    tmp <- data.frame(
      type = gsub("\\.type", "", names(tmp[, grep("\\.type", names(tmp))])),
      value = unlist(unname(c(tmp[, grep("\\.value", names(tmp))]))),
      stringsAsFactors = FALSE
    )
    rbind(tmp, c(id_name, id))
  }
}

# FIXME: allow length > 1 id input

#' Methods for getting IDs from other IDs
#'
#' @export
#' @name oc_lookup
#' @param id Either a digital object identifier (DOI),
#' PMID, or PMCID, depending on the function
#' @return data.frame, with two columns, one for identifier type
#' and the other for the identifier value. Or an empty data.frame
#' when no results found
#' @param ... curl options passed on to [crul::verb-GET]
#' @examples \dontrun{
#' oc_doi2ids("10.1097/igc.0000000000000609")
#' oc_pmid2ids("26645990")
#' oc_pmcid2ids("PMC4679344")
#' }

#' @export
#' @rdname oc_lookup
oc_doi2ids <- oc_2ids_template(qry_doi2ids, "doi")

#' @export
#' @rdname oc_lookup
oc_pmid2ids <- oc_2ids_template(qry_pmid2ids, "pmid")

#' @export
#' @rdname oc_lookup
oc_pmcid2ids <- oc_2ids_template(qry_pmcid2ids, "pmcid")
