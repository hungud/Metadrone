﻿SELECT DISTINCT 
    INFORMATION_SCHEMA.TABLES.TABLE_NAME                AS TABLE_NAME,
    INFORMATION_SCHEMA.TABLES.TABLE_TYPE                AS TABLE_TYPE,
    INFORMATION_SCHEMA.COLUMNS.ORDINAL_POSITION         AS ORDINAL_POSITION, 
    INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME              AS COLUMN_NAME, 
    INFORMATION_SCHEMA.COLUMNS.DATA_TYPE                AS DATA_TYPE, 
    INFORMATION_SCHEMA.COLUMNS.CHARACTER_MAXIMUM_LENGTH AS CHARACTER_MAXIMUM_LENGTH, 
    INFORMATION_SCHEMA.COLUMNS.NUMERIC_PRECISION        AS NUMERIC_PRECISION, 
    INFORMATION_SCHEMA.COLUMNS.NUMERIC_SCALE            AS NUMERIC_SCALE, 
    INFORMATION_SCHEMA.COLUMNS.IS_NULLABLE              AS IS_NULLABLE, 
    CASE WHEN INFORMATION_SCHEMA.COLUMNS.EXTRA = 'auto_increment' THEN 'YES' ELSE 'NO' END 
                                                        AS IS_IDENTITY, 
    INFORMATION_SCHEMA.COLUMNS.COLUMN_KEY               AS CONSTRAINT_TYPE 
FROM 
    INFORMATION_SCHEMA.TABLES 
LEFT JOIN 
    INFORMATION_SCHEMA.COLUMNS ON INFORMATION_SCHEMA.COLUMNS.TABLE_NAME = INFORMATION_SCHEMA.TABLES.TABLE_NAME 
WHERE 
    INFORMATION_SCHEMA.TABLES.TABLE_SCHEMA <> 'mysql' AND INFORMATION_SCHEMA.TABLES.TABLE_SCHEMA <> 'information_schema' 
ORDER BY 
    INFORMATION_SCHEMA.TABLES.TABLE_NAME, 
    INFORMATION_SCHEMA.COLUMNS.ORDINAL_POSITION
