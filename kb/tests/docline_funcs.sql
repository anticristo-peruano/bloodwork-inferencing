/*
Auxiliary functions to point plpython3u towards the virtual environment
and load the NLP functions.
*/

CREATE SCHEMA IF NOT EXISTS test AUTHORIZATION postgres;
SET search_path TO test, loinc, snomedct, umls;
CREATE EXTENSION IF NOT EXISTS plpython3u;




CREATE OR REPLACE FUNCTION use_venv(venv text)
RETURNS text
LANGUAGE plpython3u
AS $$
import os, sys, site
venv_path = os.path.realpath(os.path.expanduser(venv))
sitepkgs = os.path.join(venv_path,'lib',f'python{sys.version_info[0]}.{sys.version_info[1]}','site-packages')
site.addsitedir(sitepkgs)
return f'using {sitepkgs}'
$$;

SELECT use_venv('/nvme/git/work/bloodwork-inferencing/.venv');
-- Should be changed for something not absolute.



CREATE OR REPLACE FUNCTION test.stoilos(
    a text,
    b text,
    p double precision DEFAULT 0.60,
    subs_thres integer DEFAULT 2,
    prefix_scale double precision DEFAULT 0.10,
    max_prefix integer DEFAULT 4)
RETURNS double precision
LANGUAGE plpython3u
AS $$
import docline.nlp.metrics as doc
return float(doc.stoilos_similarity(
    a, b,
    p = p,
    subs_thres = subs_thres,
    prefix_scale = prefix_scale,
    max_prefix = max_prefix
))
$$;




CREATE OR REPLACE FUNCTION test.sjb(
    a text,
    b text,
    sim_thres double precision DEFAULT 0.80)
RETURNS double precision
LANGUAGE plpython3u
AS $$
import docline.nlp.metrics as doc
return float(doc.soft_jaccard_bow(
    a, b,
    sim_thres = sim_thres
))
$$;




CREATE OR REPLACE FUNCTION test.sim(
    a text,
    b text,
    p double precision DEFAULT 0.70,
    sim_thres double precision DEFAULT 0.80)
RETURNS double precision
LANGUAGE plpython3u
AS $$
import docline.nlp.metrics as doc
return float(doc.combined_similarity(
    a, b,
    p = p,
    sim_thres = sim_thres
))
$$;




CREATE OR REPLACE FUNCTION test.conf(
    a text,
    b text,
    p double precision DEFAULT 0.70,
    floor double precision DEFAULT 0.15,
    ceil double precision DEFAULT 1.00,
    sim_thres double precision DEFAULT 0.80)
RETURNS double precision
LANGUAGE plpython3u
AS $$
import docline.nlp.metrics as doc
return float(doc.confidence_score(
    a, b,
    p = p,
    floor = floor,
    ceil = ceil,
    sim_thres = sim_thres
))
$$;

SELECT test.stoilos('serum sodium', 'sodium [substance] in serum'); -- 0.76
SELECT test.sjb('blood urea nitrogen','urea nitrogen in blood');    -- 1
SELECT test.sim('glucose', 'glucose test');                         -- 0.745
SELECT test.conf('glucose','glucose test');                         -- 700