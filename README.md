citecorp
================

<!--[![cran checks](https://cranchecks.info/badges/worst/citecorp)](https://cranchecks.info/pkgs/citecorp)-->

[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![R-check](https://github.com/ropensci/citecorp/workflows/R-check/badge.svg)](https://github.com/ropensci/citecorp/actions?query=workflow%3AR-check)
[![rstudio mirror
downloads](https://cranlogs.r-pkg.org/badges/citecorp)](https://github.com/metacran/cranlogs.app)
[![cran
version](https://www.r-pkg.org/badges/version/citecorp)](https://cran.r-project.org/package=citecorp)

Client for the Open Citations Corpus <http://opencitations.net/> (OCC)

OCC created their own identifiers called Open Citation Identifiers
(oci), e.g.,

    06180334099-06101759895

You are probably not going to be using oci identifiers, but rather DOIs
and/or PMIDs and/or PMCIDs. See `?oc_lookup` for methods for
cross-walking among identifier types.

If you’d like to use the OpenCitations Sparql endpoint yourself you can
find that at <http://opencitations.net/sparql>

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
oc_doi2ids("10.1039/c9sc00991d")
#>                  doi                                    paper      pmcid
#> 1 10.1039/c9sc00991d https://w3id.org/oc/meta/br/061103888040 PMC6422012
#> 2 10.1039/c9sc00991d https://w3id.org/oc/meta/br/061103888040 PMC6422012
#>       pmid
#> 1 31857888
#> 2 31859689
oc_pmid2ids("31857888")
#>                  doi                                    paper      pmcid
#> 1 10.1039/c9sc00991d https://w3id.org/oc/meta/br/061103888040 PMC6422012
#> 2 10.1039/c9sc02702e https://w3id.org/oc/meta/br/061103888040 PMC6422012
#>       pmid
#> 1 31857888
#> 2 31857888
oc_pmcid2ids("PMC6422012")
#>                  doi                                    paper      pmcid
#> 1 10.1039/c9sc00991d https://w3id.org/oc/meta/br/061103888040 PMC6422012
#> 2 10.1039/c9sc00991d https://w3id.org/oc/meta/br/061103888040 PMC6422012
#> 3 10.1039/c9sc02702e https://w3id.org/oc/meta/br/061103888040 PMC6422012
#> 4 10.1039/c9sc02702e https://w3id.org/oc/meta/br/061103888040 PMC6422012
#>       pmid
#> 1 31859689
#> 2 31857888
#> 3 31857888
#> 4 31859689
```

You can pass in more than one identifer to each of the above functions:

``` r
oc_doi2ids(oc_dois[1:6])
#>                                  doi                                    paper
#> 1       10.1097/rli.0b013e31821eea45   https://w3id.org/oc/meta/br/0630171503
#> 2 10.1111/j.2042-3306.1989.tb02167.x https://w3id.org/oc/meta/br/062601718144
#> 3               10.1128/jvi.00758-10 https://w3id.org/oc/meta/br/061401102284
#> 4      10.1016/s0168-9525(99)01798-9 https://w3id.org/oc/meta/br/062603752185
#> 5           10.1177/0148607114529597 https://w3id.org/oc/meta/br/061102146039
#> 6            10.1111/1567-1364.12217  https://w3id.org/oc/meta/br/06603713132
#> 7      10.1016/s0168-9525(99)01798-9  https://w3id.org/oc/meta/br/06170394225
#>       pmid
#> 1 21577119
#> 2  2670542
#> 3 20702630
#> 4 10461200
#> 5 24711119
#> 6 25263709
#> 7     <NA>
```

## COCI methods

OpenCitations Index of Crossref open DOI-to-DOI references

If you don’t load `tibble` you get normal data.frame’s

``` r
library(tibble)
doi1 <- "10.1108/jd-12-2013-0166"
# references
oc_coci_refs(doi1)
#> # A tibble: 44 × 7
#>    timespan  citing                  creation   oci   author_sc journal_sc cited
#>  * <chr>     <chr>                   <chr>      <chr> <chr>     <chr>      <chr>
#>  1 P1Y10M10D 10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.5…
#>  2 P9Y2M5D   10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.1…
#>  3 P1Y5M     10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.1…
#>  4 P1Y5M     10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.1…
#>  5 P43Y      10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.1…
#>  6 P5Y10M20D 10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.1…
#>  7 P5Y2M27D  10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.1…
#>  8 P2Y0M     10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.1…
#>  9 P49Y7M9D  10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.1…
#> 10 P2Y2M     10.1108/jd-12-2013-0166 2015-03-09 0618… no        no         10.1…
#> # ℹ 34 more rows
# citations
oc_coci_cites(doi1)
#> # A tibble: 34 × 7
#>    timespan  citing                    creation oci   author_sc journal_sc cited
#>  * <chr>     <chr>                     <chr>    <chr> <chr>     <chr>      <chr>
#>  1 P6Y0M1D   10.7717/peerj-cs.421      2021-03… 0610… no        no         10.1…
#>  2 P4Y8M16D  10.3233/ds-190019         2019-11… 0610… no        no         10.1…
#>  3 P4Y8M16D  10.3233/ds-190016         2019-11… 0610… yes       no         10.1…
#>  4 P3Y10M12D 10.3233/sw-180307         2019-01… 0610… no        no         10.1…
#>  5 P1Y0M14D  10.3233/sw-160224         2016-03… 0610… yes       no         10.1…
#>  6 P2Y4M     10.1057/s41275-017-0070-x 2017-08  0610… no        no         10.1…
#>  7 P2Y11M20D 10.7287/peerj.preprints.… 2018-03… 0611… no        no         10.1…
#>  8 P1Y11M5D  10.1101/108480            2017-02… 0613… no        no         10.1…
#>  9 P3Y10M29D 10.59350/zcrhs-r7h02      2019-02… 0613… no        no         10.1…
#> 10 P2Y       10.1007/978-3-030-01379-… 2018     0615… yes       no         10.1…
#> # ℹ 24 more rows
# metadata
oc_coci_meta(doi1)
#> # A tibble: 1 × 13
#>   oa_link issue reference source_title doi   citation year  citation_count title
#> * <chr>   <chr> <chr>     <chr>        <chr> <chr>    <chr> <chr>          <chr>
#> 1 ""      2     10.1136/… Journal Of … 10.1… 10.1057… 2015… 34             Sett…
#> # ℹ 4 more variables: page <chr>, source_id <chr>, volume <chr>, author <chr>
```

## Meta

  - Please [report any issues or
    bugs](https://github.com/ropensci/citecorp/issues)
  - License: MIT
  - Get citation information for `citecorp` in R doing `citation(package
    = 'citecorp')`
  - Please note that this project is released with a [Contributor Code
    of
    Conduct](https://github.com/ropensci/citecorp/blob/master/CODE_OF_CONDUCT.md).
    By participating in this project you agree to abide by its terms.

[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
