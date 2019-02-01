citecorp
=========

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Build Status](https://travis-ci.com/ropenscilabs/citecorp.svg?branch=master)](https://travis-ci.com/ropenscilabs/citecorp)



citecorp (ya know, like tacocorp, but for citations) 

Client for the Open Citations Corpus

uses an WIP pkg under the hood: [sparqldsl][]

## Install

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

If you don't load `tibble` you get mormal data.frame's


```r
library(tibble)
doi1 <- "10.1108/jd-12-2013-0166"
# references
oc_coci_refs(doi1)
#> # A tibble: 36 x 7
#>    cited       oci           author_sc journal_sc timespan creation citing 
#>  * <chr>       <chr>         <chr>     <chr>      <chr>    <chr>    <chr>  
#>  1 10.1001/ja… 020010100083… no        no         P9Y2M5D  2015-03… 10.110…
#>  2 10.1002/as… 020010100083… no        no         P41Y8M   2015-03… 10.110…
#>  3 10.1002/(s… 020010100083… no        no         P25Y6M   2015-03… 10.110…
#>  4 10.1007/bf… 020010100083… no        no         P17Y2M   2015-03… 10.110…
#>  5 10.1007/s1… 020010100083… no        no         P2Y2M3D  2015-03… 10.110…
#>  6 10.1007/s1… 020010100083… no        no         P5Y8M27D 2015-03… 10.110…
#>  7 10.1016/j.… 020010100083… no        no         P2Y3M    2015-03… 10.110…
#>  8 10.1016/j.… 020010100083… no        no         P1Y10M   2015-03… 10.110…
#>  9 10.1023/a:… 020010100083… no        no         P12Y     2015-03… 10.110…
#> 10 10.1038/35… 020010100083… no        no         P13Y10M  2015-03… 10.110…
#> # … with 26 more rows
# citations
oc_coci_cites(doi1)
#> # A tibble: 13 x 7
#>    cited    oci            author_sc journal_sc timespan creation citing   
#>  * <chr>    <chr>          <chr>     <chr>      <chr>    <chr>    <chr>    
#>  1 10.1108… 0200101070736… no        no         P1Y4M1D  2016-07… 10.1177/…
#>  2 10.1108… 0200705050436… no        no         P2Y11M2… 2018-03… 10.7554/…
#>  3 10.1108… 0200101040536… no        no         P2Y      2018     10.1145/…
#>  4 10.1108… 0200100090336… no        no         P2Y3M4D  2017-06… 10.1093/…
#>  5 10.1108… 0200100000736… no        no         P1Y      2017     10.1007/…
#>  6 10.1108… 0200303040636… no        no         P0Y      2015     10.3346/…
#>  7 10.1108… 0200100000736… no        no         P2Y9M12D 2017-12… 10.1007/…
#>  8 10.1108… 0200302030336… no        no         P1Y14D   2016-03… 10.3233/…
#>  9 10.1108… 0200302030336… no        no         P3Y5M4D  2018-08… 10.3233/…
#> 10 10.1108… 0200100000736… no        no         P2Y      2018     10.1007/…
#> 11 10.1108… 0200101040236… no        no         P3Y4M21D 2018-07… 10.1142/…
#> 12 10.1108… 0200100000736… no        no         P1Y      2017     10.1007/…
#> 13 10.1108… 0200100050736… no        no         P2Y4M    2017-08  10.1057/…
# metadata
oc_coci_meta(doi1)
#> # A tibble: 1 x 13
#>   citation author issue source_title doi   title oa_link volume
#> * <chr>    <chr>  <chr> <chr>        <chr> <chr> <chr>   <chr> 
#> 1 10.1177… Peron… 2     Journal Of … 10.1… Sett… ""      71    
#> # … with 5 more variables: citation_count <chr>, page <chr>, year <chr>,
#> #   source_id <chr>, reference <chr>
```


## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/citecorp/issues)
* License: MIT
* Get citation information for `citecorp` in R doing `citation(package = 'citecorp')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

[sparqldsl]: https://github.com/ropenscilabs/sparqldsl
