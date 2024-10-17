citecorp
=========

[![cran checks](https://cranchecks.info/badges/worst/citecorp)](https://cranchecks.info/pkgs/citecorp)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![R-check](https://github.com/ropensci/citecorp/workflows/R-check/badge.svg)](https://github.com/ropensci/citecorp/actions?query=workflow%3AR-check)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/citecorp)](https://github.com/metacran/cranlogs.app)
[![cran version](https://www.r-pkg.org/badges/version/citecorp)](https://cran.r-project.org/package=citecorp)

Client for the Open Citations Corpus http://opencitations.net/ (OCC)

OCC created their own identifiers called Open Citation Identifiers (oci), e.g., 

```
06180334099-06101759895
```

You are probably not going to be using oci identifiers, but rather DOIs and/or PMIDs
and/or PMCIDs. See `?oc_lookup` for methods for cross-walking among identifier types.

If you'd like to use the OpenCitations Sparql endpoint yourself you can find that
at http://opencitations.net/sparql


## Install

CRAN version


``` r
install.packages("citecorp")
```

Development version


``` r
remotes::install_github("ropensci/citecorp")
```


``` r
library("citecorp")
```

## Methods for converting IDs


``` r
oc_doi2ids("10.1097/igc.0000000000000609")
#>                                        doi     pmid
#> 1 https://w3id.org/oc/meta/br/061102460616 26645990
oc_pmid2ids("26645990")
#>                            doi                                     pmid
#> 1 10.1097/igc.0000000000000609 https://w3id.org/oc/meta/br/061102460616
oc_pmcid2ids("PMC4679344")
#> data frame with 0 columns and 0 rows
```

You can pass in more than one identifer to each of the above functions:


``` r
oc_doi2ids(oc_dois[1:6])
#>                                        doi     pmid
#> 1   https://w3id.org/oc/meta/br/0630171503 21577119
#> 2 https://w3id.org/oc/meta/br/062601718144  2670542
#> 3 https://w3id.org/oc/meta/br/061401102284 20702630
#> 4 https://w3id.org/oc/meta/br/062603752185 10461200
#> 5 https://w3id.org/oc/meta/br/061102146039 24711119
#> 6  https://w3id.org/oc/meta/br/06603713132 25263709
#> 7  https://w3id.org/oc/meta/br/06170394225     <NA>
```

## COCI methods

OpenCitations Index of Crossref open DOI-to-DOI references

If you don't load `tibble` you get normal data.frame's


``` r
library(tibble)
doi1 <- "10.1108/jd-12-2013-0166"
# references
oc_coci_refs(doi1)
#> # A tibble: 44 × 7
#>    timespan  citing                  creation   oci                      author_sc journal_sc cited                       
#>  * <chr>     <chr>                   <chr>      <chr>                    <chr>     <chr>      <chr>                       
#>  1 P1Y10M10D 10.1108/jd-12-2013-0166 2015-03-09 06180334099-06101759895  no        no         10.5539/ass.v9n5p18         
#>  2 P9Y2M5D   10.1108/jd-12-2013-0166 2015-03-09 06180334099-0610269965   no        no         10.1001/jama.295.1.90       
#>  3 P1Y5M     10.1108/jd-12-2013-0166 2015-03-09 06180334099-06110356152  no        no         10.1038/502298a             
#>  4 P1Y5M     10.1108/jd-12-2013-0166 2015-03-09 06180334099-06110356153  no        no         10.1038/502295a             
#>  5 P43Y      10.1108/jd-12-2013-0166 2015-03-09 06180334099-061301147654 no        no         10.1101/sqb.1972.036.01.015 
#>  6 P5Y10M20D 10.1108/jd-12-2013-0166 2015-03-09 06180334099-061301788813 no        no         10.1371/journal.pcbi.1000361
#>  7 P5Y2M27D  10.1108/jd-12-2013-0166 2015-03-09 06180334099-061303036324 no        no         10.1042/bio03106023         
#>  8 P2Y0M     10.1108/jd-12-2013-0166 2015-03-09 06180334099-06130345519  no        no         10.1038/495437a             
#>  9 P49Y7M9D  10.1108/jd-12-2013-0166 2015-03-09 06180334099-06130479737  no        no         10.1126/science.149.3683.510
#> 10 P2Y2M     10.1108/jd-12-2013-0166 2015-03-09 06180334099-06140344762  no        no         10.1038/493159a             
#> # ℹ 34 more rows
# citations
oc_coci_cites(doi1)
#> # A tibble: 34 × 7
#>    timespan  citing                         creation   oci                      author_sc journal_sc cited                  
#>  * <chr>     <chr>                          <chr>      <chr>                    <chr>     <chr>      <chr>                  
#>  1 P6Y0M1D   10.7717/peerj-cs.421           2021-03-10 06101801781-06180334099  no        no         10.1108/jd-12-2013-0166
#>  2 P4Y8M16D  10.3233/ds-190019              2019-11-25 06102227626-06180334099  no        no         10.1108/jd-12-2013-0166
#>  3 P4Y8M16D  10.3233/ds-190016              2019-11-25 06102227629-06180334099  yes       no         10.1108/jd-12-2013-0166
#>  4 P3Y10M12D 10.3233/sw-180307              2019-01-21 06103007421-06180334099  no        no         10.1108/jd-12-2013-0166
#>  5 P1Y0M14D  10.3233/sw-160224              2016-03-23 06103007543-06180334099  yes       no         10.1108/jd-12-2013-0166
#>  6 P2Y4M     10.1057/s41275-017-0070-x      2017-08    0610442128-06180334099   no        no         10.1108/jd-12-2013-0166
#>  7 P2Y11M20D 10.7287/peerj.preprints.3100v3 2018-03-01 06110834152-06180334099  no        no         10.1108/jd-12-2013-0166
#>  8 P1Y11M5D  10.1101/108480                 2017-02-14 061302465288-06180334099 no        no         10.1108/jd-12-2013-0166
#>  9 P3Y10M29D 10.59350/zcrhs-r7h02           2019-02-07 061303889475-06180334099 no        no         10.1108/jd-12-2013-0166
#> 10 P2Y       10.1007/978-3-030-01379-0_9    2018       061502183940-06180334099 yes       no         10.1108/jd-12-2013-0166
#> # ℹ 24 more rows
# metadata
oc_coci_meta(doi1)
#> # A tibble: 1 × 13
#>   oa_link issue reference                                                                                                                                                                                   source_title doi   citation year  citation_count title page  source_id volume author
#> * <chr>   <chr> <chr>                                                                                                                                                                                       <chr>        <chr> <chr>    <chr> <chr>          <chr> <chr> <chr>     <chr>  <chr> 
#> 1 ""      2     10.1136/bmj.b2680; 10.1145/1217821.1226695; 10.1145/2362499.2362502; 10.1136/bmj.a568; 10.1145/2494266.2494271; 10.1523/jneurosci.0003-08.2008; 10.1007/978-3-319-03524-6_29; 10.1073/pnas… Journal Of … 10.1… 10.1057… 2015… 34             Sett… 253-… issn:002… 71     Peron…
```


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/citecorp/issues)
* License: MIT
* Get citation information for `citecorp` in R doing `citation(package = 'citecorp')`
* Please note that this project is released with a [Contributor Code of Conduct][coc].
By participating in this project you agree to abide by its terms.

[sparqldsl]: https://github.com/ropensci/sparqldsl
[coc]: https://github.com/ropensci/citecorp/blob/master/CODE_OF_CONDUCT.md


[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
