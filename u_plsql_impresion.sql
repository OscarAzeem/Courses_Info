--
declare 
v number;
begin
v:=5;
dbms_output.put_line('anonymous block. test impresion');
dbms_output.put_line(v);
end;
  
show con_name;


select * from jobs;

-- 2.0 %TYPE

declare
v_empno number:=10;
v_ename varchar2(100):='khalel';
v_salary employees.salary%TYPE;
V_HIRE_PERIOD interval YEAR TO MONTH;
v_empnol v_empno%TYPE; -- it will not be initiated like v_empno

begin
dbms_output.put_line(v_empno);
dbms_output.put_line(v_salary);
dbms_output.put_line(v_ename);
v_salary :=5000;
dbms_output.put_line(v_salary);
V_HIRE_PERIOD:='1-3';
dbms_output.put_line(V_HIRE_PERIOD);
dbms_output.put_line(v_empnol);
end;

-- Write a pl/sql block to print the first name and the last name for employee=100
select * from employees e;



select 
first_name, last_name,employee_id
from employees e
where e.employee_id=100
;

-----------------
declare
v_fname employees.first_name%TYPE;
v_lname employees.last_name%TYPE;
v_id employees.employee_id%TYPE;
BEGIN
-- the select should retrieve 1 record, otherwise it will be an exception

select first_name,last_name, employee_id
into v_fname,v_lname,v_id
FROM employees e
where e.employee_id=100;

dbms_output.put_line('First name: '|| v_fname);
dbms_output.put_line('Last name: ' || v_lname);
dbms_output.put_line('Employee id: ' || v_id);
END;



-- define a bind variable _v_sal to be a number
-- create a block to store the salary for the employee_id=100 in this variable
-- print the variable

VARIABLE v_sal number
--
--declare

BEGIN
select salary 
into:v_sal
from employees e
where employee_id=100;

END;
--
print v_sal


-- autoprint
VARIABLE v_sal number
set autoprint on
--
--declare

BEGIN
select salary 
into:v_sal
from employees e
where employee_id=100;

END;


--- bind varchar2 variable
VARIABLE v_name varchar2(50);
DECLARE
BEGIN
SELECT first_name into:v_name
FROM employees e
where e.employee_id=100;
END;

print v_name

--------------------
-- example PL/SQL block excersice 

declare
v_first_name employees.first_name%type;
v_last_name employees.last_name%type;
v_sal number;
"hire date" date;
begin
    select first_name, last_name, salary, hire_date
    into v_first_name, v_last_name, v_sal, "hire date"
    from employees
    where employee_id=100;
dbms_output.put_line('employee first name: ' ||v_first_name);
dbms_output.put_line('employee last name: ' || v_last_name);
dbms_output.put_line('employee salary: ' || v_sal);
dbms_output.put_line('hire date: ' || "hire date");
dbms_output.put_line('first name lenght ' ||length(v_first_name));
dbms_output.put_line('first 3 letters of first name is ' ||substr(v_first_name,1,3));
END;

--- to char and more

declare
v_date date:=sysdate;
v_sal number:=5000;
begin
dbms_output.put_line(v_date);
dbms_output.put_line(v_date+8);
dbms_output.put_line(v_date-3);
dbms_output.put_line(to_char(v_date,'dd-mm-yyyy hh:mi:ss am') ) ;
dbms_output.put_line(add_months(v_date,2) );
dbms_output.put_line(to_char(v_sal,'$999,999') );
end;


-- outer nested blocks

begin <<outer>>
declare
v_father_name varchar2(200):='khalel';
v_birthday date:='26-Jul-1980';
begin
    declare
    v_child varchar2(100):='child1';
    v_birthday date:='5-Apr-2013';
    begin
    dbms_output.put_line('father name ' || outer.v_father_name);
    dbms_output.put_line('father birday ' || outer.v_birthday);
    dbms_output.put_line('child name ' || v_child);
    dbms_output.put_line('child birthday ' || v_birthday);
    end;
