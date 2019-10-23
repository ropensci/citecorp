context("oc_doi2ids")
test_that("oc_doi2ids works", {
  vcr::use_cassette("oc_doi2ids", {
    x <- oc_doi2ids("10.1097/igc.0000000000000609")
  })

  expect_is(x, "data.frame")
  expect_named(x, c("doi", "pmid", "pmcid", "paper"))
  for (i in seq_len(NCOL(x))) expect_is(x[,i], "character")
})

test_that("oc_doi2ids fails well", {
  expect_error(oc_doi2ids(), "argument \"id\" is missing")
  expect_error(oc_doi2ids(matrix()), "id must be of class")
})



context("oc_pmid2ids")
test_that("oc_pmid2ids works", {
  vcr::use_cassette("oc_pmid2ids", {
    x <- oc_pmid2ids("26645990")
  })

  expect_is(x, "data.frame")
  expect_named(x, c("doi", "pmid", "pmcid", "paper"))
  for (i in seq_len(NCOL(x))) expect_is(x[,i], "character")
})

test_that("oc_pmid2ids fails well", {
  expect_error(oc_pmid2ids(), "argument \"id\" is missing")
  expect_error(oc_pmid2ids(matrix()), "id must be of class")
})



context("oc_pmcid2ids")
test_that("oc_pmcid2ids works", {
  vcr::use_cassette("oc_pmcid2ids", {
    x <- oc_pmcid2ids("PMC4679344")
  })

  expect_is(x, "data.frame")
  expect_named(x, c("doi", "pmid", "pmcid", "paper"))
  for (i in seq_len(NCOL(x))) expect_is(x[,i], "character")
})

test_that("oc_pmcid2ids fails well", {
  expect_error(oc_pmcid2ids(), "argument \"id\" is missing")
  expect_error(oc_pmcid2ids(matrix()), "id must be of class")
})
