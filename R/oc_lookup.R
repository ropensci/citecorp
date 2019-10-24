oc_2ids_template <- function(template_string, id_name) {
  function(id, ...) {
    assert(id, c("character", "integer", "numeric"))
    qry <- sprintf(template_string, paste0(sprintf("\"%s\"", id), collapse = " "))
    tmp <- cp_query(qry, ...)$results$bindings
    if (length(tmp) == 0) return(data.frame(NULL))
    df <- tmp[-grep('\\.type', names(tmp))]
    names(df) <- gsub("\\.value", "", names(df))
    names(df)[1] <- id_name
    df <- df[, names(df) %in% c("doi", "pmid", "pmcid", "paper")]
    return(df)
  }
}

#' Methods for getting IDs from other IDs
#'
#' @export
#' @name oc_lookup
#' @param id One or more digital object identifiers (DOI),
#' PMID, or PMCID, depending on the function
#' @return data.frame, with four columns:
#' 
#' - doi: digital object identifier
#' - pmid: pubmed identifier
#' - pmcid: pubmed central identifier
#' - paper: open citations corpus url
#' 
#' an empty data.frame (no columns or rows) when no results found
#' @param ... curl options passed on to [crul::verb-GET]
#' @examples
#' if (crul::ok('http://opencitations.net/sparql')) {
#' oc_doi2ids("10.1097/igc.0000000000000609")
#' oc_doi2ids('10.1093/biomet/80.3.527')
#' oc_doi2ids('10.1093/biomet/79.3.531')
#' oc_pmid2ids("26645990")
#' oc_pmcid2ids("PMC4679344")
#' 
#' oc_doi2ids(id = oc_dois[1:3])
#' oc_pmid2ids(id = oc_pmids[1:3])
#' oc_pmcid2ids(id = oc_pmcids[1:3])
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
