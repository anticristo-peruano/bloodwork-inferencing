DROP SCHEMA IF EXISTS loinc CASCADE;
CREATE SCHEMA loinc;
SET 'loinc';


CREATE TABLE answerlist (
    answerlistid                    varchar(255),
    answerlistname                  varchar(255),
    answerlistoid                   varchar(255),
    extdefinedyn                    varchar(255),
    extdefinedanswerlistcodesystem  varchar(255),
    extdefinedanswerlistlink        varchar(255),
    answerstringid                  varchar(255),
    localanswercode                 varchar(255),
    localanswercodesystem           varchar(255),
    sequencenumber                  varchar(255),
    displaytext                     varchar(255),
    extcodeid                       varchar(255),
    extcodedisplayname              varchar(255),
    extcodesystem                   varchar(255),
    extcodesystemversion            varchar(255),
    extcodesystemcopyrightnotice    text,
    subsequenttextprompt            varchar(255),
    description                     text,
    score                           varchar(255)
);


CREATE TABLE consumername (
    loincnumber                     varchar(255),
    consumername                    varchar(255)
);


CREATE TABLE documentontology (
    loincnumber                     varchar(255),
    partnumber                      varchar(255),
    parttypename                    varchar(255),
    partsequenceorder               varchar(255),
    partname                        varchar(255)
);


CREATE TABLE imagingdocumentcodes (
    loinc_num                       varchar(255),
    long_common_name                varchar(255)
);


CREATE TABLE linguisticvariants (
    id                              varchar(255),
    iso_language                    varchar(255),
    iso_country                     varchar(255),
    language_name                   varchar(255),
    producer                        varchar(255)
);


CREATE TABLE loinc (
    loinc_num                       varchar(255),
    component                       varchar(255),
    property                        varchar(255),
    time_aspct                      varchar(255),
    system                          varchar(255),
    scale_typ                       varchar(255),
    method_typ                      varchar(255),
    class                           varchar(255),
    versionlastchanged              varchar(255),
    chng_type                       varchar(255),
    definitiondescription           text,
    status                          varchar(255),
    consumer_name                   varchar(255),
    classtype                       varchar(255),
    formula                         text,
    exmpl_answers                   text,
    survey_quest_text               text,
    survey_quest_src                varchar(255),
    unitsrequired                   varchar(255),
    relatednames2                   text,
    shortname                       varchar(255),
    order_obs                       varchar(255),
    hl7_field_subfield_id           varchar(255),
    external_copyright_notice       text,
    example_units                   varchar(255),
    long_common_name                varchar(255),
    example_ucum_units              varchar(255),
    status_reason                   varchar(255),
    status_text                     text,
    change_reason_public            text,
    common_test_rank                varchar(255),
    common_order_rank               varchar(255),
    common_si_test_rank             varchar(255),
    hl7_attachment_structure        varchar(255),
    external_copyright_link         varchar(255),
    paneltype                       varchar(255),
    askatorderentry                 varchar(255),
    associatedobservations          varchar(255),
    versionfirstreleased            varchar(255),
    validhl7attachmentrequest       varchar(255),
    displayname                     varchar(255)
);


CREATE TABLE loincanswerlistlink (
    loincnumber                     varchar(255),
    longcommonname                  varchar(255),
    answerlistid                    varchar(255),
    answerlistname                  varchar(255),
    answerlistlinktype              varchar(255),
    applicablecontext               text
);


CREATE TABLE loincanswerlistlink (
    loincnumber                     varchar(255),
    longcommonname                  varchar(255),
    answerlistid                    varchar(255),
    answerlistname                  varchar(255),
    answerlistlinktype              varchar(255),
    applicablecontext               text
);


CREATE TABLE loincchangesnapshot (
    versioneffective                varchar(255),
    loinc_num                       varchar(255),
    property                        varchar(255),
    valueprior                      varchar(255),
    valuecurrent                    varchar(255),
    changereason                    text
);


CREATE TABLE loincgroup (
    parentloincgroupid              varchar(255),
    loincgroupid                    varchar(255),
    loincgroup                      varchar(255),
    archetype                       varchar(255),
    status                          varchar(255),
    versionfirstreleased            varchar(255)
);


CREATE TABLE loincgroupattributes (
    parentloincgroupid              varchar(255),
    loincgroupid                    varchar(255),
    type                            varchar(255),
    value                           text
);


CREATE TABLE loincgrouploincterms (
    category                        varchar(255),
    loincgroupid                    varchar(255),
    archetype                       varchar(255),
    loincnumber                     varchar(255),
    longcommonname                  varchar(255)
);


CREATE TABLE loincieeemedicaldevicecodemappingtable (
    loinc_num                       varchar(255),
    loinc_long_common_name          varchar(255),
    ieee_cf_code10                  varchar(255),
    ieee_refid                      varchar(255),
    equivalence                     varchar(255)
);


CREATE TABLE loincparentgroup (
    parentloincgroupid              varchar(255),
    parentloincgroup                varchar(255),
    status                          varchar(255)
);


CREATE TABLE loincparentgroupattributes (
    parentloincgroupid              varchar(255),
    type                            varchar(255),
    value                           text
);


CREATE TABLE loincpartlink_primary (
    loincnumber                     varchar(255),
    longcommonname                  varchar(255),
    partnumber                      varchar(255),
    partname                        varchar(255),
    partcodesystem                  varchar(255),
    parttypename                    varchar(255),
    linktypename                    varchar(255),
    property                        varchar(255)
);


