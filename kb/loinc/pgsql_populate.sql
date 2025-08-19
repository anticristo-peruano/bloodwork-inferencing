set schema 'loinc';

DO $$
DECLARE
	FOLDER TEXT := '/nvme/git/work/bloodwork-inferencing/kb/loinc';
BEGIN
	COPY answerlist FROM quote_literal(FOLDER || '/AccessoryFiles/AnswerFile/AnswerList.csv') CSV HEADER QUOTE AS '"';
	COPY consumername FROM quote_literal(FOLDER || '/AccessoryFiles/ConsumerName/ConsumerName.csv') CSV HEADER;
	COPY documentontology FROM quote_literal(FOLDER || '/AccessoryFiles/DocumentOntology/DocumentOntology.csv') CSV HEADER;
	COPY imagingdocumentcodes FROM quote_literal(FOLDER || '/AccessoryFiles/ImagingDocuments/ImagingDocumentCodes.csv') CSV HEADER;
	COPY linguisticvariants FROM quote_literal(FOLDER || '/AccessoryFiles/LinguisticVariants/LinguisticVariants.csv') CSV HEADER;
	COPY loinc FROM quote_literal(FOLDER || '/LoincTable/Loinc.csv') CSV HEADER;
	COPY loincanswerlistlink FROM quote_literal(FOLDER || '/AccessoryFiles/AnswerFile/LoincAnswerListLink.csv') CSV HEADER;
	COPY loincanswerlistlink FROM quote_literal(FOLDER || '/AccessoryFiles/PanelsAndForms/LoincAnswerListLink.csv') CSV HEADER;
	COPY loincchangesnapshot FROM quote_literal(FOLDER || '/AccessoryFiles/ChangeSnapshot/LoincChangeSnapshot.csv') CSV HEADER;
	COPY loincgroup FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/Group.csv') CSV HEADER;
	COPY loincgroupattributes FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupAttributes.csv') CSV HEADER;
	COPY loincgrouploincterms FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupLoincTerms.csv') CSV HEADER;
	COPY loincieeemedicaldevicecodemappingtable FROM quote_literal(FOLDER || '/AccessoryFiles/LoincIeeeMedicalDeviceCodeMappingTable/LoincIeeeMedicalDeviceCodeMappingTable.csv') CSV HEADER;
	COPY loincparentgroup FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroup.csv') CSV HEADER;
	COPY loincparentgroupattributes FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroupAttributes.csv') CSV HEADER;
	COPY loincpartlink_primary FROM quote_literal(FOLDER || '/AccessoryFiles/PartFile/LoincPartLink_Primary.csv') CSV HEADER;
	COPY loincpartlink_supplementary FROM quote_literal(FOLDER || '/AccessoryFiles/PartFile/LoincPartLink_Supplementary.csv') CSV HEADER;
	COPY loincrsnaradiologyplaybook FROM quote_literal(FOLDER || '/AccessoryFiles/LoincRsnaRadiologyPlaybook/LoincRsnaRadiologyPlaybook.csv') CSV HEADER;
	COPY loinctablecore FROM quote_literal(FOLDER || '/LoincTableCore/LoincTableCore.csv') CSV HEADER;
	COPY loincuniversallabordersvalueset FROM quote_literal(FOLDER || '/AccessoryFiles/LoincUniversalLabOrdersValueSet/LoincUniversalLabOrdersValueSet.csv') CSV HEADER;
	COPY mapto FROM quote_literal(FOLDER || '/LoincTable/MapTo.csv') CSV HEADER;
	COPY coremapto FROM quote_literal(FOLDER || '/LoincTableCore/MapTo.csv') CSV HEADER;
	COPY panelsandforms FROM quote_literal(FOLDER || '/AccessoryFiles/PanelsAndForms/PanelsAndForms.csv') CSV HEADER;
	COPY part FROM quote_literal(FOLDER || '/AccessoryFiles/PartFile/Part.csv') CSV HEADER;
	COPY partchangesnapshot FROM quote_literal(FOLDER || '/AccessoryFiles/ChangeSnapshot/PartChangeSnapshot.csv') CSV HEADER;
	COPY partrelatedcodemapping FROM quote_literal(FOLDER || '/AccessoryFiles/PartFile/PartRelatedCodeMapping.csv') CSV HEADER;
	COPY sourceorganization FROM quote_literal(FOLDER || '/LoincTable/SourceOrganization.csv') CSV HEADER;
	COPY updates FROM quote_literal(FOLDER || '/AccessoryFiles/Updates/Updates.csv') CSV HEADER;
	COPY componenthierarchybysystem FROM quote_literal(FOLDER || '/AccessoryFiles/ComponentHierarchyBySystem/ComponentHierarchyBySystem.csv') CSV HEADER;
	COPY loinc_group FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/Group.csv') CSV HEADER;
	COPY groupattributes FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupAttributes.csv') CSV HEADER;
	COPY grouploincterms FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/GroupLoincTerms.csv') CSV HEADER;
	COPY parentgroup FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroup.csv') CSV HEADER;
	COPY parentgroupattributes FROM quote_literal(FOLDER || '/AccessoryFiles/GroupFile/ParentGroupAttributes.csv') CSV HEADER;
END $$

CHECKPOINT;