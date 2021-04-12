create extension postgis;

-- INTERSECT

ST_Intersects (geometry A, geometry B)

-- EQUAL

ST_Equal(geometry A, geometry B)

-- DISJOINT

ST_Disjoint(geometry A , geometry B)

-- CROSSES

ST_Crosses(geometry A, geometry B)

-- OVERLAPS

ST_Overlaps(geometry A, geometry B)

-- TOUCHES

ST_Touches(geometry A, geometry B)

-- WITHIN

ST_Within (geometry A , geometry B)

-- CONTAINS

ST_Contains(geometry A, geometry B)

-- DISTANCE

ST_Distance(geometry A, geometry B)

-- DISTANCE WITHIN

ST_DWithin(geometry A, geometry B, distance)
