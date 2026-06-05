-- how to check data lineage in snowflake


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
