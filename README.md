citecorp
=========



[![cran checks](https://cranchecks.info/badges/worst/citecorp)](https://cranchecks.info/pkgs/citecorp)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.com/ropenscilabs/citecorp.svg?branch=master)](https://travis-ci.com/ropenscilabs/citecorp)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/citecorp)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/citecorp)](https://cran.r-project.org/package=citecorp)

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
#>                            doi     pmid      pmcid
#> 1 10.1097/igc.0000000000000609 26645990 PMC4679344
#>                             paper
#> 1 https://w3id.org/oc/corpus/br/1
oc_pmid2ids("26645990")
#>                            doi     pmid      pmcid
#> 1 10.1097/igc.0000000000000609 26645990 PMC4679344
#>                             paper
#> 1 https://w3id.org/oc/corpus/br/1
oc_pmcid2ids("PMC4679344")
#>                            doi     pmid      pmcid
#> 1 10.1097/igc.0000000000000609 26645990 PMC4679344
#>                             paper
#> 1 https://w3id.org/oc/corpus/br/1
```

You can pass in more than one identifer to each of the above functions:


```r
oc_doi2ids(oc_dois[1:6])
#>                                  doi     pmid      pmcid
#> 1               10.1128/jvi.00758-10 20702630 PMC2953162
#> 2 10.1111/j.2042-3306.1989.tb02167.x  2670542       <NA>
#> 3       10.1097/rli.0b013e31821eea45 21577119       <NA>
#> 4           10.1177/0148607114529597 24711119       <NA>
#> 5            10.1111/1567-1364.12217 25263709       <NA>
#> 6      10.1016/s0168-9525(99)01798-9 10461200       <NA>
#>                                   paper
#> 1 https://w3id.org/oc/corpus/br/5357460
#> 2  https://w3id.org/oc/corpus/br/589891
#> 3 https://w3id.org/oc/corpus/br/3931705
#> 4 https://w3id.org/oc/corpus/br/5016780
#> 5 https://w3id.org/oc/corpus/br/3819297
#> 6 https://w3id.org/oc/corpus/br/4606537
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
#>    journal_sc creation  author_sc citing   cited      timespan oci         
#>  * <chr>      <chr>     <chr>     <chr>    <chr>      <chr>    <chr>       
#>  1 no         2015-03-… no        10.1108… 10.1001/j… P9Y2M5D  02001010008…
#>  2 no         2015-03-… no        10.1108… 10.1002/a… P41Y8M   02001010008…
#>  3 no         2015-03-… no        10.1108… 10.1002/(… P25Y6M   02001010008…
#>  4 no         2015-03-… no        10.1108… 10.1007/b… P17Y2M   02001010008…
#>  5 no         2015-03-… no        10.1108… 10.1007/s… P2Y2M3D  02001010008…
#>  6 no         2015-03-… no        10.1108… 10.1007/s… P5Y8M27D 02001010008…
#>  7 no         2015-03-… no        10.1108… 10.1016/j… P2Y3M    02001010008…
#>  8 no         2015-03-… no        10.1108… 10.1016/j… P1Y10M   02001010008…
#>  9 no         2015-03-… no        10.1108… 10.1023/a… P12Y     02001010008…
#> 10 no         2015-03-… no        10.1108… 10.1038/3… P13Y10M  02001010008…
#> # … with 26 more rows
# citations
oc_coci_cites(doi1)
#> # A tibble: 13 x 7
#>    journal_sc creation  author_sc citing    cited   timespan oci           
#>  * <chr>      <chr>     <chr>     <chr>     <chr>   <chr>    <chr>         
#>  1 no         2016-07-… no        10.1177/… 10.110… P1Y4M1D  0200101070736…
#>  2 no         2018-03-… no        10.7554/… 10.110… P2Y11M2… 0200705050436…
#>  3 no         2018      no        10.1145/… 10.110… P2Y      0200101040536…
#>  4 no         2017-06-… no        10.1093/… 10.110… P2Y3M4D  0200100090336…
#>  5 no         2017      no        10.1007/… 10.110… P1Y      0200100000736…
#>  6 no         2015      no        10.3346/… 10.110… P0Y      0200303040636…
#>  7 no         2017-12-… no        10.1007/… 10.110… P2Y9M12D 0200100000736…
#>  8 no         2016-03-… no        10.3233/… 10.110… P1Y14D   0200302030336…
#>  9 no         2018-08-… no        10.3233/… 10.110… P3Y5M4D  0200302030336…
#> 10 no         2018      no        10.1007/… 10.110… P2Y      0200100000736…
#> 11 no         2018-07-… no        10.1142/… 10.110… P3Y4M21D 0200101040236…
#> 12 no         2017      no        10.1007/… 10.110… P1Y      0200100000736…
#> 13 no         2017-08   no        10.1057/… 10.110… P2Y4M    0200100050736…
# metadata
oc_coci_meta(doi1)
#> # A tibble: 1 x 13
#>   doi   source_id author title citation_count volume issue oa_link citation
#> * <chr> <chr>     <chr>  <chr> <chr>          <chr>  <chr> <chr>   <chr>   
#> 1 10.1… issn:002… Peron… Sett… 13             71     2     ""      10.1177…
#> # … with 4 more variables: reference <chr>, page <chr>, year <chr>,
#> #   source_title <chr>
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
