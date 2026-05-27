/*

a single command to chain up all the queries and run them sequentially. 
this will help in maintaining the order of execution and ensure that all necessary tables and data are in place before running dependent queries.   


all succeed → save
something fails → undo everything


*/

-- basic table 
create table bank_accounts (
    customer_name text,
    balance numeric
);


-- values 
insert into bank_accounts values
('sreedhar', 10000),
('vinuthna', 5000);


-- sample update statement

update bank_accounts
set balance = balance - 1000
where customer_name = 'sreedhar';

update bank_accounts
set balance = balance + 1000
where customer_name = 'vinuthna';


-- transaction block

begin;

-- deduct amount from sreedhar
update bank_accounts
set balance = balance - 1000
where customer_name = 'sreedhar';

-- add amount to vinuthna
update bank_accounts
set balance = balance + 1000
where customer_name = 'vinuthna';


commit;