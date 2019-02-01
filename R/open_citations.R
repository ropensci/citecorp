qry_doi2ids <- 'PREFIX datacite: <http://purl.org/spar/datacite/>
  PREFIX literal: <http://www.essepuntato.it/2010/06/literalreification/>
  SELECT ?paper ?pmid ?pmcid WHERE {
    ?paper datacite:hasIdentifier [ 
        datacite:usesIdentifierScheme datacite:doi ;
        literal:hasLiteralValue "%s"
    ] .
    
    OPTIONAL {
      ?paper datacite:hasIdentifier [ 
        datacite:usesIdentifierScheme datacite:pmid ;
        literal:hasLiteralValue ?pmid
      ] .
    }
    
    OPTIONAL {
      ?paper datacite:hasIdentifier [ 
        datacite:usesIdentifierScheme datacite:pmcid ;
        literal:hasLiteralValue ?pmcid
      ] .
    }
  }'

qry_pmid2ids <- 'PREFIX datacite: <http://purl.org/spar/datacite/>
  PREFIX literal: <http://www.essepuntato.it/2010/06/literalreification/>
  SELECT ?paper ?doi ?pmcid WHERE {
    ?paper datacite:hasIdentifier [ 
        datacite:usesIdentifierScheme datacite:pmid ;
        literal:hasLiteralValue "%s"
    ] .
    
    OPTIONAL {
      ?paper datacite:hasIdentifier [ 
        datacite:usesIdentifierScheme datacite:doi ;
        literal:hasLiteralValue ?doi
      ] .
    }
    
    OPTIONAL {
      ?paper datacite:hasIdentifier [ 
        datacite:usesIdentifierScheme datacite:pmcid ;
        literal:hasLiteralValue ?pmcid
      ] .
    }
  }'

qry_pmcid2ids <- 'PREFIX datacite: <http://purl.org/spar/datacite/>
  PREFIX literal: <http://www.essepuntato.it/2010/06/literalreification/>
  SELECT ?paper ?doi ?pmid WHERE {
    ?paper datacite:hasIdentifier [ 
        datacite:usesIdentifierScheme datacite:pmcid ;
        literal:hasLiteralValue "%s"
    ] .
    
    OPTIONAL {
      ?paper datacite:hasIdentifier [ 
        datacite:usesIdentifierScheme datacite:doi ;
        literal:hasLiteralValue ?doi
      ] .
    }
    
    OPTIONAL {
      ?paper datacite:hasIdentifier [ 
        datacite:usesIdentifierScheme datacite:pmid ;
        literal:hasLiteralValue ?pmid
      ] .
    }
  }'

oc_2ids_template <- function(template_string, id_name) {
  function(id, ...) {
   qry <- sprintf(template_string, id)
    conn <- sparqldsl::SparqlClient$new(
      url = "opencitations.net", path = "sparql")
    tmp <- conn$query(qry, ...)$results$bindings
    if (length(tmp) == 0) return(data.frame(NULL))
    tmp <- data.frame(
      type = gsub("\\.type", "", names(tmp[, grep("\\.type", names(tmp))])),
      value = unlist(unname(c(tmp[, grep("\\.value", names(tmp))]))),
      stringsAsFactors = FALSE
    )
    rbind(tmp, c(id_name, id))
  }
}

#' OpenCitations methods for getting IDs from other IDs
#' 
#' @export
#' @param id Either a digital object identifier (DOI), 
#' PMID, or PMCID, depending on the function
#' @return data.frame, with two columns, one for identifier type
#' and the other for the identifier value
#' @param ... curl options passed on to [crul::HttpClient]
#' @examples
#' oc_doi2ids("10.1097/igc.0000000000000609")
#' oc_pmid2ids("26645990")
#' oc_pmcid2ids("PMC4679344")

#' @export
#' @rdname open_citations
oc_doi2ids <- oc_2ids_template(qry_doi2ids, "doi")

#' @export
#' @rdname open_citations
oc_pmid2ids <- oc_2ids_template(qry_pmid2ids, "pmid")

#' @export
#' @rdname open_citations
oc_pmcid2ids <- oc_2ids_template(qry_pmcid2ids, "pmcid")
