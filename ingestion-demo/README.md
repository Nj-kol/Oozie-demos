
# Steps for ingestion demo setup

**Create external table**

sudo -u hdfs hdfs dfs -mkdir -p /user/cloudera/data/raw/retail_db/orders

CREATE DATABASE retail_db_ingest;
USE retail_db_ingest;

CREATE EXTERNAL TABLE ORDERS (
order_id INT, 
order_customer_id INT,
order_status STRING)
PARTITIONED BY (ingest_date string)
STORED AS AVRO
LOCATION '/user/cloudera/data/raw/retail_db/orders';

MSCK REPAIR TABLE ORDERS;

SELECT * FROM orders;

**Create internal table**

CREATE DATABASE retail_db;
USE retail_db;

CREATE TABLE retail_db.ORDERS (
order_id INT, 
order_customer_id INT,
order_status STRING)
PARTITIONED BY (ingest_date string)
STORED AS ORC;

**Load common scripts**

sudo -u hdfs hdfs dfs -mkdir -p /common/scripts
sudo -u hdfs hdfs dfs -put findNewPartitions.hql /common/scripts
sudo -u hdfs hdfs dfs -put computeStats.hql /common/scripts

**Run the job**

oozie job --oozie http://localhost:11000/oozie -config orders_ingest.properties -run

**Check data**
select * from retail_db_ingest.orders where ingest_date='2013-07-30';
select * from retail_db.orders where ingest_date='2013-07-30';

**Check table statistics**

DESCRIBE EXTENDED retail_db_ingest.orders PARTITION(ingest_date='2013-07-27');
DESCRIBE EXTENDED retail_db_ingest.orders PARTITION(ingest_date='2013-07-27');

**Check column statistics**

DESCRIBE FORMATTED retail_db_ingest.orders order_status PARTITION(ingest_date='2013-07-27');
DESCRIBE FORMATTED retail_db.orders order_status PARTITION(ingest_date='2013-07-27');