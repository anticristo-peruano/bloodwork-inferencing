/*
Auxiliary exploratory table to reduce complexity of lookup operations.
*/

CREATE INDEX IF NOT EXISTS rel_isa_idx
ON snomedct.relationship (destinationid, sourceid)
WHERE active='1' AND typeid='116680003';


DROP MATERIALIZED VIEW IF EXISTS snomedct.isa_closure CASCADE;
CREATE MATERIALIZED VIEW snomedct.isa_closure AS
WITH RECURSIVE cte AS (
  SELECT sourceid AS child, destinationid AS parent, 
  FROM snomedct.relationship
  WHERE active = '1' AND typeid = '116680003'
  UNION
  SELECT r.sourceid, cte.parent
  FROM snomedct.relationship r
  JOIN cte ON r.destinationid = cte.child
  WHERE r.active = '1' AND r.typeid = '116680003'
)
SELECT child, parent FROM cte;


CREATE UNIQUE INDEX IF NOT EXISTS isa_closure_uq ON snomedct.isa_closure (child, parent);
CREATE INDEX        IF NOT EXISTS isa_child_idx  ON snomedct.isa_closure (child);
CREATE INDEX        IF NOT EXISTS isa_parent_idx ON snomedct.isa_closure (parent);