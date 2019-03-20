# Oracle PL/SQL COURSE
* [Oracle Data Types](http://psoug.org/reference/datatypes.html "Oracle Data Types")

* Oracle - Windows
* Usuario: DatabaseOracle
* Pass: databaseoracle
* Global database name: orcl
* Master user: sys as sysdba
* Password (SYS-USER): masterdatabaseoracle
    * Or can be: masteroracledatabase (sorry)
* alter pluggable database all open;

## Instalation Oracle 12c
* Create and Configure a database
* Desktop Class
* User windows built in account
* Database edition: Enterprise Edition
* Global database name: orcl
* Pluggable databae name: orclpdb
* Software Location: C:\app\Apeiron\product\12.2.0\dbhome_1
* Oracle Enterprise Manager Database Express URL: https://localhost:5500/em
* Sys user: sys as sysdba
* Password: masteroracledatabase
* OraMTS Port Number: 2030
* PORT (tnsnames.ora): 1522
* Oracle Enterprise Manager Database Express URL: https://localhost:5500/em
* 


## configuration file to make the configurations
* Path: C:\app\DatabaseOracle\product\12.2.0\dbhome_1\network\admin
* tnsnames.ora
* As usual: connection name, same as Database name
* Connection name= Capital letters
* Service name = lower letters
* Adding the following to the tnsnames.ora file: 

ORCLPDB =

(DESCRIPTION =

(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))

(CONNECT_DATA =

(SERVER = DEDICATED)

(SERVICE_NAME = orclpdb)

)

)


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
* **You can define a procedure or function inside a pl/sql block but this will be used only in this block (in the DECLARE section)**

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
    * Definition:
        * v_salary employees.salary%TYPE;
        * [var_name] [table].[table_name]%TYPE;

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
    * PL/SQL TABLES
    * PL/SQL records
    * PL/SQL collections


