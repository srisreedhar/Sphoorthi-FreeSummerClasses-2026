# Sphoorthi Oum
# Sphoorthi Free DataEngineering Classes

# Snowflake : Connecting to SnowSQL ( CLI TOol)

### Step 1
- Download SnowSQL Tool from [SnowSQL DOwnloads Page](https://www.snowflake.com/en/developers/downloads/snowsql/)

### Step 2

- Install it on your Laptop as you install any regular software

### Step 3
- Click on 1 -> 2 and 3 as shown in the image and copy `account identifier `  & `Login` from  below details

``` 
account = "HhhhhhG-Ykkkkkk2"
user = "SPHOORTHIFREECLASSES"
authenticator = "externalbrowser"
role = "ACCOUNTADMIN"
warehouse = "<none selected>"
database = "<none selected>"
schema = "<none selected>" 
 ```

![Snowflake Web UI.](https://github.com/srisreedhar/Sphoorthi-FreeSummerClasses-2026/blob/93cd3a4671f3d909618afbb761671f3b7025acf0/Images/SnowSQL_1.png)


### Step 4

- Open COmmandline
- type below syntax and it will as you to enter your password, <br> you can enter your password and you're logged in !

`snowsql -a "HaccountG-Yidentifier2" -u "SPHOORTHIFREECLASSES"`



```
C:\Windows\System32>snowsql -a "HaccountG-Yidentifier2" -u "SPHOORTHIFREECLASSES"
Password:
* SnowSQL * v1.4.5
Type SQL statements or !help
SPHOORTHIFREECLASSES#COMPUTE_WH@(no database).(no schema)>show DATABASES;
```