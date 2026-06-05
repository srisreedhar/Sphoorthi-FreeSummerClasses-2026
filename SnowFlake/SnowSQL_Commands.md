# Sphoorthi Free Classes - Data Engineering with Snowflake

## SnowSQL COmmands List

This document contains commonly used SnowSQL commands for daily Snowflake operations/administration, 
data loading, and ETL activities.

---

### 1. Connect to Snowflake

```bash
snowsql -a <account_identifier> -u <username>
```

Example:

```bash
snowsql -a xy12345.ap-southeast-1 -u sri
```

Output:

```text
* SnowSQL *
Connecting to Snowflake...
Connected.
```

---

### 2. Check Current User

```sql
SELECT CURRENT_USER();
```

Output:

```text
+----------------+
| CURRENT_USER() |
+----------------+
| SRI            |
+----------------+
```

---

### 3. Check Current Role

```sql
SELECT CURRENT_ROLE();
```

Output:

```text
+----------------+
| CURRENT_ROLE() |
+----------------+
| ACCOUNTADMIN   |
+----------------+
```

---

### 4. Show Databases

```sql
SHOW DATABASES;
```

Output:

```text
+-----------------------+
| name                  |
+-----------------------+
| BANK                  |
| SNOWFLAKE_SAMPLE_DATA |
+-----------------------+
```

---

### 5. Use Database

```sql
USE DATABASE BANK;
```

Output:

```text
Statement executed successfully.
```

---

### 6. Show Schemas

```sql
SHOW SCHEMAS;
```

Output:

```text
+---------------------+
| name                |
+---------------------+
| RAW_TABLES_SCHEMA   |
| PROD_TABLES_SCHEMA  |
| COMMON_UTILS        |
+---------------------+
```

---

### 7. Use Schema

```sql
USE SCHEMA RAW_TABLES_SCHEMA;
```

Output:

```text
Statement executed successfully.
```

---

### 8. Show Tables

```sql
SHOW TABLES;
```

Output:

```text
+-----------------------+
| name                  |
+-----------------------+
| CUSTOMERS             |
| ACCOUNTS              |
| TRANSACTIONS          |
+-----------------------+
```

---

### 9. Describe Table

```sql
DESC TABLE CUSTOMERS;
```

Output:

```text
+--------------+---------+
| name         | type    |
+--------------+---------+
| CUSTOMER_ID  | NUMBER  |
| CUSTOMER_NAME| VARCHAR |
+--------------+---------+
```

---

### 10. Show Stages

```sql
SHOW STAGES;
```

Output:

```text
+------------------------+
| name                   |
+------------------------+
| CUSTOMER_FILES_STAGE   |
+------------------------+
```

---

### 11. Create Internal Stage

```sql
CREATE STAGE CUSTOMER_FILES_STAGE;
```

Output:

```text
Stage CUSTOMER_FILES_STAGE successfully created.
```

---

### 12. Upload File To Stage

```sql
PUT file:///C:/Data/customers.csv  @CUSTOMER_FILES_STAGE;
```

Output:

```text
+---------------+------------------+
| source        | target           |
+---------------+------------------+
| customers.csv | customers.csv.gz |
+---------------+------------------+
```

---

### 13. List Files In Stage

```sql
LIST @CUSTOMER_FILES_STAGE;
```

Output:

```text
+--------------------+
| name               |
+--------------------+
| customers.csv.gz   |
+--------------------+
```

---

### 14. Remove File From Stage

```sql
REMOVE @CUSTOMER_FILES_STAGE/customers.csv.gz;
```

Output:

```text
customers.csv.gz removed.
```

---

### 15. Show File Formats

```sql
SHOW FILE FORMATS;
```

Output:

```text
+------------+
| name       |
+------------+
| CSV_FF     |
| JSON_FF    |
+------------+
```

---

### 16. Create CSV File Format

```sql
CREATE FILE FORMAT CSV_FF
TYPE = CSV
SKIP_HEADER = 1;
```

Output:

```text
File Format CSV_FF created.
```

---

### 17. Create JSON File Format

```sql
CREATE FILE FORMAT JSON_FF
TYPE = JSON
STRIP_OUTER_ARRAY = TRUE;
```

Output:

```text
File Format JSON_FF created.
```

---

### 18. Preview Data From Stage

CSV Example:

```sql
SELECT
    $1,
    $2,
    $3
FROM @CUSTOMER_FILES_STAGE/customers.csv.gz;
```

Output:

```text
1,John,New York
2,Mary,Chicago
```

---

### 19. Load Data Into Table

```sql
COPY INTO CUSTOMERS
FROM @CUSTOMER_FILES_STAGE
FILE_FORMAT=(FORMAT_NAME='CSV_FF');
```

Output:

```text
Rows loaded successfully.
```

---

### 20. View Copy History

```sql
SELECT *
FROM TABLE(
    INFORMATION_SCHEMA.COPY_HISTORY(
        TABLE_NAME=>'CUSTOMERS',
        START_TIME=>DATEADD('DAY',-1,CURRENT_TIMESTAMP())
    )
);
```

Output:

```text
File Loaded Successfully
Rows Loaded: 1000
```

---

### 21. Show Warehouses

```sql
SHOW WAREHOUSES;
```

Output:

```text
+------------------+
| name             |
+------------------+
| COMPUTE_WH       |
+------------------+
```

---

### 22. Use Warehouse

```sql
USE WAREHOUSE COMPUTE_WH;
```

Output:

```text
Statement executed successfully.
```

---

### 23. Check Current Database

```sql
SELECT CURRENT_DATABASE();
```

Output:

```text
BANK
```

---

### 24. Check Current Schema

```sql
SELECT CURRENT_SCHEMA();
```

Output:

```text
RAW_TABLES_SCHEMA
```

---

### 25. Exit SnowSQL

```bash
!exit
```

or

```bash
quit
```

Output:

```text
Goodbye!
```

---

---

# Most Frequently Used Commands

| Command | Purpose |
|----------|----------|
| SHOW DATABASES | List databases |
| SHOW SCHEMAS | List schemas |
| SHOW TABLES | List tables |
| SHOW STAGES | List stages |
| SHOW FILE FORMATS | List file formats |
| USE DATABASE | Change database |
| USE SCHEMA | Change schema |
| PUT | Upload file |
| LIST | View stage files |
| REMOVE | Delete stage file |
| COPY INTO | Load data |
| DESC TABLE | View table structure |
| CURRENT_USER() | Current user |
| CURRENT_ROLE() | Current role |
