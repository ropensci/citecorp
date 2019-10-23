random_dois <- rcrossref::cr_r(100)
res <- lapply(random_dois, citecorp::oc_doi2ids)
dois_keep <- c()
dois_keep <- c(
  dois_keep, 
  random_dois[which(vapply(res, function(x) NROW(x) > 0, logical(1)))]
)
oc_dois <- dois_keep

# get pmids and pmcids
out <- lapply(oc_dois, citecorp::oc_doi2ids)
df <- dplyr::bind_rows(out)
oc_pmids <- dplyr::filter(df, type == "pmid") %>% .$value
oc_pmcids <- dplyr::filter(df, type == "pmcid") %>% .$value

# save data to data/ dir
save(oc_dois, file = "data/oc_dois.rda", version = 2)
save(oc_pmids, file = "data/oc_pmids.rda", version = 2)
save(oc_pmcids, file = "data/oc_pmcids.rda", version = 2)
