/*
Hierarchical map strategy between LOINC and SNOMED, 
based on shared CUI codes within UMLS.
*/

CREATE SCHEMA IF NOT EXISTS test AUTHORIZATION postgres;
SET search_path TO test, loinc, snomedct, umls;




-- 1) Auxiliary universe of LOINC and SNOMED in UMLS
DROP MATERIALIZED VIEW IF EXISTS test.umls_sct CASCADE;
CREATE MATERIALIZED VIEW test.umls_sct AS
SELECT DISTINCT code::text AS sctid, cui, str AS part_name
FROM umls.mrconso
WHERE sab LIKE 'SNOMEDCT%';
CREATE INDEX IF NOT EXISTS umls_sct_code_idx ON test.umls_sct(sctid);
CREATE INDEX IF NOT EXISTS umls_sct_cui_idx  ON test.umls_sct(cui);


DROP MATERIALIZED VIEW IF EXISTS test.umls_lnc CASCADE;
CREATE MATERIALIZED VIEW test.umls_lnc AS
SELECT DISTINCT code AS lp_code, cui, str AS part_name
FROM umls.mrconso
WHERE sab = 'LNC' AND code ~ '^LP[0-9]';
CREATE INDEX IF NOT EXISTS umls_lnc_lp  ON test.umls_lnc(lp_code);
CREATE INDEX IF NOT EXISTS umls_lnc_cui ON test.umls_lnc(cui);




-- 2) Universe of parts in LOINC
DROP MATERIALIZED VIEW IF EXISTS test.lnc_axes CASCADE;
CREATE MATERIALIZED VIEW test.lnc_axes AS
WITH parts AS (
  SELECT
    l.loinc_num,
    MAX(CASE WHEN pll.parttypename ILIKE 'COMPONENT' THEN pll.partnumber END) AS lp_component,
    MAX(CASE WHEN pll.parttypename ILIKE 'SYSTEM'    THEN pll.partnumber END) AS lp_system,
    MAX(CASE WHEN pll.parttypename ILIKE 'SCALE'     THEN pll.partnumber END) AS lp_scale,
    MAX(CASE WHEN pll.parttypename ILIKE 'TIME'      THEN pll.partnumber END) AS lp_time
  FROM loinc.loinc l
  LEFT JOIN loinc.partlink_primary pll ON pll.loinc_num = l.loinc_num
  JOIN loinc.part pt ON pt.partnumber = pll.partnumber
  WHERE pt.status = 'ACTIVE'
  GROUP BY l.loinc_num
)
SELECT
  par.loinc_num,
  par.lp_component, par.lp_system, par.lp_scale, par.lp_time,
  cpt.cui AS comp_cui,
  sys.cui AS sys_cui,
  scl.cui AS scl_cui,
  tim.cui AS tim_cui
FROM parts par
LEFT JOIN test.umls_lnc cpt ON cpt.lp_code = par.lp_component
LEFT JOIN test.umls_lnc sys ON sys.lp_code = par.lp_system
LEFT JOIN test.umls_lnc scl ON scl.lp_code = par.lp_scale
LEFT JOIN test.umls_lnc tim ON tim.lp_code = par.lp_time;
CREATE INDEX IF NOT EXISTS lnc_axes ON test.lnc_axes(loinc_num);




-- 3) Universe of laboratory procedures in SNOMED
DROP MATERIALIZED VIEW IF EXISTS test.sct_axes CASCADE;
CREATE MATERIALIZED VIEW test.sct_axes AS
WITH lab_proc AS (
  SELECT child::text AS sctid
  FROM snomedct.isa_closure
  WHERE parent = '108252007'                      -- Laboratory procedure
),
rel AS (                                          
  SELECT r.sourceid::text AS sctid,
         r.typeid,
         r.destinationid::text AS dst
  FROM snomedct.relationship r
  JOIN lab_proc lp ON lp.sctid = r.sourceid::text
  WHERE r.active = '1'
    AND r.typeid IN (
      '246093002',   -- component
      '116686009',   -- has_specimen
      '370133003',   -- specimen_substance
      '405813007',   -- proc_site_direct
      '370132008',   -- scale_type
      '370134009'    -- time_aspect
    )
),
sys_specimen AS (
  SELECT r1.sctid, r2.destinationid::text AS system_id
  FROM rel r1
  JOIN snomedct.relationship r2
    ON r2.sourceid::text = r1.dst       -- specimen -> substance
   AND r2.active='1'
   AND r2.typeid='370133003'            -- specimen_substance
  WHERE r1.typeid='116686009'           -- has_specimen
),
sys_procsite AS (
  SELECT sctid, dst AS system_id
  FROM rel
  WHERE typeid='405813007'
),
axes AS (
  SELECT
    r.sctid,
    MAX(CASE WHEN r.typeid='246093002' THEN r.dst END) AS comp_id,   -- component
    MAX(CASE WHEN r.typeid='370132008' THEN r.dst END) AS scale_id,  -- scale_type
    MAX(CASE WHEN r.typeid='370134009' THEN r.dst END) AS time_id,   -- time_aspect
    COALESCE(
      (SELECT MIN(system_id) FROM sys_specimen s WHERE s.sctid=r.sctid),
      (SELECT MIN(system_id) FROM sys_procsite p WHERE p.sctid=r.sctid)
    ) AS system_id
  FROM rel r
  GROUP BY r.sctid
)
SELECT
  a.sctid,
  a.comp_id,  a.system_id,  a.scale_id,  a.time_id,
  uc.cui AS comp_cui,
  us.cui AS sys_cui,
  uz.cui AS scl_cui,
  ut.cui AS tim_cui