end;
end outer;

---------------- EXCERSICE
/* 
Write a block that retrieve the salary for employee 100 in variable v_sal
Raise the salary by 100 in variable v_new_sal
Update the employee 100 with this new salary
Insert new department called test with ID=1
*/

DECLARE

v_salary employees.salary%TYPE;
v_new_sal employees.salary%TYPE;
BEGIN

select salary into v_salary from employees e where e.employee_id=100;

dbms_output.put_line('The old salary is: ' || v_salary);

v_new_sal:=v_salary+100;

UPDATE employees e
SET e.salary=v_new_sal
WHERE e.employee_id=100;


select salary into v_salary from employees e where e.employee_id=100;
dbms_output.put_line('The new salary is: ' || v_salary);

INSERT INTO DEPARTMENTS d  
(DEPARTMENT_ID, DEPARTMENT_NAME) 
values
(1,'Test')
;
END;

select * from employees;

select * from DEPARTMENTS;

---------------
-- SQL CURSORS
--------------


select * from employees
where department_id=20;


declare
v_rows_updated number:=0;
begin
    update employees
    set salary=salary+100
    where department_id=20;
    
v_rows_updated:=sql%rowcount;



dbms_output.put_line('REcords updated: ' || v_rows_updated);
dbms_output.put_line('');
/*
dbms_output.put_line('SQL%notfound' || TO_char(SQL%notfound));
dbms_output.put_line('SQL%found' || to_char(SQL%found));
dbms_output.put_line('SQL%rowcount' || to_char(SQL%rowcount));
*/
END;

----------------
-- save in a variable the tree sQL oracle values



CREATE OR REPLACE FUNCTION BOOLEAN_TO_CHAR(STATUS IN BOOLEAN)
RETURN VARCHAR2 IS
BEGIN
  RETURN
   CASE STATUS
     WHEN TRUE THEN 'TRUE'
     WHEN FALSE THEN 'FALSE'
     ELSE 'NULL'
   END;
END BOOLEAN_TO_CHAR;




-- you should declare the anonnimous block that calls a function
DECLARE
v_sql_notfound BOOLEAN; 
v_sql_found BOOLEAN;
v_recordsfound number:=0;


FUNCTION BOOLEAN_TO_CHAR(STATUS IN BOOLEAN)
RETURN VARCHAR2 IS
BEGIN
  RETURN
   CASE STATUS
     WHEN TRUE THEN 'TRUE'
     WHEN FALSE THEN 'FALSE'
     ELSE 'NULL'
   END;
END BOOLEAN_TO_CHAR;



BEGIN
    update employees
    set salary=salary+100
    where department_id=999;
    
    v_sql_notfound:=sql%notfound;
    v_sql_found:=sql%found;
    v_recordsfound:=sql%rowcount;
    
    dbms_output.put_line('SQLnotfound: ' ||BOOLEAN_TO_CHAR(v_sql_notfound));
    dbms_output.put_line('SQLfound: ' ||BOOLEAN_TO_CHAR(v_sql_found));
    dbms_output.put_line('SQLrowcount: ' || v_recordsfound);
    
  
    if v_sql_notfound=False then
    dbms_output.put_line('Ive found some records: ' || BOOLEAN_TO_CHAR(v_recordsfound) || ' because:  v_sql_notfound = ' || BOOLEAN_TO_CHAR(v_sql_notfound));
    
    else
    dbms_output.put_line('I couldnt find any record ' || BOOLEAN_TO_CHAR(v_sql_found));
    end if;
    
END;
-- ending the annonimous block

-- -- -- -- -- -- -


DECLARE
v_no NUMBER:=&v;
BEGIN
    IF v_no>=10 THEN
    dbms_output.put_line('The number is >=10');
    ELSIF v_no<10 THEN
    dbms_output.put_line('The number is <10');
    
    END if;
END;

