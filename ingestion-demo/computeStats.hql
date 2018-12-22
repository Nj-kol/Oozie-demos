--Calculate partition statistics
ANALYZE TABLE ${dbName}.${tableName} PARTITION(ingest_date='${ingest_date}') COMPUTE STATISTICS;

--Calculate column statistics
ANALYZE TABLE ${dbName}.${tableName} PARTITION(ingest_date='${ingest_date}') COMPUTE STATISTICS FOR COLUMNS;
