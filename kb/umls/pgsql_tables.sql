drop schema if exists umls cascade;
create schema umls;
set schema 'umls';


CREATE TABLE MRCOLS (
	COL			varchar(20),
	DES			varchar(200),
	REF			varchar(40),
	MIN			int,
	AV			numeric(5,2),
	MAX			int,
	FIL			varchar(50),
	DTY			varchar(40),
	dummy 		char(1)
);


CREATE TABLE  MRCONSO (
	CUI			char(8) NOT NULL,
	LAT			char(3) NOT NULL,
	TS			char(1) NOT NULL,
	LUI			char(10) NOT NULL,
	STT			varchar(3) NOT NULL,
	SUI			char(10) NOT NULL,
	ISPREF		char(1) NOT NULL,
	AUI			varchar(9) NOT NULL,
	SAUI		varchar(50),
	SCUI		varchar(100),
	SDUI		varchar(100),
	SAB			varchar(40) NOT NULL,
	TTY			varchar(40) NOT NULL,
	CODE		varchar(100) NOT NULL,
	STR			text NOT NULL,
	SRL			varchar(10) NOT NULL,
	SUPPRESS	char(1) NOT NULL,
	CVF			int,
	dummy 		char(1)
);


CREATE TABLE MRCUI (
	CUI1		char(8) NOT NULL,
	VER			varchar(10) NOT NULL,
	REL			varchar(4) NOT NULL,
	RELA		varchar(100),
	MAPREASON	text,
	CUI2		char(12),
	MAPIN		char(1),
	dummy 		char(1)
);


CREATE TABLE MRDEF (
	CUI			char(8) NOT NULL,
	AUI			varchar(9) NOT NULL,
	ATUI		varchar(11) NOT NULL,
	SATUI		varchar(50),
	SAB			varchar(40) NOT NULL,
	DEF			text NOT NULL,
	SUPPRESS	char(1) NOT NULL,
	CVF			int,
	dummy 		char(1)
);


CREATE TABLE MRDOC (
	DOCKEY		varchar(50) NOT NULL,
	VALUE		varchar(200),
	TYPE		varchar(50) NOT NULL,
	EXPL		text,
	dummy 		char(1)
);


CREATE TABLE MRFILES (
	FIL			varchar(50),
	DES			varchar(200),
	FMT			text,
	CLS			int,
	RWS			int,
	BTS			bigint,
	dummy 		char(1)
);


CREATE TABLE MRHIER (
	CUI			char(8) NOT NULL,
	AUI			varchar(9) NOT NULL,
	CXN			int NOT NULL,
	PAUI		varchar(10),
	SAB			varchar(40) NOT NULL,
	RELA		varchar(100),
	PTR			text,
	HCD			varchar(100),
	CVF			int,
	dummy 		char(1)
);


CREATE TABLE MRHIST (
	CUI			char(8) NOT NULL,
	SOURCEUI	varchar(100) NOT NULL,
	SAB			varchar(40) NOT NULL,
	SVER		varchar(40) NOT NULL,
	CHANGETYPE	text NOT NULL,
	CHANGEKEY	text NOT NULL,
	CHANGEVAL	text NOT NULL,
	REASON		text,
	CVF			int,
	dummy 		char(1)
);


CREATE TABLE MRMAP (
	MAPSETCUI	char(8),
	MAPSETSAB	varchar(40),
	MAPSUBSETID	varchar(10),
	MAPRANK		int,
	MAPID		varchar(50),
	MAPSID		varchar(50),
	FROMID		varchar(50),
	FROMSID		varchar(50),
	FROMEXPR	text,
	FROMTYPE	varchar(50),
	FROMRULE	text,
	FROMRES		text,
	REL			varchar(4),
	RELA		varchar(100),
	TOID		varchar(50),
	TOSID		varchar(50),
	TOEXPR		text,
	TOTYPE		varchar(50),
	TORULE		text,
	TORES		text,
	MAPRULE		text,
	MAPRES		text,
	MAPTYPE		varchar(50),
	MAPATN		varchar(100),
	MAPATV		text,
	CVF			int,
	dummy 		char(1)
);


CREATE TABLE MRRANK (
	RANK		int NOT NULL,
	SAB			varchar(40) NOT NULL,
	TTY			varchar(40) NOT NULL,
	SUPPRESS	char(1) NOT NULL,
	dummy 		char(1)
);


CREATE TABLE MRREL (
	CUI1		char(8) NOT NULL,
	AUI1		varchar(9),
	STYPE1		varchar(50) NOT NULL,
	REL			varchar(4) NOT NULL,
	CUI2		char(8) NOT NULL,
	AUI2		varchar(9),
	STYPE2		varchar(50) NOT NULL,
	RELA		varchar(100),
	RUI			varchar(10) NOT NULL,
	SRUI		varchar(50),
	SAB			varchar(40) NOT NULL,
	SL			varchar(40) NOT NULL,
	RG			varchar(10),
	DIR			varchar(1),
	SUPPRESS	char(1) NOT NULL,
	CVF			int,
	dummy 		char(1)
);


