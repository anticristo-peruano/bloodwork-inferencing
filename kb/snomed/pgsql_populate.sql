set schema 'snomedct';

DO $$
DECLARE
	FOLDER TEXT := '/nvme/git/work/bloodwork-inferencing/kb/snomed';
	GROUP TEXT := 'Full';
	RELEASE TEXT:= 'INT_20250801';
	SUFFIX TEXT;
BEGIN
	SUFFIX := CASE GROUP WHEN 'Full' THEN '_f' WHEN 'Delta' THEN '_d' WHEN 'Snapshot' THEN '_s' ELSE '' END
	
	EXECUTE 'TRUNCATE TABLE concept' || SUFFIX;
  	EXECUTE 'COPY concept' || SUFFIX || '(id, effectivetime, active, moduleid, definitionstatusid) FROM '''
        || FOLDER || '/' || GROUP || '/Terminology/sct2_Concept_' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'TRUNCATE TABLE description' || SUFFIX;
	EXECUTE 'COPY description' || SUFFIX || '(id, effectivetime, active, moduleid, conceptid, languagecode, typeid, term, casesignificanceid) FROM '''
        || FOLDER || '/' || GROUP || '/Terminology/sct2_Description_' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'' , DELIMITER ''	'', QUOTE E''\b'')';

	EXECUTE 'TRUNCATE TABLE textdefinition' || SUFFIX;
	EXECUTE 'COPY textdefinition' || SUFFIX || '(id, effectivetime, active, moduleid, conceptid, languagecode, typeid, term, casesignificanceid) FROM '''
        || FOLDER || '/' || GROUP || '/Terminology/sct2_TextDefinition_' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'', QUOTE E''\b'')';
  
	EXECUTE 'TRUNCATE TABLE relationship' || SUFFIX;
	EXECUTE 'COPY relationship' || SUFFIX || '(id, effectivetime, active, moduleid, sourceid, destinationid, relationshipgroup, typeid,characteristictypeid, modifierid) FROM '''
        || FOLDER || '/' || GROUP || '/Terminology/sct2_Relationship_' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'TRUNCATE TABLE stated_relationship' || SUFFIX;
	EXECUTE 'COPY stated_relationship' || SUFFIX || '(id, effectivetime, active, moduleid, sourceid, destinationid, relationshipgroup, typeid,  characteristictypeid, modifierid) FROM '''
        || FOLDER || '/' || GROUP || '/Terminology/sct2_StatedRelationship_' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';
  
	EXECUTE 'TRUNCATE TABLE langrefset' || SUFFIX;
	EXECUTE 'COPY langrefset' || SUFFIX || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, acceptabilityid) FROM '''
        || FOLDER || '/' || GROUP || '/Refset/Language/der2_cRefset_Language' || type || '-en_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';
  
	EXECUTE 'TRUNCATE TABLE associationrefset' || SUFFIX;
	EXECUTE 'COPY associationrefset' || SUFFIX || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, targetcomponentid) FROM '''
        || FOLDER || '/' || GROUP || '/Refset/Content/der2_cRefset_Association' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'TRUNCATE TABLE simplerefset' || SUFFIX;
	EXECUTE 'COPY simplerefset' || SUFFIX || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid) FROM '''
        || FOLDER || '/' || GROUP || '/Refset/Content/der2_Refset_Simple' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'TRUNCATE TABLE attributevaluerefset' || SUFFIX;
	EXECUTE 'COPY attributevaluerefset' || SUFFIX || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, valueid) FROM '''
        || FOLDER || '/' || GROUP || '/Refset/Content/der2_cRefset_AttributeValue' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'TRUNCATE TABLE simplemaprefset' || SUFFIX;
	EXECUTE 'COPY simplemaprefset' || SUFFIX || '(id, effectivetime, active, moduleid, refsetid,  referencedcomponentid, maptarget) FROM '''
        || FOLDER || '/' || GROUP || '/Refset/Map/der2_sRefset_SimpleMap' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';

	EXECUTE 'TRUNCATE TABLE extendedmaprefset' || SUFFIX;
	EXECUTE 'COPY extendedmaprefset' || SUFFIX || '(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, mapGroup, mapPriority, mapRule, mapAdvice, mapTarget, correlationId, mapCategoryId) FROM '''
        || FOLDER || '/' || GROUP || '/Refset/Map/der2_iisssccRefset_ExtendedMap' || type || '_' || RELEASE || '.txt'' WITH (FORMAT csv, HEADER true, ENCODING ''UTF8'', DELIMITER ''	'')';
END $$