cols <- sort(c("doi", "pmid", "pmcid", "paper"))

context("oc_doi2ids")
test_that("oc_doi2ids works", {
  vcr::use_cassette("oc_doi2ids", {
    x <- oc_doi2ids("10.1097/igc.0000000000000609")
  })

  expect_is(x, "data.frame")
  expect_equal(sort(names(x)), cols)
  for (i in seq_len(NCOL(x))) expect_is(x[,i], "character")
})

test_that("oc_doi2ids works", {
  vcr::use_cassette("oc_doi2ids_fewer_columns", {
    x <- oc_doi2ids('10.1093/biomet/80.3.527')
    y <- oc_doi2ids('10.1093/biomet/79.3.531')
  })

  expect_is(x, "data.frame")
  expect_equal(sort(names(x)), c("doi", "paper"))
  for (i in seq_len(NCOL(x))) expect_is(x[,i], "character")

  expect_is(y, "data.frame")
  expect_equal(sort(names(y)), c("doi", "paper"))
  for (i in seq_len(NCOL(y))) expect_is(y[,i], "character")
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
  expect_equal(sort(names(x)), cols)
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
  expect_equal(sort(names(x)), cols)
  for (i in seq_len(NCOL(x))) expect_is(x[,i], "character")
})

test_that("oc_pmcid2ids fails well", {
  expect_error(oc_pmcid2ids(), "argument \"id\" is missing")
  expect_error(oc_pmcid2ids(matrix()), "id must be of class")
})
