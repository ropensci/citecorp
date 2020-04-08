citecorp
=========



[![cran checks](https://cranchecks.info/badges/worst/citecorp)](https://cranchecks.info/pkgs/citecorp)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build Status](https://travis-ci.com/ropenscilabs/citecorp.svg?branch=master)](https://travis-ci.com/ropenscilabs/citecorp)
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
remotes::install_github("ropenscilabs/citecorp")
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
#>    cited         timespan citing    journal_sc creation oci            author_sc
#>  * <chr>         <chr>    <chr>     <chr>      <chr>    <chr>          <chr>    
#>  1 10.1001/jama… P9Y2M5D  10.1108/… no         2015-03… 0200101000836… no       
#>  2 10.1002/asi.… P41Y8M   10.1108/… no         2015-03… 0200101000836… no       
#>  3 10.1002/(sic… P25Y6M   10.1108/… no         2015-03… 0200101000836… no       
#>  4 10.1007/bf02… P17Y2M   10.1108/… no         2015-03… 0200101000836… no       
#>  5 10.1007/s105… P2Y2M3D  10.1108/… no         2015-03… 0200101000836… no       
#>  6 10.1007/s111… P5Y8M27D 10.1108/… no         2015-03… 0200101000836… no       
#>  7 10.1016/j.we… P2Y3M    10.1108/… no         2015-03… 0200101000836… no       
#>  8 10.1016/j.we… P1Y10M   10.1108/… no         2015-03… 0200101000836… no       
#>  9 10.1023/a:10… P12Y     10.1108/… no         2015-03… 0200101000836… no       
#> 10 10.1038/3507… P13Y10M  10.1108/… no         2015-03… 0200101000836… no       
#> # … with 27 more rows
# citations
oc_coci_cites(doi1)
#> # A tibble: 20 x 7
#>    cited     timespan  citing    journal_sc creation oci               author_sc
#>  * <chr>     <chr>     <chr>     <chr>      <chr>    <chr>             <chr>    
#>  1 10.1108/… P3Y       10.1145/… no         2018     0200101040536030… no       
#>  2 10.1108/… P2Y5M     10.1057/… no         2017-08  0200100050736280… no       
#>  3 10.1108/… P4Y1M1D   10.3233/… no         2019-04… 0200302030336132… no       
#>  4 10.1108/… P4Y5M10D  10.3233/… no         2019-08… 0200302030336132… no       
#>  5 10.1108/… P1Y0M14D  10.3233/… no         2016-03… 0200302030336283… no       
#>  6 10.1108/… P3Y10M12D 10.3233/… no         2019-01… 0200302030336283… no       
#>  7 10.1108/… P3Y6M     10.1142/… no         2018-09  0200101040236280… no       
#>  8 10.1108/… P2Y11M20D 10.7554/… no         2018-03… 0200705050436142… no       
#>  9 10.1108/… P0Y       10.3346/… no         2015     0200303040636192… no       
#> 10 10.1108/… P3Y       10.1007/… no         2018     0200100000736090… no       
#> 11 10.1108/… P2Y3M4D   10.1093/… no         2017-06… 0200100090336111… no       
#> 12 10.1108/… P2Y       10.1007/… no         2017     0200100000736090… no       
#> 13 10.1108/… P3Y11M    10.1186/… no         2019-02  0200101080636280… no       
#> 14 10.1108/… P3Y       10.1007/… no         2018     0200100000736090… no       
#> 15 10.1108/… P3Y       10.1007/… no         2018     0200100000736090… no       
#> 16 10.1108/… P0Y       10.1007/… no         2015     0200100000736090… no       
#> 17 10.1108/… P2Y       10.1007/… no         2017     0200100000736090… no       
#> 18 10.1108/… P2Y9M12D  10.1007/… no         2017-12… 0200100000736090… no       
#> 19 10.1108/… P1Y11M5D  10.1101/… no         2017-02… 0200101000136010… no       
#> 20 10.1108/… P1Y4M1D   10.1177/… no         2016-07… 0200101070736000… no
# metadata
oc_coci_meta(doi1)
#> # A tibble: 1 x 13
#>   issue oa_link citation_count author source_title citation source_id volume
#> * <chr> <chr>   <chr>          <chr>  <chr>        <chr>    <chr>     <chr> 
#> 1 2     http:/… 20             Peron… Journal Of … 10.1145… issn:002… 71    
#> # … with 5 more variables: year <chr>, page <chr>, doi <chr>, reference <chr>,
#> #   title <chr>
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
