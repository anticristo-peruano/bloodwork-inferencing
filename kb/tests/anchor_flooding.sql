/*
"Recursive and heuristic alignment approach that extends a pre-existing alignment (initial anchors)
between LOINC and SNOMED-CT by comparing taxonomical related concepts." [6]
Alignment uses both lexical and semantic approaches:
  - Lexical: Stoilos similarity and [6]'s WGram (a bag of words similarity).
  - Semantic: Similarity and confidence from meanings on UMLS Metathesaurus.
*/


CREATE SCHEMA IF NOT EXISTS test AUTHORIZATION postgres;
SET search_path TO test, loinc, snomedct, umls;

/*
TO-DO LOL
*/