## PL/SQL TABLES:
* When using an user defined data type, i.e PL/SQL table in this case, the data type declaration should be given whithin the DECLARE or IS section.
* Objects of type TABLE are called PL/SQL tables, which are modeled as (but not the same as) database [PL/SQL table](https://docs.oracle.com/cd/A57673_01/DOC/server/doc/PLS23/ch4.htm "PL/SQL table")
* its primary key gives you array-like access to rows
* Think of the **key and rows as the index and elements of a one-dimensional array.**
* PL/SQL table is an ordered collection of elements of the same type
    * Each element has a unique index number that determines its position in the ordered collection
* **PL/SQL tables differ from arrays** in two important ways
    * First: 
        1. arrays have fixed lower and upper bounds
        2. PL/SQL tables are unbounded.
        3. the size of a PL/SQL table can increase dynamically
    * Second: 
        1. arrays require consecutive index numbers
        2. PL/SQL tables do not. This characteristic, called sparsity, allows the use of meaningful index numbers

### Why Use PL/SQL Tables?
* **PL/SQL tables help you move bulk data  into and out of database tables or between client-side applications and stored subprograms** 
* They can store columns or rows of Oracle data, and they can be passed as parameters
* PL/SQL tables make it easy to move collections of data into and out of database tables or between client-side applications and stored subprograms
* You can even use PL/SQL tables of records to simulate local database tables.
* You can specify a TABLE type in the RETURN clause of a function specification. That allows the function to return a PL/SQL table of the same type. 


## PL/SQL Table Sintax:
* **An initialization clause is not required (or allowed).**
    * A PL/SQL table is unbounded; its index can include any BINARY_ INTEGER value. So, you cannot initialize a PL/SQL table in its declaration.
* Table sintax:
    
    TYPE table_type_name IS TABLE OF datatype [NOT NULL]
   
    INDEX BY BINARY_INTEGER; 

* INDEX BY clause must specify datatype BINARY_INTEGER, which has a magnitude range of -2147483647 .. 2147483647.
* Tabla row sintax:
    * To specify the element type, you can use %TYPE to provide the datatype of a variable or database column. In the following example, you define a TABLE type based on the ename column:

    DECLARE

    TYPE EnameTabTyp IS TABLE OF emp.ename%TYPE

    INDEX BY BINARY_INTEGER;

* you can add the NOT NULL constraint to a TABLE type definition and so prevent the storing of nulls in PL/SQL tables of that type

### Sintax for a RECORDS PL/SQL Table
* In the following example, you use a RECORD type to specify the element type:
    
    DECLARE

    TYPE TimeRecTyp IS RECORD (

    hour   SMALLINT := 0, 

    minute SMALLINT := 0,

    second SMALLINT := 0);

    TYPE TimeTabTyp IS TABLE OF TimeRecTyp

    INDEX BY BINARY_INTEGER;

* With a PL/SQL table of records, you use the following syntax to reference fields in a record:
    * plsql_table_name(index).field_name
* the following IF statement references a field in the record stored by the first element of the PL/SQL table emp_tab: 
    
    DECLARE

    TYPE EmpTabTyp IS TABLE OF emp%ROWTYPE 

    INDEX BY BINARY_INTEGER;

    emp_tab EmpTabTyp;

    BEGIN

    ...

    IF emp_tab(1).job = 'CLERK' THEN ...

    END;

* When calling a function **that returns a PL/SQL table,** you use the following syntax to reference elements in the table
    * function_name(parameters)(index)


## PL/SQL Table Attributes
* **Attributes are characteristics of an object.**
* Currently, you **cannot** use PL/SQL **table attributes** in a SQL statement
* A PL/SQL table has the attributes **EXISTS, COUNT, FIRST, LAST, PRIOR, NEXT, and DELETE.** 
    * The attributes EXISTS, PRIOR, NEXT, and DELETE take parameters
        * Each parameter must be an expression that yields a BINARY_INTEGER value or a value implicitly convertible to that datatype
        * This four table attributes act like a function, which is called as part of an expression
    * DELETE acts like a procedure, which is called as a statement


* To apply the attributes to a PL/SQL table, you use dot notation, as follows: 
    * plsql_table_name.attribute_name

### Using EXISTS
* EXISTS(n) returns TRUE if the nth element in a PL/SQL table exists. Otherwise, EXISTS(n) returns FALSE.
* You can use EXISTS to avoid the exception NO_DATA_FOUND, which is raised when you reference a nonexistent element

### Using COUNT
* COUNT returns the number of elements that a PL/SQL table contains.
* COUNT is useful because the future size of a PL/SQL table is unconstrained and therefore unknown
* you could use COUNT to specify the upper bound of a loop range

### Using FIRST and LAST
* FIRST and LAST return the first and last (smallest and largest) index numbers in a PL/SQL table.
* If the PL/SQL table is empty, FIRST and LAST return nulls.
* If the PL/SQL table contains only one element, FIRST and LAST return the same index number,

### Using PRIOR and NEXT
* PRIOR(n) returns the index number that precedes index n in a PL/SQL table
* NEXT(n) returns the index number that succeeds index n.
* If n has no predecessor, PRIOR(n) returns a null. Likewise, if n has no successor, NEXT(n) returns a null. 
* **You can use PRIOR or NEXT to traverse PL/SQL tables indexed by any series of integers**
* **you can use PRIOR or NEXT to traverse PL/SQL tables from which some elements have been deleted**

### Using DELETE
* Delete has three forms: 
    1. DELETE removes all elements from a PL/SQL table
    2. DELETE(n) removes the nth element
    3. DELETE(m, n) removes all elements in the range m .. n.


### Retrieving Oracle Data with PL/SQL TABLE
* You can retrieve Oracle data into a PL/SQL table in three ways
    1. SELECT INTO statement lets you select a single row of data
        * Using the SELECT INTO statement, you can select a column entry into a scalar element. Or, you can select an entire row into a record element
    2. The FETCH statement or a cursor FOR loop lets you fetch multiple rows
        * Using the FETCH statement, you can fetch an entire column of Oracle data into a PL/SQL table of scalars
        * Or, you can fetch an entire table of Oracle data into a PL/SQL table of records

### Inserting Oracle Data with PL/SQL TABLE
* You cannot reference **record** variables in the VALUES clause
    * Instead, you must specify one or more fields in the record
* 





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
* Can be the following types: 
    * Associative array (or index-by table) (PL/SQL TABLE)
    * Nested table:
        * a nested table is like a one-dimensional array with an arbitrary number of elements
        * a nested table is a column type that holds a set of values
        * The database stores the rows of a nested table in no particular order
    * Variable-size array (varray)
        * A variable-size array (varray) is an item of the data type VARRAY
        * 
* These composite variables have internal components that you can treat as individual variables
* In a collection, **the internal components are always of the same data type, and are called elements**
* In a record, the internal components can be of different data types, and are called fields

## EXTEND (Increase the size of a collection):
* EXTEND it's used to increase the size of a nested table or varray
* The procecure EXTEND has three forms: 
    1. **EXTEND** appends one null element to a collection.
    2. **EXTEND(n)** appends n null elements to a collection.
    3. **EXTEND(n,i)**  appends n copies of the ith element to a collection
* NOTE(s):
1. **You cannot use EXTEND with index-by tables**
2. You cannot use EXTEND to add elements to an uninitialized collection
3. If you impose the NOT NULL constraint on a TABLE or VARRAY type, you cannot apply the first two forms of EXTEND to collections of that type.





# Cursors
* **Attributes are characteristics of an object.**
* A cursor has the attributes %FOUND, %NOTFOUND, %ISOPEN, and %ROWCOUNT.
* Every SQL statement executed by the Oracle server has an associated individual cursor: 
    * *Implicit cursors:* Declared and managed by PL/SQL for all DML and PL/SQL statements.
        * They are defined with the *prefix:* **SQL**
            * ***Functions:*** 
                * SQL%BULK_EXCEPTIONS
                *
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
* Using the [Cursor](https://stackoverflow.com/questions/10629802/can-i-pass-an-explicit-cursor-to-a-function-procedure-for-use-in-for-loop "Cursor as function parameter") as a function parameter.  

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

## HANDLING ERRORS WITH IMPLICIT CURSOR PROPERTIES DUE TO A BULK BINDING (FORALL - SAVE EXCEPTIONS)
* It's possible to use this propierties after declaring a *FORALL* and *SAVE EXCEPTIONS* statement in order to see each error individually.

### BULK_EXEPTIONS
* **SQL%BUL_EXCEPTION.COUNT**:
    * Conteo total de las excepciones encontradas
* **SQL%BULK_EXCEPTIONS**: can be indexed an has the following properties: 
    1. SQL%BULK_EXCEPTIONS(n).error_index
    2. SQL%BULK_EXCEPTIONS(n).error_code
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
* You can give permissions to certain users to execute a Procedure. 
* The procedures are all about exceptions. When calling a procedure with a IN/OUT variable, if the program ends without finding an exception, **the calculated value** from the procedure it's returned. If the program reaches an exception the **original** value it´s returned, **if not NOCOPY** is declared. 

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
* **When using a procedure, the SELECT statement must be declared with an INTO sentence**
* Are a type of subprogram that perform an action.
* Can be stored in the database as a schema object. 
* Promote reusability and maintainability
* It's necessary to declare the EXCEPTION inside each procedure, besides the EXCEPTION in the PL/SQL block. 
* **If no EXCEPTION is declared inside the procedure, after finding an error the oracle server will end the main PL/SQL block and a ROLLBACK will be executed.**
* 

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

### Calling a procedure
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
* **Calling with OUT parameters**
    * You should DECLARE the returning variables inside the *DECLARE* statement and such variables used when calling the procedure
    * Example:

    DECLARE 

    v_first_name employees.first_name%type;

    v_sal employees.salary%type;

    BEGIN

    query_emp(104,v_first_name,v_sal);


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



# Functions
* PL/SQL that return a value (In general to Compute A Value)
* The PL/SQL block must have at least one RETURN statement. 
* Main object it's a SELECT statement. 
* Can be stored in the database as a schema object for repeated execution
* Is called as part of an expression or is used to provide a parameter value. 
* Host (BIND) variables are not Allowed, also substitute variables (reserved character *&*)
* It should be at least one return expression in executable section
* Return datatype should be withouth size. 
* OUT / IN OUT can be used, but it's not a good practice. 

## Methods to invoke a function:
1. As a part of an expression:
    * variable:=function(parameters)
2. As a parameter value: 
    * execute dbms_output.put_line(get_sal(100));
3. Using a host varaible

variable b_salary number;

execute :b_salary:=get_sal(100);

print b_salary;

4. As a part of a select statement 
    * select funcion_name(parameters) from dual;
    * Example with a column from the select statement, used as a parameter to a function in another column:

select employee_id, first_name, get_sal(employee_id)

from employees

where department_id=20;


## Differences Between Procedures and Functions
* Procedures:
    * Execute as a PL/SQL sstatement
    * Do not contain RETURN clause in the Header
    * Can pass values (if any) using output parameters
    * Can contain a RETURN statement without a value
    * Main reason: To perform an action; can not be used in select
* Functions: 
    * Can also contain an EXCEPTION block.
    * Invoke as part of an expression (cant be called by the EXECUTE command)
    * Can be called as variable:=function(parameters)
    * Must contain a RETURN clause in the header. 
    * Must return a single value.
    * Must contain at least one RETURN statement
    * Main reason: To return a VALUE; can be used in Select, but it should not include OUT/ IN OUT parameters. 
* A procedure that have one parameter (OUT) would be better rewritten as a function.


## Advantages of User-Defined Functions in SQL statemetns
* Can extend SQL where activities are too complex, too awkward, or unavailable in SQL.
* Can increase efficiency when used in the WHERE clause to filter data, as opposed to filtering the data in the application. 
* Can manipulate data values. 

## Calling User-Defined Functions in SQL statements. 
* User-defined functions act like ***built-in-single-row functions*** and can be used in: 
    * The SELECT list or clause of a query
    * Conditional expressions of the WHERE and HAVING clauses
    * The CONNECT BY, START WITH, ORDER BY, and GROUP BY  clauses of a query
    * The VALUES clause of the INSERT statement
    * The SET clause of the UPDATE statement. 
    * 

## Restrictions when calling Functions from SQL expressions
* User-defined functinos that are callable from sQL expressions must: 
    * Be stored in the database
    * Accept only IN parameters with valid SQL data types not ***PL/SQL-specified types (Record, table, Boolean)***
    * Return valid SQL data types, not PL/SQL-specific types
* When calling functions in SQL statements: 
    * Parameters must be specified with positional notation (this before 11g only)
    * You must own the function or have the EXECUTE privilege
* Can not be used in CHeck constraint (create table/alter table)
+ Can not be used as default value for a column

## Controlling side effects when calling functinos from SQL Expressions
* Functions called from:
    * A SELECT statement cannot contain DML statements
    * An UPDATE or DELETE statement on a table T cannot query or contain DML on the same table T
    * SQL statements cannot end transactions (that is, cannot execute COMMIT or ROOLBACK operations)
* Note: Calls to subprograms that break these restrictions are also not allowed in the function
* When a function is called from UPDATE/DELETE, then the function can not query or modify database tables modified by that statement. 
    * Error: Mutating table. 
* 

# Packages
* When having many functions logically similar it's better to use a PACKAGE
* A package it's divided in two main parts: 
    1. Package specification (definition). 
        * Needs just the definition headers withouth the code. 
        * There's no need for the BEGIN clause. 
    2. Package body. 
        * The package body should have the definition of each function declared in the Package specification. 
* A Package is a schema that groups logically related   PL/SQL types, variables, and subprograms. 
* Packages usually have two parts: 
    1. A specification (spec)
        * The specification is the interface to the package. It declares the types, variables, constants ,exceptions, cursors, and subprograms that can be referenced from outside the package. 
    2. A body
        * The body defines the queries for the cursors and the code for the subprograms. 
        * Enable the Oracle server to read multiple objects into memory at once. 
* Advantages of using packages: 
    * Hiding information:
        * Only the declarations in the package specification are visible and accesible to applications
        * Private constructs in the package body are hiden and inaccessible
        * All coding is hidden in the package body. 

## Package specification without body
* This is used when we want to define global variables.

## Creating the Package Specification using CREATE PACKAGE Statement.
* CREATE [OR REPLACE] PACKAGE package_name IS|AS public type and variable declarations subprogram specifications END [package_name]
* The OR REPLACE option drops and re-creates the package specification.
* Variables declared in the package specification are initialized to NULL by default;
* All the constructs declared in a package specification are visible to users who are granted privileges on the package. 

## Creating the Package Body
* CREATE [OR REPLACE] PACKAGE BODY package_name IS|AS private type and variable declarations. Subprogram bodies. [BEGIN initialization statements] END [package_name];
* The OR REPLACE option drops and re-creates the package body. 
* Identifiers defined in the package body are private and not visible outside the package body
* All private constructs must be declared before they are referenced.
* Public constructs are visible to the package body. 
* 

## Guidelines for writing packages. 
* The package specification should contain as few constructs as possible
* Package specification: 
    * Try to keep package specification simple as you can
* Package body: 
    * Try to add additional codes you need in package body as private subprograms. 
* Recompile package: 
    * When the package body suffers mayor changes (including new functions or procedures) the package specification should be compiled as well. 
* Dropping package specification and body: 
    * drop package [package_name];
* Drop only package body
    * drop package body [package_name];

# Overloading Subprograms in PL/SQL

* Enables you to create two or mroe subprograms with the same name.
* Requires that the subprogram's formal parameters ***differ in number, order, or data type familiy***
* Enables you to build flexible ways for invoiking subprograms with different data.
* Provides a way to extend functionality without loss of existing code; taht is, ading new parameters to existing subprograms
* Provies a way to overload local subprograms, package suprograms, and type methods, ***but not stand-alone subprograms.*** 
* 

# Persistent State of Packages
* The collection of package variables and the values define the package state. The package state is: 
    * Initialized when the package is first loaded
    * Persistent (by default) for the life of the session:
        * Stored in the User Global Area (UGA)
        * **Unique to each session**
        * Subject to change when packge subprograms are called or public variables are modified.
        * 
    * Not persistent for the session but persistent for the life of a subprogram call when using *PRAGMA SERIALLY_REUSABLE* in the package specification. 
        * PRAGMA SERIALLY_REUSABLE:
            * The value of the persistent variable will be reseted after executing again the persistent code
            * The life of the persistent variable will be only the life of the SERIALLY_REUSABLE procedure;
            * 

## PERSISTENT STATE AND CURSORS (Real application)
* They are declared in the body of the package: 

--- package definition

CREATE OR REPLACE PACKAGE cur_pkg

IS

-- global cursor declared

CURSOR c_emp IS

SELECT employee_id FROM EMPLOYEES;

# Oracle Supplied Packages
* Are provided with the Oracle server
* Extend the functionality of the database
* Enable access to certain SQL features that are normally restricted for PL/SQL 
* Abbreviated list of some Oracle-supplied packages:
    * DBMS_OUTPUT
    * UTL_FILE
    * UTL_MAIL
    * DBMS_ALERT
    * DBMS_LOCK
    * DBMS_SESSION
    * HTP
    * DBMS_SCHEDULER

## DBMS_OUTPUT
* The DBMS_OUTPUT package enables you to send messages from stored subprograms and triggers 
* PUT and PUT_LINE place text in the buffer
* GET_LINE and GET_LINES read the buffer
* Messages are not send until the sending subprogram or trigger completes
* Use SET SERVEROUTPUT ON to display messages in SQL Developer and SQL * Plus
* PUT appends text from the procedure to the current line of the line otput buffer.
* NEW_LINE places an end-of-line marker in the output buffer. 
* PUT_LINE combines the action of PUT and NEW_LINE (to trim leading spaces).
+ GET_LINE retrieves the current lien from the buffer into a procedure variable. 
* GET_LINES retrieves 

## UTL_FILE
* The UTL_FILE package extends PL/SQL programs to read and write operating system text files:
    * Provides a restricted version of operating system stream file I/O for text files
    * can acces files in operarating system directories defined by a CREATE DIRECTORY statement. 
* To READ/WRITE a file we need to craete a directory. 
* The directory can be created only by sys and system users;
* Steps to create a directory:
    1. Open sqlplus
    2. Connection with sysdba
    3. Alter session set container=orclpdb (the plug db name)
    4. Create directory mydir as 'F:\TEST'
    5. grant READ, WRITE on DIRECTORY mydir to public;
    6. CREATE THE DIRECTORY ON your computer (the server)
    7. Put empty file sample.txt

## UTL_FILE DECLARED EXCEPTIONS
* INVALID_PATH: file location invalid
* INVALID_MODE: the open_mode parameter in FOPEN is invalid
* INVALID_FILEHANDLE: File handle invalid
* INVALID_OPERATION: File could not be opened or operated on as requested. 
* READ_ERROR: Operating system error ocurred during the read oepration
* WRITE_ERROR: Operating system error ocurred during the write operation
* INTERNAL_ERROR: Unspecified PL/SQL error. 
* 

## UTL_MAIL PACKAGE
* A utility for managing email
* Requires the setting of the SMTP_OUT_SERVER database
* Provides the following procedures
    * SEND: for messages without attachments. 
        * Packages an email message, locates SMTP information, and delivers the message to the SMTP server for forwarding to the recipients. 
    * SEND_ATTACH_RAW for messages with binary attachments (like picture)
        * Represents the SEND procedure overloaded for RAW attachments. 
    * SEND_ATTACH_VARCHAR2: for messages with text attachments
        * Represents the SEND procedure overloaded for VARCHAR2 attachments
* ***WORKING PROCEDURE***:
1.  The DBA install the UTL_MAIL package
    * @$ORACLE_HOME/rdbms/admin/utlmail.sql
    * @$ORACLE_HOME/rdbms/admin/prvtmail.plb
2. Define the SMTP_OUT_SERVER (*init.ora*)
3. The DBA grants Execute on UTL_MAIL to a USER/Public
4. The DBA adds a Record in ACL (Access Control List) Using a package called DBMS_NETWORK_ACL_ADMIN
5. Now the USER can use UTL_MAIL


# Dynamic SQL
* ***USUALLY***: The **SQL STATEMENTS** are created at **COMPILE TIME**
* When some word belonging to an element of a database object (schema name, table name) it's used as an input variable, the server cannot find such input variable in the **compile time**, in such cases it's neccesary to use *Dynamic SQL*
* Dynamic SQL Meaning: 
    * IN Dynamic SQL, The SQL statements are created dynamically at run time (not compile time)
* All SQL statements go through some or all of the following stages:
    * Parse:
        * Check the statement syntax, validating the statement. Ensure all referencing objects are correct. The privileges exist. 
    * Bind:
        * Check the bind variable if the statement contains Bind Var. (**It's also used with the :VARIABLE replacement**)
    * Execute:
        * Execute the statement (non Queries statements)
    * Fetch:
        * Retrieve the rows (queries statements)

## What is dynamic SQL?
* The full text of the dynamic sQL statement might be unknow until run time; therefore, its syntax is checked at *run time rather than at compile time*.
* You can use dynamic SQL statemetns to make your PL/SQL programs more general and flexible. 

## Dyamic SQL process
* Use dynamic SQL to create a SQL statement whose structure may change during run time. Dynamic SQL: 
     * Is constructed and stored as a chracter string, string variable, or string expressio within the application. 
     * Is a SQL statement with varying column data, or different conditions with or without placeholders (bind variables).
     * Enables DDL, DCL, or session-control statements to be written and executed from PL/SQL
     * Is executed with Native Dynamic SQL statements or the DBMS_SQL package. 
 
## When do you need dynamic SQL?
* In PL/SQL you need dynamic SQL in order to execute the following. 
    * SQL whose full text is unknown at compile time such as:
        * A SELECT statement that includes an identifier that is **unknown at compile time** (such as table name)
        * A WHERE clause in which the column name is **unknown at compile time.** 


## Methods to create Dynamic SQL:
1. execute immediate
2. the package dbms_sql

## EXECUTE IMMEDIATE statement for NDS or PL/SQL anonymous blocks:
* INTO: is used for ***single-row queries*** and specifies the variables or records into which column values are retrieved. 
* USING: is used to hold all bind arguments. The default parameter mode is IN. 
    * ***The USING sentence must be declared always last***
    * The sintaxis for USING sentence is-> =: (contrary to assigning value to a variable, which is: := )
* Example:

.EXECUTE IMMEDIATE dynamic_string

INTO 

USING [IN|OUT|IN OUT] bind argument;

* When combining using and into, the INTO clause should be used before USING:

EXECUTE IMMEDIATE 'select first_name from employees where employee_id=:c'

INTO V_ENAME USING vno;

* When using %Rowtype and INTO combination, you cant use this function in a SELECT statement, because the function retrieves a %ROWTYPE value (if defined so).

### Using the ALTER statement to compile:
* A procedure:
    * Alter procedure [procedure_name] compile;
* A function
    * Alter function [function_name] compile;
* A package specification:
    * Alter package [package_specification_name] compile specification;
* A package body:
    * Alter package [package_body_name] compile body;



## REF CURSOR
* The REF cursor can be opened many times with **different queries**.
* And so far, that's it. 


## DBMS_SQL
* When using you shouldn't add the ';' character at the end of the sentence, if so, it'll give the error code ORA-00933
* Uses explicitly the execution flow of SQL:
    * Parse, Bind, Execute and Fetch
* When using DBMS_SQL you should declare each one of the four parts of the execlution flow of SQL.  Example:
    * dbms_sql.parse();
    * dbms.sql.execute();
* DBMS_SQL gives you more control of how many rows are being affected by the SQL sentence. example: 

v_no_rec:=dbms_sql.execute(v_cur_id);

dbms_output.put_line(v_no_rec || ' record(s) were deleted from ' || p_table_name);

# Design consideration for PLSQL code
* Constants and exceptions are typicaly implemented using a bodiless package (that is, a package specification).
* Start with standardization of:
    * Exception names
    * Constant definitions

## Standadizing Exceptions
* They are declared in a package specification, for example: 

CREATE OR REPLACE PACKAGE error_pkg IS

e_fk_err EXCEPTION;

PRAGMA EXCEPTIO_INIT (e_fk_err,-2292);

And called like: 

EXEPTION

WHEN error_pkg.e_fk_err THEN...

### Standardizing Exception Handling
* Consider writing a subprogram for common exception handling to:
    * Display errors based on SQLCODE and SQLERRM values for exceptions.
    * Track run-time errors easily by using parameters in your code to identify: 
        * The procedure in which the error ocurred
        * The location (line number) of the error.
        * RAISE_APPLICATION_ERROR using stack trace capabilities, with the third argument set to TRUE:
            * RAISE_APPLICATION(-20001,'My first error',TRUE); 
            * Example:

             DECLARE

            e_fk_err EXCEPTION;
            
            PRAGMA EXCEPTION_INIT (e_fk_err,-02292);
            
            BEGIN
            
            DELETE FROM departments;
            
            EXCEPTION
            
            WHEN e_fk_err THEN
            
            RAISE_APPLICATION_ERROR (-20001,'my error',true);
            
            END;
        * a

### Standardizing Constants
* For programs that use local variables whose values should not change:
    * Convert the varaibles to constants to reduce maintenance and debugging.
    * Create one central package specification and place all constants in it.
        * Example:

        CREATE OR REPLACE PACKAGE global_Measurement

        IS

        c_mile_to_km constant number:=1.6093;

        END;

## Local subprograms
* A local subprogram is a PROCEDURE or FUNCTION defined **at the end of the declarative section**.
* Can be be accesible from the block owner
* It's compiled as a part of the owner block. 
* Why using a local subprogram?
    * Reduction of repetitive code
    * Code readability
    * Easy mantenance

## Definer's Rights Versus Invoker's Rights
* Definer's rights (**DEFAULT** way: *AUTHID DEFINER*):
    * Used prior to Oracle 8i (it was the only option available)
    * Programs execute with the privileges of the creating user.
    * **User does not require privileges on underlying objects that the procedure accesses. User requires privilege only to execute a procedure.**
    * Instead of the sentence: *AUTHID CURRENT_USER* of Invoker rights,  it's *AUTHID DEFINER*
* Invoker's rights:
    * Introduced in Oracle 8i
    * Programs execute with the privileges of the calling user.
    * **User requieres privileges on the underlying objects that the procedure accesses.**
    * Should be declared the Invoker's rights after the CREATE statement with the option: *AUTHID CURRENT_USER*
    * Example:

        CREATE OR REPLACE PROCEDURE add_hr_table

        (p_id number, p_name varchar2) **authid current_user**

    * After being defined **authid current_user** and if the calling user doesn´t have permissions to any object within the Procedure|Package|Function, ORACLE will give the following errors:
        * Which part within the procedure the user doesn't have acces to: **ORA-06512: at "HR.ADD_HR_TABLE_AUTH_ID", line 5**
        * Which kind of error: **00942. 00000 -  "table or view does not exist"**
        * In order to solve the previous type of errors, GRANT permissions should be given to the calling user. 

## Autonomous Transactions
* Each transaction are independent from the main transaction. Such new transaction is declared with the statement: *PRAGMA AUTONOMUS_TRANSACTION*
* Are independent transactions started by another main transaction
* Are specified with PRAGMA AUTONOMOUS_TRANSACTION
* All the transactions will be ended by the *parent commit* but using PRAGMA AUTONOMUS_TRANSACTION
* Example:
    
    CREATE OR REPLACE PROCEDURE child_block IS

    **PRAGMA AUTONOMOUS_TRANSACTION;**

### Features of Autonomous Transactions 
* Are independent of the main transaction.
* Suspend the calling transaction until the autonomous transactions are completed. 
* Are not nested transactions
* Do not rollback if the main transaction rolls back. 
* Enable the changes to become visible to other transactions upon a commit.
* Are started and ended by ***individual* subprograms** and **not by nested or anonymous PL/SQL blocks**
* 

## USING THE NOCOPY HINT
* Allows the PL/SQL compiler to PASS OUT and IN OUT parameters by reference rather than by value. 
* *Enhances performance by reducing overhead when passing parameters*
* We use NOCOPY in complex data types (LOBs, XMLTYPEs, collections, etc).
* Example:
    
    DECLARE

    TYPE rec_emp_type IS TABLE OF employees%ROWTYPE;

    rec_emp rec_emp_type;

    PROCEDURE populate(p_tab IN OUT **NOCOPY** emptabtype) IS

    BEGIN

    ...

* **IN parameters are always passed by reference**, no temporary buffer is needed, it's used the same memory location
* When trying to modify an **IN** value, the server will give the following error: *Expression **IN_VALUE** cannot be used as an assignment target*
* **OUT/IN OUT** parameters can be passed by:
    1. Pass by value (default)
        * The default actino is to create a tepmorary buffer (formal parameter), copy the data from the aprameter variable (actual parameter) to that buffer and work on the tepmorary buffer during the lifetime of the procedure. On successful completion of the procedure, the contest of the temproary buffer are copied back into the parameter variable. In the event of an exception ocurring, the copy back operation does not happen. 
    2. Pass by reference using no copy

### Effects of the NOCOPY HINT
* The procedures are all about exceptions. When calling a procedure with a IN/OUT variable, if the program ends without finding an exception, **the calculated value** from the procedure it's returned. If the program reaches an exception the **original** value it´s returned, **if not NOCOPY** is declared, if so, the modified value it's returned since using **NOCOPY** will pass the value as reference. 
* If the subprogram exits with an exception that is not handled:
    * You cannot rely on the values of the actual parameters passed to a NOCOPY parameter
    * Any incomplete modifications **are not 'rolled back'**
* The remote procedure call (RPC) protocol enables you to pass parameters only by value
    * **If you want to call a procedure in a remote database the NOCOPY will not work, only in the local database it will work**

### When does the PL/SQL compiler ignore the NOCOPY hint?
* The NOCOPY hint has no effect if:
    * The actual parameter:
        * Is an element of an index-by-table
        * Is constrained (for example, by scale(number) or NOT NULL)
        * And formal parameter are records, where one or both records were declared by using %ROWTYPE or %TYPE, and constraints on corresponding fields in the recors differ
        * Requieres an implicit data type conversion
    * The subprogram is involved in an external or remote procedure call. (calling a procedure in another database).
* 


## Using the PARALLEL_ENABLE Hint
* Can be used in **functions** as an optimization hint
* Indicates that a function can be used in a parallelized query or parallelized DML statement. 
* **Cache and parallel are only in oracle enterprise editions** [See Diferences between Oracle editions](https://docs.oracle.com/database/121/DBLIC/editions.htm#DBLIC116 "Diferrences oracle editions")


## USING the Cross-Session PL/SQL Function Result Cache
* Each time a result-cached PL/SQL function is called with different parameter values, those parameters and their results are stored in cache. 
* The function result cache is stored in a shared global area (SGA), making it available to any session that runs you application. 
* Subsequent calls to the same function with the same parameters uses the result from cache. 
* Improves performance and scalability.
* Use with functions that are called frequently and dependent on information that changes infrequently. 
* Notes:
    * If the database object that uses to compute the value changed ,then result is computed. 
    * If function execution results in an unhandled exception, the exception results are not stored in the cache. 
* Example:

    CREATE OR REPLACE FUNCTION get_sum_sal_dept

    (dept_id number)

    return number result_cache -- <-  result cache info

## USING the deterministic clause with functions
* **If another session runs the same code with the same parameters the code is still executed. The cache is not shared between sessions**
* Cache and parallel are only available for oracle enterprise editions.
* Also the DBA should make changes in these values
    * parameter shared_pool_size
    * parameter result_cache_max_size
    * parameter result_cache_mode
* The DETERMINISTIC hint has been available since Oracle 8i
* Specify DETERMINISTIC to indicate that the function returns the same result value whenever it is called with the same values for its arguments.
* This helps the optmizer avoid redundant function calls. 
* If a function was called previously with the same argumetns, the optimizer can elect to use the previous result. 
* Do not specify DETERMINISTIC for a function whose result depends on the state of session variables or schema obects. 
* You must specify this keyword if you intent to call the function in the expression of a funcion-based index OR from the query of a materialized view taht is marked refresh fast or enable query rewrite. 
    * When oracle encounters ad eterministic function in one of these contexts, it attempts to use previously calculated results when possible rather than reexecuting the functino. If you subsequently change the semantics of the function, you must manually rebuild all dependent function-based indexes and materialized view. 

## BULK BINDING
* **BULK BINDING** only works with *EXCEPTIONS*. [Nice explication about FORALL and BULK COLLECT](https://blogs.oracle.com/oraclemagazine/bulk-processing-with-bulk-collect-and-forall "FORALL AND BULK COLLECT") 
* When dealing with *collections* this slower the performance in the dataserver, So Oracle introduced something called BULK binding. (**Send the SQL statemetns using bulk**).
* Sintax:
    * The FORALL keyword instructs the PL/SQL engine to bulk bind input collections before sending them to te SQL engine: 

    FORALL index IN lower_bound..upper_bound

    sql_statement;

    * The **BULK COLLECT** keyword instructs the SQL engine to bulk bind output collections before returning them to the PL/SQL engine. 

    ... BULK COLLECT INTO

    collection_name[,collection_name]

### Handling FORALL EXCEPTIONS with the %BULK_EXCEPTIONS Attribute
* To manage exceptions and have the bulk bind complete despite errors, add the keyword SAVE EXCEPTIONS to your FORALL statement after the bounds, before the DML statement. 
* All exceptions raised during the execution are saved in the cursor attribute **%BULK_EXCEPTIONS**, which stores a collection of records. Each record has two fields:
    1. **%BULK_EXCEPTIONS(I). ERROR_INDEX** Holds the "iteration" of the FORALL statement during which the exception was raised and 
    2. **%BULK_EXCEPTIONS(I).ERROR_CODE** which holds the corresponding Oracle error code. 
* Values stored in %BULK_EXCEPTIONS refer to the most recently executed FORALL statement. Its subscripts range from 1 to **%BULK_EXCEPTIONS.COUNT**

### FORALL AND SAVE EXCEPTIONS
* Inside a FORALL statement, when finding an error the PL/SQL block will go to the exception section and the block will be ended. To bypass this kind of error it's possible to declare a PL/SQL block outside the FOR (instead of FORALL) and deal with each register as one exception. For specifically the FORALL statement it's available the SAVE EXCEPTIONS statement, as the example below: 
* **FORALL i IN ename_table.first..ename_table.last SAVE EXCEPTIONS**
* Using the **SAVE EXCEPTIONS** statement means the server will send the SQL statements one by one (like a simple for)

## BULK COLLECT INTO
* It's convenient when you want to insert values from a certain table into a PL/SQL table, but instead of doing the FOR statement you can use the **BULK COLLECT INTO** sentence. 
* Example:
    * select first_name **bulk collect into** ename_table from ename; -- where ename_table it's a PL/SQL table
    * 

## RETURNING - BULK COLLECT INTO
* After doing an DML statement (UPDATE, i.e) and appending the *RETURNING* operator, the Oracle server will return all the affected values.
    * Example: 
        
        UPDATE employees

        SET salary=salary+p_amount

        WHERE employee_id=emp_id

        **RETURNING salary into v_new_sal**;

* The returning statement can also be combined with *BULK COLLECT INTO* as the example Below:
    * Example:

    FORALL i IN emp_table.first..emp_table.last

    UPDATE ename_test

    SET salary=salary/2

    WHERE employee_id=emp_table(i).employee_id

    **RETURNING employee_id, salary BULK COLLECT INTO emp_new_sal;**

# Triggers
* A trigger is a PL/SQL block that is **stored in the database** (it's like an squema object like procedures and functions) and fired (executed) in response to a specified event. 
* The Oracle database automatically executes a trigger when specified conditions occur. 
* **Defining Triggers**
    * A trigger can be defined on the table, view, schema (schema owner), or database (all users)
* Differences between Application and Database Triggers
    * A database trigger:
        * Fires whenever a DML, a DDL, or **system event occurs on a schema or database.**
    * Application trigger:
        * Fires whenever an event occurs within a particular application (outside the database)
* When a raise_application_error sentence is raised, the trigger/procedure its ended. 
* Everytime a trigger is raised depending on the condition which the trigger is fired, the DBMS server adds two new values to the buffer called :old.column_name and :new.column_name. Like all the bind variables, they can be accessed by the operator: ':'. 
* You should never use COMMIT or ROLLBACK whithin the body of the trigger, the commit or rollback should be in the main transaction(DML), THIS IS CALLED **DATA CONSISTENCY** (rolling back all, o commit all)

## Trigger Event Types
* You can write triggers that fire whenever one of the following operations occurs in the database: 
    * A database manipulation **(DML)** statement (DELETE, INSERT, or UPDATE)
    * A database definition **(DDL)** statement (CREATE,ALTER or DROP)
    * A database operation such as SERVERERROR, LOGON, LOGOFF, STARTUP, or SHUTDOWN

## Business Application Scenarios for Implementing Triggers:
You can use triggers for: 
* Security
    * Insert allowed only in working hours
* Auditing
    * Log all the transactions for specific tables
* Data integrity:
    * Complex integrity rules which not standard
* Referential integrity:
    * Non stanard referential
* Table replication:
    * Syncronize a table
* Computing derived data automatically
* Event loggin

## Available Trigger Types
* **Simple DML triggers**
    * BEFORE
    * AFTER
    * INSTEAD OF
* **Compound triggers**
* **Non DML Triggers**
    * DDL event triggers
        * Audit for some user who tries to create a database
    * Database event triggers

## Trigger Event Types and Body
* A **trigger event** type determines which DML statement cause the trigger to execute. The possible evetns are: 
    * INSERT
    * UPDATE [of column]
    * DELETE
* A **trigger body** determines what action is performed and is a PL/SQL block or a CALL to a procedure. Also called the code of "what you want to do" when an action happens.
    * The trigger body could be a PL/SQL block, or
    * A call to other procedure

## DML Triggers
1. Statement-Level trigger
    * Used commonly on: security check on (user, time,...)
    * Is the default when creating a trigger
    * Fires **once** for the triggering event
    * Fires once **even if no rows are affected**
    * **COMMON CASES**:
        * When you want to check security **before** DML (DATE, TIME)
        * When you want to check user profile **before** DML
2. Row-Level Triggers
    * Used commonly on: transactions log
    * Use the FOR EACH ROW clause when creating a trigger.
    * Fires once for each row affected by  the triggering event
    * Does **not fire if** the triggering **event does not affect any rows.**
    * **COMMON CASES**:
        * When you need the **OLD** and new values for the **DML**

## Triggers Sintax
CREATE [ OR REPLACE ] TRIGGER [trigger_name]

[BEFORE | AFTER | INSTEAD OF ]

[INSERT | UPDATE | DELETE......]

[OF] [COLUMN_NAME OF THE OBJECT]

ON[name of underlying object] 

[REFERENCING NEW AS **NEW** OLD AS **OLD**]

[FOR EACH ROW] 

[WHEN[condition for trigger to get execute] ]

DECLARE

[Declaration part]

BEGIN

[Execution part] 

EXCEPTION

[Exception handling part] 

END;


## Trigger constraints priority
* First the database will check the following constraints in the following order:
    1. Trigger constraint
    2. Integrity constraint (child record) 


## Trigger conditional predicates
* IF INSERTING
* IF DELETING
* IF UPDATING
* Example:

IF inserting THEN

raise_application_error(-20010,'INSERT not allowed now');

ELSIF DELETING THEN 

raise_application_error(-20011,'DELETE not allowed now');

ELSIF UPDATING THEN

raise_application_error(-20012,'UPDATE not allowed now');

END IF;

## OLD AND NEW QUALIFIERS
1. INSERT CASE (there will be just new values, no old ones)
    * Insert into dept (deptno, dname) values (1,'IT');
    * New values:
        * :new.deptno=1
        * :new.dname='IT'
2. UPDATE CASE (there will be new and old values)
    * UPDATE DEPT

    SET dname='IT dept' -> **new value**-> :new.dname

    WHERE deptno=1 -> **old value** -> :old.deptno
3. DELETE CASE (all the columns are old values, there is no new)


## Trigger-Firing Sequence:
1. BEFORE statement trigger
2. BEFORE row trigger
3. AFTER row trigger
4. AFTER statement trigger.


## Follow statement in triggers
* In case when declaring many triggers in the same leve, you will never know which one will be fired first because everyone has the same hierarchy.
* To explicity declare which trigger will be fired first, you should use the statement **FOLLOWS**
    * CREATE OR REPLACE TRIGGER t2

    BEFORE

    INSERT

    ON emp

    **FOLLOWS** T1

    BEGIN

    INSERT INTO table VALUES (value1,value2);

    END;

 
## Compound Trigger (After Oracle 11g)
* You can compound multiple triggers into one single trigger called, compound trigger. 
* Inside the Compound triger you can have optional secctions for each individual trigger. 
* The sequence for each individual trigger is very important, and should follow:
    1. BEFORE STATEMENT IS
    2. BEFORE EACH ROW IS
    3. AFTER EACH ROW IS
    4. AFTER STATEMENT IS
* Compound Trigger definition:
    * A single trigger on a table that allows you to specify actions for each of the following four timing points: 
        * Before the firing statement
        * Before each row that the firing statement affects
        * After each row that the firing statement affects
        * After the firing statement. 
* Compound Trigger Structure for Tables:
    * CREATE OR REPLACE TRIGGER [SCHEMA].[TRIGGER] FOR [DML_EVENT_CLAUSE] ON [SCHEMA].[TABLE]

    COMPOUND TRIGGER

    -- Initial section

    -- declarations

    -- subprograms

    -- Optional Section

    BEFORE STATEMENT IS ..;

    -- Optional Section

    BEFORE EACH ROW IS ..;

    --Optional Section

    AFTER EACH ROW IS..;

    --Optional section

    AFTER STATEMENT IS...;

* 








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

# December Path to freedom :) - Now also January :( - Now also March :(
1. SQL -- ok
2. PL/SQL -- 73%
3. DBA BASICS -- 20% 
4. Informatica -- 25%
5. Scala -- pending
6. scikit book -- pending
7. AWS -- pending 
8. Hadoop - pending. 


----
----