CREATE TABLE loincpartlink_supplementary (
    loincnumber                     varchar(255),
    longcommonname                  varchar(255),
    partnumber                      varchar(255),
    partname                        varchar(255),
    partcodesystem                  varchar(255),
    parttypename                    varchar(255),
    linktypename                    varchar(255),
    property                        varchar(255)
);


CREATE TABLE loincrsnaradiologyplaybook (
    loincnumber                     varchar(255),
    longcommonname                  varchar(255),
    partnumber                      varchar(255),
    parttypename                    varchar(255),
    partname                        varchar(255),
    partsequenceorder               varchar(255),
    rid                             varchar(255),
    preferredname                   varchar(255),
    rpid                            varchar(255),
    longname                        varchar(255)
);


CREATE TABLE loinctablecore (
    loinc_num                       varchar(255),
    component                       varchar(255),
    property                        varchar(255),
    time_aspct                      varchar(255),
    system                          varchar(255),
    scale_typ                       varchar(255),
    method_typ                      varchar(255),
    class                           varchar(255),
    classtype                       varchar(255),
    long_common_name                varchar(255),
    shortname                       varchar(255),
    external_copyright_notice       text,
    status                          varchar(255),
    versionfirstreleased            varchar(255),
    versionlastchanged              varchar(255)
);


CREATE TABLE loincuniversallabordersvalueset (
    loinc_num                       varchar(255),
    long_common_name                varchar(255),
    order_obs                       varchar(255)
);


CREATE TABLE mapto (
    loinc                           varchar(255),
    map_to                          varchar(255),
    comment                         varchar(255)
);


CREATE TABLE coremapto (
    loinc                           varchar(255),
    map_to                          varchar(255),
    comment                         varchar(255)
);


CREATE TABLE panelsandforms (
    parentid                        varchar(255),
    parentloinc                     varchar(255),
    parentname                      varchar(255),
    id                              varchar(255),
    sequence                        varchar(255),
    loinc                           varchar(255),
    loincname                       varchar(255),
    displaynameforform              varchar(255),
    observationrequiredinpanel      varchar(255),
    observationidinform             varchar(255),
    skiplogichelptext               text,
    defaultvalue                    varchar(255),
    entrytype                       varchar(255),
    datatypeinform                  varchar(255),
    datatypesource                  varchar(255),
    answersequenceoverride          varchar(255),
    conditionforinclusion           varchar(255),
    allowablealternative            varchar(255),
    observationcategory             varchar(255),
    context                         text,
    consistencychecks               text,
    relevanceequation               varchar(255),
    codinginstructions              text,
    questioncardinality             varchar(255),
    answercardinality               varchar(255),
    answerlistidoverride            varchar(255),
    answerlisttypeoverride          varchar(255),
    external_copyright_notice       text
);


CREATE TABLE part (
    partnumber                      varchar(255),
    parttypename                    varchar(255),
    partname                        varchar(255),
    partdisplayname                 varchar(255),
    status                          varchar(255)
);


CREATE TABLE partchangesnapshot (
    versioneffective                varchar(255),
    partnumber                      varchar(255),
    property                        varchar(255),
    valueprior                      varchar(255),
    valuecurrent                    varchar(255),
    changereason                    varchar(255)
);


CREATE TABLE partrelatedcodemapping (
    partnumber                      varchar(255),
    partname                        varchar(255),
    parttypename                    varchar(255),
    extcodeid                       varchar(255),
    extcodedisplayname              varchar(255),
    extcodesystem                   varchar(255),
    equivalence                     varchar(255),
    contentorigin                   varchar(255),
    extcodesystemversion            varchar(255),
    extcodesystemcopyrightnotice    text
);


CREATE TABLE sourceorganization (
    id                              varchar(255),
    copyright_id                    varchar(255),
    name                            varchar(255),
    copyright                       text,
    terms_of_use                    text,
    url                             varchar(255)
);


CREATE TABLE updates (
    rectype                         varchar(255),
    loinc_num                       varchar(255),
    component                       varchar(255),
    property                        varchar(255),
    time_aspct                      varchar(255),
    system                          varchar(255),
    scale_typ                       varchar(255),
    method_typ                      varchar(255),
    class                           varchar(255)
);


CREATE TABLE componenthierarchybysystem (
    path_to_root                    varchar(255),
    sequence                        varchar(255),
    immediate_parent                varchar(255),
    code                            varchar(255),
    code_text                       varchar(255)
);


CREATE TABLE loinc_group (
    parentgroupid		            varchar(255),
    groupid		                    varchar(255),
    loinc_group		                varchar(255),
    archetype		                varchar(255),
    status		                    varchar(255),
    versionfirstreleased		    varchar(255)
);


CREATE TABLE groupattributes (
    parentgroupid		            varchar(255),
    groupid		                    varchar(255),
    type		                    varchar(255),
    value		                    text
);


CREATE TABLE grouploincterms (
    category		                varchar(255),
    groupid		                    varchar(255),
    archetype		                varchar(255),
    loincnumber		                varchar(255),
    longcommonname		            text
);


CREATE TABLE parentgroup (
    parentgroupid		            varchar(255),
    parentgroup		                varchar(255),
    status		                    varchar(255)
);


CREATE TABLE parentgroupattributes (
    parentgroupid		            varchar(255),
    type		                    varchar(255),
    value		                    text
);
