# Oracle PL/SQL COURSE

* Oracle - Windows
* Usuario: DatabaseOracle
* Pass: databaseoracle
* Global database name: orcl
* Master user: sys as sysdba
* Password (SYS-USER): masterdatabaseoracle
* alter pluggable database all open;


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
* If using a SELECT statement it should return just one row or it will lead to and exception. 

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
* When declaring a bind variable you cant initialized it at the same time. 
* You can initialize a bind varible with the EXECUTE command. 
    * execute :b_telephone:='971505914988';
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
* IF -condition- THEN -sentences- ELSIF -condition- THEN -sentences- ELSIF -condition- THEN -sentences-  END IF; 
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

## Programmer-defined records *RECORD*
DECLARE

TYPE -var_record_name- IS RECORD

(

 v_name esquema.table%type,

 v_name2 number;

);

-var_of_record-  -var_record_name-


## Table-based record. %Rowtype
* %ROWTYPE Attibute 
    * Declare a variable according to a collection of columns in a database Table or view
    * Prefix %ROWTYPE
    * Fields in the record take their names and data types from the columns of the table or view
* Sintax:
    * DECLARE
    * identifier -reference-%ROWTYPE;
    



## PL/SQL collections
* INDEX BY tables or associative arrays
* Nested table
* VARRAY


# Cursors
* Every SQL statement executed by the Oracle server has an associated individual cursor: 
    * *Implicit cursors:* Declared and managed by PL/SQL for all DML and PL/SQL statements.
        * .
    * *Explicit cursors:* Declared and managed by the programmer
        * You declare explicit cursors in PL/SQL when you have a SELECT statement that returns multiple rows. You can process each row returned by the SELECT statement. 
        * Functions: 
            * Can perform row-by-row processing beyond the first row returned by a a query
            * Keep track of the row that is currently being procesed
            * Enable the programmer to manually control explicit cursors in the PL/SQL block. 
        * Controlling Explicit Cursors:
            * Declare: 
                * Created a named SQL area.
            * Open: 
                * Identify the active set
            * FETCH:
                * Load the current row into variables. 
            * EMPTY?:
                * Test for existing rows. Return to FETCH if rows are found. 
            * CLOSE:
                * Relase the active set. 
        * Explicit Cursor Attributes: 
            * %ISOPEN - boolean. 
                * Evaluates to TRUE if the cursor is OPEN.
            * %NOTFOUND - boolean
                * Evaluates to TRUE if the most recent fetch does not return a row
            * %FOUND - boolean
            	* Evaluates to TRUE if the most recent fetch returns a row; complement of %NOTFOUND
        	* %ROWCOUNT - Number
        		* Evaluates to the total number of rows returned so far. 
		* Hints when declaring a cursor: 
		    * Do not include the INTO clause in the cursor declaration because it appears later in the FETCH statement. 
		    * If processing rows in a speific sequence is requered, use the ORDER BY clause in the query. 
		    * The cursor can be any valid SELECT statement, including joins, subquerys and so on.
	    * Hints when Opening a Cursor:
	    	* The OPEN statement executes the query associated with the cursor, identifies the active set, and positions the cursor pointer at ther first row. The OPEN statement is included in the executable section of the PL/SQL block.
	    	* Open is an executable statement that performs the folowwing operations: 
	    	    1. Dynamically allocates memory for a context area
	    	    2. Parsers the SELECT statement
	    	    3. Binds the input variables (sets the alues for the input variables by obtaining their memory addresses)
	    	    4. Identifies the active set (the set of rows that satisfy the serach criteria). Rows in the active set are not retrieved into variables when the OPEN statement is executed. Rather, the FETCH statement retrieves the rows from the cursor to the variables. 
	    	    5. Positions the pointer to the first row in the active set. 
    	    * Note: if a query returns no rows when the cursor is opened. PL/SQL does not raise an exception. YOu can find out the number of rows returned with an explicit cursor by using the -cursor_name-%ROWCOUNT attribute. 
	    * Hints when fetching data from a cursor:
	    	* The FETCH statement retrieves the rows from the cursor one at a time. After each fetch, the cursor adavances to the next row in the active set. You can use the %NOTFOUND attribute to determine wheter the entire active set has been retrieved.
	    	* The FETCH statement performs the following operations: 
	    	    1. Reads the data for the current row into the output PL/SQL variables
	    	    2. Advances the pointer to the next row in the active set. 
	    * Hints when closing the Cursor. 
	    	* The CLOSE statement disables the ursor, releases the context area and "undefines" the active set. Close the cursor after completing the processing of the FETCH statement. You can reopen the cursor if requeried. 
	    	* A cursor can be reopened only if it is closed. If you attempt to fetch data from a cursor after it has been closed, then an INVALID_CURSOR exception will be raised. 
	    	* Note: Although it is possible to terminate the PL/SQL block withouth closing cursors, there is a maximum limit on the number of open cursors per session, which is determined by the OPEN_CURSORS, paramter in the database parameter file. 
	    	* Default: OPEN_CURSORS=50.

