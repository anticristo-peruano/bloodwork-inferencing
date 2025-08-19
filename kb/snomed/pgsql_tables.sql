drop schema if exists snomedct cascade;
create schema snomedct;
set schema 'snomedct';


CREATE TABLE concept_f(
  	id 									varchar(18) not null,
  	effectivetime 						char(8) not null,
  	active 								char(1) not null,
  	moduleid 							varchar(18) not null,
  	definitionstatusid 					varchar(18) not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE description_f(
  	id 									varchar(18) not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	conceptid 							varchar(18) not null,
  	languagecode 						varchar(2) 	not null,
  	typeid 								varchar(18) not null,
  	term 								text 		not null,
  	casesignificanceid 					varchar(18) not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE textdefinition_f(
  	id 									varchar(18) not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	conceptid 							varchar(18) not null,
  	languagecode 						varchar(2) 	not null,
  	typeid 								varchar(18) not null,
  	term 								text 		not null,
  	casesignificanceid 					varchar(18) not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE relationship_f(
  	id 									varchar(18) not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	sourceid 							varchar(18) not null,
  	destinationid 						varchar(18) not null,
  	relationshipgroup 					varchar(18) not null,
  	typeid 								varchar(18) not null,
  	characteristictypeid 				varchar(18) not null,
  	modifierid 							varchar(18) not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE stated_relationship_f(
  	id 									varchar(18) not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	sourceid 							varchar(18) not null,
  	destinationid 						varchar(18) not null,
  	relationshipgroup 					varchar(18) not null,
  	typeid 								varchar(18) not null,
  	characteristictypeid 				varchar(18) not null,
  	modifierid 							varchar(18) not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE langrefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
  	acceptabilityid 					varchar(18) not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE associationrefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
  	targetcomponentid 					varchar(18) not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE attributevaluerefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
  	valueid 							varchar(18) not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE simplerefset_f(
  	id 									uuid 	not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE simplemaprefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
  	maptarget 							text not null,
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE extendedmaprefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
  	mapGroup 							smallint 	not null,
  	mapPriority 						smallint 	not null,
  	mapRule 							text,
  	mapAdvice 							text,
  	mapTarget 							text,
  	correlationId 						varchar(18),
  	mapCategoryId 						varchar(18),
  	PRIMARY KEY(id, effectivetime)
);


CREATE TABLE MRCMModuleScoperefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
	mrcmRuleRefsetId 					varchar(18) NOT NULL,
	PRIMARY KEY (id, effectiveTime)
);


CREATE TABLE RefsetDescriptorrefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
	attributeDescription 				varchar(18) NOT NULL,
	attributeType 						varchar(18) NOT NULL,
	attributeOrder 						INTEGER 	NOT NULL,
	PRIMARY KEY (id, effectiveTime)
);


CREATE TABLE DescriptionTyperefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
	descriptionFormat 					VARCHAR(18) NOT NULL,
	descriptionLength 					INTEGER 	NOT NULL,
	PRIMARY KEY (id, effectiveTime)
);


CREATE TABLE MRCMAttributeDomain_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
	domainId 							varchar(18) NOT NULL,
	grouped 							char(1) 	NOT NULL,
	attributeCardinality 				VARCHAR(12) NOT NULL,
	attributeInGroupCardinality 		VARCHAR(12) NOT NULL,
	ruleStrengthId 						varchar(18) NOT NULL,
	contentTypeId 						varchar(18) NOT NULL,
	PRIMARY KEY (id, effectiveTime)
);


CREATE TABLE MRCMAttributeRangeRefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
  	rangeConstraint						TEXT 		NOT NULL,
	attributeRule 						TEXT 		NOT NULL,
	ruleStrengthId 						varchar(18) NOT NULL,
	contentTypeId 						varchar(18) NOT NULL,
	PRIMARY KEY (id, effectiveTime)
);


CREATE TABLE MRCMDomain_f(  
	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
  	domainConstraint 					TEXT,
  	parentDomain 						TEXT,
  	proximalPrimitiveConstraint 		TEXT,
  	proximalPrimitiveRefinement 		TEXT,
  	domainTemplateForPrecoordination 	TEXT,
  	domainTemplateForPostcoordination 	TEXT,
  	guideURL 							TEXT 		NOT NULL,
 	PRIMARY KEY (id, effectiveTime)
);


CREATE TABLE ModuleDependencyRefset_f(
  	id 									uuid 		not null,
  	effectivetime 						char(8) 	not null,
  	active 								char(1) 	not null,
  	moduleid 							varchar(18) not null,
  	refsetid 							varchar(18) not null,
  	referencedcomponentid 				varchar(18) not null,
	sourceEffectiveTime 				CHAR(8) 	NOT NULL,
	targetEffectiveTime 				CHAR(8) 	NOT NULL,
	PRIMARY KEY (id, effectiveTime)
);


CREATE TABLE OWLExpressionRefset_f(
	id 									uuid 		not null,
	effectivetime 						char(8) 	not null,
	active 								char(1) 	not null,
	moduleid 							varchar(18) not null,
	refsetid 							varchar(18) not null,
	referencedcomponentid 				varchar(18) not null,
	owlexpression 						TEXT 		NOT NULL,
	PRIMARY KEY (id, effectiveTime)
);
