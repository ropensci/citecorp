citecorp
=========

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Build Status](https://travis-ci.com/ropenscilabs/citecorp.svg?branch=master)](https://travis-ci.com/ropenscilabs/citecorp)



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
#>    author_sc creation  journal_sc oci           timespan cited      citing 
#>  * <chr>     <chr>     <chr>      <chr>         <chr>    <chr>      <chr>  
#>  1 no        2015-03-… no         020010100083… P9Y2M5D  10.1001/j… 10.110…
#>  2 no        2015-03-… no         020010100083… P41Y8M   10.1002/a… 10.110…
#>  3 no        2015-03-… no         020010100083… P25Y6M   10.1002/(… 10.110…
#>  4 no        2015-03-… no         020010100083… P17Y2M   10.1007/b… 10.110…
#>  5 no        2015-03-… no         020010100083… P2Y2M3D  10.1007/s… 10.110…
#>  6 no        2015-03-… no         020010100083… P5Y8M27D 10.1007/s… 10.110…
#>  7 no        2015-03-… no         020010100083… P2Y3M    10.1016/j… 10.110…
#>  8 no        2015-03-… no         020010100083… P1Y10M   10.1016/j… 10.110…
#>  9 no        2015-03-… no         020010100083… P12Y     10.1023/a… 10.110…
#> 10 no        2015-03-… no         020010100083… P13Y10M  10.1038/3… 10.110…
#> # … with 26 more rows
# citations
oc_coci_cites(doi1)
#> # A tibble: 13 x 7
#>    author_sc creation  journal_sc oci            timespan cited   citing   
#>  * <chr>     <chr>     <chr>      <chr>          <chr>    <chr>   <chr>    
#>  1 no        2016-07-… no         0200101070736… P1Y4M1D  10.110… 10.1177/…
#>  2 no        2018-03-… no         0200705050436… P2Y11M2… 10.110… 10.7554/…
#>  3 no        2018      no         0200101040536… P2Y      10.110… 10.1145/…
#>  4 no        2017-06-… no         0200100090336… P2Y3M4D  10.110… 10.1093/…
#>  5 no        2017      no         0200100000736… P1Y      10.110… 10.1007/…
#>  6 no        2015      no         0200303040636… P0Y      10.110… 10.3346/…
#>  7 no        2017-12-… no         0200100000736… P2Y9M12D 10.110… 10.1007/…
#>  8 no        2016-03-… no         0200302030336… P1Y14D   10.110… 10.3233/…
#>  9 no        2018-08-… no         0200302030336… P3Y5M4D  10.110… 10.3233/…
#> 10 no        2018      no         0200100000736… P2Y      10.110… 10.1007/…
#> 11 no        2018-07-… no         0200101040236… P3Y4M21D 10.110… 10.1142/…
#> 12 no        2017      no         0200100000736… P1Y      10.110… 10.1007/…
#> 13 no        2017-08   no         0200100050736… P2Y4M    10.110… 10.1057/…
# metadata
oc_coci_meta(doi1)
#> # A tibble: 1 x 13
#>   title doi   citation volume author oa_link year  reference citation_count
#> * <chr> <chr> <chr>    <chr>  <chr>  <chr>   <chr> <chr>     <chr>         
#> 1 Sett… 10.1… 10.1177… 71     Peron… ""      2015  10.1001/… 13            
#> # … with 4 more variables: source_title <chr>, page <chr>, issue <chr>,
#> #   source_id <chr>
```


## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/citecorp/issues)
* License: MIT
* Get citation information for `citecorp` in R doing `citation(package = 'citecorp')`
* Please note that this project is released with a [Contributor Code of Conduct][coc].
By participating in this project you agree to abide by its terms.

[sparqldsl]: https://github.com/ropenscilabs/sparqldsl
[coc]: https://github.com/ropenscilabs/citecorp/blob/master/CODE_OF_CONDUCT.md