## FOR - CURSORS
* A For loop cursor doesn't need to OPEN, FETCH, and CLOSE
* Oracle will do all these thing implicity
* Iterating in a explicit way: 
    * FOR elemento in CURSOR
* Iterating in a no explicit way: 
    * FOR elemento in (SELECT * FROM ---)

## CURSOR WITH PARAMETERS
* When declaring a cursor you should open parenthesis with the number of parameters and the type of each one, withouth saying the size. 
    * CURSOR Mycursor (var1 TypeVar1, var2 TypeVar2)

## FOR UPDATE Clause (solution for the WHERE statement whithin the FOR)
* When you put for update, then no one can do any DML (I, U, D) for these records, until you finish your transaction (commit, update).
* When you use the for update statement, oracle gives you the option to refer directly to that records selected in the CURSOR statement. It's possible to update inside the FOR the reserved ercords.
* 


# EXCEPTIONS
* The errors obtained by the BEGIN section in the PL/SQL Block Structure are handled here.
* They are around 20 predefined exceptions name by ORACLE. 
* An exception is a PL/SQL error that is raised during program execution. 
* An exception can be raised: 
    * Implicitly by the Oracle server
    * Explicitly by the program
* AN exception can be handled:
    * By trapping it with a handler
    * By propagating it to the calling environment
* In contrast with the usual PL/SQL program it doesn't end ebruptly, when the exception is raised, the control shifts to the exception section and all the statements in the exception section are executed. The PL/SQL block terminates with normal, successful completion. 
* When dealing with exceptions, the 'others' STATEMENT should be declared at the end of EXCEPTION block. 



## EXCEPTION TYPES
1. Predefined Oracle server error: 
    * One of approximately 20 errors that occur most often in PL/Sql CODE. 
    * You need not declare these exceptions. They are predefined by the Oracle Server and are raised implicitly. 
    * Sample predefined exceptions:
        * NO_DATA_FOUND
        * TOO_MANY_ROWS
        + INVALID_CURSOR
        * ZERO_DIVIDE
        * DUP_VAL_ON_INDEX
2. Non-predefined Oracle Server error: 
    * Any other standard Oracle Server error. 
    * You need to declare these within the declarative section; the Oracle server will raise the error implicitly, and you can catch for the error in the exception handler. 
3. User-defined error: 
    * A condition that a developer determines is abnormal. 
    * Declare in the declarative section and raise explicitly. 

* Exception Syntax

WHEN

EXCEPTION_NAME1 [OR EXCEPTION_NAME2...] THEN

STATEMENT1;


* Guidelines for Trapping Exceptions:
    * The EXCEPTION keyword starts the exception-handling section.
    * Several exception handers are allowed
    * Only one handler is processed before leaving the block. 
    * WHEN OTHERS is the last clause.


## Common mistakes with dealing with EXCEPTIONS:
* When an error it's encountered, the program goes inmediatly to the EXCEPTION block and then ends such block. 
* For solving the END of a PL/SQL statement due to and EXCEPTION raised off-time, you can declare a nested PL/SQL block which deals with such exception. 

## Non predefined Oracle Server Error EXCEPTIONS:
* They are defined in the DECLARE statement
* the PRAGMA statement specifies how the exception it's triggered. 
* You should declare the oracle number error inside the PRAGMA statement: 
    * PRAGMA exception_init(exception_name,oracle_error_number);
        * ex: PRAGMA exception_init(e_insert,-01400);
* Printing the sqlcode error: 
    * dbms_output.put_line(sqlcode);
* Printing the error description (sqlerrm):
    * dbms_output.put_line(sqlerrm);

## USER PREDEFINED EXCEPTIONS:
* The exception declared should be specified inside the DECLARE section
    * -exception_variable- exception; 
* The exception should be raised manually (usually inside an IF block)
* After raised, the exception it's called by the EXCEPTION block. 
* The sqlcode for an user predefined exception it's always: 1
* The sqlerrm for an user predefined exception it's always: "User-Defined Exception"

## Raise Application Error Procedure
* Sintax: 
    * raise_application_error(error_number,message[, (TRUE | FALSE)]);
        * **error_number**: Number between -20000 and -20999
        * **message**: Is the user-specified message for the exception; is a character string up to 2048 bytes long.
        * **TRUE|FALSE**: Is an optional Boolean parameter(if TRUE the error is placed on the stack of previous errors. If FALSE, which is the default, the error replaces all previous errors)
* You can use this procedure to issue user-defined error messages from stored subprograms
* You can reprot errors to your application and avoid returning unhandled exceptions. 
* Such errors should be a number between -20000 and -20999

