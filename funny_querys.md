# Create table as other table: 

CT DatabaseName.TableName as DatabaseNameReference.TableNameReference with no data;

# Insert values INSERT INTO - SELECT

INSERT INTO DatabaseName.TableName

SELECT * FROM DatabaseNameReference.TableNameReference

WHERE CONDITION='CONDITION';


# MySQL
## MySQL DDL definition
* [MySQL Data types](http://www.mysqltutorial.org/mysql-data-types.aspx "Mysql data types")
    * Select current timestamp: 
        * select CURRENT_TIMESTAMP from dual;
* [Show table definition](https://stackoverflow.com/questions/898688/how-to-get-database-structure-in-mysql-via-query "Mysql ddl table definition")
    * Statement: **DESCRIBE** (only shows type, and primary key)
        * DESCRIBE [TABLE_NAME];
    * Statement: **SHOW CREATE TABLE** (shows the complete table definition):
        * SHOW CREATE TABLE [TABLE_NAME];


## General Knowledge
* You can't put SHOW statements inside a subquery. **The only statement that can go in a subquery is SELECT.**
* When creating a table with the sentences: CREATE TABLE_BACKUP AS SELECT * FROM TABLE_ORIGINAL, the MySQL server doesn't add the **PRIMARY KEYS** belonging to the TABLE_ORIGINAL
* Considerations when using (and creating) indexes: 
    * Every time a **PRIMARY KEY** is declared as a constraint in a column table, also is automatically created an **UNIQUE INDEX** for such column table
    * However, when declaring an **UNIQUE INDEX** in a column table no **PRIMARY KEY** is build in such column table. 
    * Remember: ***you should not build unique indexes on your primary key column(s), since the server already checks uniqueness for primary key values***

### OVERHEAD table
* [overhead](https://stackoverflow.com/questions/565997/in-mysql-what-does-overhead-mean-what-is-bad-about-it-and-how-to-fix-it "overhead table") is temporary diskspace that the database used to run some of the queries, so you should only worry if this gets really high. 
* 

## Start the MySQL Server
1. $ sudo service mysql start
2. $ mysql -u root -p 

* Load a .sql file: 

mysql> use db_name;

mysql> source backup-file.sql;

* Change the Database and Table Name to case insensitive (by default some environments has the Case senstive option ON by default)
1. Edit: 
    * sudo nano /etc/mysql/my.cnf
2. Underneath the [mysqld] section.add
    * lower_case_table_names = 1
3. Restart Mysql 
    * sudo /etc/init.d/mysql restart
4. Check the changes: 
    * mysqladmin -u root -p variables


## MySQL DBA Querys
* **When Grating you can use Wildcards.**
* [Create an user](https://dev.mysql.com/doc/refman/8.0/en/create-user.html "Create an user on MySQL"): 
    * CREATE [USER] IDENTIFIED BY [PASSWORD_USER];
* [Grant Permissions](https://dev.mysql.com/doc/refman/8.0/en/grant.html "Grant Mysql8.0 reference manual")
    * GRANT ALL:
        * GRANT ALL ON [SCHEMA].[TABLE | * ] TO ['USER']
    * GRANT CREATE on any database and any table:
        * GRANT CREATE ON * . * TO ['USER'];
* Show Table definition: 
    * SHOW CREATE TABLE [SCHEMA].[TABLE]
* 


# Teradata 
## [Teradata Database Data Dictionary attributes:](https://docs.teradata.com/reader/oiS9ixs2ypIQvjTUOJfgoA/IWBAjOWwSlE5SLswfe_6Gw "Data dictionary")
* **[SPOOL:](https://docs.teradata.com/reader/u8~Pwz3BmiO8RrPCsqF7bQ/obhnM3wzTkPdGCe9ZrlNoQ "Teradata Spool")**
    * Defines the maximum amount of space available to the user for intermediate query results,  volatile tables, or formatted answer sets to queries.
    The spool space specified in a profile takes precedence over spool space specified in a CREATE USER statement.
* **
* 

## TERADATA DDL definition
* [Teradata Primary Index](http://www.teradatawiki.net/2013/08/Teradata-Primary-Index.html "Teradata primary index info")
    * **Unique Primary Index(UPI)**
        * A Unique Primary Index (UPI) is unique and cannot have any duplicates.
        * If you try and insert a row with a Primary Index value that is already in the table, the row will be rejected. 
        * **An UPI enforces UNIQUENESS for a column (or columns)**
        * **SQL SINTAXIS**
            * CREATE TABLE sample_1
            
             (col_a INT
            
             ,col_b INT
            
             ,col_c INT)
            
            **UNIQUE PRIMARY INDEX** (col_b);
    * **Non-Unique Primary Index (NUPI)**
        * A Non-Unique Primary Index (NUPI) means that the values for the selected column can be non-unique. 
        * **Duplicate values can exist.**
        * **SQL SINTAXIS**
            * CREATE TABLE sample_2
            
             (col_x INT
            
             ,col_y INT
            
             ,col_z INT)
            
            **PRIMARY INDEX** (col_x);

* [Teradata Create Table *SET* VS *MULTISET*](http://www.teradatatech.com/?p=782 "Set vs Multiset Teradata")
    * When a Table is created if not explicity declared, by default is a SET table. 
    * A SET table force Teradata to **check for the duplicate rows every time a new row is inserted or updated in the table.** This is an overhead on the resource if we need to insert massive amount of rows.
    * **SET**
        * If we are inserting data using ***INSERT into SEL from clause*** then SET table check for duplicate rows will removed automatically and there will be no DUPLICATE ROW ERROR.
    *  **MULTISET**
        * If we are inserting data using ***INSERT into VALUES clause*** then SET table check for duplicate rows will not be removed automatically and there will be DUPLICATE ROW ERROR.



* Getting Databases and tables info -- Teradata

 SELECT DatabaseName,TableName, CreatorName, CreateTimeStamp, LastAlterName FROM dbc.columns
 GROUP BY (DatabaseName,TableName, CreatorName, CreateTimeStamp, LastAlterName)
 where DatabaseName NOT IN ('DBC','dbcmngr')
 ORDER BY DatabaseName, CreateTimeStamp;

 * Show all user privileges:
```
 SELECT
A.ROLENAME,
A.GRANTEE,
A.GRANTOR,
B.DATABASENAME,
B.TABLENAME,
B.COLUMNNAME,
D.ACCESSRIGHT_DESC ACCESSRIGHT,
B.GRANTORNAME,
C.DEFAULTDATABASE,
C.DEFAULTACCOUNT,
C.ROLENAME DEFAULTROLENAME,
C.PROFILENAME,
C.OWNERNAME
FROM
DBC.ROLEMEMBERS A
JOIN
DBC.ALLROLERIGHTS B
ON
A.ROLENAME=B.ROLENAME
JOIN
DBC.USERS C
ON
C.USERNAME=A.GRANTEE
JOIN
DBA.ACCESSRIGHT_REF D
ON
B.ACCESSRIGHT=D.ACCESSRIGHT
; 
```

* Create table as other table: 

CT DatabaseName.TableName as DatabaseNameReference.TableNameReference with no data;

* Insert values INSERT INTO - SELECT

INSERT INTO DatabaseName.TableName

SELECT * FROM DatabaseNameReference.TableNameReference

WHERE CONDITION='CONDITION';

* Add a new column to a pre-existing table
    * ALTER TABLE RETAIL.EMPLOYEE ADD NewCol CHAR(25)
* Change the column name to a pre-existing table
    * alter table your_db.your_table RENAME job_code TO depart_number;
* Granting ALL TABLE permissons to an user
    * GRANT ALL PRIVILEGES ON [ESQUEMA].[TABLE] TO [USER]


## TERADATA CREATE COMMAND
* **[CREATING USERS AND GRATING PRIVILEGES](https://docs.teradata.com/reader/u8~Pwz3BmiO8RrPCsqF7bQ/n7MECvaDeRfH1milApRIdg "Creating users and granting privileges")**
* **[CREATE USER:](https://docs.teradata.com/reader/u8~Pwz3BmiO8RrPCsqF7bQ/HkONjPwbd0wA6n3gTuJA2A "Create uer teradata")**
    * You must create a Teradata user with CREATE FUNCTION and EXECUTE FUNCTION access rights.
        * Example:
            * CREATE user test AS password=test perm = 200000000, SPOOL = 100000000;
    * Steps to Crate an User:
        2. Creating a database (similar to an schema in Oracle):
            * CREATE DATABASE myDB AS PERM = 500e+06; -- 0.5 GB ```nomodeset```
        1. Creating an user (the created database can be the default database for the new user):
            * CREATE USER sysdba AS PERM=1e+09, PASSWORD=mypassword; -- 1 GB


## TERADATA GRANT COMMAND
* **[CONNECTION AND PRIVILEGES](https://docs.teradata.com/reader/u8~Pwz3BmiO8RrPCsqF7bQ/HLlDxftcO9jcWSAHaAtLkw "Grant connection and privileges Teradata")**
* 

# ORACLE
Common oracle knowledge
* When creating a table with the sentences: CREATE TABLE_BACKUP AS SELECT * FROM TABLE_ORIGINAL, the ORACLE server doesn't add the **PRIMARY KEYS** belonging to the TABLE_ORIGINAL
* When an user doesn't have rights to see o query a table/view/procedure the server will retrieve the following sentence: ORA-00942: table or view does not exist, even if the squema object exists. 
    * You can't see any tables because the USER doesn't [**OWN**](https://www.thatjeffsmith.com/archive/2013/03/why-cant-i-see-my-tables-in-oracle-sql-developer/ "Cool info about the user rights") any tables.
* An User could have **USER RIGHTS (USER_SYS_PRIVS)** and rights granted by their  **GRANTED_ROLE (user_role_privs)**. When using *Dynamic SQL (execute immediate)* the user should have the rights for the SQL STATEMENTS declared within the procedure. 
* ***Until an user has done a commit***, the remain users **can't see** any possible modification or update. 
* When giving permissions to a certain Database object (package|procedure|function), you can grant such permissions since the object owner or with the sys as dba account.


## Oracle DDL Definition

* [Oracle Data types](https://docs.oracle.com/cd/A58617_01/server.804/a58241/ch5.htm "Oracle Data types")
* [Oracle Datetime and Interval Datatypes](https://docs.oracle.com/cd/B19306_01/server.102/b14225/ch4datetime.htm "Oracle interval time")
* [Declaring an autoincrement column](https://www.oracle.com/technetwork/es/articles/sql/oracle-database-columna-identidad-2775883-esa.html "Oracle autoincrement column")
    * In Oracle 12c (mid 2014) they introduced **IDENTITY** columns which allows users to create auto increment columns.
* [Describe the **basic ddl info** about a schema object definition (table,view,sp)](https://docs.oracle.com/javadb/10.8.3.0/tools/rtoolsijcomrefdescribe.html "Describe an object")
    * Describe : 
        * DESCRIBE [SCHEMA].[TABLE]
* [Describe the **full ddl info** ](https://stackoverflow.com/questions/19564989/how-to-extract-table-definitions-using-sql-or-toad "Full Oracle DDL definition")
    *  select dbms_metadata.get_ddl('TABLE', table_name) from user_tables;
* [Oracle Primary Keys](https://www.techonthenet.com/oracle/primary_keys.php "Oracle Primary Keys")
* [Creating Oracle Tables](http://ramkedem.com/en/oracle-create-table-statement/ "Creating Oracle tables"), when creating a table, the not null sentence should be always at the end of the row.
    * [Creating Oracle not null columns](http://www.oracletutorial.com/oracle-basics/oracle-not-null/ "Oracle not null columns")
* [Alter table to add a new column](http://www.dba-oracle.com/t_alter_table_add_column_syntax_example.htm "Alter table to add a new column")

## NLS (National Language Support) (Solves ORA-01861 ERROR)
* [NLS (National Language Support)](https://docs.oracle.com/cd/B28359_01/server.111/b28298/ch3globenv.htm "NLS") parameters that determine the locale-specific behavior on both the client and the server. 
*  NLS parameters can be specified in the following ways:
* As initialization parameters on the server. 
    * You can include parameters in the initialization parameter file to specify a default session NLS environment. **These settings have no effect on the client side; they control only the server's behavior**
* As environment variables on the client
    * You can use NLS environment variables, which may be platform-dependent, to specify locale-dependent behavior for the client and also to override the default values set for the session in the initialization parameter file
* With the ALTER SESSION statement:
    * You can use NLS parameters that are set in an ALTER SESSION statement **to override the default values that are set for the session in the initialization parameter file or set by the client with environment variables**
    * Example: 
        * ALTER SESSION SET NLS_SORT = FRENCH;
    * Example altering NSL_DATE_LANGUAGE parameter session: 
        * ALTER SESSION SET NLS_DATE_LANGUAGE = AMERICAN;
* In SQL functions:
    * You can use NLS parameters explicitly to hardcode NLS behavior within a SQL function. This practice overrides the default values that are set for the session in the initialization parameter file, set for the client with environment variables, or set for the session by the ALTER SESSION statement
    * Example: 
        * TO_CHAR(hiredate, 'DD/MON/YYYY', 'nls_date_language = FRENCH')


### NLS Data Dictionary Views
* You can query the NSL parameters with the following sentences:
* **NLS_SESSION_PARAMETERS**
    * shows the NLS parameters and their values for the session that is querying the view. It does not show information about the character set.
    * Example:
        * select * from nls_session_parameters
* **NLS_INSTANCE_PARAMETERS:**
    * shows the current NLS instance parameters that have been explicitly set and the values of the NLS instance parameters
    * Example:
        * select * from NLS_INSTANCE_PARAMETERS
* **NLS_DATABASE_PARAMETERS:**
    * shows the values of the NLS parameters for the database. The values are stored in the database.
    * Example: 
        * select * from NLS_DATABASE_PARAMETERS;



## Alter command
* [Oracle add column](https://www.techonthenet.com/oracle/tables/alter_table.php "Add a new column in oracle server")
    * ALTER TABLE customers

    ADD customer_name varchar2(45);
* [Oracle rename a column table](https://www.geeksforgeeks.org/sql-alter-rename/ "Oracle rename column table")
    * ALTER TABLE [table_name] RENAME COLUMN [old_name] TO [new_name];

* [Oracle adding a primary key constraint](https://www.techonthenet.com/oracle/primary_keys.php "Oracle adding a PK constraint")
    * ALTER TABLE table_name
ADD CONSTRAINT constraint_name PRIMARY KEY (column1, column2, ... column_n);


## ORACLE INDEXES 
* [Oracle Indexes](https://docs.oracle.com/cd/B28359_01/server.111/b28310/indexes003.htm#ADMIN11723 "Oracle indexes")
    * **CREATE AN INDEX OUTSIDE OF INTEGRITY CONSTRAINTS:**
        * CREATE INDEX [INDEX_NAME] ON [TABLE_NAME]<(COLUMN_TABLE_NAME)>

        TABLESPACE [TABLESPACE_NAME]

        STORAGE (INITIAL 20K 

        NEXT 20K

        PCTINCREACE 75);

* **CREATING AN UNIQUE INDEX:**
    * CREATE **UNIQUE** INDEX [INDEX_NAME] ON [TABLE_NAME]<(COLUMN_TABLE_NAME)>

    TABLESPACE [TABLESPACE_NAME];
* **DROPPING AN INDEX:**
    * DROP INDEX [INDEX_NAME];

## General Info: 

* [Oracle Grant](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_9013.htm "Oracle grant")
    * Note: You can't give permissons for DROPPING *just one table* to an user. To solve this you can create a procedure, give permissions to such user, and then whithin the procedure declare the drop table. 
* [Oracle Revoke](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_9020.htm "Oracle revoke")  
* [Oracle Synonyms](https://www.thatjeffsmith.com/archive/2013/03/why-cant-i-see-my-tables-in-oracle-sql-developer/ "Cool info about synonyms")
    * A SYNONYM is like a shortcut or pointer or link, it allows you to reference an object in the database by a different name
    * Everytime you have been granted any type or right (select, update, etc) to an squema object different from yours, a synonym is created in order to **QUERY** the object outside your default schema. Now you have a synonym who has the rights to execute a certain right to an object, but you dont have directly the rights to such object because you are not the owner .
    * 


## General Queries
* Show [Explain Plan FOR](https://docs.oracle.com/cd/B10500_01/server.920/a96533/ex_plan.htm "Expalin plan paps")
    * Example: 
        * EXPLAIN PLAN FOR SELECT * FROM [TABLE];
* Show Current version:
    * SELECT * FROM V$VERSION
* Create Table with the same structure as other table (with no data): 
	* CREATE TABLE [table_name] AS SELECT * FROM [ESCHEMA].[TABLE] WHERE 1=0; -- select no value
	* Example:
		* create table test_table as select * from hr.employees where 1=0;
* Create table with the same structure and data from other table: 
	* CREATE TABLE [table_name] AS SELECT * FROM [ESCHEMA].[TABLE]; 
	* Example:
		* create table test_table as select * from hr.employees;
* Limit the result subset:
    * select * from [esquema.table] where ROWNUM <= [number_limit]
* Getting the current user (show user):
    * select user from dual;
* Shows all directories:
    * select * from ALL_DIRECTORIES;
* Shows permissions for tables, squemas: 
    * SELECT * FROM all_tab_privs
* Create or Replace:
    * CREATE OR REPLACE [NAME]
    * works on functions, procedures, packages, types, synonyms, trigger and views. **THIS DOES NOT WORK ON TABLES, MATERIALIZED VIEWS, DATABASE LINKS**
* Shows all user privileges:
    *  select * from USER_SYS_PRIVS;
* Shows roles you've been granted
    * select * from user_role_privs;
* Shows which privileges each role gives you in role_sys_privs  (with the role name as the grantee):
    * select * from role_sys_privs;
* Shows all the privileges granted to the user.
    * select * from session_privs;
* Grant permissions to an user: 
    * Create: 
        * grant CREATE ANY TABLE TO HR;
    * DROP:
        * grant DROP ANY TABLE TO HR;
    * Alter a database:
    	* grant ALTER DATABASE TO HR;
    * Select:
        * GRANT SELECT ON [esquema.table] TO [user_name]
	* Create a session and connect to database:
	    * GRANT CREATE SESSION, CONNECT TO [user_name];
    * Permissions to execute an external procedure (not propietary): 
        * With the account procedure owner: 
            * GRANT EXECUTE ON [PROCEDURE_PACKAGE_NAME] TO [USER_NAME];
* Grant permissions to the *SYS v$ view:* 
    * Oracle v$ views are named V_$VIEWNAME and they have synonyms in format V$VIEWNAME and you can’t give privilage on a synonym.
    * Example:
        * grant select on v_$session to hr;
    * Grant permissions to transactions view: **V$TRANSACTION;**
        *  grant select on V_$TRANSACTION to HR;
* Shows info about all objects:
    * SELECT * from ALL_OBJECTS;
* Shows procedures/functions/packages content:
    * select * from user_source;
* Shows which procedures/packages/functions have execute permissions for an user:
    * select * from user_tab_privs;
* Shows all the objects owned by the USER:
    * select * from user_objects;
* Shows detailed info about the triggers owned by the user:
    * select * from user_triggers;
* Shows the content of the database objects that were given permission to execute to a certain user, but such user is not the owner. 
    * SELECT * FROM all_source WHERE name = '[Procedure|Package|Function]' ORDER BY TYPE, LINE;
* [SET_SQUEMA (Default schema)](https://docs.oracle.com/javadb/10.6.2.1/ref/rrefsqlj32268.html "The default schema for a certain user")
    * By default the 'default schema name' it is the user you use to log in. [GET_SQUEMA (GET Default schema)](https://dba.stackexchange.com/questions/131995/what-is-the-name-of-the-default-schema-in-oracle "GET Default schema")
    * You can query it as belows:
        * select sys_context('USERENV', 'CURRENT_SCHEMA') from dual;
    * Changing the default schema: 
        * alter session set current_schema=USER2;
* Revoke permissons SELECT|INSERT|UPDATE|DELETE to a TABLE TO certain user:
    * REVOKE  [INSERT|DELETE|UPDATE] ON ESQUEMA.TABLE FROM USER;
        * Example: REVOKE  INSERT,DELETE,UPDATE ON HR.HR_TABLE FROM FORD;
* Show the error message of an SQL error: 
	* dbms_output.put_Line(sqlerrm([error_Number]));
* Show all the **Triggers** (independent of the database privileges)
    * select * from all_triggers;
    * **DEPENDING** on your assigned database privileges:
        * select * from DBA_TRIGGERS;
        * select * from USER_TRIGGERS;


## SYS V$VIEW_NAME
* Show all sessions:
    * select * from V$session;
* Show all Transactions:
    * select * from V$TRANSACTION;
* Show locked tables:
    * select * from v$lock

## Partitions
* Table partitions: Dividing table into multiple pieces. 
* Partitioning enables data management operations such data laods, index creation and rebuilding, and backup/revoery at the **partition level**, rather than on the entire table. This results in significantly reduced times for these operations. 
* Partitioning improves query performance
* Partition independence for partition maintenance operations lets you perform concurrent maintenance operations on different partitions of the same table or indx. 
* Partitioning increaces the availability of mission-critical databases. If critical tables and indexes are divided into partitions to reduce the maintenance windows, recovery times and impact of failures. 
* Partitioning can be implemented without requiring any modification to your applications. 

### QUERYING PARTITIONS
* **QUERYING SPECIFIC PARTITIONS CONTENT**:
    * SELECT * FROM [TABLE] PARTITION([PARTITION_NAME]) WHERE=[CONDITIONS]
* **SHOW all tab partitions (metadata table):**
    * SELECT * FROM ALL_TAB_PARTITIONS
* **SHOW all partitions from a specifyc table:**
    * SELECT * FROM ALL_TAB_PARTITIONS WHERE TABLE_NAME='[TABLE_NAME]'
* **ADDING A NEW PARTITION**:
    * A partition can be added when **NO other partition** has been declared before with an upper bound. The partition PARTITION sales_pmax VALUES LESS THAN (MAXVALUE), always adds a bigger value and no new partitions can be created. To create a new partition you have to delete the MAXVALUE partition. 
    * [Creating partition example:](https://www.enterprisedb.com/de/docs/en/10.0/Ora_Compat_Dev_Guide/Database_Compatibility_for_Oracle_Developers_Guide.1.106.html "Partition alter example") 
        * ALTER TABLE SALES ADD PARTITION p10 VALUES LESS THAN(TO_DATE ('2016-01-01', 'YYYY-MM-DD'));
* **DROPPING A PARTITION:**
    * ALTER TABLE [TABLE] DROP PARTITION [PARTITION_NAME];
### Partitioning Methods
* When creating partitions you need to use the TO_DATE function to convert DATES to the specific DATE used by the NSL_DATE_LANGUAGE parameter.

* **Range Partitioning:**
    * Partitioning technique where data is stored separately in different sub-tables based on the data range
    * Example:
    * CREATE TABLE SALES

    (

    customer_id NUMBER,

    order_date DATE,

    order_amount number,

    region varchar2(10)

    )

    PARTITION BY RANGE (order_date)

    (

    PARTITION sales_p1507 VALUES LESS THAN (TO_DATE('2015-07-01',' YYYY-MM-DD')),

    PARTITION sales_p1508 VALUES LESS THAN (TO_DATE('2015-08-01',' YYYY-MM-DD')),

    PARTITION sales_pmax VALUES LESS THAN (MAXVALUE)

    );

* **List Partitioning:**
    * List partitioning is a partitioning technique where you specify a list of discrete values for the partitioning key in the description for each partition.
        * Example: 
        * CREATE TABLE SALES_PARTITION_LIST

        (

        customer_id NUMBER,
        
        order_date DATE,
        
        order_amount NUMBER,
        
        region varchar2(10)
        
        )

        PARTITION BY LIST (region)

        (

        PARTITION partition_east VALUES ('east'),
        
        PARTITION partition_west VALUES ('west'),
        
        PARTITION partition_nort_south VALUES ('north', 'south')

        );
* **Hash Partitioning:**
    * Hash partitioning is a partitioning technique where a hash key is used to distribute rows evenly across the different partitions (sub-tables). **You can't explicity declare partitions** 
    * This is typically used where rangets aren't appropiate, i.e. customer id, product ID, etc.
    * Example:
        * CREATE TABLE SALES_PARTITION_HASH

        (
        
        customer_id NUMBER,
        
        order_date DATE,
        
        order_amount number,
        
        region varchar2(10)

        )

        PARTITION BY HASH(customer_id)

        (

        PARTITION c1,

        PARTITION c2,

        PARTITION c3,

        PARTITION c4

        );


* **Composite Partitioning**
    * Composite partitioning is a partitioning technique that combines some of the other partitioning methods.
    * Example: 
        * CREATE TABLE SALES_PARTITION_COMPOSITE_PARTITION

        (
        
        customer_id NUMBER,
        
        order_date DATE,
        
        order_amount number,
        
        region varchar2(10)

        )

        PARTITION BY RANGE(order_date)
        
        SUBPARTITION BY HASH(customer_id) SUBPARTITIONS 4
        
        (
        
        PARTITION partition_julio VALUES LESS THAN (TO_DATE('2015-07-01', 'YYYY-MM-DD')),
        
        PARTITION partition_agosto VALUES LESS THAN (TO_DATE('2015-08-01', 'YYYY-MM-DD')),
        
        PARTITION partition_septiembre VALUES LESS THAN (TO_DATE('2015-09-01', 'YYYY-MM-DD')),
        
        PARTITION partition_pmax VALUES LESS THAN (MAXVALUE)
        
        );

* **INTERVAL PARTITIONING:**
    * Interval partitioning is an enhancement to range partitioning in Oracle 11g and Interval partitioning.
    * Automatically creates time-based partition as new data is added **instead** of saving it in the **MAXVALUE** partition.
    * You have the specify the interval quantity with the clause **INTERVAL**
    * Example:
        * CREATE TABLE SALES_PARTITION_BY_INTERVAL

        (
        
        customer_id NUMBER,
        
        order_date DATE,
        
        order_amount number,
        
        region varchar2(10)

        )

        PARTITION BY RANGE(order_date)
        
        **INTERVAL(NUMTOYMINTERVAL(1,'MONTH'))**
        
        (
        
        PARTITION partition_julio VALUES LESS THAN (TO_DATE('2015-07-01', 'YYYY-MM-DD')),
        
        PARTITION partition_agosto VALUES LESS THAN (TO_DATE('2015-08-01', 'YYYY-MM-DD')),
        
        PARTITION partition_septiembre VALUES LESS THAN (TO_DATE('2015-09-01', 'YYYY-MM-DD'))
        
        );        


## TABLESPACES
* A tablespace **logically** organizes data will it's being physically stored in **Data Files**
* A tablespace belongs to only one database
* A tablespace has at least **one Data File** that is used to store data to the associated tablespace. 
* A tablespace stores not only table data but all Database objects (indexes, views, materialized view, sequences, etc.). 
* A tablespace can have **multiple Data Files** but a Data File it's associated **to only one** Tablespace. 
* When any object is created if no TABLESPACE is explicity specify in their declaration, such object is stored in the USERS TABLESPACE.
    * You can see such USERS DEFAULT TABLESPACE with the following query: 
        * SELECT * FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_PERMANENT_TABLESPACE';
* A Data File it's stored in a Storage System (NFS, Exadata, SAN, Raw, File System)
* **EFECTS OF DELETE VS TRUNCTABLE TABLE ON A TABLESPACE:**
    * When deleting a table using the *DELETE* clause, the space taken for such rows remains untouch. The rows remains but the space is shown as available to be used for new rows. In other words the table is still full but with the space available, therefore, it could be not shown in the **dba_free_space** view.
    * When deleting a table using the **TRUNCATE** sentence completely deletes all the rows and is shown in the **dba_free_space** view.
* Logical stored sequence: 
    1. Database
    2. Tablespace
    3. Segment
        * Collection of **Extents**
    4. Extent
        * Collection of **Data Blocks**
    5. Data Block: 
        * 8Kb size.  
        * A data block is the smallest unit of storage in an Oracle database. In contrast, at the physical, operating system level, all data is stored in bytes. 
        * **SHOW THE DB BLOCK SIZE:**
            * SHOW PARAMETER db_block_size;
* **TABLESPACES TYPES**
    1. **PERMANENT**:
        * It's used to stored all the permanent data, i.e. Table data, indexes. 
    2. **UNDO:**
        * It's used to stored all the undo data, when rollback a transaction if neccesary. 
    3. **TEMPORARY:** 
        * It's used to stored all the temporary data, for example, when you are running a sql statement this tablespace is **used to store sort or Join operations.**
        * [The temporary tablespace called TEMP](https://stackoverflow.com/questions/11839576/ora-01652-unable-to-extend-temp-segment-by-in-tablespace "TEMP tablespace") which is used internally by database for operations like distinct, joins,etc. Since my query(which has 4 joins) fetches almost 50 million records the TEMP tablespace does not have that much space to occupy all data. Hence the query fails even though my tablespace has free space
* **DEFAULT TABLESPACES:**
    1. **SYSTEM:**
        * It's used by the Oracle server to manage the database. Contains the data dictionary and tables that contain administrative information about the database. 
        * Not all users have accces to the SYSTEM tablespace. 
        * You cant take the SYSTEM tablespace offline. 
        * Is not recommended to store user data into the System tablespace. 
    2. **SYSAUX (System Auxiliary):**
        * Auxiliary Tablespace to the SYSTEM Tablespace.
        * Has the same properties as the SYSTEM Tablespace. 
    3. **TEMP:**
        * It's used to store al the temporary data. Everytime you run a SQL query with a sort operation.
    4. **UNDOTBS1:**
        * It's used to store all the UNDO data.
    5. **USERS:**
        * It's used to store all the data created by the users. 
        * During table creation, the DBA should declare a Tablespace in which store all the Table info. If no Tablespace is mentioned, all the data related to the table is stored in the USERS tablespace. 
    6. **EXAMPLE:**
        * Contains all the sample schemas that are installed when you create the database. 


## ONLINE/OFFLINE TABLESPACES
* **ONLINE:**
    * The Tablespace is up and running. 
    * The Oracle Database **can** read/write from such tablespace.
* **OFFLINE:**
    * The Tablespace is offline.
    * The Oracle Database **can not** read/write from such tablespace. 
    * Main objectives:
        + Offline Tablespace backup
        * Recover an individual tablespace or datafile
        * Move a datafile withouth closing the database.


## TABLESPACES WITH DIFFERENT BLOCK SIZES
* Default block size: 8KB
* Main motivations to have bigger block size:
    * Due to indexes (because of serial nature of index range scans)
    * Larger tables that are the target to full table scans
    * Tables with large objects (LOB's, BLOB's, CLOB's)
    * Tables with large rows that might lead to chained/migrated rows
    * Temporary tablespace for sorting

## TEMPORARY TABLESPACE 
* Whenever you JOIN two large tables, sort or create a cursor the Oracle Database will allocate space in the temporary tablespace (TEMP)
* **[SOLVING THE ORA-01652 UNABLE TO EXTEND *TEMP* SEGMENT PROBLEM:](http://www.dba-oracle.com/t_temp_tablespace_100_percent_full.htm "Ora-01652 problem")**
    * You should add more space to the **Temporary** tablespace or set ON the autoextend option. 
        * alter database TEMPFILE 'C:\APP\XMY9080\ORADATA\ORCL\TEMP1_DATAFILE_TEMPGROUP1.DBF' **autoextend on** maxsize 2000M;


### TEMPORARY TABLESPACE GROUP
* [Temporary Tablespace Groups](http://www.dba-oracle.com/t_temporary_tablespace_groups.htm "TEMP groups")
    * **ADD A TEMPORARY TABLESPACE TO A TEMPORARY TABLESPACE GROUP:**
        * ALTER TABLESPACE [TEMP_TABLSEPACE_NAME] TABLESPACE GROUP [TEMP_TABLESPACE_GROUP_NAME];
* Temporary tablespace groups allow an Oracle dtabase to write to **multiple temp tablespace simultaneously.**
* A user is assigned to a group of temp tablespaces instead of a single temporary tablespace.
* It allows a single SQL operation to use multiple temporary tablespaces for **sorting**
* Example:
    * CREATE TEMPORARY TABLESPACE TEMP1

    TEMPFILE '/disk1/dev/data/temp01.dbf'

    SIZE 50m

    TABLESPACE GROUP tempgroup1;
* 


## ADDING SPACE TO A DATABASE
* You can add more space to any database doing any of the following: 
    1. Create a new tablespace
    2. [Add a datafile to an existing tablespace:](http://www.dba-oracle.com/t_alter_tablespace_add_datafile.htm) 
        * ALTER TABLESPACE tbs1

        ADD DATAFILE '/disk1/dev/data/data02.dbf'

        SIZE 50m

        AUTOEXTEND ON

        NEXT 512k

        MAXSIZE 250M;
    3. Increace the size of an existing data file:
        * ALTER DATABASE

        DATAFILE '/disk1/dev/data/data02.dbf'

        RESIZE 100m;
    4. Configure dynamic growth data file using the AUTOEXTEND=ON sentence.


## ROW MOVEMENT AND SHRINK COMMAND
* [ROW MOVEMENT AND SHRINK COMMAND](http://www.dba-oracle.com/t_alter_table_shrink_space_command.htm "Row movement and shrink command")
    * To execute the **SHRINK COMMAND** it's neccessary that the table in which it'll be executed it's enabled the **ROW MOVEMENT**
        * ALTER TABLE [TABLE_NAME] ENABLE ROW MOVEMENT;
    * Executing the shrink command:
        * ALTER TABLE [TABLE_NAME] SHRINK SPACE; 
    * Note: After executing the **SHRINK COMMAND** the indexes related to such table will be broken and must be rebuild o created again. 


## To review. 20/03/2019
* [Tablespaces info](https://amitzil.wordpress.com/2016/03/23/tablespaces-free-space-and-stuff/)
* [Managing Defragmentation and shrink](https://www.oracle.com/technetwork/articles/database/fragmentation-table-shrink-tips-2330997.html)
* [Oracle Alter Table](http://www.dba-oracle.com/t_alter_table_move_index_constraint.htm)



## TABLESPACE QUERYS:
* [**CREATE A TABLESPACE:**](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_7003.htm "Create a tablespace")
    * CREATE TABLESPACE tbs1

    DATAFILE '/disk1/dev/data/data01.dbf'

    size 50m

    autoextend on

    next 512k

    maxsize 250M;
* **CREATING A TABLESPACE WITH A DIFFERENT BLOCK SIZE THAN DEFAULT:**
    * CREATE TABLESPACE [TABLESPACE_NAME] ['DATAFILE_NAME'] SIZE 10M BLOCKSIZE 16K;
    * NOTE: to change the blocksize of a Tablespace it should be declared first at Database level
* **CREATE A TABLESPACE WITH AN EXISTING .DBF FILE:**
    * You should add **REUSE** after the **SIZE** sentence.
    * CREATE TABLESPACE tbs2

    DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\USERS_CREATED2.DBF'

    size 5m

    **REUSE**

    autoextend on

    next 512k

    maxsize 250M;

* **SHOW ALL DBA DATA FILES OF EACH TABLESPACE:**
    * SELECT * FROM dba_data_files;
* **SHOW TABLESPACES INFO:**
    * SELECT * FROM dba_tablespaces;
* **SHOW THE FREE SPACE OF ALL TABLESPACES:**
    * SELECT * FROM dba_free_space;
    * Notice, if no free space is available for any Tablespace, it won't appear in the query results. 
* **SHOW ALL INFO ABOUT ALL TABLESPACES:**
    * This query is taken from [**HERE**](https://amitzil.wordpress.com/2016/03/23/tablespaces-free-space-and-stuff/ "Tablespaces cool info")
    * Query:

```
select
tablespace_name,
curr_size,
max_size,
free_size,
curr_size-free_size used_size,
pct_free,
round(((max_size-(curr_size-free_size))/max_size)*100,2) pct_free_total,
free_chunks,
largest_chunk
from
(select 
ts.tablespace_name,
round(dbf.bytes/1024/1024,2) curr_size,
round(dbf.maxbytes/1024/1024) max_size,
nvl(round(fs.bytes/1024/1024,2),0) free_size,
round((nvl(fs.bytes,0)/dbf.bytes)*100,2) pct_free,
nvl(fs.free_chunks,0) free_chunks,
nvl(round(fs.largest_chunk/1024/1024,2),0) largest_chunk
from
dba_tablespaces ts,
(select
tablespace_name,
sum(bytes) bytes, 
sum(greatest(maxbytes,bytes)) maxbytes
from
(select tablespace_name,bytes,maxbytes from dba_data_files)
group by tablespace_name
) dbf,
(select
tablespace_name, 
sum(bytes) bytes,
count(*) free_chunks,
max(bytes) largest_chunk
from dba_free_space
group by tablespace_name
) fs
where ts.tablespace_name=dbf.tablespace_name
and ts.tablespace_name=fs.tablespace_name(+)
)
order by pct_free desc;

```
* **ASSIGNING A TABLESPACE TO A CERTAIN TABLE WHEN CREATING:**
    * CREATE TABLE [SCHEMA].[TABLE] ([COLUMN_NAME] [DATA_TYPE]) **TABLESPACE** [TABLESPACE_NAME]
* **DROPPING A TABLESPACE:**
    * *Dropping a Tablespace with no info inside*: 
        * DROP TABLESPACE [TABLESPACE_NAME];
        * Notice: 
            * When you delete a tablespace using the DROP sentence only, physically the Data File (.DBF) for such Tablespace remains untouch in the OS. If you want to delete the .DBF file also, you should use the DROP setence with INCLUDING CONTENTS AND DATAFILES. 
            * When deleting a tablespace **all the related objects to such tablespace (tables, views) are also deleted.**
    * *Dropping a Tablespace with existing info:*
        * DROP TABLESPACE [TABLESPACE_NAME] INCLUDING CONTENTS AND DATAFILES;
        * Notice: 
            * Using the INCLUDING CONTENTS AND DATAFILES option also with the DROP TABLESPACE sentence, the .DBF file from such tablespace is physically removed from the OS.
            * If a transaction is currently active from an object which uses any .DBF file related to such TABLESPACE, the .DBF file can't be removed from the OS until the transaction finishes. 
* **RENAMING AN EXISTING TABLESPACE:**
    * ALTER TABLESPACE [TABLESPACE_NAME] RENAME TO [NEW_NAME_TABLESPACE];
* **RENAMING AN EXISTING DATA FILE (.DBF):**
    * NOTE: To rename an existing datafile, the Tablespace belonging to such DataFile should be offline: 
        * Manually you should rename the  ['DATA_FILE_NAME'] TO ['DATA_FILE_NEW_NAME'] using the OS navigator
    * ALTER DATABASE RENAME FILE ['DATA_FILE_NAME'] TO ['DATA_FILE_NEW_NAME'];
* **SETTING OFFLINE A TABLESPACE:**
    * ALTER TABLESPACE [TABLESPACE_NAME] OFFLINE;
* **SETTING ONLINE A TABLESPACE:**
    * ALTER TABLESPACE [TABLESPACE_NAME] ONLINE;
* **REMOVE A DATAFILE FROM AN EXISTING TABLESPACE:**
    * ALTER TABLESPACE [TABLESPACE_NAME] DROP DATAFILE '[DATAFILE_NAME]';
    * Note: Only works with empty datafiles. 
* **SHOW THE TEMPORARY TABLESPACES:**
    * SELECT * from dba_temp_files;
* **CREATE A TEMPORARY TABLESPACE:**
    * CREATE **TEMPORARY** TABLESPACE [TEMPORARY_TABLESPACE_NAME] **TEMPFILE** ['DATA_FILE_NAME'] SIZE 10M;
* **SHOW THE DEFAULT TEMPORARY (TEMP) TABLESPACE:**
    * SELECT * FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_TEMP_TABLESPACE';
* **CHANGING THE DEFAULT TEMPORARY (TEMP) TABLESPACE:**
    * ALTER DATABASE DEFAULT TEMPORARY TABLESPACE [NEW_TEMPORARY_TABLESPACE_NAME]
* **SHOW ALL THE TEMPORARY TABLESPACE GROUPS:**
    * SELECT * FROM dba_tablespace_groups;
* **[ALTER AN EXISTING TEMP DATAFILE FROM A TEMP TABLESPACE TO AUTOEXTEND ON](https://www.databasejournal.com/features/oracle/autoextend-oracle-database-file-sizes.html "ALTER AUTOEXTEND"):**
    * ALTER DATABASE **TEMPFILE** 'C:\APP\XMY9080\ORADATA\ORCL\TEMP1_DATAFILE_TEMPGROUP1.DBF' AUTOEXTEND **ON** maxsize 2000M;
* **ALTER AN EXISTING DATAFILE FROM A TABLESPACE TO AUTOEXTEND ON:**
    *  ALTER DATABASE **DATAFILE** 'C:\APP\XMY9080\ORADATA\ORCL\DATAFILE.DBF' AUTOEXTEND **ON** maxsize 2000M;




## DBA
* Changing the session:
    * alter session set container=orclpdb;
* Creating user:
    * CREATE USER [USER_NAME] IDENTIFIED BY [PASSWORD];
* Show all users of the database visible to the current user. 
    * This view does not describe the users (see the related views).
    * select * from ALL_USERS;
    * DBA_USERS; describes all users of the database, and contains more columns than ALL_USERS
    * USER_USERS describes the current user, and contains more columns than ALL_USERS;
* Increaze the buffer size: 
	* When facing the error: *RA-20000: ORU-10027: buffer overflow, limit of 2000 bytes*, you can increaze the buffer size as follows: 
	* SQL PLUS: 
		1. set serveroutput on size 1000000; (buffer up to 1,000,000)
		2. set serveroutput on size unlimited; (unlimited)
	* PL/SQL
		1. DBMS_OUTPUT.ENABLE(1000000); 
		2. DBMS_OUTPUT.ENABLE (buffer_size => NULL); 
* **CHANGING THE DEFAULT BLOCK SIZE AT DATABASE LEVEL:**
    * ALTER SYSTEM SET DB_16K_CACHE_SIZE=60M SCOPE=both;
* **SHOW ALL DATABASE PROPERTIES:**
    * SELECT * FROM DATABASE_PROPERTIES;
* 

### Auditing command
* **[Auditing database Activity](https://docs.oracle.com/cd/E11882_01/server.112/e10575/tdpsg_auditing.htm#TDPSG50000 "Auditing command")**

## RANDOM QUERYS
* [GENERATE RANDOM VALUES (INT, STRINGS)](https://oracle-base.com/articles/misc/dbms_random "Random values")
* **[GENERATE RANDOM STRINGS](https://docs.oracle.com/cd/B19306_01/appdev.102/b14258/d_random.htm#i996825 "Random strings")**
    * **DBMS_RANDOM.string('l',10)**

## SQLPLUS
* **CHANGING THE OUTPUT FORMAT:**
    * SET LINESIZE 150;
    * COLUMN TABLESPACE_NAME FORMAT A30
    * COLUMN FILE_NAME FORMAT A50


# [OLAP - SQL](https://www.ibm.com/developerworks/community/blogs/fredho66/entry/sql_olap_functions_in_informix1?lang=en "Olap functions")
* OLAP is ***OnLine Analytical Processing*** (as opposed to OnLine Transaction Processing – OLTP).
* It usually works with multi-dimensional databases requiring frequent roll-up, roll-down and slicing and dicing.
* OLAP is the overall encompassing term for the type of processing to be done, there are specific functions known as SQL OLAP functions that are supported by different database systems and/or BI tools
* SQL OLAP they adhere to and extend the *ANSI SQL-99* standards, known as the “Elementary OLAP” package

## Window Partition
*  A window partition is a set of rows that are grouped together for the **purpose** of applying an OLAP function, as defined by one or more columns in a special ***OVER()*** clause.
* The OLAP function is applied to every row, but is calculated with respect to the rows in the partition. If **no** partition is specified, the OLAP function is computed over the **complete intermediate result set.**
* A window partition is a subset of rows returned by a query, 
* Non-analytic functions compute their calculations with respect to every row in the result set. 
* An OLAP function in a query is **applied** with respect to the **contents of its window partitions.**
* You can *define window* partitions according to the values in a *single dimension* or you can specify *multiple dimensions*. For example, you could partition the rows based on city and state values or month, quarter, and year values.
* General Sintaxis:
```
Olap_function () over (partition by col1, col2…)
```
    * Example:
        * The stores are ranked according to their sales totals *for each value;* as the date changes, the ranking values are reset. Multiple sets of ranked values (1 to n) are computed within a single query expression.
        * 
```
Select date, store_name, sum(dollars) as sales_dols,
rank () over (partition by date order by sales_dols desc) as date_rank
from period, store, sales
where period.perkey = sales.perkey
and store.storekey = sales.storekey
and state = “CA”
group by date, store_name
order by date;
```

## The OVER() Clause
* The **OLAP OVER** clause differentiates **OLAP functions** from other analytic or reporting functions
* Depending on the type of OLAP function in question (ranking, aggregation, etc.), the OVER clause is subject to different usage rules. 
* The OVER clause has three distinct *CLAUSES* (capabilities):
    1. ***PARTITION BY***:
        * For Defining window partitions
    2. ***ORDER BY***:
        * For Ordering rows within partitions
        * The ORDER BY clause for an OLAP function defines the expressions for sorting rows ***within*** window partitions; however, the ORDER BY clause can be used without a preceding PARTITION BY clause, in which case the sort specification ensures that the OLAP function is applied to a meaningful (and intended) ordering of the intermediate result set.
        * The ORDER BY clause,  is a prerequisite for the *ranking family of OLAP functions.*
        * In the case of OLAP aggregations, the ORDER BY clause is not required in general, but it is a prerequisite to defining a window frame. 
            * The partitioned rows must be sorted before the appropriate aggregate values can be computed for each frame
        * Example:  the window partition is defined by the “Dimension” column. The five rows that contain the value “A” comprise a window, as do the five rows for “B” and “C”. The Meaure column is the input data for an OLAP RANK function; the rows within each partition are ordered by the Measure values. When the RANK function is applied, it is calculated over each partition. The Measure values are ranked 1 through 5 within each partition.

 The OLAP ROW_NUMBER function is also calculated in this example, without a PARRITION BY clause, to produce consecutive row numbers for the entire result set
```
Select row_number() over () as row,
dimension,
measure,
rank () over (partition by dimension order by measure)
as Olap_rank
from …;
```
    3. ***ROWS/RANGE specification:***
        * For Defining window frames 

## Window Frames
* For non-ranking OLAP functions, such as aggregations, you can define a ***window frame***
* A window frame defines a set of rows within a window partition.
* When a window frame is defined, **the OLAP function is computed with respect to the contents of this moving frame rather than the fixed contents of the whole partition.**
* The definition of a window frame can be:
    1. Row-based (ROWS specification)
        * The reference point for all window frames in the **current row**. 
        * The SQL OLAP syntax provides mechanisms for defining a row-based window frame as ¨**any number of rows preceding and/or following the current row.**
        * Example: The following example applies these rules to a specific set of values, showing the OLAP AVG function that would be calculated for each row. The sliding calculations produce a moving average with an interval of three rows or fewer, depending on which row is the current one.
```
Select row_number () over () as row,
dimension,
measure,
avg (measure) over (partition by dimension)
order by measure
rows between current row and 2 following) as OLAP_AVG
from …
```
    2. Value-based (RANGE specification).
        * The SQL OLAP syntax also supports another kind of window frame, **whose limits are defined in terms of a value-based or range-based set of rows rather than a specific sequence of rows**.
        * A frame could be defined as the set of rows with Year values some number of years preceding or following the current row’s year.
        * Example:
```
select row_number() over () as row,
dimension,
year,
measure,
avg (measure) over (partition by dimension
order by year asc
range between current row and 1 preceding ) as olap_avg
from …
```

## [QUALIFY OLAP](https://docs.oracle.com/cd/E57185_01/HIRUG/ch12s04s04s09.html "Qualify olap")
* Filters results of a previously computed OLAP function according to user-specified conditions.
* Example: 
```
SELECT COL_1
,SUBSTR(COL_2,1,18) AS COD
FROM SCHEMA.TABLE1
QUALIFY ROW_NUMBER() OVER (PARTITION BY COD ORDER BY FECHA ASC) = 1
```
* Example 2:
```
SELECT TRUNC(FECHA,'MONTH') AS FECHA_TRUNCADA
MAX(FECHA) OVER ()   AS MAX_FECHA
from SCHEMA.TABLA
```