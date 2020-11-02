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
remotes::install_github("ropensci/citecorp")
```


```r
library("citecorp")
```

## Methods for converting IDs


```r
oc_doi2ids("10.1097/igc.0000000000000609")
#>                            doi                           paper      pmcid
#> 1 10.1097/igc.0000000000000609 https://w3id.org/oc/corpus/br/1 PMC4679344
#>       pmid
#> 1 26645990
oc_pmid2ids("26645990")
#>                            doi                           paper      pmcid
#> 1 10.1097/igc.0000000000000609 https://w3id.org/oc/corpus/br/1 PMC4679344
#>       pmid
#> 1 26645990
oc_pmcid2ids("PMC4679344")
#>                            doi                           paper      pmcid
#> 1 10.1097/igc.0000000000000609 https://w3id.org/oc/corpus/br/1 PMC4679344
#>       pmid
#> 1 26645990
```

You can pass in more than one identifer to each of the above functions:


```r
oc_doi2ids(oc_dois[1:6])
#>                                  doi                                 paper
#> 1               10.1128/jvi.00758-10 https://w3id.org/oc/corpus/br/5357460
#> 2 10.1111/j.2042-3306.1989.tb02167.x  https://w3id.org/oc/corpus/br/589891
#> 3       10.1097/rli.0b013e31821eea45 https://w3id.org/oc/corpus/br/3931705
#> 4           10.1177/0148607114529597 https://w3id.org/oc/corpus/br/5016780
#> 5            10.1111/1567-1364.12217 https://w3id.org/oc/corpus/br/3819297
#> 6      10.1016/s0168-9525(99)01798-9 https://w3id.org/oc/corpus/br/4606537
#>        pmcid     pmid
#> 1 PMC2953162 20702630
#> 2       <NA>  2670542
#> 3       <NA> 21577119
#> 4       <NA> 24711119
#> 5       <NA> 25263709
#> 6       <NA> 10461200
```

## COCI methods

OpenCitations Index of Crossref open DOI-to-DOI references

If you don't load `tibble` you get normal data.frame's


```r
library(tibble)
doi1 <- "10.1108/jd-12-2013-0166"
# references
oc_coci_refs(doi1)
#> # A tibble: 37 x 7
#>    journal_sc author_sc timespan citing    oci             cited        creation
#>  * <chr>      <chr>     <chr>    <chr>     <chr>           <chr>        <chr>   
#>  1 no         no        P9Y2M5D  10.1108/… 02001010008361… 10.1001/jam… 2015-03…
#>  2 no         no        P41Y8M   10.1108/… 02001010008361… 10.1002/asi… 2015-03…
#>  3 no         no        P25Y6M   10.1108/… 02001010008361… 10.1002/(si… 2015-03…
#>  4 no         no        P17Y2M   10.1108/… 02001010008361… 10.1007/bf0… 2015-03…
#>  5 no         no        P2Y2M3D  10.1108/… 02001010008361… 10.1007/s10… 2015-03…
#>  6 no         no        P5Y8M27D 10.1108/… 02001010008361… 10.1007/s11… 2015-03…
#>  7 no         no        P2Y3M    10.1108/… 02001010008361… 10.1016/j.w… 2015-03…
#>  8 no         no        P1Y10M   10.1108/… 02001010008361… 10.1016/j.w… 2015-03…
#>  9 no         no        P12Y     10.1108/… 02001010008361… 10.1023/a:1… 2015-03…
#> 10 no         no        P13Y10M  10.1108/… 02001010008361… 10.1038/350… 2015-03…
#> # … with 27 more rows
# citations
oc_coci_cites(doi1)
#> # A tibble: 23 x 7
#>    journal_sc author_sc timespan  citing     oci               cited    creation
#>  * <chr>      <chr>     <chr>     <chr>      <chr>             <chr>    <chr>   
#>  1 no         no        P3Y       10.1145/3… 0200101040536030… 10.1108… 2018    
#>  2 no         no        P2Y5M     10.1057/s… 0200100050736280… 10.1108… 2017-08 
#>  3 no         no        P4Y1M1D   10.3233/d… 0200302030336132… 10.1108… 2019-04…
#>  4 no         no        P4Y5M10D  10.3233/d… 0200302030336132… 10.1108… 2019-08…
#>  5 no         no        P1Y0M14D  10.3233/s… 0200302030336283… 10.1108… 2016-03…
#>  6 no         no        P3Y10M12D 10.3233/s… 0200302030336283… 10.1108… 2019-01…
#>  7 no         no        P3Y6M     10.1142/s… 0200101040236280… 10.1108… 2018-09 
#>  8 no         no        P2Y11M20D 10.7554/e… 0200705050436142… 10.1108… 2018-03…
#>  9 no         no        P0Y       10.3346/j… 0200303040636192… 10.1108… 2015    
#> 10 no         no        P3Y       10.1007/9… 0200100000736090… 10.1108… 2018    
#> # … with 13 more rows
# metadata
oc_coci_meta(doi1)
#> # A tibble: 1 x 13
#>   doi   reference issue source_id citation page  volume author citation_count
#> * <chr> <chr>     <chr> <chr>     <chr>    <chr> <chr>  <chr>  <chr>         
#> 1 10.1… 10.1001/… 2     issn:002… 10.1145… 253-… 71     Peron… 23            
#> # … with 4 more variables: year <chr>, source_title <chr>, title <chr>,
#> #   oa_link <chr>
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