## Group functions and exceptions
* When using a GROUP BY statement the exception can't be raised with an oracle exception: *no_data_found*, because the GROUP BY clause allways return a value (a NULL value when no data found). 
* The exception when using GROUP BY could be raised with an user defined exception, if the value returned is NULL.
* 

# Procedures and subprograms
* You can give permissons to certain users to execute a Procedure. 

## Anonymous Blocks and Subprograms
* **Anonymous Blocks**: 
    * Unnamed PL/SQL blocks. 
    * Compiled every time
    * Not stored in the database
    * Cannot ve invoked by other applications
    * Cannnot take parameters
* **Subprograms**: 
    * Named PL/SQL blocks
    * **A subprogram can be a procedure or a function**
    * Compiled only once
    * Stored in the database
    * Named and, therefore, can be invoked by other applications. 
    * Subprograms called funtions must return values
    * Can take parameters
    * A PL/SQL subprogram is a named PL/SQL block that can be clled with a set of parameters. 
    * You can declare and define a subprogram within either a PL/SQL block or another subprogram. 
    * a subprogram consist of a specification and a body. 
    * Typically, you use a procedure to perform an action and a function to compute and return a value. 
* The main idea it's to modularize the code into subprograms   
    * Locate the code sequences repated more than once
    * Create subprogram P containing the repetead code
    * Modify original code to invoke the new subprogram. 

## Modularizing Development with PL/SQL Blocks. 
* PL/SQL is a block-structured language. The PL/SQL code block helps modularize code by using: 
    * Anonymous blocks
    * Procedures and functions
    * Packages
    * Database triggers
* The benefits of using modular program constructs are: 
    * Easy maintenance
    * Improved data security and integrity 
    * Improved performance
    * Improved code clarity


# Procedures
* Are a type of subprogram that perform an action.
* Can be stored in the database as a schema object. 
* Promote reusability and maintainability

## Understanding Procedure sintax
* First off all you should have *procedure privilege* in the oracle server user.
* Substitution and host variables are not allowed in procedures.
* Sintax: 
    * CREATE OR REPLACE PROCEDURE: 
        * Optional to override and existing procedure
    * Parameters: 
    * (-first_parameter- *PARAMETER_MODE*  TYPE_PARAMETER, -second_parameter- *PARAMETER_MODE* TYPE_PARAMETER): 
        * Parameters must be declared withouth specifying size. 
        * The *PARAMETER_MODE* could be one of the tree following: 
            1. IN: the parameter will be sent from the incoming environment.
            2. OUT: returns a value to the caller
                * When using the OUT *PARAMETER_MODE*, should consider the following:
                    * The variables returned should be declared before as BIND (Also called host) variables.
                    * When calling the Stored Procedure, the BIND variables should have an ':'as a prefix.  
            3. IN/OUT: supplies an input value, which may be returned (output) as a modified value
            * Parameter modes are specified in the formal parameter declaration, after the aprameter name and before its data type
            * The IN mode is the dfault if no mode is specified. 
* Calling a procedure:
    * You can call a procedure by the command: 
        * *execute* PROCEDURE_NAME(PARAMETER1,PARAMETER2);
    * You can call a procedure inside any PL/SQL block: 
        * BEGIN
        * PROCEDURE_NAME(PARAMETER1, PARAMETER2);
        * ...
        * END; 
* After declaring the Procedure Name and parameters, the procedure it's initialized with one of the three following reserved words:
    1. IS
    2. OR
    3. AS

## Metadata Querys Procedures
* Seeing the metadata Procedure

select * from user_objects

where object_name='PROCEDURE_NAME_CREATED';

* Seeing the text Procedure: 

select * from user_source

where name='PROCEDURE_NAME_CREATED'

ORDER BY LINE;

* Dropping a procedure: 

drop procedure 'PROCEDURE_NAME_CREATED'


## Comparing the parameter Mode
* **IN**:
    * Default mode
    * Value is passed into subprogram
    * Formal parameter acts as a constant
    * Actual parameter can be a literal, expression, constant, or initialized variable.
    * Can be assigned a default value
* **OUT**:
    * Must be specified
    * Returned to calling environment
    * Unintialized variable
    * Cannot be assigned a default value
* **IN/OUT**:
    * Must be specified. 
    * Passed into subprogram; returned to calling environment. 
    * Initialized variable
    * Must be a variable
    * Cannot be assigned a default value

## Available notations for passion actual parameters
* When calling a subprogram, you can write the actual parameters using the following notations: 
* Positional: 
    * List the actual parameters in the sam order as the formal parameters
* Named: 
    * Lists the actual parameters in arbitrary order and uses the association operator (=>) to associate a named formal parameter with its actual parameter
* Mixed: 
    * Lists some of the actual parameters as positional and some as named. 


## Default option for parameters
* Two ways when specifying the parameter:
    1. VarName VarType:='VarValue'
    * VarName VarType DEFAULT 'VarValue'
* 



* Video: 50








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