------------------------------
DECLARE
v_grade NUMBER:=&v;
BEGIN
    IF v_grade between 90 and 100 THEN
    dbms_output.put_line('A');
    ELSIF v_grade between 80 and 90 THEN
    dbms_output.put_line('B');
    ELSIF v_grade between 70 and 80 THEN
    dbms_output.put_line('C');
    ELSE
    dbms_output.put_line('NONNE');
    END IF;
END;

-----------------------
/* Write a block that take the employee id as substitue variable. 
if salary >=1500 print >1500
else <1500 print <1500
*/

DECLARE
v_salary employees.salary%TYPE:=0;
v_in_id number:=&emp_id;
BEGIN
SELECT salary INTO v_salary from employees e where e.employee_id=v_in_id;
IF v_salary >=5000 THEN
    dbms_output.put_line('the salary >=5000');
    ELSIF v_salary<5000 THEN
    dbms_output.put_line('the salary <5000');
    END IF;
END;


-------------
-- EXAMPLE IF AND NULL VALUES
----------

DECLARE
x number:=10;
y number;
BEGIN
if x<>y THEN
    dbms_output.put_line('this row will never be print because you are comparing a null value');
    ELSE
    dbms_output.put_line('Entering the else because failing to compare the null value');
    END IF;
END;


--- fixing the null values
DECLARE
x number:=10;
y number;
--z number:=&int_z;
BEGIN
if nvl(x,0)<>nvl(y,0) THEN
    dbms_output.put_line('The values are different');
    ELSE
    dbms_output.put_line('The value its the same');
    END IF;
END;


-- dealing with null in both values
DECLARE
x number;
y number;


BEGIN
if x is null and y is null THEN
    dbms_output.put_line('The value its the same');
    
    ELSE
    dbms_output.put_line('The values are different');
    END IF;
END;


--------------------------
--- CASE EXAMPLE ---------
-------------------------


DECLARE 
v_sal number;
v_desc varchar2(100);
BEGIN
    select salary into v_sal
    from employees e
    where e.employee_id=&emp_id;
    
    v_desc:= CASE
    when v_sal is null then 'the salary value is null'
    when v_sal between 1000 and 3000 then 'the salary is low'
    when v_sal between 3001 and 5000 then 'salary is medium'
    when v_sal >=5001 then 'salary very high'
    end; 
    
    dbms_output.put_line(v_desc);
END;

---- loop example

DECLARE
v_counter number :=0;
BEGIN
LOOP
    v_counter:=v_counter+1;
    dbms_output.put_line(v_counter);
    exit when v_counter=30;
END LOOP;
END;

-- print the employee first name for employees 100,101,102
-- using basic loop

DECLARE
v_first_name varchar2(100);
v_last_name varchar2(100);
v_var_id number:=100;
BEGIN
    LOOP 
    select e.last_name, e.first_name into v_first_name,v_last_name from employees e
    where E.employee_id=v_var_id;
    dbms_output.put_line('Last name: ' || v_last_name || ' First Name: ' || v_first_name || ' ID: ' || v_var_id);
        
    v_var_id:=v_var_id+1;
    EXIT WHEN v_var_id=103;
    END LOOP;
END;


------------
-- FOR LOOP EXAMPLE
------------

BEGIN
 for i in 1..10
 LOOP
  dbms_output.put_line(i);
  END LOOP;
END;


--------
-- NESTED FOR EXAMPLE
--------
DECLARE
v_s varchar2(100):='';
BEGIN
for i in 1..10
LOOP
    for j in 1..i
    LOOP
    v_s:=v_s||'*';
    END LOOP;
    dbms_output.put_line(v_s);
    v_s:='';
END LOOP;
END;


---------
------ LABELED LOOOPS ------
----------


DECLARE
v_s varchar2(100):='';
BEGIN
<<outer_loop>>
for i in 1..10
LOOP
    <<iner_loop>>
    for j in 1..i
    LOOP
    v_s:=v_s||'*';
    exit;
    END LOOP inner_loop;
    dbms_output.put_line(v_s);
    v_s:='';
