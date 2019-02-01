context("oc_doi2ids")

test_that("oc_doi2ids works", {
  vcr::use_cassette("oc_doi2ids", {
    x <- oc_doi2ids("10.1097/igc.0000000000000609")
  })

  expect_is(x, "data.frame")
  expect_named(x, c("type", "value"))
  expect_is(x$type, "character")
  expect_is(x$value, "character")
})

test_that("oc_doi2ids fails well", {
  expect_error(oc_doi2ids(), "argument \"id\" is missing")
  expect_error(oc_doi2ids(matrix()), "id must be of class")
  expect_error(oc_doi2ids(1:3), "length\\(id\\) == 1 is not TRUE")
})



context("oc_pmid2ids")

test_that("oc_pmid2ids works", {
  vcr::use_cassette("oc_pmid2ids", {
    x <- oc_pmid2ids("26645990")
  })

  expect_is(x, "data.frame")
  expect_named(x, c("type", "value"))
  expect_is(x$type, "character")
  expect_is(x$value, "character")
})

test_that("oc_pmid2ids fails well", {
  expect_error(oc_pmid2ids(), "argument \"id\" is missing")
  expect_error(oc_pmid2ids(matrix()), "id must be of class")
  expect_error(oc_pmid2ids(1:3), "length\\(id\\) == 1 is not TRUE")
})



context("oc_pmcid2ids")

test_that("oc_pmcid2ids works", {
  vcr::use_cassette("oc_pmcid2ids", {
    x <- oc_pmcid2ids("PMC4679344")
  })

  expect_is(x, "data.frame")
  expect_named(x, c("type", "value"))
  expect_is(x$type, "character")
  expect_is(x$value, "character")
})

test_that("oc_pmcid2ids fails well", {
  expect_error(oc_pmcid2ids(), "argument \"id\" is missing")
  expect_error(oc_pmcid2ids(matrix()), "id must be of class")
  expect_error(oc_pmcid2ids(1:3), "length\\(id\\) == 1 is not TRUE")
})
