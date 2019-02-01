qry_doi2ids <- 'PREFIX datacite: <http://purl.org/spar/datacite/>
  PREFIX literal: <http://www.essepuntato.it/2010/06/literalreification/>
  SELECT ?paper ?pmid ?pmcid WHERE {
    ?paper datacite:hasIdentifier [
        datacite:usesIdentifierScheme datacite:doi ;
        literal:hasLiteralValue "%s"
    ] .

    OPTIONAL {
      ?paper datacite:hasIdentifier [
        datacite:usesIdentifierScheme datacite:pmid ;
        literal:hasLiteralValue ?pmid
      ] .
    }

    OPTIONAL {
      ?paper datacite:hasIdentifier [
        datacite:usesIdentifierScheme datacite:pmcid ;
        literal:hasLiteralValue ?pmcid
      ] .
    }
  }'

qry_pmid2ids <- 'PREFIX datacite: <http://purl.org/spar/datacite/>
  PREFIX literal: <http://www.essepuntato.it/2010/06/literalreification/>
  SELECT ?paper ?doi ?pmcid WHERE {
    ?paper datacite:hasIdentifier [
        datacite:usesIdentifierScheme datacite:pmid ;
        literal:hasLiteralValue "%s"
    ] .

    OPTIONAL {
      ?paper datacite:hasIdentifier [
        datacite:usesIdentifierScheme datacite:doi ;
        literal:hasLiteralValue ?doi
      ] .
    }

    OPTIONAL {
      ?paper datacite:hasIdentifier [
        datacite:usesIdentifierScheme datacite:pmcid ;
        literal:hasLiteralValue ?pmcid
      ] .
    }
  }'

qry_pmcid2ids <- 'PREFIX datacite: <http://purl.org/spar/datacite/>
  PREFIX literal: <http://www.essepuntato.it/2010/06/literalreification/>
  SELECT ?paper ?doi ?pmid WHERE {
    ?paper datacite:hasIdentifier [
        datacite:usesIdentifierScheme datacite:pmcid ;
        literal:hasLiteralValue "%s"
    ] .

    OPTIONAL {
      ?paper datacite:hasIdentifier [
        datacite:usesIdentifierScheme datacite:doi ;
        literal:hasLiteralValue ?doi
      ] .
    }

    OPTIONAL {
      ?paper datacite:hasIdentifier [
        datacite:usesIdentifierScheme datacite:pmid ;
        literal:hasLiteralValue ?pmid
      ] .
    }
  }'
