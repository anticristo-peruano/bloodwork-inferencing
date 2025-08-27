-- Overview on main LOINC
SELECT * 
FROM loinc.loinc 
limit 20;

-- Classtype differential
SELECT classtype, class, COUNT(*) as count
FROM loinc.loinc
GROUP BY classtype, class
ORDER BY classtype, count DESC;
