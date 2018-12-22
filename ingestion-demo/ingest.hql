SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE ${permDb}.${permTable} 
PARTITION (ingest_date='${ingest_date}')
SELECT 
order_id,
order_customer_id,
order_status
FROM ${tempDb}.${tempTable}
WHERE ingest_date='${ingest_date}';