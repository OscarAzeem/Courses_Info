# Create table as other table: 

CT DatabaseName.TableName as DatabaseNameReference.TableNameReference with no data;

# Insert values INSERT INTO - SELECT

INSERT INTO DatabaseName.TableName

SELECT * FROM DatabaseNameReference.TableNameReference

WHERE CONDITION='CONDITION';


# Teradata 
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





# ORACLE
* Oracle queries
* An User could have **USER RIGHTS (USER_SYS_PRIVS)** and rights granted by their  **GRANTED_ROLE (user_role_privs)**. When using *Dynamic SQL (execute immediate)* the user should have the rights for the SQL STATEMENTS declared within the procedure. 


## General Info: 

* [Oracle Grant](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_9013.htm "Oracle grant")



## General Queries
* Limit the result subset:
    * select * from [esquema.table] where ROWNUM <= [number_limit]
* Show all directories:
    * select * from ALL_DIRECTORIES;
* Show permissions for tables, squemas: 
    * SELECT * FROM all_tab_privs
* Create or Replace:
    * CREATE OR REPLACE [NAME]
    * works on functions, procedures, packages, types, synonyms, trigger and views. **THIS DOES NOT WORK ON TABLES, MATERIALIZED VIEWS, DATABASE LINKS**
* Show all user privileges:
    *  select * from USER_SYS_PRIVS;
* Show roles you've been granted
    * select * from user_role_privs;
* Show which privileges each role gives you in role_sys_privs  (with the role name as the grantee):
    * select * from role_sys_privs;
* Show all the privileges granted to the user.
    * select * from session_privs;
* Grant permissions to an user: 
    * Create: 
        * grant CREATE ANY TABLE TO HR;
    * DROP:
        * grant DROP ANY TABLE TO HR;
    * Alter a database:
    	* grant ALTER DATABASE TO HR;
* Show info about all objects:
    * SELECT * from ALL_OBJECTS;
* Show procedures/functions/packages content:
    * select * from user_source;
* 