END LOOP outer_loop;
END;

---------
------ LABELED LOOOPS ------
-- exiting an outer loop from a inner loop
----------


DECLARE
v_s varchar2(100):='';
BEGIN
<<outer_loop>>
for i in 1..10
LOOP
    <<iner_loop>>
    for j in 1..i
    LOOP
    v_s:=v_s||'*';
    exit outer_loop when i=3;
    END LOOP inner_loop;
    dbms_output.put_line(v_s);
    v_s:='';
END LOOP outer_loop;
END;


--------------------
declare

x number:=1;

begin

  loop

    x:=x+1;

   exit when x=5;

    DBMS_OUTPUT.PUT_LINE('hi');

  end loop;

end; 

---------- EXAMPLE---------
--------- RECORDS----------
---------------

DECLARE

TYPE t_emp IS RECORD
( 
    v_emp_id employees.employee_id%TYPE,
    v_first_name employees.first_name%TYPE,
    v_last_name employees.last_name%TYPE
);

v_r_emp t_emp;

BEGIN

select e.employee_id, e.first_name, e.last_name
INTO v_r_emp
FROM employees e
WHERE e.employee_id=100;


dbms_output.put_line('EMP_ID : ' || v_r_emp.v_emp_id || ' LN = ' || v_r_emp.v_last_name || ' FN: ' || v_r_emp.v_first_name);
END;




---------- ADDING A FOR LOOP IN THE EXAMPLE ABOVE---------
--------- RECORDS----------
---------------

DECLARE

TYPE t_emp IS RECORD
( 
    v_emp_id employees.employee_id%TYPE,
    v_first_name employees.first_name%TYPE,
    v_last_name employees.last_name%TYPE
);

v_r_emp t_emp;

BEGIN

FOR i IN 100..110
LOOP

select e.employee_id, e.first_name, e.last_name
INTO v_r_emp
FROM employees e
WHERE e.employee_id=i;


dbms_output.put_line('EMP_ID : ' || v_r_emp.v_emp_id || ' LN = ' || v_r_emp.v_last_name || ' FN: ' || v_r_emp.v_first_name);

END LOOP;
END;

-------------------------------------------

----- EXAMPLE RECORDS ----
-----


select * from DEPARTMENTS d
WHERE d.department_id=10;


create table BDPARTMENTS as select * from departments
where department_id=10;


create table BDPARTMENTS as select * from departments
where 1=2;

select * from BDPARTMENTS where department_id=20;

drop table BDPARTMENTS;

DELETE BDPARTMENTS;

UPDATE BDPARTMENTS
SET department_name='Azeems Department'
;


DECLARE
TYPE t_dept is record
(
    v_dept_id departments.department_id%Type,
    v_dept_name departments.department_name%Type,
    v_dept_manager departments.manager_id%TYPE,
    v_location_id departments.location_id%TYPE

);

v_dept t_dept; 

BEGIN
select d.department_id, d.department_name, d.manager_id, d.location_id
into v_dept
from departments d
where department_id=10;


insert into BDPARTMENTS values (v_dept.v_dept_id, v_dept.v_dept_name , v_dept.v_dept_manager , v_dept.v_location_id);

END;



-- EJEMPLO CON %ROWTYPE
--

DECLARE
v_dept DEPARTMENTS%rowtype;


BEGIN

select d.department_id, d.department_name, d.manager_id, d.location_id
into v_dept
from departments d
where department_id=20;


insert into BDPARTMENTS values v_dept;

END;

-- EJEMPLO CON ROWTYPE
-- UPDATE Y SET

DECLARE
v_dept DEPARTMENTS%rowtype;


BEGIN

select d.department_id, d.department_name, d.manager_id, d.location_id
into v_dept
from departments d
where department_id=10;

v_dept.department_id:=99;
v_dept.department_name:='azeem';

UPDATE BDPARTMENTS SET row=v_dept
;

/*
UPDATE BDPARTMENTS SET row=v_dept
where department_id=20;
*/
END;

