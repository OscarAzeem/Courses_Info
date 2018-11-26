# Oracle PL/SQL COURSE

Oracle - Windows
Usuario: DatabaseOracle
Pass: databaseoracle
Global database name: orcl
Master user: sys as sysdba
Password (SYS-USER): masterdatabaseoracle
Pluggable database name: orclpdb


## configuration file to make the configurations
* Path: C:\app\DatabaseOracle\product\12.2.0\dbhome_1\network\admin
* tnsnames.ora
* As usual: connection name, same as Database name
* Connection name= Capital letters
* Service name = lower letters

### Configuring the connectyon tipe
* using Connection type = TNS, you have to select a Network alias, which is declared in the tnsames.ora file.
* 

### Steps to enable the HR account and the orclpdb

show con_name; 

select name, con_id from v$pdbs;

select * from v$pdbs;

alter session set container=orclpdb;

show con_name;

select name, open_mode from v$pdbs;

alter pluggable database open; 

select * from all_users;

alter user hr identified by hr account unlock; 

### Open the pluggable database after a reboot

* with the sys user: 
* alter pluggable database all open;


## PL/SQL BLOCK STRUCTURE
### Declare (optional)
* Variables, cursors, user-defined exceptions
### Begin (mandatori)
* Sql statements
* PL/SQL statements
### Exception (optional)
* Actions to perform when errors occur
### END; (mandatory)





# Block Types
## Anonymous
* Bloc with no name

## Subpograms
* Has a name, you define a name

### Procedure
* A pl/sql block that perform an action 


### Function 
* * A pl/sql block that retain a value 







# Commands
## show con_name
	* Shows the database you are connected currently
## 


# Tables and Views
## Dictionary view (objects belong to the oracle server (information about the database))
## Stored the pluggable database available in the container database: 
	* v$pdbs

## User tables: user_tables 

