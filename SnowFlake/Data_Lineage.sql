-- how to check data lineage in snowflake
-- Screenshot of lineage in Snowflake UI Below -
-- https://github.com/srisreedhar/Sphoorthi-FreeSummerClasses-2026/blob/5184a7c092b9328d064533ccd6bf89eeffd05594/Images/DataLineage_2026-06-05_132852.png


-- NEW BANK Database
CREATE or REPLACE TABLE NEWBANK.STAGING.ABC(
"alphabets" STRING
);

insert into NEWBANK.STAGING.ABC
values ('a'),('b'),('c');

select * from NEWBANK.STAGING.ABC;


-- BANK Database

CREATE or REPLACE TABLE BANK.EXTERNAL_SCHEMA.XYZ(
"alphabets" STRING
);

insert into BANK.EXTERNAL_SCHEMA.XYZ
values ('d'),('e'),('f');

select * from BANK.EXTERNAL_SCHEMA.XYZ;



-- SuperheroDB Database 

create or replace table superhero_db.prod_tables_schema.lineage_ex(
"alphabets" string
);


insert into superhero_db.prod_tables_schema.lineage_ex
select * from bank.external_schema.xyz
union all
select * from newbank.staging.abc ;


select * from superhero_db.prod_tables_schema.lineage_ex;



