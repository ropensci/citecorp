citecorp
=========



[![cran checks](https://cranchecks.info/badges/worst/citecorp)](https://cranchecks.info/pkgs/citecorp)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build Status](https://travis-ci.com/ropenscilabs/citecorp.svg?branch=master)](https://travis-ci.com/ropenscilabs/citecorp)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/citecorp)](https://github.com/metacran/cranlogs.app)
[![cran version](https://www.r-pkg.org/badges/version/citecorp)](https://cran.r-project.org/package=citecorp)

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
#> # A tibble: 36 x 7
#>    citing   timespan journal_sc oci           creation author_sc cited     
#>  * <chr>    <chr>    <chr>      <chr>         <chr>    <chr>     <chr>     
#>  1 10.1108… P9Y2M5D  no         020010100083… 2015-03… no        10.1001/j…
#>  2 10.1108… P41Y8M   no         020010100083… 2015-03… no        10.1002/a…
#>  3 10.1108… P25Y6M   no         020010100083… 2015-03… no        10.1002/(…
#>  4 10.1108… P17Y2M   no         020010100083… 2015-03… no        10.1007/b…
#>  5 10.1108… P2Y2M3D  no         020010100083… 2015-03… no        10.1007/s…
#>  6 10.1108… P5Y8M27D no         020010100083… 2015-03… no        10.1007/s…
#>  7 10.1108… P2Y3M    no         020010100083… 2015-03… no        10.1016/j…
#>  8 10.1108… P1Y10M   no         020010100083… 2015-03… no        10.1016/j…
#>  9 10.1108… P12Y     no         020010100083… 2015-03… no        10.1023/a…
#> 10 10.1108… P13Y10M  no         020010100083… 2015-03… no        10.1038/3…
#> # … with 26 more rows
# citations
oc_coci_cites(doi1)
#> # A tibble: 13 x 7
#>    citing    timespan  journal_sc oci            creation author_sc cited  
#>  * <chr>     <chr>     <chr>      <chr>          <chr>    <chr>     <chr>  
#>  1 10.1177/… P1Y4M1D   no         0200101070736… 2016-07… no        10.110…
#>  2 10.7554/… P2Y11M20D no         0200705050436… 2018-03… no        10.110…
#>  3 10.1145/… P2Y       no         0200101040536… 2018     no        10.110…
#>  4 10.1093/… P2Y3M4D   no         0200100090336… 2017-06… no        10.110…
#>  5 10.1007/… P1Y       no         0200100000736… 2017     no        10.110…
#>  6 10.3346/… P0Y       no         0200303040636… 2015     no        10.110…
#>  7 10.1007/… P2Y9M12D  no         0200100000736… 2017-12… no        10.110…
#>  8 10.3233/… P1Y14D    no         0200302030336… 2016-03… no        10.110…
#>  9 10.3233/… P3Y5M4D   no         0200302030336… 2018-08… no        10.110…
#> 10 10.1007/… P2Y       no         0200100000736… 2018     no        10.110…
#> 11 10.1142/… P3Y4M21D  no         0200101040236… 2018-07… no        10.110…
#> 12 10.1007/… P1Y       no         0200100000736… 2017     no        10.110…
#> 13 10.1057/… P2Y4M     no         0200100050736… 2017-08  no        10.110…
# metadata
oc_coci_meta(doi1)
#> # A tibble: 1 x 13
#>   author source_title doi   page  citation oa_link citation_count title
#> * <chr>  <chr>        <chr> <chr> <chr>    <chr>   <chr>          <chr>
#> 1 Peron… Journal Of … 10.1… 253-… 10.1177… ""      13             Sett…
#> # … with 5 more variables: volume <chr>, reference <chr>, issue <chr>,
#> #   year <chr>, source_id <chr>
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
