qry_doi2ids <- 'PREFIX datacite: <http://purl.org/spar/datacite/>
  PREFIX literal: <http://www.essepuntato.it/2010/06/literalreification/>
  SELECT ?paper ?pmid ?pmcid ?value
  WHERE {
    {
      ?paper datacite:hasIdentifier [
          datacite:usesIdentifierScheme datacite:doi ;
          literal:hasLiteralValue ?value
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
    } .
    VALUES ?value { %s }
  }'

qry_pmid2ids <- 'PREFIX datacite: <http://purl.org/spar/datacite/>
  PREFIX literal: <http://www.essepuntato.it/2010/06/literalreification/>
  SELECT ?paper ?doi ?pmcid ?value
  WHERE {
    {
      ?paper datacite:hasIdentifier [
          datacite:usesIdentifierScheme datacite:pmid ;
          literal:hasLiteralValue ?value
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
    } .
    VALUES ?value { %s }
  }'

qry_pmcid2ids <- 'PREFIX datacite: <http://purl.org/spar/datacite/>
  PREFIX literal: <http://www.essepuntato.it/2010/06/literalreification/>
  SELECT ?paper ?doi ?pmid ?value
  WHERE {
    {
      ?paper datacite:hasIdentifier [
          datacite:usesIdentifierScheme datacite:pmcid ;
          literal:hasLiteralValue ?value
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
    } .
    VALUES ?value { %s }
  }'
