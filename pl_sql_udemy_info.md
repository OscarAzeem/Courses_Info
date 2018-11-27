# Oracle PL/SQL COURSE

* Oracle - Windows
* Usuario: DatabaseOracle
* Pass: databaseoracle
* Global database name: orcl
* Master user: sys as sysdba
* Password (SYS-USER): masterdatabaseoracle
* Pluggable database name: orclpdb


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

### Show the sqlplus console output
* set serveroutput on;

### Executing a .sql query
* @C:\ruta\filename.sql



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
* Block with no name
* Compiled every time
* Not stored in the database
* Cannot be invoked by other applications
* Do not return values
* Cannot take parameters

## Subpograms
* Has a block name, you define a name
* Compiled only once
* Stored in the database
* Named and, therefore, can be invoked by other applications
* Subprograms called functions must return values
* Can take parameters 

### Procedure
* A pl/sql block that perform an action 


### Function 
* A pl/sql block that return a value 


# Open a user connection from sqlplus terminal
* 



# Declaring a PL/SQL variables
	They are declared between the Declare sentence and the Begin sentence. 
## Variables info:
* Declared and initialized in the declarative section (between declare & begin)
* Used and assigned new valeus in the executable section (between begin & end)
* Passed as parameters to PL/SQL subprograms (like procedure and function)
* Used to hold the output of a PL/SQL subprogram V_sal=get_emp_sal(100)

* When Giving a variable the not null or constant restriction, you should inicialize that variable. 
* A variable could be assigned with the operator := or DEFAULT

## Tipes of variables
* Scalar
* Composite
* Reference
* Large obect (LOB)



# Commands
## show con_name
	* Shows the database you are connected currently
## dbms_output

### dbms_output.put_line (imprime una linea)
* ejemplo: 
	dbms_output.put_line('anonymous block');


# Tables and Views
## Dictionary view (objects belong to the oracle server (information about the database))
## Stored the pluggable database available in the container database: 
	* v$pdbs

## User tables: user_tables 

