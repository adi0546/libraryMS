SELECT table_schema AS SchemaName
  , table_catalog
  , table_type, table_name, table_schema
  FROM INFORMATION_SCHEMA.TABLES




select t.table_name,t.schema_name,t.column_name, GROUP_CONCAT(t.constraint_type ORDER BY t.constraint_type SEPARATOR ',') AS CONSTRAINTS, t.optional,t.column_type,t.data_type,t.column_comment from 
(select 'REAL' as schema_name, c.TABLE_NAME, c.COLUMN_NAME, c.IS_NULLABLE AS OPTIONAL, c.DATA_TYPE, c.COLUMN_TYPE, cons.constraint_type, c.COLUMN_COMMENT 
from information_schema.columns c 
LEFT JOIN 
(SELECT tc.table_name,tc.constraint_schema,tc.table_schema,kcu.column_name,tc.constraint_type FROM information_schema.table_constraints tc 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu 
on kcu.table_schema = tc.table_schema 
AND kcu.table_name = tc.table_name
and kcu.constraint_name = tc.constraint_name
where tc.table_schema = 'REAL'
GROUP BY tc.table_schema,tc.table_name, kcu.column_name,tc.constraint_type) cons
on c.table_schema = cons.table_schema
AND c.table_name = cons.table_name
and c.column_name = cons.column_name
where c.table_schema = 'REAL') t
group by t.schema_name,t.table_name,t.column_name;



