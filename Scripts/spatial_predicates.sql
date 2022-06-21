-- INTERSECTS --
-- True if some point in common

ST_Intersects (geometry A, geometry B)

-- EQUAL --
-- True if geometries are identical

ST_Equal(geometry A, geometry B)

-- DISJOINT --
-- True if geometries never coincide

ST_Disjoint(geometry A , geometry B)

-- CROSSES --
-- True if geometries have some interior points in common 
-- False between point-point and polygon-polygon

ST_Crosses(geometry A, geometry B)

-- OVERLAPS --
-- True if geometries share some space
-- False when geometries are in different dimension like point-polygon

ST_Overlaps(geometry A, geometry B)

-- TOUCHES --
-- True if geometries coincide in their boundaries
-- False if their interiors do 

ST_Touches(geometry A, geometry B)

-- WITHIN --
-- True if geometry A is within geometry B

ST_Within (geometry A , geometry B)

-- CONTAINS --
-- True if geometry A contains geometry B

ST_Contains(geometry A, geometry B)

-- DISTANCE --
-- Returns float with distance value between geometries

ST_Distance(geometry A, geometry B)

-- DISTANCE WITHIN
-- True if geometry A is within distance value of geometry B

ST_DWithin(geometry A, geometry B, distance)
