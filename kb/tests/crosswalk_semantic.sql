/*
Hierarchical crosswalk on shared relationship.
Somewhere here it is, allegedly, given the statements of [5]: https://github.com/OHDSI/Vocabulary-v5.0/tree/master
*/

CREATE SCHEMA IF NOT EXISTS test AUTHORIZATION postgres;
SET search_path TO test, loinc, snomedct, umls;

