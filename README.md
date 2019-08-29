citecorp
=========



[![cran checks](https://cranchecks.info/badges/worst/citecorp)](https://cranchecks.info/pkgs/citecorp)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.com/ropenscilabs/citecorp.svg?branch=master)](https://travis-ci.com/ropenscilabs/citecorp)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/citecorp)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/citecorp)](https://cran.r-project.org/package=citecorp)

citecorp (like tacocorp, but for citations)

Client for the Open Citations Corpus <http://opencitations.net/> (OCC)

OCC created their own identifiers called Open Citation Identifiers (oci), e.g., 

```
020010009033611182421271436182433010601-02001030701361924302723102137251614233701000005090307
```

You are probably not going to be using oci identifiers, but rather DOIs and/or PMIDs
and/or PMCIDs. See `?oc_lookup` for methods for cross-walking among identifier types.

If you'd like to use the OpenCitations Sparql endpoint yourself you can find that
at http://opencitations.net/sparql


## Install

CRAN version


```r
install.packages("citecorp")
```

Development version


```r
devtools::install_github("ropenscilabs/citecorp")
```


```r
library("citecorp")
```

## Methods for converting IDs


```r
oc_doi2ids("10.1097/igc.0000000000000609")
#>    type                           value
#> 1 paper https://w3id.org/oc/corpus/br/1
#> 2  pmid                        26645990
#> 3 pmcid                      PMC4679344
#> 4   doi    10.1097/igc.0000000000000609
oc_pmid2ids("26645990")
#>    type                           value
#> 1 paper https://w3id.org/oc/corpus/br/1
#> 2   doi    10.1097/igc.0000000000000609
#> 3 pmcid                      PMC4679344
#> 4  pmid                        26645990
oc_pmcid2ids("PMC4679344")
#>    type                           value
#> 1 paper https://w3id.org/oc/corpus/br/1
#> 2   doi    10.1097/igc.0000000000000609
#> 3  pmid                        26645990
#> 4 pmcid                      PMC4679344
```

## COCI methods

OpenCitations Index of Crossref open DOI-to-DOI references

If you don't load `tibble` you get normal data.frame's


```r
library(tibble)
doi1 <- "10.1108/jd-12-2013-0166"
# references
oc_coci_refs(doi1)
#> # A tibble: 36 x 7
#>    journal_sc cited       timespan oci           author_sc citing  creation
#>  * <chr>      <chr>       <chr>    <chr>         <chr>     <chr>   <chr>   
#>  1 no         10.1001/ja… P9Y2M5D  020010100083… no        10.110… 2015-03…
#>  2 no         10.1002/as… P41Y8M   020010100083… no        10.110… 2015-03…
#>  3 no         10.1002/(s… P25Y6M   020010100083… no        10.110… 2015-03…
#>  4 no         10.1007/bf… P17Y2M   020010100083… no        10.110… 2015-03…
#>  5 no         10.1007/s1… P2Y2M3D  020010100083… no        10.110… 2015-03…
#>  6 no         10.1007/s1… P5Y8M27D 020010100083… no        10.110… 2015-03…
#>  7 no         10.1016/j.… P2Y3M    020010100083… no        10.110… 2015-03…
#>  8 no         10.1016/j.… P1Y10M   020010100083… no        10.110… 2015-03…
#>  9 no         10.1023/a:… P12Y     020010100083… no        10.110… 2015-03…
#> 10 no         10.1038/35… P13Y10M  020010100083… no        10.110… 2015-03…
#> # … with 26 more rows
# citations
oc_coci_cites(doi1)
#> # A tibble: 13 x 7
#>    journal_sc cited    timespan oci            author_sc citing    creation
#>  * <chr>      <chr>    <chr>    <chr>          <chr>     <chr>     <chr>   
#>  1 no         10.1108… P1Y4M1D  0200101070736… no        10.1177/… 2016-07…
#>  2 no         10.1108… P2Y11M2… 0200705050436… no        10.7554/… 2018-03…
#>  3 no         10.1108… P2Y      0200101040536… no        10.1145/… 2018    
#>  4 no         10.1108… P2Y3M4D  0200100090336… no        10.1093/… 2017-06…
#>  5 no         10.1108… P1Y      0200100000736… no        10.1007/… 2017    
#>  6 no         10.1108… P0Y      0200303040636… no        10.3346/… 2015    
#>  7 no         10.1108… P2Y9M12D 0200100000736… no        10.1007/… 2017-12…
#>  8 no         10.1108… P1Y14D   0200302030336… no        10.3233/… 2016-03…
#>  9 no         10.1108… P3Y5M4D  0200302030336… no        10.3233/… 2018-08…
#> 10 no         10.1108… P2Y      0200100000736… no        10.1007/… 2018    
#> 11 no         10.1108… P3Y4M21D 0200101040236… no        10.1142/… 2018-07…
#> 12 no         10.1108… P1Y      0200100000736… no        10.1007/… 2017    
#> 13 no         10.1108… P2Y4M    0200100050736… no        10.1057/… 2017-08
# metadata
oc_coci_meta(doi1)
#> # A tibble: 1 x 13
#>   author reference title issue source_id page  oa_link year  volume
#> * <chr>  <chr>     <chr> <chr> <chr>     <chr> <chr>   <chr> <chr> 
#> 1 Peron… 10.1001/… Sett… 2     issn:002… 253-… ""      2015  71    
#> # … with 4 more variables: citation_count <chr>, doi <chr>,
#> #   source_title <chr>, citation <chr>
```


## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/citecorp/issues)
* License: MIT
* Get citation information for `citecorp` in R doing `citation(package = 'citecorp')`
* Please note that this project is released with a [Contributor Code of Conduct][coc].
By participating in this project you agree to abide by its terms.

[sparqldsl]: https://github.com/ropenscilabs/sparqldsl
[coc]: https://github.com/ropenscilabs/citecorp/blob/master/CODE_OF_CONDUCT.md


[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