select * from BDPARTMENTS;



-------------- CURSORS EXAMPLE -------------------------

-- Example 1. cursors. 

DECLARE 
    CURSOR c_emp_dept30 IS
    SELECT employee_id, first_name from employees
    where department_id=30;
    -- variables
    v_empno employees.employee_id%TYPE;
    v_first_name employees.first_name%TYPE;
    
BEGIN
    OPEN c_emp_dept30;
    LOOP 
        FETCH   c_emp_dept30 into v_empno, v_first_name;
        --dbms_output.put_line(c_emp_dept30%notfound);
        EXIT WHEN c_emp_dept30%notfound;
        dbms_output.put_line(v_empno || ' ' || v_first_name);
    end loop;
CLOSE c_emp_dept30;
END;

-------------- CURSORS EXAMPLE -------------------------

DECLARE
    CURSOR c_emp is
    SELECT employee_id, first_name, last_name FROM employees
    where department_id=30;
    
    v_emp_rec employees%rowtype;
    
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp into v_emp_rec.employee_id, v_emp_rec.first_name, v_emp_rec.last_name;
        EXIT WHEN c_emp%notfound;
        dbms_output.put_line(v_emp_rec.first_name || ' '  || v_emp_rec.last_name || '  ' || v_emp_rec.employee_id);
    END LOOP;
CLOSE c_emp;
END;
    
    
--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--+-+-+
--------------- CURSOR RECORDS--------------------


DECLARE
    CURSOR cur IS
        SELECT * FROM employees
        where department_id=30;
        
        rcur cur%ROWTYPE;
BEGIN
    OPEN cur;
    loop
        FETCH cur into rcur;
        EXIT WHEN cur%notfound;
        dbms_output.put_line(rcur.first_name || ' ' || rcur.last_name || ' ' || rcur.employee_id || ' ' || rcur.hire_date);
        END LOOP;
    CLOSE cur;
end;


-----------------------------------------------------
-- update the salaries for employees in dept30 using cursor (+100 for each one)

------
DECLARE

CURSOR cur IS
    select * from employees where DEPARTMENT_ID=30;
    
    rcur cur%ROWTYPE;
    vsal employees.salary%TYPE;
    
BEGIN
    OPEN cur;
    LOOP 
    FETCH cur into rcur; 
    dbms_output.put_line(rcur.first_name || ' ' || rcur.last_name || ' ' || rcur.employee_id || ' ' || rcur.salary);
    update employees e set e.salary=e.salary+100 where e.employee_id=rcur.employee_id;
    select salary into vsal from employees e where e.employee_id=rcur.employee_id;
    dbms_output.put_line('New salary: ' || vsal);
    EXIT WHEN cur%notfound;
    END LOOP;
    CLOSE cur;
END; 
    
select * from employees e  where e.department_id=30;

update employees e set salary=salary+100 where e.department_id=30;

--------------------------
--------- using the cursor variables: %notfound, %isopen, %rowcount

DECLARE
    -- beginning cursor. 
    CURSOR cur is
    select employee_id, first_name from employees; 
    -- end cursor
    vemp employees.employee_id%TYPE;
    vfir employees.first_name%TYPE;
    
BEGIN
    if cur%isopen then
    dbms_output.put_line('The Cursor is already open');
    elsif NOT cur%isopen then
    dbms_output.put_line('Openning the cursors');
    OPEN cur;
    END IF;
    dbms_output.put_line('Original counter cursor: ' || cur%rowcount);
    dbms_output.put_line('');
    LOOP
    FETCH cur into vemp, vfir;
    exit when cur%notfound or cur%rowcount>10;
    dbms_output.put_line('ID: ' || vemp || ' First name: ' || vfir);
    dbms_output.put_line('Iteration counter cursor: ' || cur%rowcount);
    END LOOP;
    dbms_output.put_line('');
    dbms_output.put_line('Final counter cursor: ' || cur%rowcount);
    CLOSE cur; 
