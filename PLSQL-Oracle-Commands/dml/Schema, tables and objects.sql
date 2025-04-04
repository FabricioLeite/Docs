--Search for columns throughout the schema
SELECT COL.COLUMN_ID, 
       COL.OWNER AS SCHEMA_NAME,
       COL.TABLE_NAME, 
       COL.COLUMN_NAME, 
       COL.DATA_TYPE, 
       COL.DATA_LENGTH, 
       COL.DATA_PRECISION, 
       COL.DATA_SCALE, 
       COL.NULLABLE
FROM SYS.ALL_TAB_COLUMNS COL
INNER JOIN SYS.ALL_TABLES T ON COL.OWNER = T.OWNER 
  AND COL.TABLE_NAME = T.TABLE_NAME
WHERE 
	COL.COLUMN_NAME LIKE  '%PRODUCT%' --case sensitive
ORDER BY COL.COLUMN_ID;

--View tables that reference a particular table
SELECT 
    a.CONSTRAINT_NAME,
    a.TABLE_NAME,
    a.R_CONSTRAINT_NAME,
    b.TABLE_NAME AS REFERENCED_TABLE_NAME
FROM 
    ALL_CONSTRAINTS a
JOIN 
    ALL_CONSTRAINTS b ON a.R_CONSTRAINT_NAME = b.CONSTRAINT_NAME
WHERE 
    a.CONSTRAINT_TYPE = 'R' --foreign key
    AND b.TABLE_NAME = 'PRODUCT'; --case sensitive