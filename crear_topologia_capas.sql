CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;

-- CREAR ESQUEMA TOPOLOGICO

SELECT topology.CreateTopology('nombre_topo', SRC, tolerancia); 

-- AÑADIR COLUMNA TOPOGEOMETRICA

SELECT topology.AddTopoGeometryColumn('nombre_topo', 'esquema_capa', 'nombre_capa', 'nombre_topogeom', 'tipo_geometría');

-- CREAR TOPOLOGIA

UPDATE nombre_capa 
SET topogeom = topology.toTopoGeom(
     columna_geom, 'esquema_topo', 
     layer_id, tolerancia
);

-- BORRAR TOPOLOGIA

SELECT topology.DropTopology('nombre_capa');
