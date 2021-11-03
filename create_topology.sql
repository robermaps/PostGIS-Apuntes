-- ADD EXTENSIONS TO DATABASE 

CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;

-- CREATE TOPOLOGIC SCHEMA

SELECT topology.CreateTopology('topology_name', SRC, tolerance); 

-- ADD TOPOGEOMETRIC COLUMN TO TABLE (LAYER)

SELECT topology.AddTopoGeometryColumn('topology_name', 'table_schema', 'table_name', 'topogeometry_name', 'geometry_type');

-- CREATE TOPOLOGY POPULATING TOPOGEOMETRIC COLUMN

UPDATE table_name 
SET topogeometry_name = topology.toTopoGeom(
     geometry_column, 'topology_name', 
     id_column, tolerance
);

-- BORRAR TOPOLOGIA

SELECT topology.DropTopology('table_name');
