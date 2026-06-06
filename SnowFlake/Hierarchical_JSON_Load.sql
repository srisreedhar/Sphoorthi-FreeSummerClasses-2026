/*

sample JSON structure -> 

{
        "id":11,
        "first_name":"Iggie",
        "last_name":"Pudsall",
        "gender":"Male",
        "city":"Maodao",
        "job":{
                "title":"Senior Cost Accountant",
                "salary":30000
                },
        "spoken_languages":[
                                {
                                  "language":"Swedish",
                                  "level":"Advanced"
                                },
                                {
                                  "language":"Bislama",
                                  "level":"Advanced"
                                }
                         ],
        "prev_company":["Luettgen-Nolan","Gulgowski LLC"]

S3 File -> https://bucketsnowflake-jsondemo.s3.amazonaws.com/HR_data.json

*/




show databases;
use SUPERHERO_DB;

show schemas;

-- created schema to handle the workflow
create schema nested_json_schema;
--drop stage nested_json_files;

-- creating external_files storage space - to store JSON files
create stage nested_json_schema.nested_json_files
url = 's3://bucketsnowflake-jsondemo';

-- test files in the stage
list @nested_json_schema.nested_json_files;

-- creating table to handle JSON objects as rows
create or replace table nested_json_schema.nested_json_rows
(
    raw_json_rows variant
);


-- copying individual JSON rows into column as rows
copy into nested_json_schema.nested_json_rows
from @nested_json_schema.nested_json_files
file_format = (format_name = superhero_db.COMMON_UTILS.JSON_FF);


-- verify load
select * from nested_json_schema.nested_json_rows;


-- extracting values from nested_json_schema.nested_json_rows.raw_json_rows field
select  raw_json_rows:id::integer as id,
        raw_json_rows:city::string as city,
        raw_json_rows:first_name::string as first_name,
        raw_json_rows:gender::string as gender,
        raw_json_rows:job:salary::integer as current_salary,
        raw_json_rows:job:title::string as current_jobtitle,
        raw_json_rows:last_name::string as last_name
         -- raw_json_rows:spoken_languages:language::string as spoken_language, -- nulls //for hierarchical data
         -- raw_json_rows:spoken_languages:level::string as language_proficiency -- null
from nested_json_schema.nested_json_rows;

-- in the above example we're access the field values by field label, like id,first_name, gender .. 

-- we also can access columns using $ sign from raw tables
-- $ first_column  = $1
-- $second_column = $2
-- we cannot do a select * on raw tables
-- we have te entire json data in first column and hence we use $1 to extract all data 
-- just remove ::Datatype from below example see how the results are being parsed


select $1:city::string,
       $1:first_name::string,
       $1:gender::string,
       $1:id::integer
from nested_json_schema.nested_json_rows;




-- an array of dicts/json objects
select  raw_json_rows:spoken_languages
from nested_json_schema.nested_json_rows;



-- use array_size to know number of objects in the array
-- array size is 3
select max(array_size(raw_json_rows:spoken_languages)) as total_objs
from nested_json_schema.nested_json_rows;



-- extracting spoken_languages
-- addind them as columns to the dataset

select  
        --raw_json_rows:spoken_languages,
        raw_json_rows:spoken_languages[0]:language::string as language_1,
        raw_json_rows:spoken_languages[0]:level::string as language_1_lvl,
        raw_json_rows:spoken_languages[1]:language::string as language_2,
        raw_json_rows:spoken_languages[1]:level::string as language_2_lvl,
        raw_json_rows:spoken_languages[2]:language::string as language_3,
        raw_json_rows:spoken_languages[2]:level::string as language_3_lvl
from nested_json_schema.nested_json_rows;



-- adding languages as ROWS to the dataset
-- we can further normalize this dataset by creating this as a seperate table

select * 
from (
        select   raw_json_rows:id::integer as id, -- JoinKey to main table
                --raw_json_rows:spoken_languages,
                raw_json_rows:spoken_languages[0]:language::string as language,
                raw_json_rows:spoken_languages[0]:level::string as language_lvl
        from nested_json_schema.nested_json_rows
        union all
        select  raw_json_rows:id::integer as id, 
                raw_json_rows:spoken_languages[1]:language::string as language,
                raw_json_rows:spoken_languages[1]:level::string as language_lvl
        from nested_json_schema.nested_json_rows
        union all
        select  raw_json_rows:id::integer as id,
                raw_json_rows:spoken_languages[2]:language::string as language,
                raw_json_rows:spoken_languages[2]:level::string as language_lvl
        from nested_json_schema.nested_json_rows
        order by id 
    );



--  Dataset with languages and levels
select  raw_json_rows:id::integer as id,
        raw_json_rows:city::string as city,
        raw_json_rows:first_name::string as first_name,
        raw_json_rows:gender::string as gender,
        raw_json_rows:job:salary::integer as current_salary,
        raw_json_rows:job:title::string as currnet_jobtitle,
        raw_json_rows:last_name::string as last_name,
        -- main table till here
        raw_json_rows:spoken_languages[0]:language::string as language_1,
        raw_json_rows:spoken_languages[0]:level::string as language_1_lvl,
        raw_json_rows:spoken_languages[1]:language::string as language_2,
        raw_json_rows:spoken_languages[1]:level::string as language_2_lvl,
        raw_json_rows:spoken_languages[2]:language::string as language_3,
        raw_json_rows:spoken_languages[2]:level::string as language_3_lvl
