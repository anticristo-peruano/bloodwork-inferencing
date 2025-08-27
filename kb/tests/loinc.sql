-- Overview on main LOINC
SELECT * 
FROM loinc.loinc 
limit 20;

-- Classtype differential
SELECT classtype, class, COUNT(*) as count
FROM loinc.loinc
GROUP BY classtype, class
ORDER BY classtype, count DESC;

-- Parts, primary and supplementary
SELECT *
FROM loinc.part p
JOIN loinc.partlink_primary plp on p.partname = plp.partname
JOIN loinc.partlink_supplementary pls on p.partname = pls.partname
WHERE pls.linktypename = 'DetailedModel'
  AND pls.parttypename = 'COMPONENT'
LIMIT 20;
