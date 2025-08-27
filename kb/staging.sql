CREATE SCHEMA IF NOT EXISTS kg AUTHORIZATION postgres;
SET search_path TO kg, loinc, snomedct, umls;

---- LOINC INFORMATION
-- Hematology tests (lab observations)
DROP MATERIALIZED VIEW IF EXISTS kg.loinc_test CASCADE;
CREATE MATERIALIZED VIEW kg.loinc_test AS
SELECT loinc_num, long_common_name, component, property, time_aspct, system,
       scale_typ, method_typ, class, classtype, example_ucum_units
FROM loinc.loinc
WHERE classtype = '1'
AND (class ILIKE 'HEM%' OR class ILIKE 'COAG%' OR long_common_name ILIKE '%hematolog%');

--SELECT * FROM kg.loinc_test LIMIT 20;

-- Hematology analyte component
DROP MATERIALIZED VIEW IF EXISTS kg.loinc_analyte CASCADE;
CREATE MATERIALIZED VIEW kg.loinc_analyte AS
SELECT t.loinc_num, p.partnumber, p.partname
FROM kg.loinc_test t
JOIN loinc.partlink_primary plp on t.loinc_num = plp.loinc_num
JOIN loinc.partlink_supplementary pls on t.loinc_num = pls.loinc_num
JOIN loinc.part p on p.partname = pls.partname
WHERE pls.linktypename = 'DetailedModel' AND pls.parttypename = 'COMPONENT';

--SELECT * FROM kg.loinc_analyte LIMIT 20;

