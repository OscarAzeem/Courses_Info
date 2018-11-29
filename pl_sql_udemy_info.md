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
* The SELECT statement will lead to exceptions if no rows are selected or return more than one row. 

### END; (mandatory)

## Inside a PL/SQL block
* Identifiers: are the names given to a PL/SQL object. 
* Delimiters: symbols that have special meaning. I.E. ;+*
* Literals: Any value that is assigned to a variable is a literal
* comments: between, /* comment * / 


## SQL Statements in PL/SQL
* Retrieve a row from the database by using the SELECT command
* Make changes to rows in the database by using DML commands
* Control a transaction with the COMMIT, ROLLBACK or SAVEPOINT command
* PL/SQL doesn't directly support data definition language (DDL) statements;
* PL/SQL deos not directly support data control language (DCL) statements, such as GRANT or REVOKE. You can use dynamic SQL to execute them. 
* Could make changes to the database tables by using DML commands such as:
    * INSERT
    * UPDATE
    * DELETE
    * MERGE
* 




## SQL Functions in PL/SQL
* Available in procedural statements: single-row functions
    * ex: v_ename:=substr(ename,1,5);
    * v_lname:=length(first_name);
* Not available in procedural statements.
* 

## Data Type Conversion
* Converts data to comparable data types
* Is of two types:
    * implicit conversion
    * explicit conversion
* Functions:
    * TO_CHAR
    * TO_DATE
    * TO_NUMBER
    * TO_TIMESTAMP





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
* When a variable its initialized but not assigned the oracle server will give it a NULL value. 
* When using an operator. Operators with null value always return a null value.
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


## %Type Atribute
* Is used to declara a variable according to
    * A database column definitio
    * Another declared variable
* Is prefixed with:
    * The database table and column 
    * The name of the declared variable

## & Operator
* The oracle server will receive this value by a prompt window
* 











## Exceptions
* You'll have an exception when the select statement returns none or more than a single record
* 

## Bind variables (VARIABLE statement)
* When declaring a bind number variable, you shouldn't define a size. 
* When declaring a bind varchar2 variable you should define a size. 
* Created in the environment
* Also called host variables
* Created with the VARIABLE (also just: VAR) keyword
* Used in SQL statemetns and PL/SQL blocks
* Accesed even after the PL/SQL block is executed
* Referenced with a preceding colon
* It'll remain until the end of the session
* 

# Implicit Cursor (area in the memory)
* Everytime you declare a sql sentence, oracle will open a cursor, such cursor will point to an area in memory called context area. (implicit cursor)
* Implicit cursor: you dont have direct acces to it (belongs to oracle) , but cursor attribute
* Cursor attribute (oracle cursors)
    * SQL%notfound -false/true
    * SQL%found - false/true
    * SQL%rowcount


# Flow Execution
## IF STATEMENT
* IF -condition- THEN -sentences- ELSE -else sentences - END IF;

## ELIF STATEMENT
* IF -condition- THEN -sentences- ELSIF -condition- -sentences- ELSIF -condition- -sentences-  END IF; 
* 

## Case expression != Case statement
* Case statement:
    * Start with CASE statement
    * Ends with END CASE statement
    * After When you can put statements 
    * You can do actions due to conditions
    * 


* Case Expression
	* Contains the CASE statement withouth the END CASE just the END statement.
	* after when you cant put statements

# Loops
## LOOP
* LOOP -sentences- EXIT WHEN -condition- ; END LOOP;

## WHILE - LOOP 
* WHILE -condition- LOOP -statement- END LOOP;

## FOR - LOOP
* oracle will round the [INICIO_VARIABLE]..[FIN_VARIABLE] if fractions;
* FOR i IN [INICIO_VARIABLE]..[FIN_VARIABLE] LOOP -sentences- END LOOP;

## FOR IN REVERSE - LOOP
* oracle will round the [INICIO_VARIABLE]..[FIN_VARIABLE] if fractions;
* FOR i IN REVERSE [INICIO_VARIABLE]..[FIN_VARIABLE] LOOP -sentences- END LOOP;

## LABELED LOOPS
* They are labeled one line above the FOR statement, with the following sintax:
* <<FOR_LABEL>>
* FOR  i IN [INICIO_VARIABLE]..[FIN_VARIABLE]
* END LOOP FOR_LABEL;

## Continue Statement
* CONTINUE WHEN -condition- ;
* Continue statement menas, stop executing the next statement when -condition-

# Composite Data Types
* Can hold multiple values (unlike scalar types)
* Are of two types: 
    * PL/SQL records
    * PL/SQL collections


## PL/SQL RECORDS
* A PL/SQL record is a composite data structure that is a group of related data stored in fields
* Each filed in the PL/SQL record has its onw name and tata type. 
* Is a group of related data items stored in fields, each with its own name and data type.
* Each record defined can have as many fields as neccesary
* Records can be assigned initial values and can be defined as not null
* Fields withouth initial values are initialized to NULL
* The DEFAULT keyword can also be used when defining fields. 
* You can define RECORD types and declare user-defined records in the declarative part of any block, subprogram, or package.
* You can declare and reference nested records. One record can be the component of another record
* 

### Declaring a PL/SQL record
* Programmer-defined records.
* Table-based record. %Rowtype
* Cursor-based record. 

## Programmer-defined records
DECLARE
TYPE -var_record_name- IS RECORD
(
 v_name esquema.table%type,
 v_name2 number;
);
-var_of_record-  -var_record_name-



## PL/SQL collections
* INDEX BY tables or associative arrays
* Nested table
* VARRAY














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

