/*

create database,
create schemas,
create tables,
load data from csv files to staging,
load dta into target tables from staging,

create cluster-keys
sample select queries


*/

-- create database
create database Bank;

-- make it active 
use database Bank;


-- create schemas
create schema staging;
create schema prod;

-- create tables

create or replace table Bank.staging.loan_payment_raw (
  "loan_id" string,
  "loan_status" string,
  "principal" string,
  "terms" string,
  "effective_date" string,
  "due_date" string,
  "paid_off_time" string,
  "past_due_days" string,
  "age" string,
  "education" string,
  "gender" string
 );


-- drop table
drop table Bank.staging.loan_payment;

-- prod table

create or replace table Bank.prod.loan_payment_clean (
  "loan_id" string,
  "loan_status" string,
  "principal" string,
  "terms" string,
  "effective_date" string,
  "due_date" string,
  "paid_off_time" string,
  "past_due_days" string,
  "age" string,
  "education" string,
  "gender" string,
  "load_time" date
 );

 -- verify staging table
 select * from staging.loan_payment_raw;

  -- verify prod table
 select * from prod.loan_payment_clean;

 -- load data into table from staging
 -- use fully qualified db path
 -- files list https://bucketsnowflakes3.s3.amazonaws.com/
 
 copy into Bank.staging.loan_payment_raw
    from s3://bucketsnowflakes3/loan_payments_data.csv
    file_format = (type = csv , field_delimiter = ',' , skip_header=1); 

-- validate the data
select * from staging.loan_payment_raw;

-- insert into prod table

insert into Bank.prod.loan_payment_clean
select *, current_date()
from Bank.staging.loan_payment_raw;


  -- verify prod table
 select * from prod.loan_payment_clean;

-- create a stage for external folders/cloud storages / files 

create schema Bank.external_schema;


-- create external file stage
-- read s3 folder 
 create stage if not exists Bank.external_schema.bucketsnowflakes3
 url='s3://bucketsnowflakes3';

-- list all the files in the BucketSnowflakeS3 folder using the stage
List @Bank.external_schema.bucketsnowflakes3;
