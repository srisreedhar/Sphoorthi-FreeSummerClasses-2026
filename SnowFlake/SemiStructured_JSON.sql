/*
SuperHeors

{
  "name": "Superman",
  "real_name": "Clark Kent",
  "powers": ["Flight","Super Strength","X-Ray Vision","Heat Vision"],
  "team": "Justice League",
  "home": "Metropolis"
}

File URL - https://raw.githubusercontent.com/srisreedhar/DataSets/refs/heads/master/superheroes.json



WorkFlow Steps- 

1. Create Database & Schemas
2. Create Stages to hold the files
3. Create File Format to read the files
4. Upload files to stage
5. Create tables to hold the data
6. Load data from stage to tables
7. Verify data load
8. Sample Queries



Database       → SUPERHERO_DB

Schema         → RAW_TABLES_SCHEMA
Schema         → PROD_TABLES_SCHEMA
Schema         → COMMON_UTILS

Stage          → SUPERHERO_FILES_STAGE

Raw JSON Table → SUPERHERO_JSON_ROWS

JSON Column    → RAW_JSON_FIELD


JSON File -> Stage -> Raw JSON Table ->Extract Hero Details -> DIM_SUPERHEROES -> 
Extract Powers Array -> F_SUPERHERO_POWERS


SUPERHERO_DB

├── RAW_TABLES_SCHEMA ( DataBase level)
│
│   ├── SUPERHERO_FILES_STAGE (Files Storage)
│   │
│   │     superheroes.json
│   │
│   └── SUPERHERO_JSON_ROWS ( TABLE )
│
│         ├── RAW_JSON_FIELD
│         └── LOADED_AT
│
│
└── COMMON_UTILS  ( DataBase level)
│
│   └── FILE_FORMATS 
│
│         └── JSON_FF
│
│
└── PROD_TABLES_SCHEMA ( DataBase level)
    │
    ├── DIM_SUPERHEROES (TABLE)
    │
    │     ├── HERO_ID
    │     ├── HERO_NAME
    │     ├── REAL_NAME
    │     ├── TEAM_NAME
    │     └── HOME_CITY
    │
    │
    └── F_SUPERHERO_POWERS (TABLE)
          │
          ├── HERO_NAME
          └── POWER_NAME



*/
-- DataBase 

-- create DB to hold these files & Data 
CREATE OR REPLACE DATABASE SUPERHERO_DB;

USE DATABASE SUPERHERO_DB;

--Drop to start again
DROP DataBase SUPERHERO_DB;


-- Schemas 


-- schema to store Raw data
CREATE OR REPLACE SCHEMA RAW_TABLES_SCHEMA;
-- schema to store clean data
CREATE OR REPLACE SCHEMA PROD_TABLES_SCHEMA;
-- schema to store all the utils which can be used across account 
CREATE OR REPLACE SCHEMA Common_Utils;



-- Stages

CREATE OR REPLACE STAGE RAW_TABLES_SCHEMA.SUPERHERO_FILES_STAGE;

-- Create File Format

CREATE OR REPLACE FILE FORMAT Common_Utils.JSON_ff
TYPE = JSON
STRIP_OUTER_ARRAY = TRUE;


-- verify the file formats
SHOW FILE FORMATS IN SCHEMA Common_Utils;

-- Upload file to Raw_stage Use PUT or UPLOAD from BROWSER
-- then
-- list files in that stage
-- PUT file:///D:\Projects\Git\Data\DataSets\superheroes.json  @RAW_TABLES_SCHEMA.SUPERHERO_FILES_STAGE;

LIST @RAW_TABLES_SCHEMA.SUPERHERO_FILES_STAGE;


-- Tables Creation to Hold the Data

CREATE OR REPLACE TABLE  RAW_TABLES_SCHEMA.SUPERHERO_JSON_ROWS
(
    RAW_JSON_FIELD VARIANT
);

-- COPY INTO RAW_data.SUPERHEROES_RAW (RAW_DATA)
-- FROM @RAW_data.SUPERHERO_STAGE

-- FILE_FORMAT =
-- (
--     FORMAT_NAME = UTILS.JSON_FF
-- );



-- Tables

-- CREATE OR REPLACE TABLE RAW_data.SUPERHEROES_json
-- (
--     RAW_JSON_FIELD VARIANT

-- );


-- load data from files_stage to raw_data_table_staging schema 


-- COPY INTO RAW_data.SUPERHEROES_json_rows
-- FROM @RAW_data.SUPERHERO_STAGE
-- FILE_FORMAT = (
--     FORMAT_NAME = 'COMMON_UTILS.JSON_FF'
-- );


COPY INTO  RAW_TABLES_SCHEMA.SUPERHERO_JSON_ROWS (RAW_JSON_FIELD)
FROM @RAW_TABLES_SCHEMA.SUPERHERO_FILES_STAGE
FILE_FORMAT =( FORMAT_NAME = COMMON_UTILS.JSON_FF );
--ON_ERROR = 'CONTINUE'

-- verify data load
SELECT * FROM RAW_TABLES_SCHEMA.SUPERHERO_JSON_ROWS;


-- create PROD_Schema Tables to load final Data 

CREATE OR REPLACE TABLE PROD_TABLES_SCHEMA.DIM_SUPERHEROES
(
    hero_id NUMBER AUTOINCREMENT,
    hero_name STRING,
    real_name STRING,
    team_name STRING,
    city_name STRING
);


INSERT INTO PROD_TABLES_SCHEMA.DIM_SUPERHEROES
( hero_name,real_name,team_name,city_name)
SELECT
        raw_json_field:name::STRING,
        raw_json_field:real_name::STRING,
        raw_json_field:team::STRING,
        raw_json_field:home::STRING
FROM RAW_TABLES_SCHEMA.SUPERHERO_JSON_ROWS;


-- verify data in PROD Schema - Final Data
select * from PROD_TABLES_SCHEMA.DIM_SUPERHEROES;

/*
Load POWERS

"powers":[ "Flight", "Super Strength", "Heat Vision"]

*/


CREATE OR REPLACE TABLE PROD_TABLES_SCHEMA.F_SUPERHERO_POWERS
(
    HERO_NAME STRING,
    POWER_NAME STRING
);


-- Flatter the array

INSERT INTO PROD_TABLES_SCHEMA.F_SUPERHERO_POWERS ( HERO_NAME,POWER_NAME )
SELECT  
        hero_record.RAW_JSON_FIELD:name::STRING,
        power_record.VALUE::STRING
FROM RAW_TABLES_SCHEMA.SUPERHERO_JSON_ROWS as hero_record,
LATERAL FLATTEN( INPUT => hero_record.RAW_JSON_FIELD:powers) as power_record;

-- verify Load
SELECT * FROM PROD_TABLES_SCHEMA.F_SUPERHERO_POWERS
ORDER BY HERO_NAME;


-- verify data / sample queries

SELECT * FROM PROD_TABLES_SCHEMA.F_SUPERHERO_POWERS
ORDER BY HERO_NAME;

SELECT * FROM PROD_TABLES_SCHEMA.F_SUPERHERO_POWERS
WHERE POWER_NAME = 'Super Strength'
ORDER BY HERO_NAME;

SELECT * FROM PROD_TABLES_SCHEMA.F_SUPERHERO_POWERS
WHERE POWER_NAME = 'Flight'
ORDER BY HERO_NAME;

