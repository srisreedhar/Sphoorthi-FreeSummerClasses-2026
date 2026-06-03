# Sphoorthi Oum
# Sphoorthi Free DataEngineering Classes

## Snowflake Practice Datasets & Public S3 Buckets

These datasets can be used for practicing:

- Stages
- File Formats
- COPY INTO
- Data Loading
- Error Handling
- JSON Processing
- Semi-Structured Data
  
- Snowpipe
- External Stages

---

# 1. Buckets Used & Discussed during Classes

## Bucket 1 (CSV Files)

### Main Bucket

https://bucketsnowflakes3.s3.amazonaws.com/

---

## Bucket 2 (CSV Files with Errors & Error Handling )

### Main Bucket

https://bucketsnowflakes4.s3.amazonaws.com/

---

# 2. CSV Files for Practice

## Loan Payments Dataset

https://bucketsnowflakes4.s3.amazonaws.com/Loan_payments_data.csv


---

## Order Details Dataset

https://bucketsnowflakes4.s3.amazonaws.com/OrderDetails.csv



---

## Sample Dataset

https://bucketsnowflakes4.s3.amazonaws.com/sampledata.csv


---

# 3. CSV Files with Errors

- ON_ERROR


---

## Error File 1

https://bucketsnowflakes4.s3.amazonaws.com/OrderDetails_error.csv

---

## Error File 2

https://bucketsnowflakes4.s3.amazonaws.com/OrderDetails_error2.csv

---

# 4. JSON Dataset

## Snowflake JSON Tutorial File

https://snowflake-docs.s3.amazonaws.com/tutorials/json/server/2.6/2016/07/15/15/json_tutorial.json

---

# 5. ZIP Files Dataset

## NYC Citibike Trip Data

https://s3.amazonaws.com/tripdata/


---

# 6. Snowflake Workshop Lab

popular Snowflake training datasets.
Some of them are not working, they may have been deprecated. 
I advice you to actually inspect before you start any workflow - 

---

## Main Bucket

https://snowflake-workshop-lab.s3.amazonaws.com/

---

## Citibike Trips CSV Folder

This is working
The buckets have data


https://snowflake-workshop-lab.s3.amazonaws.com/citibike-trips-csv/


---

# 7. Snowflake Quickstarts

Official Snowflake Quickstart datasets.

---

## Main Bucket

https://sfquickstarts.s3.amazonaws.com/

---

## Tasty Bytes Dataset

https://sfquickstarts.s3.amazonaws.com/frostbyte_tastybytes/

This dataset is specially to practice snowpark & streams.

---

# Recommended Order

1. Loan_payments_data.csv
2. OrderDetails.csv
3. sampledata.csv
4. OrderDetails_error.csv
5. OrderDetails_error2.csv
6. json_tutorial.json
7. Citibike Dataset
8. Tasty Bytes Dataset

---

# Datasets covering the topics we have dealt in our classes - 

| Dataset | Topics |
|----------|----------|
| Loan Payments | COPY INTO, SQL |
| Order Details | CSV Loading |
| Sample Data | SQL Practice |
| Error Files | Error Handling |
| JSON Tutorial | VARIANT, FLATTEN |
| Citibike | Large Dataset Loading |
| Tasty Bytes | End-to-End Snowflake Project |

---

## Also, please note - 

- Buckets `bucketsnowflakes3` and `bucketsnowflakes4` were used during classes.
- JSON and Customer Details datasets may require additional validation before use and we will use other datasets to learn 
    about VARIANT and JSON Data loading in our classes through `PUT` commands.
- I think Some folders may not expose directory listings and files must be accessed directly, this may be the error with some of the files above like - ` (6) Snowflake Workshop Lab`

### Sri Sreedhar