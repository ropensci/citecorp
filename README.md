citecorp
=========



Client for the Open Citations Corpus

## Install

Development version


```r
devtools::install_github("ropenscilabs/citecorp")
```


```r
library("citecorp")
```

## Open citations methods


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

## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/citecorp/issues)
* License: MIT
* Get citation information for `citecorp` in R doing `citation(package = 'citecorp')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