CREATE TABLE MRSAB (
	VCUI		char(8),
	RCUI		char(8),
	VSAB		varchar(40) NOT NULL,
	RSAB		varchar(40) NOT NULL,
	SON			text NOT NULL,
	SF			varchar(40) NOT NULL,
	SVER		varchar(40),
	VSTART		char(8),
	VEND		char(8),
	IMETA		varchar(10) NOT NULL,
	RMETA		varchar(10),
	SLC			text,
	SCC			text,
	SRL			int NOT NULL,
	TFR			int,
	CFR			int,
	CXTY		varchar(50),
	TTYL		varchar(400),
	ATNL		text,
	LAT			char(3),
	CENC		varchar(40) NOT NULL,
	CURVER		char(1) NOT NULL,
	SABIN		char(1) NOT NULL,
	SSN			text NOT NULL,
	SCIT		text NOT NULL,
	dummy 		char(1)
);


CREATE TABLE MRSAT (
	CUI			char(8) NOT NULL,
	LUI			char(10),
	SUI			char(10),
	METAUI		varchar(100),
	STYPE		varchar(50) NOT NULL,
	CODE		varchar(100),
	ATUI		varchar(11) NOT NULL,
	SATUI		varchar(50),
	ATN			varchar(100) NOT NULL,
	SAB			varchar(40) NOT NULL,
	ATV			text,
	SUPPRESS	char(1) NOT NULL,
	CVF			int,
	dummy 		char(1)
);


CREATE TABLE MRSMAP (
	MAPSETCUI	char(8),
	MAPSETSAB	varchar(40),
	MAPID		varchar(50),
	MAPSID		varchar(50),
	FROMEXPR	text,
	FROMTYPE	varchar(50),
	REL			varchar(4),
	RELA		varchar(100),
	TOEXPR		text,
	TOTYPE		varchar(50),
	CVF			int,
	dummy 		char(1)
);


CREATE TABLE MRSTY (
	CUI			char(8) NOT NULL,
	TUI			char(4) NOT NULL,
	STN			varchar(100) NOT NULL,
	STY			varchar(50) NOT NULL,
	ATUI		varchar(11) NOT NULL,
	CVF			int,
	dummy 		char(1)
);


CREATE TABLE MRXNS_ENG (
	LAT			char(3) NOT NULL,
	NSTR		text NOT NULL,
	CUI			char(8) NOT NULL,
	LUI			char(10) NOT NULL,
	SUI			char(10) NOT NULL,
	dummy 		char(1)
);


CREATE TABLE MRXNW_ENG (
	LAT			char(3) NOT NULL,
	NWD			varchar(200) NOT NULL,
	CUI			char(8) NOT NULL,
	LUI			char(10) NOT NULL,
	SUI			char(10) NOT NULL,
	dummy 		char(1)
);


CREATE TABLE MRAUI (
	AUI1		varchar(9) NOT NULL,
	CUI1		char(8) NOT NULL,
	VER			varchar(10) NOT NULL,
	REL			varchar(4),
	RELA		varchar(100),
	MAPREASON	text NOT NULL,
	AUI2		varchar(9) NOT NULL,
	CUI2		char(8) NOT NULL,
	MAPIN		char(1) NOT NULL,
	dummy 		char(1)
);


CREATE TABLE AMBIGSUI (
	SUI			char(10) NOT NULL,
	CUI			char(8) NOT NULL,
	dummy 		char(1)
);


CREATE TABLE AMBIGLUI (
	LUI			char(10) NOT NULL,
	CUI			char(8) NOT NULL,
	dummy 		char(1)
);


CREATE TABLE DELETEDCUI (
	PCUI		char(8) NOT NULL,
	PSTR		text NOT NULL,
	dummy 		char(1)
);


CREATE TABLE DELETEDLUI (
	PLUI		char(10) NOT NULL,
	PSTR		text NOT NULL,
	dummy 		char(1)
);


CREATE TABLE DELETEDSUI (
	PSUI		char(10) NOT NULL,
	LAT			char(3) NOT NULL,
	PSTR		text NOT NULL,
	dummy 		char(1)
);


CREATE TABLE MERGEDCUI (
	PCUI		char(8) NOT NULL,
	CUI			char(8) NOT NULL,
	dummy 		char(1)
);


CREATE TABLE MERGEDLUI (
	PLUI		char(10),
	LUI			char(10),
	dummy 		char(1)
);

