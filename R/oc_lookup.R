oc_2ids_template <- function(template_string, id_name) {
  function(id, ...) {
    # Ensure id is of correct type
    assert(id, c("character", "integer", "numeric"))

    # Construct the query string
    qry <- sprintf(template_string, paste0(sprintf("\"%s\"", id), collapse = " "))

    # Execute the query and get results
    tmp <- cp_query(qry, ...)$results$bindings

    # If no results, return an empty data.frame
    if (length(tmp) == 0) return(data.frame(NULL))

    # Process the results
    df <- tmp[-grep('\\.type', names(tmp))]
    names(df) <- gsub("\\.value", "", names(df))
    names(df)[names(df) == "value"] <- id_name
    df <- df[, names(df) %in% c("doi", "pmid", "pmcid", "paper"), drop = FALSE]
    df <- df[, sort(names(df)), drop = FALSE]

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
#' An empty data.frame (no columns or rows) when no results found
#' 
#' Column order will always be the same; note though that some
#' columns may be missing if, for example, there's no PMID for
#' a DOI search.
#' @param ... curl options passed on to [crul::verb-GET]
#' @examples
#' if (oc_lookup_check()) {
#' try(
#'   oc_doi2ids("10.1097/igc.0000000000000609", timeout_ms=10),
#'   silent = TRUE
#' )
#' }
#' 
#' ### More examples
#' \dontrun{
#' oc_doi2ids('10.1093/biomet/80.3.527')
#' oc_doi2ids('10.1093/biomet/79.3.531')
#' oc_pmid2ids("31857888")
#' oc_pmcid2ids("PMC6422012")
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

#' oc_lookup checker
#' @export
#' @keywords internal
oc_lookup_check <- function() {
  qry <- sprintf(qry_doi2ids, "\"10.1093/biomet/80.3.527\"")
  oc_sparql_OK(qry)
}
