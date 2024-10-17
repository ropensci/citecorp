#' @title citecorp
#' @description Client for the Open Citations Corpus http://opencitations.net/
#' @importFrom fauxpas http find_error_class
#' @importFrom data.table setDF rbindlist
#' @importFrom jsonlite fromJSON
#' @importFrom crul HttpClient
#' @name citecorp-package
#' @aliases citecorp
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @author David Selby \email{david_antony.selby@dfki.de}
#' @keywords package
"_PACKAGE"

#' Vector of 25 DOIs (Digital Object Identifiers)
#'
#' To be used in examples, etc. for [oc_lookup] and [oc_coci]
#' methods
#'
#' @name oc_dois
#' @docType data
#' @keywords data
NULL

#' Vector of 24 PMIDs (PubMed Identifiers)
#'
#' To be used in examples, etc. for [oc_lookup] and [oc_coci]
#' methods
#'
#' @name oc_pmids
#' @docType data
#' @keywords data
NULL

#' Vector of 8 PMCIDs (PubMed Central Identifiers)
#'
#' To be used in examples, etc. for [oc_lookup] and [oc_coci]
#' methods
#'
#' @name oc_pmcids
#' @docType data
#' @keywords data
NULL
