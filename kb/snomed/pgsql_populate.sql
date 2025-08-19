set schema 'snomedct';

DO $$
DECLARE
	FOLDER TEXT := '/nvme/git/work/bloodwork-inferencing/kb/snomed';
	type TEXT := 'Full';
	RELEASE TEXT:= 'INT_20250801';
	SUFFIX TEXT;
BEGIN
	SUFFIX := CASE type WHEN 'Full' THEN '_f' WHEN 'Delta' THEN '_d' WHEN 'Snapshot' THEN '_s' ELSE '' END;
	
  	EXECUTE 'COPY concept ' || '(id, effectivetime, active, moduleid, definitionstatusid) FROM '
        || quote_literal(FOLDER || '/' || type || '/Terminology/sct2_Concept_' || type || '_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'COPY description ' || '(id, effectivetime, active, moduleid, conceptid, languagecode, typeid, term, casesignificanceid) FROM '
        || quote_literal(FOLDER || '/' || type || '/Terminology/sct2_Description_' || type || '-en_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'' , DELIMITER ''	'', QUOTE E''\b'')';

	EXECUTE 'COPY textdefinition ' || '(id, effectivetime, active, moduleid, conceptid, languagecode, typeid, term, casesignificanceid) FROM '
        || quote_literal(FOLDER || '/' || type || '/Terminology/sct2_TextDefinition_' || type || '_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'', QUOTE E''\b'')';
  
	EXECUTE 'COPY relationship ' || '(id, effectivetime, active, moduleid, sourceid, destinationid, relationshipgroup, typeid,characteristictypeid, modifierid) FROM '
        || quote_literal(FOLDER || '/' || type || '/Terminology/sct2_Relationship_' || type || '_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'COPY stated_relationship ' || '(id, effectivetime, active, moduleid, sourceid, destinationid, relationshipgroup, typeid,  characteristictypeid, modifierid) FROM '
        || quote_literal(FOLDER || '/' || type || '/Terminology/sct2_StatedRelationship_' || type || '_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';
  
	EXECUTE 'COPY langrefset ' || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, acceptabilityid) FROM '
        || quote_literal(FOLDER || '/' || type || '/Refset/Language/der2_cRefset_Language' || type || '-en_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';
  
	EXECUTE 'COPY associationrefset ' || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, targetcomponentid) FROM '
        || quote_literal(FOLDER || '/' || type || '/Refset/Content/der2_cRefset_Association' || type || '_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'COPY simplerefset ' || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid) FROM '
        || quote_literal(FOLDER || '/' || type || '/Refset/Content/der2_Refset_Simple' || type || '_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'COPY attributevaluerefset ' || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, valueid) FROM '
        || quote_literal(FOLDER || '/' || type || '/Refset/Content/der2_cRefset_AttributeValue' || type || '_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'COPY simplemaprefset ' || '(id, effectivetime, active, moduleid, refsetid,  referencedcomponentid, maptarget) FROM '
        || quote_literal(FOLDER || '/' || type || '/Refset/Map/der2_sRefset_SimpleMap' || type || '_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'COPY extendedmaprefset ' || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, mapGroup, mapPriority, mapRule, mapAdvice, mapTarget, correlationId, mapCategoryId) FROM '
        || quote_literal(FOLDER || '/' || type || '/Refset/Map/der2_iisssccRefset_ExtendedMap' || type || '_' || RELEASE || '.txt') || 'WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';
END $$