END;
    
    
    
--------------------------------------------------------------
-- EXAMPLE WITH THE FOOR LOOP
-- AND EXPLICIT CURSOR DECLARATION
--------------------------------------------------------------
DECLARE
    CURSOR cur is
    SELECT * FROM  employees where department_id=30;

BEGIN
--dbms_output.put_line('Iteration counter cursor: ' || cur%rowcount);
dbms_output.put_line('');
FOR elemento in cur
    LOOP
    dbms_output.put_line('Iteration counter cursor: ' || cur%rowcount);
    dbms_output.put_line(elemento.employee_id || ' ' || elemento.first_name);
    END LOOP;
END; 


--------------------------------------------------------------
-- EXAMPLE WITH THE FOOR LOOP
-- AND NO EXPLICIT CURSOR DECLARATION
--------------------------------------------------------------

DECLARE

BEGIN

for i in (select * from employees where DEPARTMENT_id=30)
    LOOP
    dbms_output.put_line('Iteration counter cursor: ' || SQL%rowcount);
    dbms_output.put_line(i.employee_id|| ' ' || i.first_name);
    END LOOP;
END; 
    
    
--------------------------------------------------------------
-- EXAMPLE: CURSOR WITH PARAMETERS AND TRADICIONAL LOOP
--------------------------------------------------------------
    
DECLARE
    CURSOR c_emp_dept (v_dept number) --here it's defined the parameter withouth the size
    IS
    SELECT employee_id, first_name FROM employees
    where department_id=v_dept;
    
    v_empno employees.employee_id%type;
    v_first_name employees.first_name%type;
    v_dep number:=10;
    
BEGIN
OPEN c_emp_dept(v_dep);
    dbms_output.put_line('Department name: ' || TO_CHAR(v_dep));
    LOOP
        FETCH c_emp_dept into v_empno, v_first_name;
        EXIT WHEN c_emp_dept%notfound;
        dbms_output.put_line(v_empno||' ' ||v_first_name);
    END LOOP;
CLOSE c_emp_dept;

v_dep:=20;

OPEN c_emp_dept(v_dep);
    dbms_output.put_line('Department name: ' || TO_CHAR(v_dep));
    LOOP
        FETCH c_emp_dept into v_empno, v_first_name;
        EXIT WHEN c_emp_dept%notfound;
        dbms_output.put_line(v_empno||' ' ||v_first_name);
    END LOOP;
CLOSE c_emp_dept;

END;

 --------------------------------------------------------------
-- EXAMPLE: CURSOR WITH NESTED LOOP AND UPDATE. 
--------------------------------------------------------------
    
DECLARE
    CURSOR cur (v_dept number) --here it's defined the parameter withouth the size
    IS
    SELECT * FROM employees
    where department_id=v_dept;   
    
BEGIN


FOR i in 1..100
LOOP 
    dbms_output.put_line('');
    dbms_output.put_line('Working at ID: ' || i);
    FOR e in cur(i)
    LOOP
    dbms_output.put_line(e.employee_id||' ' ||e.first_name || ' Deperatment ID: '|| e.department_id );
    UPDATE EMPLOYEES SET last_name='FoundAtDepartment: '|| e.department_id where employees.employee_id=e.employee_id; 
    
    END LOOP;
    dbms_output.put_line('');
END LOOP;
END;

-- Query Análogo -- 

UPDATE EMPLOYEES SET last_name='FoundAtDepartment: '|| department_id;



 --------------------------------------------------------------
-- EXAMPLE: CURRENT OF
--------------------------------------------------------------

DECLARE
    CURSOR cur is
    SELECT employee_id, first_Name, salary FROM employees
    where department_id=30
    FOR UPDATE;
    
BEGIN 

    FOR i in cur
    LOOP
        update employees
        set salary=salary+1
        where CURRENT OF cur;
    END LOOP;
    commit;
    
END;


select * from dual; 



begin

for i in (select first_name fname from employees )

    loop

    DBMS_OUTPUT.PUT_LINE(i.first_name);

    end loop;

