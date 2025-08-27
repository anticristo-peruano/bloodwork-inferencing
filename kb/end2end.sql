DROP MATERIALIZED VIEW IF EXISTS kg.e2e_test2dis CASCADE;
CREATE MATERIALIZED VIEW kg.e2e_test2dis AS
SELECT
  t.loinc_num                      AS test_loinc,
  t.long_common_name               AS test_name,

  o.sctid                          AS observable_id,
  od.term                          AS observable_term,

  f.sctid                          AS finding_id,
  fd.term                          AS finding_term,

  d.sctid                          AS disease_id,
  dd.term                          AS disease_term,

  df.typeid                        AS disease_reltype,          -- e.g., 363705008 / 47429007 / 42752001
  df.relid                         AS disease_relid
FROM kg.lnc_test t
JOIN kg.lnc_sct_obs l2o          ON l2o.loinc_num   = t.loinc_num
JOIN kg.sct_observable o         ON o.sctid         = l2o.sctid
JOIN kg.find2obs fo              ON fo.observable_id= o.sctid
JOIN kg.sct_finding f            ON f.sctid         = fo.finding_id
JOIN kg.dis2find df              ON df.finding_id   = f.sctid
JOIN kg.sct_disease d            ON d.sctid         = df.disease_id

-- prefer Synonym over FSN for each concept's label
LEFT JOIN LATERAL (
  SELECT dsc.term
  FROM snomedct.description dsc
  WHERE dsc.conceptid = o.sctid AND dsc.active='1'
        AND dsc.typeid IN ('900000000000013009','900000000000003001')
  ORDER BY CASE WHEN dsc.typeid='900000000000013009' THEN 0 ELSE 1 END, dsc.term
  LIMIT 1
) od ON TRUE

LEFT JOIN LATERAL (
  SELECT dsc.term
  FROM snomedct.description dsc
  WHERE dsc.conceptid = f.sctid AND dsc.active='1'
        AND dsc.typeid IN ('900000000000013009','900000000000003001')
  ORDER BY CASE WHEN dsc.typeid='900000000000013009' THEN 0 ELSE 1 END, dsc.term
  LIMIT 1
) fd ON TRUE

LEFT JOIN LATERAL (
  SELECT dsc.term
  FROM snomedct.description dsc
  WHERE dsc.conceptid = d.sctid AND dsc.active='1'
        AND dsc.typeid IN ('900000000000013009','900000000000003001')
  ORDER BY CASE WHEN dsc.typeid='900000000000013009' THEN 0 ELSE 1 END, dsc.term
  LIMIT 1
) dd ON TRUE;


DROP MATERIALIZED VIEW IF EXISTS kg.e2e_an2dis CASCADE;
CREATE MATERIALIZED VIEW kg.e2e_an2dis AS
SELECT
  a.partnumber                    AS analyte_id,
  a.partname                      AS analyte_name,

  t.loinc_num                     AS test_loinc,
  t.long_common_name              AS test_name,

  o.sctid                         AS observable_id,
  od.term                         AS observable_term,

  f.sctid                         AS finding_id,
  fd.term                         AS finding_term,

  d.sctid                         AS disease_id,
  dd.term                         AS disease_term,

  df.typeid                       AS disease_reltype,
  df.relid                        AS disease_relid
FROM kg.lnc_analyte a
JOIN kg.lnc_test t               ON t.loinc_num     = a.loinc_num
JOIN kg.lnc_sct_obs l2o          ON l2o.loinc_num   = t.loinc_num
JOIN kg.sct_observable o         ON o.sctid         = l2o.sctid
JOIN kg.find2obs fo              ON fo.observable_id= o.sctid
JOIN kg.sct_finding f            ON f.sctid         = fo.finding_id
JOIN kg.dis2find df              ON df.finding_id   = f.sctid
JOIN kg.sct_disease d            ON d.sctid         = df.disease_id

LEFT JOIN LATERAL (
  SELECT dsc.term
  FROM snomedct.description dsc
  WHERE dsc.conceptid = o.sctid AND dsc.active='1'
        AND dsc.typeid IN ('900000000000013009','900000000000003001')
  ORDER BY CASE WHEN dsc.typeid='900000000000013009' THEN 0 ELSE 1 END, dsc.term
  LIMIT 1
) od ON TRUE

LEFT JOIN LATERAL (
  SELECT dsc.term
  FROM snomedct.description dsc
  WHERE dsc.conceptid = f.sctid AND dsc.active='1'
        AND dsc.typeid IN ('900000000000013009','900000000000003001')
  ORDER BY CASE WHEN dsc.typeid='900000000000013009' THEN 0 ELSE 1 END, dsc.term
  LIMIT 1
) fd ON TRUE

LEFT JOIN LATERAL (
  SELECT dsc.term
  FROM snomedct.description dsc
  WHERE dsc.conceptid = d.sctid AND dsc.active='1'
        AND dsc.typeid IN ('900000000000013009','900000000000003001')
  ORDER BY CASE WHEN dsc.typeid='900000000000013009' THEN 0 ELSE 1 END, dsc.term
  LIMIT 1
) dd ON TRUE;


SELECT COUNT(*) FROM kg.e2e_test2dis;
SELECT COUNT(*) FROM kg.e2e_an2dis;

SELECT * FROM kg.e2e_test2dis
ORDER BY test_loinc, disease_term
LIMIT 20;
