citecorp 0.2.0
==============

### NEW FEATURES

* the functions `oc_doi2ids`, `oc_pmid2ids`, and `oc_pmcid2ids` (see `?oc_lookup`) now all accept more than 1 identifier. the underlying SPARQL queries were modified to make this possible. (#1)
* three new package datasets (oc_dois, oc_pmids, oc_pmcids) with vectors of identifiers of each of those types for testing and examples

### BUG FIXES

* fixed an error in parsing results in `oc_lookup` functions - this fix was later changed as part of another fix, but still appreciated (#2) (#3) thanks @Selbosh
* fix to parsing in `oc_lookup` functions: only retrieve data.frame columns if they exist - prevents error on retrieving a column that doesn't exist (#4) thanks @Selbosh


citecorp 0.1.0
==============

### NEW FEATURES

* Released to CRAN
