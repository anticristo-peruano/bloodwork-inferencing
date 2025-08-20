set schema 'loinc';


DO $$
DECLARE
	FOLDER TEXT := '/nvme/git/work/bloodwork-inferencing/kb/loinc';

BEGIN
	EXECUTE format('COPY answerlist FROM %L CSV HEADER QUOTE AS %L',FOLDER || '/AccessoryFiles/AnswerFile/AnswerList.csv','"'); 
	EXECUTE 'COPY consumername FROM ' || quote_literal(FOLDER || '/AccessoryFiles/ConsumerName/ConsumerName.csv') || ' CSV HEADER';
	EXECUTE 'COPY documentontology FROM ' || quote_literal(FOLDER || '/AccessoryFiles/DocumentOntology/DocumentOntology.csv') || ' CSV HEADER';
	EXECUTE 'COPY imagingdocumentcodes FROM ' || quote_literal(FOLDER || '/AccessoryFiles/ImagingDocuments/ImagingDocumentCodes.csv') || ' CSV HEADER';
	EXECUTE 'COPY linguisticvariants FROM ' || quote_literal(FOLDER || '/AccessoryFiles/LinguisticVariants/LinguisticVariants.csv') || ' CSV HEADER';
	EXECUTE 'COPY loinc FROM ' || quote_literal(FOLDER || '/LoincTable/Loinc.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincanswerlistlink FROM ' || quote_literal(FOLDER || '/AccessoryFiles/AnswerFile/LoincAnswerListLink.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincchangesnapshot FROM ' || quote_literal(FOLDER || '/AccessoryFiles/ChangeSnapshot/LoincChangeSnapshot.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincgroup FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/Group.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincgroupattributes FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupAttributes.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincgrouploincterms FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupLoincTerms.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincieeemedicaldevicecodemappingtable FROM ' || quote_literal(FOLDER || '/AccessoryFiles/LoincIeeeMedicalDeviceCodeMappingTable/LoincIeeeMedicalDeviceCodeMappingTable.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincparentgroup FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroup.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincparentgroupattributes FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroupAttributes.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincpartlink_primary FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PartFile/LoincPartLink_Primary.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincpartlink_supplementary FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PartFile/LoincPartLink_Supplementary.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincrsnaradiologyplaybook FROM ' || quote_literal(FOLDER || '/AccessoryFiles/LoincRsnaRadiologyPlaybook/LoincRsnaRadiologyPlaybook.csv') || ' CSV HEADER';
	EXECUTE 'COPY loinctablecore FROM ' || quote_literal(FOLDER || '/LoincTableCore/LoincTableCore.csv') || ' CSV HEADER';
	EXECUTE 'COPY loincuniversallabordersvalueset FROM ' || quote_literal(FOLDER || '/AccessoryFiles/LoincUniversalLabOrdersValueSet/LoincUniversalLabOrdersValueSet.csv') || ' CSV HEADER';
	EXECUTE 'COPY mapto FROM ' || quote_literal(FOLDER || '/LoincTable/MapTo.csv') || ' CSV HEADER';
	EXECUTE 'COPY coremapto FROM ' || quote_literal(FOLDER || '/LoincTableCore/MapTo.csv') || ' CSV HEADER';
	EXECUTE 'COPY panelsandforms FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PanelsAndForms/PanelsAndForms.csv') || ' CSV HEADER';
	EXECUTE 'COPY part FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PartFile/Part.csv') || ' CSV HEADER';
	EXECUTE 'COPY partchangesnapshot FROM ' || quote_literal(FOLDER || '/AccessoryFiles/ChangeSnapshot/PartChangeSnapshot.csv') || ' CSV HEADER';
	EXECUTE 'COPY partrelatedcodemapping FROM ' || quote_literal(FOLDER || '/AccessoryFiles/PartFile/PartRelatedCodeMapping.csv') || ' CSV HEADER';
	EXECUTE 'COPY sourceorganization FROM ' || quote_literal(FOLDER || '/LoincTable/SourceOrganization.csv') || ' CSV HEADER';
	EXECUTE 'COPY updates FROM ' || quote_literal(FOLDER || '/AccessoryFiles/Updates/Updates.csv') || ' CSV HEADER';
	EXECUTE 'COPY componenthierarchybysystem FROM ' || quote_literal(FOLDER || '/AccessoryFiles/ComponentHierarchyBySystem/ComponentHierarchyBySystem.csv') || ' CSV HEADER';
	EXECUTE 'COPY loinc_group FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/Group.csv') || ' CSV HEADER';
	EXECUTE 'COPY groupattributes FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupAttributes.csv') || ' CSV HEADER';
	EXECUTE 'COPY grouploincterms FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupLoincTerms.csv') || ' CSV HEADER';
	EXECUTE 'COPY parentgroup FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroup.csv') || ' CSV HEADER';
	EXECUTE 'COPY parentgroupattributes FROM ' || quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroupAttributes.csv') || ' CSV HEADER';

END $$;

CHECKPOINT;