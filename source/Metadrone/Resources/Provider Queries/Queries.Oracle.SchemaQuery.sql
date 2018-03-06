﻿SELECT
  USER_TABLES.TABLE_NAME,
  'BASE TABLE'                    AS TABLE_TYPE,
  ALL_TAB_COLUMNS.COLUMN_NAME,
  ALL_TAB_COLUMNS.DATA_TYPE,
  ALL_TAB_COLUMNS.COLUMN_ID       AS ORDINAL_POSITION,
  ALL_TAB_COLUMNS.DATA_LENGTH     AS CHARACTER_MAXIMUM_LENGTH,
  ALL_TAB_COLUMNS.DATA_PRECISION  AS NUMERIC_PRECISION,
  ALL_TAB_COLUMNS.DATA_SCALE      AS NUMERIC_SCALE,
  ALL_TAB_COLUMNS.NULLABLE        AS IS_NULLABLE,
  (SELECT ALL_INDEXES.UNIQUENESS
   FROM ALL_INDEXES
   INNER JOIN ALL_IND_COLUMNS ON ALL_IND_COLUMNS.INDEX_NAME = ALL_INDEXES.INDEX_NAME
   WHERE ALL_INDEXES.TABLE_NAME = USER_TABLES.TABLE_NAME
   AND ALL_IND_COLUMNS.COLUMN_NAME = ALL_TAB_COLUMNS.COLUMN_NAME
   AND ROWNUM = 1)                AS IS_IDENTITY,
  (SELECT ALL_CONSTRAINTS.CONSTRAINT_TYPE
   FROM ALL_CONSTRAINTS
   INNER JOIN ALL_CONS_COLUMNS ON ALL_CONS_COLUMNS.CONSTRAINT_NAME = ALL_CONSTRAINTS.CONSTRAINT_NAME
   WHERE ALL_CONSTRAINTS.TABLE_NAME = USER_TABLES.TABLE_NAME
   AND ALL_CONS_COLUMNS.COLUMN_NAME = ALL_TAB_COLUMNS.COLUMN_NAME
   AND ROWNUM = 1)                AS CONSTRAINT_TYPE
FROM
  USER_TABLES
INNER JOIN
  ALL_TAB_COLUMNS on ALL_TAB_COLUMNS.TABLE_NAME = USER_TABLES.TABLE_NAME

UNION ALL

SELECT
  USER_VIEWS.VIEW_NAME            AS TABLE_NAME,
  'VIEW'                          AS TABLE_TYPE,
  ALL_TAB_COLUMNS.COLUMN_NAME,
  ALL_TAB_COLUMNS.DATA_TYPE,
  ALL_TAB_COLUMNS.COLUMN_ID       AS ORDINAL_POSITION,
  ALL_TAB_COLUMNS.DATA_LENGTH     AS CHARACTER_MAXIMUM_LENGTH,
  ALL_TAB_COLUMNS.DATA_PRECISION  AS NUMERIC_PRECISION,
  ALL_TAB_COLUMNS.DATA_SCALE      AS NUMERIC_SCALE,
  ALL_TAB_COLUMNS.NULLABLE        AS IS_NULLABLE,
  (SELECT ALL_INDEXES.UNIQUENESS
   FROM ALL_INDEXES
   INNER JOIN ALL_IND_COLUMNS ON ALL_IND_COLUMNS.INDEX_NAME = ALL_INDEXES.INDEX_NAME
   WHERE ALL_INDEXES.TABLE_NAME = USER_VIEWS.VIEW_NAME
   AND ALL_IND_COLUMNS.COLUMN_NAME = ALL_TAB_COLUMNS.COLUMN_NAME
   AND ROWNUM = 1)                AS IS_IDENTITY,
  (SELECT ALL_CONSTRAINTS.CONSTRAINT_TYPE
   FROM ALL_CONSTRAINTS
   INNER JOIN ALL_CONS_COLUMNS ON ALL_CONS_COLUMNS.CONSTRAINT_NAME = ALL_CONSTRAINTS.CONSTRAINT_NAME
   WHERE ALL_CONSTRAINTS.TABLE_NAME = USER_VIEWS.VIEW_NAME
   AND ALL_CONS_COLUMNS.COLUMN_NAME = ALL_TAB_COLUMNS.COLUMN_NAME
   AND ROWNUM = 1)                AS CONSTRAINT_TYPE
FROM
  USER_VIEWS
INNER JOIN
  ALL_TAB_COLUMNS on ALL_TAB_COLUMNS.TABLE_NAME = USER_VIEWS.VIEW_NAME

ORDER BY
  TABLE_NAME, ORDINAL_POSITION