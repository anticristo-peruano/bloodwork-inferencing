/*
The query that broke my spirit.
*/

CREATE SCHEMA IF NOT EXISTS test AUTHORIZATION postgres;
SET search_path TO test, loinc, snomedct, umls;
CREATE EXTENSION IF NOT EXISTS plpython3u;



WITH lnc AS (
  SELECT DISTINCT
    l.loinc_num,
    mc.code,
    mc.cui,
    mc.str,
    l.long_common_name
  FROM loinc.loinc l
  LEFT JOIN loinc.partlink_primary pll ON pll.loinc_num = l.loinc_num
  JOIN loinc.part pt ON pt.partnumber = pll.partnumber
  JOIN umls.mrconso mc ON mc.code = pll.partnumber
  WHERE pt.status = 'ACTIVE' AND pll.parttypename IN ('COMPONENT','SYSTEM')
),
lab_proc AS (
  SELECT child::text AS sctid
  FROM snomedct.isa_closure
  WHERE parent IN ('108252007','363787002','123038009','105590001','386053000','246093002','71388002','4421005')                      -- Laboratory procedure
),
sct AS (
  SELECT DISTINCT 
    mc.code::text, 
    mc.cui, 
    mc.str
  FROM umls.mrconso mc
  JOIN lab_proc r ON mc.code = r.sctid
  WHERE sab LIKE 'SNOMEDCT%'
  AND tty IN ('PT','FN')
)
SELECT DISTINCT ON (cui,loinc_num,sctid)
  COALESCE(l.cui, s.cui) AS cui,
  l.code AS loinc_num,
  s.code AS sctid,
  l.long_common_name AS lnc_longterm,
  l.str as lnc_term,
  s.str AS sct_term
FROM lnc l
FULL OUTER JOIN sct s ON l.cui = s.cui
WHERE l.code IS NOT NULL and s.code IS NOT NULL
