-- ADD EXTENSIONS

create extension postgis;
create extension pgrouting;

-- CREATE COLUMNS TO TARGET TABLE (LAYER)

ALTER TABLE table_name ADD COLUMN cost double precision;
ALTER TABLE table_name ADD COLUMN source int;
ALTER TABLE table_name ADD COLUMN target int;

-- CREATE TOPOLOGY

SELECT pgr_createTopology('table_name', tolerance, 'geometry_column', 'gid', 'source', 'target');
