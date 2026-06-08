/*

Copy command syntax we discussed in the class today [03-06-2026]

using CopyOptions



COPY INTO <table_name> -- Target
FROM  @ExternalStage   -- Source
FILES = ( '<file_name>','<file_name2>') 
FILE_FORMAT = <file_format_name>
ON_ERROR = ABORT_STATEMENT | CONTINUE | SKIP_FILE | SKIP_FILE_<number> | SKIP_FILE_<percentage>

 

*/

-- create a database
create database csvfilesdb;

use database csvfilesdb;


-- creating schema to store files
create or replace schema external_stages;

-- creating schema to store data in tables
create or replace schema rawdata_schema;



-- Create new stage
 CREATE OR REPLACE STAGE csvfilesdb.external_stages.aws_files_stage
    url='s3://bucketsnowflakes4';
 
 -- List files in stage
 LIST @csvfilesdb.external_stages.aws_files_stage;



 
 -- Create example table
 CREATE OR REPLACE TABLE csvfilesdb.rawdata_schema.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));
 
 --  error message
COPY INTO csvfilesdb.rawdata_schema.ORDERS_EX
    FROM @csvfilesdb.external_stages.aws_files_stage
     file_format= (type = csv field_delimiter=',' skip_header=1)
     files = ('OrderDetails_error.csv');
    -- ON_ERROR = 'ABORT_STATEMENT';
    

 -- Validating table is empty    
SELECT * FROM csvfilesdb.rawdata_schema.ORDERS_EX  ;  
    

  -- Error handling using the ON_ERROR option
COPY INTO csvfilesdb.rawdata_schema.ORDERS_EX
    FROM @csvfilesdb.external_stages.aws_files_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv')
    ON_ERROR = 'CONTINUE';
    
  -- Validating results 
SELECT * FROM csvfilesdb.rawdata_schema.ORDERS_EX;
SELECT COUNT(*) FROM csvfilesdb.rawdata_schema.ORDERS_EX;


-- Truncating table 

TRUNCATE TABLE csvfilesdb.rawdata_schema.ORDERS_EX;



-- Error handling using the ON_ERROR option = ABORT_STATEMENT (default)


COPY INTO csvfilesdb.rawdata_schema.ORDERS_EX
    FROM @csvfilesdb.external_stages.aws_files_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'ABORT_STATEMENT';




 -- Validating results and truncating table 

SELECT * FROM csvfilesdb.rawdata_schema.ORDERS_EX;
SELECT COUNT(*) FROM csvfilesdb.rawdata_schema.ORDERS_EX;


TRUNCATE TABLE csvfilesdb.rawdata_schema.ORDERS_EX;



-- Error handling using the ON_ERROR option = SKIP_FILE


COPY INTO csvfilesdb.rawdata_schema.ORDERS_EX
    FROM @csvfilesdb.external_stages.aws_files_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE';
    
    


-- Validating results 

SELECT * FROM csvfilesdb.rawdata_schema.ORDERS_EX;
SELECT COUNT(*) FROM csvfilesdb.rawdata_schema.ORDERS_EX;




-- Truncating table 

TRUNCATE TABLE csvfilesdb.rawdata_schema.ORDERS_EX;    
    

-- Error handling using the ON_ERROR option = SKIP_FILE_<number>
COPY INTO csvfilesdb.rawdata_schema.ORDERS_EX
    FROM @csvfilesdb.external_stages.aws_files_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE_2';    
    
    
  -- Validating results and truncating table 
SELECT * FROM csvfilesdb.rawdata_schema.ORDERS_EX;
SELECT COUNT(*) FROM csvfilesdb.rawdata_schema.ORDERS_EX;

TRUNCATE TABLE csvfilesdb.rawdata_schema.ORDERS_EX;    

    
-- Error handling using the ON_ERROR option = SKIP_FILE_<number>
COPY INTO csvfilesdb.rawdata_schema.ORDERS_EX
    FROM @csvfilesdb.external_stages.aws_files_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE_0.2%'; 
  
  
SELECT * FROM csvfilesdb.rawdata_schema.ORDERS_EX;




-- drop database
-- drop database csvfilesdb;


-- Defining Size_Limit for a file in stage


CREATE OR REPLACE STAGE csvfilesdb.external_stages.aws_files_stage
    url='s3://bucketsnowflakes4'
    size_limit = 5000000; -- 5 MB 

-- only the files/data till 5MB will be loaded into the table, 
-- rest will be skipped and error will be logged in the load history.



-- RETURN_FAILED_ONLY



-- This option is used to load only the failed records using the COPY command.
-- This option is used in conjunction with the ON_ERROR option to specify how to handle errors during the load process.
-- When the ON_ERROR option is set to 'CONTINUE', the COPY command will continue to load the data even if there are errors in the file. If the RETURN_FAILED_ONLY option is set to true, only the records that failed to load will be returned in the result set.

COPY INTO csvfilesdb.rawdata_schema.ORDERS_EX
    FROM @csvfilesdb.external_stages.aws_files_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    RETURN_FAILED_ONLY = TRUE;


-- Truncate Columns


COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    TRUNCATECOLUMNS = true; 
    

-- specifies whether to truncate the string values in the columns that exceed the defined column width. If set to true, the string values will be truncated to fit the column width, and a warning will be logged in the load history. If set to false, an error will be raised if any string value exceeds the defined column width, and the load process will be aborted.
-- when set ,     TRUNCATECOLUMNS = true, the string values that exceed the defined column width will be truncated to 
-- fit the column width of the Target tables





-- FORCE Load
-- forces to load data from the same source and from same file again  resulting in duplicates


CREATE OR REPLACE TABLE  csvfilesdb.rawdata_schema.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

    
-- S3 stage object

CREATE OR REPLACE STAGE csvfilesdb.external_stages.aws_stage_copy
    url='s3://snowflakebucket-copyoption/size/';

list @csvfilesdb.external_stages.aws_stage_copy;


-- copy command
COPY INTO csvfilesdb.rawdata_schema.ORDERS 
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*';


truncate table csvfilesdb.rawdata_schema.ORDERS;
-- run one more time

COPY INTO csvfilesdb.rawdata_schema.ORDERS 
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*';

select count(*) from csvfilesdb.rawdata_schema.ORDERS;
-- now force run

COPY INTO csvfilesdb.rawdata_schema.ORDERS 
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    force = TRUE;

select count(*) from csvfilesdb.rawdata_schema.ORDERS;


truncate table csvfilesdb.rawdata_schema.ORDERS;