set schema 'umls';

DO $$
DECLARE
	FOLDER TEXT := '/nvme/git/work/bloodwork-inferencing/kb/umls';
	RELEASE TEXT:= '2025AA';
	
	TABLES TEXT[] := ARRAY[
		'MRCOLS','MRCONSO','MRCUI','MRDEF','MRDOC',
	    'MRFILES','MRHIER','MRHIST','MRMAP','MRRANK',
		'MRREL','MRSAB','MRSAT','MRSMAP','MRSTY',
		'MRXNS_ENG','MRXNW_ENG','MRAUI','AMBIGSUI','AMBIGLUI',
		'DELETEDCUI','DELETEDLUI','DELETEDSUI','MERGEDCUI','MERGEDLUI'
	];

	t TEXT;
BEGIN
	FOREACH t IN ARRAY TABLES LOOP
		EXECUTE 'COPY ' || t ||
                ' FROM ' || quote_literal(FOLDER || '/' || RELEASE || '/META/' || t || '.RRF') ||
                ' WITH (FORMAT text, DELIMITER ''|'', NULL '''')';

        EXECUTE 'ALTER TABLE ' || t || ' DROP COLUMN dummy';
	END LOOP;
END $$