end; 

------------------

------ DEALING WITH EXCEPTIONS-------
-------------------------------------

--- 1) Executing one block which brings error.

declare
v_first_name employees.first_name%type;

BEGIN
    select first_name into v_first_name
    from
    employees
    where employee_id=1; -- theres no emp_id=1
END;

------------------------------------------
-- 2) executing the same block but declaring the exception


declare
v_first_name employees.first_name%type;

BEGIN
    select first_name into v_first_name
    from
    employees
    where employee_id=100; -- theres no emp_id=1
    dbms_output.put_line(v_first_name);
    
    
EXCEPTION 
    WHEN no_data_found then
    dbms_output.put_line('EXCEPTION: no_data_found. The query doesnt retrieve any record');
    
    


END;

--------------------------------------
---------
-- 3) handling many exceptions

DECLARE 
v_emp_id employees.employee_id%type;
BEGIN

    SELECT employee_id into v_emp_id
    FROM
    employees    
    where first_name=&name;

    exception
    when no_data_found then
    dbms_output.put_line('EX: no_data_found');
    
    when too_many_rows then
    dbms_output.put_line('EX: too_many_rows');
    
    when others then
    dbms_output.put_line('EX: others');
END;

-----------------------------------------
-- DEALING WITH EXCEPTIONS
-- SOLUTION TO AN ENDED BLOCK DUE TO AN EXCEPTION WITH A NESTED PL/SQL BLOCK.
--
DECLARE
v_first_name employees.first_name%type;

BEGIN
FOR i in 80..102
    LOOP

    DECLARE
    v_first_name employees.first_name%type;
    
    BEGIN
    
    SELECT first_name into v_first_name
    FROM
    employees
    WHERE employee_id=i;
    
    dbms_output.put_line(i|| ' ' || v_first_name);
    
    
    EXCEPTION
    WHEN no_data_found THEN
    dbms_output.put_line('EXCEPTION: NO DATA FOUND');
    
    END;
    
    
    END LOOP; 
    
END;
---------------------------

---DEALING WITH ORACLE SERVER EXCEPTIONS
-------
--- Example with the code number: -01400

DECLARE
e_insert exception;
pragma exception_init(e_insert,-01400);
BEGIN
    INSERT INTO departments(DEPARTMENT_ID, DEPARTMENT_NAME)
    values (1,null);
    
    EXCEPTION
    WHEN e_insert then
    dbms_output.put_line('insert failed');
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    
    when others then
    dbms_output.put_line('EXCEPTION: OTHERS');
END; 


-----------------------------------------------------


--- Example Dealing with exception Oracle Server and update sentence. 
-- REMEMBER, each DML sentence should be inside a PL/SQL block, due to the exception hadling, otherwise 
-- at the first exception will end all the PL/SQL block. 

DECLARE 
e_insert exception;
PRAGMA exception_init(e_insert,-01400);

BEGIN

    BEGIN
        INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME)
        VALUES (1,null);
    
    EXCEPTION
        WHEN e_insert THEN
        dbms_output.put_line('EXCEPTION: Insert Failed');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
    
    
    END;
    
    
    BEGIN
        
        UPDATE employees
        SET employee_id='ss'
        WHERE employee_id=100;
        
        EXCEPTION
        WHEN e_insert THEN
        dbms_output.put_line('EXCEPTION: UPDATE Failed');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
        
        
        WHEN others THEN
        dbms_output.put_line('EXCEPTION: UPDATE Failed');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
        
    
    END;
    
    
END;



------------------exception: user defined error--------------------

select * from employees where employee_id=1;

DECLARE
v_employee_id number:=1;

BEGIN
UPDATE employees
set salary=20000
WHERE employee_id=v_employee_id;

dbms_output.put_line(sql%rowcount);

END;

    
--------------------------------------------
-----------------------------------------
--------- EXAMPLE: EXCEPTION, USER DEFINED ERROR

