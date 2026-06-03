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
drop database csvfilesdb;