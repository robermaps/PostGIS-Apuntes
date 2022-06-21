-- This query imports 2 csv files to Postgres 
-- a first new one with the ratio between variable1 and variable2 and their id
-- and a second new one with the max value and the row id of variable1 for each category 

-- Create empty tables 
CREATE TABLE file1 (
  id VARCHAR(2),
  common_field VARCHAR(100),
  variable1 VARCHAR(3),
  category CHAR(1),
  PRIMARY KEY (id)
);

CREATE TABLE file2 (
  common_field VARCHAR(100),
  variable2 VARCHAR(3)
);

-- Import CSV content 
COPY file1(id,common_field,variable1,category)
FROM 'c:/route/file1.csv'
DELIMITER ';' CSV HEADER ;

COPY file2(common_field,variable2)
FROM 'c:/route/file2.csv'
DELIMITER ';' CSV HEADER ;

-- Fix column type 
ALTER TABLE file1 ALTER COLUMN variable1 TYPE numeric(5,2) USING variable1::smallint;
ALTER TABLE file2 ALTER COLUMN variable2 TYPE numeric(5,2) USING variable2::smallint;

-- Query to get the row id and ratio and copy to new file ratios.csv
CREATE VIEW ratios as
SELECT file1.id, CAST ((NULLIF(file1.variable1,0) / NULLIF(file2.variable2,0)) as numeric(5,2)) as ratio FROM file1
LEFT JOIN file2 
ON file1.common_field = file2.common_field
ORDER BY ratio DESC
;

COPY (SELECT * FROM ratios) 
TO 'c:/route/ratios.csv' 
DELIMITER ';' CSV HEADER;

-- Query to get the row id in each category where variable1 is maximum and copy to new file max_values.csv
create view maxvalues as 
SELECT file1.category, CAST(max(file1.variable1) as smallint) 
FROM file1 
GROUP BY file1.category;

COPY (SELECT file1.category, file1.id, max(file1.variable1) from file1
INNER join maxvalues
on maxvalues.max = file1.variable1 and maxvalues.category = file1.category
group by file1.category, file1.id) 
TO 'c:/route/max_values.csv' 
DELIMITER ';' CSV HEADER;