from nested_json_schema.nested_json_rows;



-- Previous company array
-- ex - ["MacGyver, Kessler and Corwin","Gerlach, Russel and Moen"]
select raw_json_rows:prev_company 
from nested_json_schema.nested_json_rows;



-- finding the array size
-- max size 3
select max(array_size(raw_json_rows:prev_company ))
from nested_json_schema.nested_json_rows;



-- extracting values
-- we can furthre normalize this into another table,
-- just adding raw_json_rows:id::integer as id as join key to main table

select  -- raw_json_rows:id::integer as id -- JoinKey to main table
        raw_json_rows:prev_company[0]::string as prevcompany_1,
        raw_json_rows:prev_company[1]::string as prevcompany_2,
        raw_json_rows:prev_company[2]::string as prevcompany_3
from nested_json_schema.nested_json_rows;


-- Final & complete Query
select  raw_json_rows:id::integer as id,
        raw_json_rows:city::string as city,
        raw_json_rows:first_name::string as first_name,
        raw_json_rows:gender::string as gender,
        raw_json_rows:job:salary::integer as current_salary,
        raw_json_rows:job:title::string as current_jobtitle,
        raw_json_rows:last_name::string as last_name,
        raw_json_rows:spoken_languages[0]:language::string as language_1,
        raw_json_rows:spoken_languages[0]:level::string as language_1_lvl,
        raw_json_rows:spoken_languages[1]:language::string as language_2,
        raw_json_rows:spoken_languages[1]:level::string as language_2_lvl,
        raw_json_rows:spoken_languages[2]:language::string as language_3,
        raw_json_rows:spoken_languages[2]:level::string as language_3_lvl,
        raw_json_rows:prev_company[0]::string as prevcompany_1,
        raw_json_rows:prev_company[1]::string as prevcompany_2,
        raw_json_rows:prev_company[2]::string as prevcompany_3
from nested_json_schema.nested_json_rows;



-- inserting the final values into prod/clean tables
create or replace table prod_tables_schema.hr_data_clean
(
    id integer,
    city string,
    first_name string,
    gender string,
    current_salary integer,
    current_jobtitle string,
    last_name string,
    language_1 string,
    language_1_lvl string,
    language_2 string,
    language_2_lvl string,
    language_3 string,
    language_3_lvl string,
    prevcompany_1 string,
    prevcompany_2 string,
    prevcompany_3 string
) cluster by (city);


-- insert final values into prod tables
insert into prod_tables_schema.hr_data_clean
select  raw_json_rows:id::integer as id,
        raw_json_rows:city::string as city,
        raw_json_rows:first_name::string as first_name,
        raw_json_rows:gender::string as gender,
        raw_json_rows:job:salary::integer as current_salary,
        raw_json_rows:job:title::string as current_jobtitle,
        raw_json_rows:last_name::string as last_name,
        raw_json_rows:spoken_languages[0]:language::string as language_1,
        raw_json_rows:spoken_languages[0]:level::string as language_1_lvl,
        raw_json_rows:spoken_languages[1]:language::string as language_2,
        raw_json_rows:spoken_languages[1]:level::string as language_2_lvl,
        raw_json_rows:spoken_languages[2]:language::string as language_3,
        raw_json_rows:spoken_languages[2]:level::string as language_3_lvl,
        raw_json_rows:prev_company[0]::string as prevcompany_1,
        raw_json_rows:prev_company[1]::string as prevcompany_2,
        raw_json_rows:prev_company[2]::string as prevcompany_3
from nested_json_schema.nested_json_rows;

-- verify data
select * from prod_tables_schema.hr_data_clean;




-- Other ways of Extracting the data using flatten() 
-- lateral flatten(input=> raw_json_rows:spoken_languages);
-- this commands outputs a table and when we use this command 
-- along with the main table the natural join takes place and all the values are added to main table


-- wierd output
-- but related to columns generated by flatten
select *
from nested_json_schema.nested_json_rows as n,
lateral flatten(input => n.raw_json_rows:spoken_languages) as l,
lateral flatten(input => n.raw_json_rows:prev_company) c;

-- spoken languages
-- seperate table
select  n.raw_json_rows:id::integer as id,
        -- l.index,
        l.value:language::string as language,
        l.value:level::string as level
from nested_json_schema.nested_json_rows as n,
lateral flatten(input =>  raw_json_rows:spoken_languages ) as l;

-- Previous companies
-- seperate table
select  n.raw_json_rows:id::integer as id,
        -- pv.index,
        pv.value::string as prev_company
from nested_json_schema.nested_json_rows as n,
lateral flatten(input =>  raw_json_rows:prev_company ) as pv;

-- join with main table        