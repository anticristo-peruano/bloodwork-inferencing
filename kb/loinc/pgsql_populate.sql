set schema 'loinc';


DO $$
DECLARE
	FOLDER TEXT := '/nvme/git/work/bloodwork-inferencing/kb/loinc';

BEGIN
	EXECUTE format('COPY answerlist FROM %L CSV HEADER QUOTE AS %L',FOLDER || '/AccessoryFiles/AnswerFile/AnswerList.csv','"'); 
	EXECUTE 'COPY consumername FROM ' || quote_literal(FOLDER || '/AccessoryFiles/ConsumerName/ConsumerName.csv') || ' CSV HEADER';
	EXECUTE 'COPY documentontology FROM ' || quote_literal(FOLDER || '/AccessoryFiles/DocumentOntology/DocumentOntology.csv') || ' CSV HEADER';
	EXECUTE 'COPY loinc FROM ' || quote_literal(FOLDER || '/LoincTable/Loinc.csv') || ' CSV HEADER';
	EXECUTE 'COPY answerlistlink FROM ' || quote_literal(FOLDER || '/AccessoryFiles/AnswerFile/LoincAnswerListLink.csv') || ' CSV HEADER';
	EXECUTE 'COPY ieeemedicaldevicecodemappingtable FROM ' || quote_literal(FOLDER || '/AccessoryFiles/LoincIeeeMedicalDeviceCodeMappingTable/LoincIeeeMedicalDeviceCodeMappingTable.csv') || ' CSV HEADER';
	EXECUTE 'COPY partlink_primary FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PartFile/LoincPartLink_Primary.csv') || ' CSV HEADER';
	EXECUTE 'COPY partlink_supplementary FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PartFile/LoincPartLink_Supplementary.csv') || ' CSV HEADER';
	EXECUTE 'COPY universallabordersvalueset FROM ' || quote_literal(FOLDER || '/AccessoryFiles/LoincUniversalLabOrdersValueSet/LoincUniversalLabOrdersValueSet.csv') || ' CSV HEADER';
	EXECUTE 'COPY mapto FROM ' || quote_literal(FOLDER || '/LoincTable/MapTo.csv') || ' CSV HEADER';
	EXECUTE 'COPY panelsandforms FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PanelsAndForms/PanelsAndForms.csv') || ' CSV HEADER';
	EXECUTE 'COPY part FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PartFile/Part.csv') || ' CSV HEADER';
	EXECUTE 'COPY partrelatedcodemapping FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PartFile/PartRelatedCodeMapping.csv') || ' CSV HEADER';
	EXECUTE 'COPY sourceorganization FROM ' || quote_literal(FOLDER || '/LoincTable/SourceOrganization.csv') || ' CSV HEADER';
	EXECUTE 'COPY componenthierarchybysystem FROM ' || quote_literal(FOLDER || '/AccessoryFiles/ComponentHierarchyBySystem/ComponentHierarchyBySystem.csv') || ' CSV HEADER';
	EXECUTE 'COPY lgroup FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/Group.csv') || ' CSV HEADER';
	EXECUTE 'COPY groupattributes FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupAttributes.csv') || ' CSV HEADER';
	EXECUTE 'COPY grouploincterms FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupLoincTerms.csv') || ' CSV HEADER';
	EXECUTE 'COPY parentgroup FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroup.csv') || ' CSV HEADER';
	EXECUTE 'COPY parentgroupattributes FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroupAttributes.csv') || ' CSV HEADER';

END $$;

CHECKPOINT;