FROM axes a
LEFT JOIN test.umls_sct uc ON uc.sctid = a.comp_id
LEFT JOIN test.umls_sct us ON us.sctid = a.system_id
LEFT JOIN test.umls_sct uz ON uz.sctid = a.scale_id
LEFT JOIN test.umls_sct ut ON ut.sctid = a.time_id;
CREATE INDEX IF NOT EXISTS sct_axes_idx ON test.sct_axes(sctid);




-- 4) Pairing testings
-- Lvl 3: comp + sys + scale
DROP MATERIALIZED VIEW IF EXISTS test.lnc2sct_lvl3 CASCADE;
CREATE MATERIALIZED VIEW test.lnc2sct_lvl3 AS
SELECT l.loinc_num, s.sctid, 3 AS match_level
FROM test.lnc_axes l
JOIN test.sct_axes s ON s.comp_cui = l.comp_cui
WHERE l.sys_cui IS NOT NULL AND s.sys_cui = l.sys_cui
  AND l.scl_cui IS NOT NULL AND s.scl_cui = l.scl_cui;

-- Lvl 2a: comp + sys
DROP MATERIALIZED VIEW IF EXISTS test.lnc2sct_lvl2a CASCADE;
CREATE MATERIALIZED VIEW test.lnc2sct_lvl2a AS
SELECT l.loinc_num, s.sctid, 2 AS match_level
FROM test.lnc_axes l
JOIN test.sct_axes s ON s.comp_cui = l.comp_cui
WHERE l.sys_cui IS NOT NULL AND s.sys_cui = l.sys_cui;

-- Lvl 2b: comp + scale
DROP MATERIALIZED VIEW IF EXISTS test.lnc2sct_lvl2b CASCADE;
CREATE MATERIALIZED VIEW test.lnc2sct_lvl2b AS
SELECT l.loinc_num, s.sctid, 2 AS match_level
FROM test.lnc_axes l
JOIN test.sct_axes s ON s.comp_cui = l.comp_cui
WHERE l.scl_cui IS NOT NULL AND s.scl_cui = l.scl_cui;

-- Lvl 1: only comp
DROP MATERIALIZED VIEW IF EXISTS test.lnc2sct_lvl1 CASCADE;
CREATE MATERIALIZED VIEW test.lnc2sct_lvl1 AS
SELECT l.loinc_num, s.sctid, 1 AS match_level
FROM test.lnc_axes l
JOIN test.sct_axes s ON s.comp_cui = l.comp_cui;


DROP MATERIALIZED VIEW IF EXISTS test.lnc2sct_relmap CASCADE;
CREATE MATERIALIZED VIEW test.lnc2sct_relmap AS
WITH all_levels AS (
  SELECT * FROM test.lnc2sct_lvl3
  UNION ALL
  SELECT * FROM test.lnc2sct_lvl2a
  UNION ALL
  SELECT * FROM test.lnc2sct_lvl2b
  UNION ALL
  SELECT * FROM test.lnc2sct_lvl1
),
ranked AS (
  SELECT
    loinc_num, sctid, MAX(match_level) AS match_level
  FROM all_levels
  GROUP BY loinc_num, sctid
),
best AS (
  SELECT
    loinc_num, sctid, match_level,
    ROW_NUMBER() OVER (PARTITION BY loinc_num ORDER BY match_level DESC, sctid) AS rnk
  FROM ranked
)
SELECT loinc_num, sctid, match_level
FROM best
WHERE rnk = 1;
CREATE INDEX IF NOT EXISTS l2s_loinc_idx ON test.lnc2sct_relmap(loinc_num);
CREATE INDEX IF NOT EXISTS l2s_sct_idx   ON test.lnc2sct_relmap(sctid);




-- 5) Review tables
SELECT match_level, COUNT(*) AS pairs 
FROM test.lnc2sct_relmap 
GROUP BY 1 
ORDER BY 1 DESC;
