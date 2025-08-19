#!/bin/sh

psql -U postgres -p 5432 -f pgsql_tables.sql postgres
echo "Tables loaded."

psql -U postgres -p 5432 -f pgsql_populate.sql postgres
echo "Tables populated."

psql -U postgres -p 5432 -f pgsql_index.sql postgres
echo "Indexing Ready."