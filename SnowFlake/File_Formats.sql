
-- csv
-- check all the avilable options for file formats in snowflake
-- https://docs.snowflake.com/en/sql-reference/sql/create-file-format


-- csv file format 

CREATE OR REPLACE FILE FORMAT CSV_FF
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
null_if = ('NULL', 'null') -- this will treat 'NULL' and 'null' as null values in the dataset
empty_as_null = true -- this will treat empty strings as null values in the dataset



-- JSON file format

CREATE OR REPLACE FILE FORMAT JSON_FF
TYPE = 'JSON'
STRIP_OUTER_ARRAY = true -- this will remove the outer array from the JSON file and treat each element as a separate row in the dataset
IGNORE_UTF8_ERRORS = true -- this will ignore any UTF-8 errors in the JSON file


-- Parquet file format
CREATE OR REPLACE FILE FORMAT PARQUET_FF
TYPE = 'PARQUET'
COMPRESSION = 'SNAPPY' -- this will use SNAPPY compression for the Parquet file


--xml file format
CREATE OR REPLACE FILE FORMAT XML_FF
TYPE = 'XML'
COMPRESSION = 'GZIP' -- this will use GZIP compression for the XML file
