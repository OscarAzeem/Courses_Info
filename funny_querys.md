# Create table as other table: 

CT DatabaseName.TableName as DatabaseNameReference.TableNameReference with no data;

# Insert values INSERT INTO - SELECT

INSERT INTO DatabaseName.TableName

SELECT * FROM DatabaseNameReference.TableNameReference

WHERE CONDITION='CONDITION';


# MySQL
General Knowledge
* When creating a table with the sentences: CREATE TABLE_BACKUP AS SELECT * FROM TABLE_ORIGINAL, the MySQL server doesn't add the **PRIMARY KEYS** belonging to the TABLE_ORIGINAL
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

## MySQL DDL definition
* [MySQL Data types](http://www.mysqltutorial.org/mysql-data-types.aspx "Mysql data types")
    * Select current timestamp: 
        * select CURRENT_TIMESTAMP from dual;

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

* Getting Databases and tables info -- Teradata

 SELECT DatabaseName,TableName, CreatorName, CreateTimeStamp, LastAlterName FROM dbc.columns
 GROUP BY (DatabaseName,TableName, CreatorName, CreateTimeStamp, LastAlterName)
 where DatabaseName NOT IN ('DBC','dbcmngr')
 ORDER BY DatabaseName, CreateTimeStamp;

 * Show all user privileges:

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

* Create table as other table: 

CT DatabaseName.TableName as DatabaseNameReference.TableNameReference with no data;

* Insert values INSERT INTO - SELECT

INSERT INTO DatabaseName.TableName

SELECT * FROM DatabaseNameReference.TableNameReference

WHERE CONDITION='CONDITION';




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

## Alter command
* [Oracle add column](https://www.techonthenet.com/oracle/tables/alter_table.php "Add a new column in oracle server")
    * ALTER TABLE customers

    ADD customer_name varchar2(45);


## General Info: 

* [Oracle Grant](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_9013.htm "Oracle grant")
    * Note: You can't give permissons for DROPPING *just one table* to an user. To solve this you can create a procedure, give permissions to such user, and then whithin the procedure declare the drop table. 
* [Oracle Revoke](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_9020.htm "Oracle revoke")  
* [Oracle Synonyms](https://www.thatjeffsmith.com/archive/2013/03/why-cant-i-see-my-tables-in-oracle-sql-developer/ "Cool info about synonyms")
    * A SYNONYM is like a shortcut or pointer or link, it allows you to reference an object in the database by a different name
    * Everytime you have been granted any type or right (select, update, etc) to an squema object different from yours, a synonym is created in order to **QUERY** the object outside your default schema. Now you have a synonym who has the rights to execute a certain right to an object, but you dont have directly the rights to such object because you are not the owner .
    * 


## General Queries
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
* Getting the current user:
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
