CREATE SCHEMA IF NOT EXISTS kg AUTHORIZATION postgres;
SET search_path TO kg, loinc, snomedct, umls;

---- LOINC UNIVERSE
-- 1a) Active set of lab observations
DROP MATERIALIZED VIEW IF EXISTS kg.lnc_test CASCADE;
CREATE MATERIALIZED VIEW kg.lnc_test AS
SELECT loinc_num, long_common_name, component, property, time_aspct, system,
       scale_typ, method_typ, class, classtype, example_ucum_units
FROM loinc.loinc
WHERE classtype = '1'
AND status = 'ACTIVE'
AND (class ILIKE 'HEM%' OR class ILIKE 'COAG%' OR long_common_name ILIKE '%hematolog%');


-- 1b) Observation analytes
DROP MATERIALIZED VIEW IF EXISTS kg.lnc_analyte CASCADE;
CREATE MATERIALIZED VIEW kg.lnc_analyte AS
SELECT t.loinc_num, p.partnumber, p.partname
FROM kg.lnc_test t
JOIN loinc.partlink_primary plp on t.loinc_num = plp.loinc_num
JOIN loinc.partlink_supplementary pls on t.loinc_num = pls.loinc_num
JOIN loinc.part p on p.partname = pls.partname
WHERE pls.linktypename = 'DetailedModel' AND pls.parttypename = 'COMPONENT';


--SELECT * FROM kg.lnc_test LIMIT 20;
--SELECT * FROM kg.lnc_analyte LIMIT 20;

---- UMLS UNIVERSE
-- 2a) Intermapping LOINC and UMLS
DROP MATERIALIZED VIEW IF EXISTS kg.lnc_umls CASCADE;
CREATE MATERIALIZED VIEW kg.lnc_umls AS
SELECT t.loinc_num, c.cui, c.str AS loinc_str
FROM kg.lnc_test t
JOIN umls.mrconso c
ON c.sab = 'LNC' AND c.code = t.loinc_num AND c.ts = 'P' AND c.lat = 'ENG';


-- 2b) Synonyms for the same concept
DROP MATERIALIZED VIEW IF EXISTS kg.analyte_synonyms CASCADE;
CREATE MATERIALIZED VIEW kg.analyte_synonyms AS
SELECT lu.loinc_num, s.cui, s.str, s.lat, s.sab, s.tty
FROM kg.lnc_umls lu
JOIN umls.mrconso s ON s.cui = lu.cui
WHERE s.lat IN ('ENG');


--SELECT * FROM kg.lnc_umls LIMIT 20;
--SELECT * FROM kg.analyte_synonyms LIMIT 20;

---- SNOMED UNIVERSE
-- 3a) General parent-child relationship
CREATE INDEX IF NOT EXISTS rel_isa_idx
ON snomedct.relationship (destinationid, sourceid)
WHERE active='1' AND typeid='116680003';

DROP MATERIALIZED VIEW IF EXISTS snomedct.isa_closure CASCADE;
WITH RECURSIVE cte AS (
  SELECT sourceid AS child, destinationid AS parent
  FROM snomedct.relationship
  WHERE active = '1' AND typeid = '116680003'
  UNION ALL
  SELECT r.sourceid, cte.parent
  FROM snomedct.relationship r
  JOIN cte ON r.destinationid = cte.child
  WHERE r.active = '1' AND r.typeid = '116680003'
)
SELECT DISTINCT child, parent FROM cte;

CREATE UNIQUE INDEX IF NOT EXISTS isa_closure_uq ON snomedct.isa_closure (child, parent);
CREATE INDEX        IF NOT EXISTS isa_child_idx  ON snomedct.isa_closure (child);
CREATE INDEX        IF NOT EXISTS isa_parent_idx ON snomedct.isa_closure (parent);


-- 3b) Sets
DROP MATERIALIZED VIEW IF EXISTS kg.sct_observable CASCADE;
CREATE MATERIALIZED VIEW kg.sct_observable AS
SELECT c.id AS sctid
FROM snomedct.concept c
JOIN snomedct.isa_closure ic ON ic.child = c.id
WHERE ic.parent = '363787002' AND c.active = '1';  -- Observable entity


DROP MATERIALIZED VIEW IF EXISTS kg.sct_finding CASCADE;
CREATE MATERIALIZED VIEW kg.sct_finding AS
SELECT c.id AS sctid
FROM snomedct.concept c
JOIN snomedct.isa_closure ic ON ic.child = c.id
WHERE ic.parent = '404684003' AND c.active = '1';  -- Clinical finding


DROP MATERIALIZED VIEW IF EXISTS kg.sct_disease CASCADE;
CREATE MATERIALIZED VIEW kg.sct_disease AS
SELECT c.id AS sctid
FROM snomedct.concept c
JOIN snomedct.isa_closure ic ON ic.child = c.id
WHERE ic.parent = '64572001' AND c.active = '1';   -- Disease


---- FINAL MAPPINGS
-- 
DROP MATERIALIZED VIEW IF EXISTS kg.lnc_sct_obs CASCADE;
CREATE MATERIALIZED VIEW kg.lnc_sct_obs AS
SELECT DISTINCT lu.loinc_num, sn.code::text AS sctid, sn.str AS sct_term
FROM kg.lnc_umls lu
JOIN umls.mrconso sn
ON sn.cui = lu.cui AND sn.sab LIKE 'SNOMEDCT%' AND sn.tty IN ('PT','FN')
JOIN kg.sct_observable obs ON obs.sctid = sn.code::text;
-- Not every LOINC shares CUI with SNOMED. Literature gap.


DROP MATERIALIZED VIEW IF EXISTS kg.find2obs CASCADE;
CREATE MATERIALIZED VIEW kg.find2obs AS
SELECT r.sourceid AS finding_id, r.destinationid AS observable_id, r.id AS relid
FROM snomedct.relationship r
WHERE r.active=1 AND r.typeid='363714003'  -- interprets
AND r.sourceid IN (SELECT sctid FROM kg.sct_finding)
AND r.destinationid IN (SELECT sctid FROM kg.sct_observable);


DROP MATERIALIZED VIEW IF EXISTS kg.dis2find CASCADE;
CREATE MATERIALIZED VIEW kg.dis2find AS
SELECT r.sourceid AS disease_id, r.destinationid AS finding_id, r.typeid, r.id AS relid
FROM snomedct.relationship r
WHERE r.active=1
AND r.sourceid IN (SELECT sctid FROM kg.sct_disease)
AND r.destinationid IN (SELECT sctid FROM kg.sct_finding)
AND r.typeid IN ('363705008','47429007','42752001');        
