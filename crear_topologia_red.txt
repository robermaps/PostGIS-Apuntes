-- ACTIVAR EXTENSIONES

create extension postgis;
create extension pgrouting;

-- CREAR COLUMNAS 

ALTER TABLE nombre_capa ADD COLUMN coste double precision;
ALTER TABLE nombre_capa ADD COLUMN source int;
ALTER TABLE nombre_capa ADD COLUMN target int;

-- CREAR TOPOLOGIA

SELECT pgr_createTopology('nombre_capa', tolerancia, 'geom', 'gid', 'source', 'target');
