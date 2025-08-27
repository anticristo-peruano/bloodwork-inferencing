CREATE SCHEMA IF NOT EXISTS kg AUTHORIZATION postgres;
SET search_path TO kg, loinc, snomedct, umls;

-- Hematology tests from LOINCS
CREATE MATERIALIZED VIEW loinctest AS
SELECT loinc_num, long_common_name, component, property, time_aspct, system,
       scale_typ, method_typ, class, classtype, example_ucum_units
FROM loinc.loinc
WHERE classtype = '1'
AND (class ILIKE 'HEM%' OR class ILIKE 'COAG%' OR long_common_name ILIKE '%hematolog%');