DECLARE
v_employee_id number:=1;
e_invalid_no exception;
BEGIN
    UPDATE employees
    SET salary=20000
    WHERE employee_id=v_employee_id;
    
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    
    if sql%notfound then
    dbms_output.put_line('sql%notfound statement. exception raised');
    raise e_invalid_no;
    END IF; 
    
    EXCEPTION
    WHEN e_invalid_no then
    dbms_output.put_line('invalid emp ID: ' || v_employee_id);
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    
end;
    
-------------------------------------------------
----- RAISE APPLICATION ERROR 

DECLARE 
v_employee_id number:=1;
BEGIN
UPDATE employees
SET salary=20000
WHERE employee_id=v_employee_Id;

if sql%notfound then
raise_application_error(-20000, 'Invalid emp ID');
END IF;

END; 

--------------------------------------------------
-------- GROUP FUNCTIONS AND EXCEPTIONS
--------------------------------------

SELECT * FROM employees
where EMPLOYEE_ID=15154;

SELECT SUM(SALARY) FROM EMPLOYEES
WHERE DEPARTMENT_ID=888;

DECLARE
v_sum_sal number;
BEGIN
    SELECT SUM(SALARY) INTO v_sum_sal
    FROM employees
    WHERE DEPARTMENT_ID=&dno;
    dbms_output.put_line('the sum is: ' ||v_sum_sal);
    dbms_output.put_line('sql%rowcount: ' || sql%rowcount);
    
    
    EXCEPTION
    WHEN no_data_found then
    dbms_output.put_line('no data found');
    
END;
    
-----------------------
---- GROUP BY CLAUSE AND EXEPTIONS (REVISITED)-------

DECLARE
    v_sum_sal number;
    v_er exception;
    v_department number:=&dno;
    
BEGIN
    SELECT sum(salary) into v_sum_sal
    FROM employees
    WHERE department_id=v_department;
    
    if v_sum_sal is not null then
    dbms_output.put_line('The sum is: ' || v_sum_sal);
    dbms_output.put_line(sql%rowcount);
    END IF;
    
    if v_sum_sal is null then
    dbms_output.put_line('There is no department: ' || v_department);
    dbms_output.put_line(sql%rowcount);
    raise v_er;
    END IF;
    
    
    
    EXCEPTION
    when v_er then
    dbms_output.put_line('No data found. It was received a NULL value');
    
END;

--------- MANY BLOCKS AND MANY EXCEPTIONS

DECLARE
v_sum_sal number(2);
v_er exception;
BEGIN
        BEGIN
        SELECT SUM(salary) into v_sum_sal
        FROM employees
        WHERE department_Id=&dno;
            IF v_sum_sal is not null then
            dbms_output.put_line('The sum is ' || v_sum_sal);
            dbms_output.put_line(sql%rowcount);
            else
            raise v_er;
            END IF;
            
        EXCEPTION
        when v_er then
        dbms_output.put_line('No data found (exception raised due to a null value');
        END;
    
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
END; 

------------------------------------------------------------------------------------

begin

 update employees

set salary=0

where employee_id=5;

  exception

  when no_data_found then

  dbms_output.put_line('xyz');

end; 

-------------------------------
----- BEGIN PROCEDURE: IS - example
-------------------------------

CREATE OR REPLACE PROCEDURE update_sal
(p_emp_id in number, p_amount in number)
IS
--- variable definitions (cursors even) here

BEGIN
    UPDATE employees
    set salary=salary+p_amount
    where employee_id=p_emp_id;
commit; 

exception

WHEN others then
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);

END;

-- executing the procedure within a single block: 
execute update_sal(100,50);


-- Seeing the metadata info about some procedure:

select * from user_objects
where object_name='UPDATE_SAL';


select * from user_source

where name='UPDATE_SAL'

ORDER BY LINE;


----------------------

-------------------------------
----- BEGIN PROCEDURE: OUT - example
-------------------------------


select * from employees;











select * from employees;

