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
* ***Until an user has done a commit***, the remain users **can't see** any possible modification or update. 


## General Info: 

* [Oracle Grant](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_9013.htm "Oracle grant")



## General Queries
* Limit the result subset:
    * select * from [esquema.table] where ROWNUM <= [number_limit]
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
	* Create a session and connect to database:
	    * GRANT CREATE SESSION, CONNECT TO [user_name];
    * Permissions to execute an external procedure (not propietary): 
        * With the account procedure owner: 
            * GRANT EXECUTE ON [PROCEDURE_PACKAGE_NAME] TO [USER_NAME];
* Shows info about all objects:
    * SELECT * from ALL_OBJECTS;
* Shows procedures/functions/packages content:
    * select * from user_source;
* Shows which procedures/packages/functions have execute permissons for an user:
    * select * from user_tab_privs;
* Shows the content of the database objects that were given permission to execute to a certain user, but such user is not the owner. 
    * SELECT * FROM all_source WHERE name = '[Procedure|Package|Function]' ORDER BY TYPE, LINE;
* [SET_SQUEMA (Default schema)](https://docs.oracle.com/javadb/10.6.2.1/ref/rrefsqlj32268.html "The default schema for a certain user")
    * By default the 'default schema name' it is the user you used to log in. 
    * You can query it as belows:
        * select sys_context('USERENV', 'CURRENT_SCHEMA') from dual;
    * Changing the default schema: 
        * alter session set current_schema=USER2;





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