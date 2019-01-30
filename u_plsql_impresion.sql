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

CREATE OR REPLACE PROCEDURE query_emp
(p_emp_id IN employees.employee_id%type,
p_f_name out employees.first_name%type,
p_sal OUT employees.salary%type)
IS

BEGIN
    SELECT first_name,salary
    INTO p_f_name, p_sal
    FROM employees
    where employee_id=p_emp_id;
    
    EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    
END;

----------------------------------------
-- DECLARING THE BIND VARIABLES FOR THE OUT EXAMPLE --

variable b_first_name varchar2(100);
variable b_sal number;

execute query_emp(105,:b_first_name, :b_sal);


BEGIN
dbms_output.put_line(b_first_name);
dbms_output.put_line(b_sal);
END;

PRINT b_first_name b_sal;


-----------------------------
-- The other way to call and print the OUT parameter
DECLARE 
v_first_name employees.first_name%type;
v_sal employees.salary%type;
BEGIN
query_emp(104,v_first_name,v_sal);
dbms_output.put_line(v_first_name);
dbms_output.put_line(v_sal);
END;


------------------------------------------------------
-- IN/OUT PARAMETER
-----------------------------------------------------
-- asume the lenght for a tel is 12
-- example 971505914988
-- we need a produce to format the 971505914988 to 971(50)5914988

CREATE OR REPLACE PROCEDURE format_tel
(p_tel in out varchar2)
IS
BEGIN
p_tel:=substr(p_tel,1,3)||'('||substr(p_tel,4,2)||')'||substr(p_tel,7);
end ; 

variable b_telephone varchar2(20);
execute :b_telephone:='971505914988';

execute format_tel(:b_telephone);
print b_telephone; 

----------------------------------------------------

--- EXERCISE FOR PASSING PARAMETERS ------
---

CREATE TABLE products
(
    prod_id number,
    prod_name varchar2(20),
    prod_type varchar2(20),
    constraint products_pk primary key (prod_id)
);


CREATE OR REPLACE PROCEDURE add_products
(p_prod_id number, p_prod_name varchar2, p_prod_type varchar2)
IS
BEGIN

INSERT INTO products VALUES (p_prod_id, p_prod_name, p_prod_type);
commit;
exception
when others then
dbms_output.put_line('error in insert');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);


END; 



-----------------
---- calling the procedure FROM A PL/SQL BLOCK
----------------
DECLARE
v_prod_id number(3);
v_prod_name varchar2(20);
v_prod_type varchar(20);
BEGIN
add_products(2,'Nombre2','Tipo2');


EXCEPTION
WHEN others then
dbms_output.put_line('error in insert');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);

END; 

----------------------
------ CALLING THE PROCEDURE FROM A "EXECUTE" BLOCK

execute add_products(3,'Nombre3','Tipo3');



----------- CALLING THE PROCEDURE FROM AN "ECECUTE" BLOCK
---- NAMED 

execute add_products(p_prod_id=>4, p_prod_name=>'Nombre4', p_prod_type=>'Tipo4');


------------------------------
-- DECLARING A PROCEDURE WITH DEFAULT PARAMETERS
------------------------------

CREATE OR REPLACE PROCEDURE add_products
(p_prod_id number, p_prod_name varchar2:='Uknown Name', p_prod_type varchar2 default 'Uknown Type')
IS

-- declare section (analogous)
e_constraint exception;
PRAGMA exception_init(e_constraint,-1);

BEGIN
INSERT INTO products (PROD_ID,PROD_NAME,PROD_TYPE) VALUES (p_prod_id, p_prod_name, p_prod_type);
dbms_output.put_line('Values inserted: ' || p_prod_id || p_prod_name || p_prod_type);


COMMIT;

EXCEPTION
WHEN e_constraint then
dbms_output.put_line('Unique constraint was violated. Exception declared by oracle server');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);

WHEN OTHERS THEN
dbms_output.put_line('OTHERS EXCEPTION');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);

END;

------------------------------

-- caling a procedure with the default parameters

execute add_products(p_prod_id=>5);

execute add_products(p_prod_id=>6);


-----------------------------

-- HAndling procedure exceptions

BEGIN
add_products(11,'PC');
add_products(12,'Lactoc');
add_products(21,'Keyboard');

--DELETE from products;


END;

-----------------------------------

--- USING A BOOLEAN TYPE AS PARAMETER ---

----

CREATE OR REPLACE PROCEDURE bolean_parameter(p boolean default True)
IS
---
BEGIN
if p then
    dbms_output.put_line('The p value is True or None value was given');
    
    ELSIF NOT P then
    dbms_output.put_line('The p value fALSE');
    
    
    
END if;


END;


---- DELCARING THE PL/SQL BLOCK
DECLARE
value_boolean BOOLEAN:=FALSE;


BEGIN

bolean_parameter();
end;

-----------------------------------

-- PROCEDURES AND ROWTYPE VARIABLES
-- NOTICE THIS CODE: THE ROWTYPE DEFINITION AND INSERT

-----------------------------------

CREATE OR REPLACE PROCEDURE test_plsql_records
( rec in DEPARTMENTS%rowtype)
IS
BEGIN
INSERT INTO DEPARTMENTS VALUES rec;

EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('OTHERS EXCEPTION');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);

END; 


-- calling the procedure

DECLARE
v departments%rowtype;
BEGIN
FOR i in 1..1000
LOOP
dbms_output.put_line('Working on: ' || i);
v.DEPARTMENT_ID:=i;
v.department_name:=TO_CHAR(v.DEPARTMENT_ID);
test_plsql_records(v);

END LOOP; 

END;

-----------------------------------

-- FUNCTIONS EXAMPLE
-- 

-----------------------------------

-- create a function to return the salary for an employee
-- so we need one parameter (in) number (employee_id)
-- the return value should be also a number because it is the salary.

CREATE OR REPLACE FUNCTION get_sal
(p_emp_id number)
return number
IS
v_sal NUMBER;
BEGIN
    SELECT salary into v_sal
    FROM EMPLOYEES
    WHERE employee_id=p_emp_id;
    
    return v_sal;
END; 

-- Methods for calling a function:
-- 1) As a part of an expression: 
DECLARE
v_sal number;
BEGIN
FOR i in 100..220
LOOP
v_sal:=get_sal(i);
dbms_output.put_line('wORKING on: ' || i ||  ' The sal is: ' || v_sal);
END LOOP;
END; 


-- 2 as a parameter value

BEGIN
dbms_output.put_line(get_sal(100));
END;

execute get_sal(100);

-- Also we can do this:

execute dbms_output.put_line(get_sal(100));



---------------------------------------

-- Restrictions when calling functions from SQL 

CREATE OR REPLACE FUNCTION get_sal_tax
(p_sal number)
RETURN NUMBER
IS

BEGIN
COMMIT; 

    IF p_sal<5000 then
    RETURN p_sal*(10/100);
    ELSE
    return p_sal*(15/100);
    END IF;
    
END;    

-- You can not use a function in select if the function contain commit/rollback. 
SELECT employee_id, first_name, salary, get_sal_tax(salary)
FROM employees
WHERE get_sal_tax(salary)>2000
ORDER BY get_sal_tax(salary);


-- but it will work like this: 
DECLARE
v number;
BEGIN
v:=get_sal_tax(5000);
dbms_output.put_line(v);
END;


-------------------------

CREATE OR REPLACE FUNCTION get_sal_tax
(p_sal number)
RETURN NUMBER
IS

BEGIN
    INSERT INTO DEPARTMENTS(department_id, department_name)
    values (-99,'test');
    
    IF p_sal<5000 THEN
    RETURN p_sal*(10/100);
    ELSE
    RETURN p_sal*(15/100);
    END IF;
END; 

----------------------
-- You can not use function in select if the function contains DML statements. 

SELECT employee_id, first_name, salary, get_sal_tax(salary)
FROM employees
WHERE get_sal_tax(salary)>2000
ORDER BY get_sal_tax(salary);

---------------


--- BUT IT WILL WORK LIKE THIS: 
DECLARE
v number;
BEGIN
v:=get_sal_tax(5000);
dbms_output.put_line(v);
END;

select * from DEPARTMENTS
where department_id=-99;

-------------------------------------------------


drop function get_sal_tax;



create or replace function get_full_name

(p_emp_id number)

return varchar2
is
v_full_name varchar2(200);
begin
  select first_name||' '||last_name into v_full_name
  from employees
  where employee_id=p_emp_id;
  return v_full_name;
end; 


----------------------------------
BEGIN
select get_full_name(-50) FROM DUAL;
END;

execute dbms_output.put_line(get_full_name(-50));



-----------------------------------

-- pACKAGES

CREATE OR REPLACE FUNCTION square_area
(p_side number)
RETURN NUMBER
IS
BEGIN
RETURN p_side*p_side;
END;

select square_area(10) from dual; 


---------------------
CREATE OR REPLACE FUNCTION rectangle_area
(p_a number, p_b number)
RETURN NUMBER
IS
--
BEGIN
RETURN p_a*p_b;
END;


select rectangle_area(10,4) from dual; 


--------------------------------------------------
-------- BUILDING A PACKAGE-----------------------
---------------------------------------------------

CREATE OR REPLACE PACKAGE AREA
IS

    FUNCTION square_area(p_a number)
    return number;
    
    FUNCTION rectangle_area(p_a number, p_b number)
    RETURN NUMBER;
    
    -- we dont have begin in package specification
    
END;

CREATE OR REPLACE PACKAGE BODY AREA
IS
    FUNCTION square_area
    (p_a number)
    RETURN NUMBER
    IS
    BEGIN
    RETURN p_a*p_a;
    END;


    FUNCTION rectangle_area
    (p_a number, p_b number)
    RETURN NUMBER
    IS
    --
    BEGIN
    RETURN p_a*p_b;
    END;

BEGIN
----- SHOULD CONTAIN A BEGIN
dbms_output.put_line('some test');
END; 


---- calling the package: AREA:------------


select area.square_area(20) from dual; 


select area.rectangle_area(4,6) from dual; 

-----------



drop function square_area;

drop function rectangle_area; 



------------------------

-- EXCERCISE WITH THE STUDENT CREATED TABLE:

-------------------------

drop table student; 

CREATE TABLE STUDENT
( 
    student_id number,
    first_name varchar2(100),
    birthday date,
    constraint student_pk primary key (student_id)
);

--------
-- BUILDING A PACKAGE WITH THE THREE DML: insert, delete, query a student, 


create sequence student_number;

drop sequence student_number;

-- BUILDING SPECIFICATION PACKAGE

CREATE OR REPLACE PACKAGE PSTUDENT
IS
    PROCEDURE insert_student(p_est_fname varchar2, p_est_birthday date);
    
    PROCEDURE delete_student(p_est_id number);
    
    FUNCTION query_student(p_est_id number)
    RETURN varchar2;
END;


-- BUILDING THE BODY FOR THE SPECIFICATION
CREATE OR REPLACE PACKAGE BODY PSTUDENT
IS
    PROCEDURE  insert_student(p_est_fname varchar2, p_est_birthday date)
    IS
    BEGIN
    INSERT INTO STUDENT VALUES (student_number.nextval, p_est_fname, TO_DATE(p_est_birthday));
    commit;
    
    EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('Erorr insertando: ');
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    END;


    PROCEDURE delete_student(p_est_id number)
    IS
    --
    BEGIN
    delete from student where STUDENT_ID=p_est_id;
    commit;
    
    EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('Error en el borrado: ');
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    END;
    
    
    FUNCTION query_student(p_est_id number)
    RETURN varchar2
    IS
    --
    variable_nombre varchar2(100);
    BEGIN
    select 'Birthday: ' || student.birthday || ' Name: ' || student.first_name INTO variable_nombre
    from student where student.student_id=p_est_id;
    return variable_nombre;
    
    EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('Error la búsqueda ');
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    return '0';
    END;
    
BEGIN
dbms_output.put_line('iNICIO DEL BLOQUE estudiante');
END;


-------------------------------------------
BEGIN
PSTUDENT.insert_student('PEDRO',TO_DATE('1992-10-25','YYYY-MM-DD'));
END;

BEGIN
PSTUDENT.delete_student(6);
END;

select PSTUDENT.query_student(2) from dual; 



BEGIN
PSTUDENT.query_student(1);
END;

--------------------------------------------

---- PACKAGE SPECIFICATION WITHOUTH A BODY

-------------------------------------------

CREATE OR REPLACE PACKAGE global_measurement
IS
    c_mile_to_km constant number:=1.6093;
    c_kilo_to_mile constant number:=0.6214;
    
END;

execute dbms_output.put_line('60 mile:= ' || 60*global_measurement.c_mile_to_km || 'KM');

---------------------------------
-- Now we can create a function that reads from this package.

CREATE OR REPLACE FUNCTION get_mile_to_km
(p_value number)
RETURN NUMBER
IS
BEGIN
    RETURN p_value*global_measurement.c_mile_to_km;
END;

----------------------------
variable v_miles number;
execute v_miles:=10;
execute dbms_output.put_line('Miles: ' || :v_miles || :v_miles*global_measurement.c_mile_to_km || 'KM');


--------------------------------------------------------
-- DEFINITION OF A FUNCTION INSIDE A PL/SQL BLOCK (in the declare section) 
-------------------------------------------------------

DECLARE
    FUNCTION get_sysdate
    RETURN DATE
    IS
    BEGIN
    RETURN SYSDATE;
    END;
BEGIN
    dbms_output.put_line(get_sysdate);
end;


----------------------------------------------------------

-----------------------------------------------------------
-------- VISIBILITY OF A PACKAGE'S COMPONENTES
-----------------------------------------------------------

CREATE OR REPLACE PACKAGE p_test
IS
c_var1 constant number:=10;
c_var2 varchar2(100):='Welcome';
PROCEDURE imprime;
END; 

CREATE OR REPLACE PACKAGE BODY p_test
IS
c_var3 varchar2(100):='hi there';
    PROCEDURE imprime
    IS
    c_var4 varchar2(100):='c_var4 variable';
    BEGIN
    dbms_output.put_line('This variable came from package spec. ' || c_var1);
    dbms_output.put_line('This variable came from package spec. ' || c_var2);
    dbms_output.put_line('This variable came from package body ' || c_var3);
    dbms_output.put_line('This variable came from print Proc ' || c_var4);
    END;
END; 


EXECUTE p_test.imprime;



---------------------------------------
create or replace package kh

is

function xx return number;

end;

--------------

create or replace package body kh

is

  function xx return number

  is

  begin

  return 10;

  end;

 

  begin

  DBMS_OUTPUT.PUT_LINE('welcome');

end;

-------

create or replace package kh

is

v number:=50;

function xx return number;

end; 


select kh.v from dual;

BEGIN
dbms_output.put_line(kh.v);
END;

------------------------

-------------------------
-- OVERLOADING SUBPROGRAMS IN PL/SQL
-------------------------

DROP TABLE customer;

CREATE TABLE customer
(
    CUST_ID NUMBER,
    nombre varchar2(100),
    birthday date
);

-- case 1 | 2, procedure differs in number of parameters

CREATE OR REPLACE PACKAGE overload_proc
IS
    PROCEDURE add_cust(p_id number, p_name varchar2, p_bd date);
    PROCEDURE add_cust(p_id number, p_name varchar2);
END; 

---------------------
CREATE OR REPLACE PACKAGE BODY overload_proc
IS
    PROCEDURE add_cust(p_id number, p_name varchar2, p_bd date)
    IS
        BEGIN
        INSERT INTO customer (cust_id, nombre, birthday) VALUES (p_id, p_name, p_bd);
        COMMIT;
    END;
    
    PROCEDURE add_cust(p_id number, p_name varchar2)
    IS  
        BEGIN
        INSERT INTO customer (cust_id, nombre) VALUES (p_id, p_name);
        COMMIT;
    END;
END; 

execute overload_proc.add_cust(1,'azeem',date '1992-10-22');

execute overload_proc.add_cust(1,'oscar');

select * from customer;


------------------------------------------------------------
--------------- CASE 2 (2 PROCEDURE SAME NUMBER of parameters, differ in type)
------------------------------------------------------------
CREATE OR REPLACE PACKAGE overload_proc
IS
    PROCEDURE add_cust(p_id number, p_name varchar2, p_bd date);
    PROCEDURE add_cust(p_id number, p_name varchar2);
    PROCEDURE add_cust(p_name varchar2, p_id number);
END;

-----------------------
CREATE OR REPLACE PACKAGE BODY overload_proc
IS
    PROCEDURE add_cust(p_id number, p_name varchar2, p_bd date)
    IS
    BEGIN
    INSERT INTO customer(cust_id, nombre, birthday) VALUES (p_id,p_name,p_bd);
    COMMIT;
    END;

    PROCEDURE add_cust(p_id number, p_name varchar2)
    IS
    BEGIN
    INSERT INTO customer (cust_id, nombre) VALUES (p_id,p_name);
    COMMIT;
    END;
    
    PROCEDURE add_cust(p_name varchar2, p_id number)
    IS
    BEGIN
    INSERT INTO customer (nombre, cust_id) VALUES (p_name, p_id);
    COMMIT;
    END;
END;

---------------------------------------------------------------

execute overload_proc.add_cust(11,'azeem',date '1992-10-22');

execute overload_proc.add_cust(12,'oscar');

execute overload_proc.add_cust('AZEEM',13);

select * from customer;


------------------------------------------------------------
------------------ CASE 3 (2 PROCEDURE SAME NUMBER OF PARAMETERS, SAME FAMILY)
------------------------------------------------------------

CREATE OR REPLACE PACKAGE overload_proc
IS
    PROCEDURE add_cust(p_id number, p_name varchar2, p_bd date);
    PROCEDURE add_cust(p_id integer, p_name varchar2, p_bd date);
END;

-------------------------------------------
CREATE OR REPLACE PACKAGE BODY overload_proc
IS
    PROCEDURE add_cust(p_id number, p_name varchar2, p_bd date)
    IS
    BEGIN
    INSERT INTO customer(cust_id, nombre, birthday) VALUES (p_id,p_name,p_bd);
    COMMIT;
    END;
    
    PROCEDURE add_cust(p_id integer, p_name varchar2, p_bd date)
    IS
    BEGIN
    INSERT INTO customer(cust_id,nombre,birthday) VALUES (p_id,p_name,p_bd);
    COMMIT;
    END;
END; 


execute overload_proc.add_cust(21,'azeem',date '1992-10-22');


execute overload_proc.add_cust(22.21,'azeem',date '1992-10-22');

select * from customer;


-------------------------------------------------
----------- OVERLOADING FUNCTIONS
--------------------------------------------------

-- function case 1
CREATE OR REPLACE PACKAGE overload_function
IS
    FUNCTION f1 (p1 number) return number;
    FUNCTION f1 (p1 number) return varchar2;
END;

-----------------------------------------

CREATE OR REPLACE PACKAGE BODY overload_function
IS
    FUNCTION f1 (p1 number) return number
    IS
    BEGIN
    RETURN p1;
    END;
    
    FUNCTION f1 (p1 number) return varchar2
    IS
    BEGIN
    RETURN p1||' added string';
    END;
END;
   
   
SELECT overload_function.f1(1) from dual;

--------------------------------------------------------
--------------- FOWARD DECLARATION---------------------
-------------------------------------------------------
CREATE OR REPLACE PACKAGE proc_rules_calling
IS
    PROCEDURE print_emp_details(p_emp_id number);
END;

-----------------------------------------------------
CREATE OR REPLACE PACKAGE BODY proc_rules_calling
IS
    FUNCTION get_no_work_days (p_emp_id number)
    RETURN NUMBER
    IS
    -- VARIABLE DECLARATION
    v_hiredate date;
    BEGIN
        SELECT hire_date into v_hiredate from employees where employee_id=p_emp_id;
        RETURN round(sysdate-v_hiredate);
    END;
    
    PROCEDURE print_emp_details (p_emp_id number)
    IS
    -- VARIABLE DECLARTION
    -- we will call the function from this procedure
    -- so it should be defined above in order to invoke it
    v_details employees%rowtype;
    BEGIN 
        SELECT * INTO v_details FROM employees WHERE employee_id=p_emp_id;
        dbms_output.put_line('id: ' || v_details.employee_id);
        dbms_output.put_line('fname: ' || v_details.first_name);
        dbms_output.put_line('salary: ' || v_details.salary);
        dbms_output.put_line('hire date: ' || v_details.hire_date);
        dbms_output.put_line('actual date: ' || sysdate);
        dbms_output.put_line('no of worked days: ' || get_no_work_days(v_details.employee_id));
    END;
END;     
        
        
-----------------------------------------------
-- calling: proc_rules_calling


execute proc_rules_calling.print_emp_details (10);

BEGIN
proc_rules_calling.print_emp_details (100);
END;

------------------------------------------------

--- EXAMPLE WITH FORWARD DECLARATION

------------------------------------------------

DROP PACKAGE proc_rules_calling; 

CREATE OR REPLACE PACKAGE proc_rules_calling
IS
    PROCEDURE print_emp_details(p_emp_id number);
END;


-----------------------------------------------------
CREATE OR REPLACE PACKAGE BODY proc_rules_calling
IS
    FUNCTION get_no_work_days (p_emp_id number)
    RETURN NUMBER; -- we can just put the function specification only
   
    
    PROCEDURE print_emp_details (p_emp_id number)
    IS
    -- VARIABLE DECLARTION
    -- we will call the function from this procedure
    -- so it should be defined above in order to invoke it
    v_details employees%rowtype;
    BEGIN 
        SELECT * INTO v_details FROM employees WHERE employee_id=p_emp_id;
        dbms_output.put_line('id: ' || v_details.employee_id);
        dbms_output.put_line('fname: ' || v_details.first_name);
        dbms_output.put_line('salary: ' || v_details.salary);
        dbms_output.put_line('hire date: ' || v_details.hire_date);
        dbms_output.put_line('actual date: ' || sysdate);
        dbms_output.put_line('no of worked days: ' || get_no_work_days(v_details.employee_id));
    END;
    
    FUNCTION get_no_work_days (p_emp_id number)
    RETURN NUMBER
     IS
    -- VARIABLE DECLARATION
    v_hiredate date;
    BEGIN
        SELECT hire_date into v_hiredate from employees where employee_id=p_emp_id;
        RETURN round(sysdate-v_hiredate);
    END;
    
    
    
END;     
       
-------------------------------------------------
-- calling: proc_rules_calling WITH FOWARD DECLARATION


execute proc_rules_calling.print_emp_details (10);

BEGIN
proc_rules_calling.print_emp_details (100);
END;

------------------------------------------------
-----------------------------------------------
--------- PERSISTENT STATE PACKAGE---------------
-------

DROP PACKAGE persistent_state;

-- PACKAGE DEFINITION--
CREATE OR REPLACE PACKAGE persistent_state
IS
    -- declaring the global variable
    g_var number:=10;
    PROCEDURE update_g_var (p_no number);
END;




CREATE OR REPLACE PACKAGE BODY persistent_state
IS
    PROCEDURE update_g_var (p_no number)
    IS
    BEGIN
    g_var:=p_no;
    dbms_output.put_line(g_var);
    END;
END;

--------------------------------------------
----- EXECUTING PERSISTENT STATE -----------
--------------------------------------------




EXECUTE persistent_state.update_g_var(80);

variable test number;

execute :test:=persistent_state.g_var;

print test;

---------------
DECLARE
x number;
BEGIN
x:=persistent_state.g_var;
dbms_output.put_line(x);
END; 





--------------------------------------------

----------------------------------------------
----------- Persistent State of Packages USING PRAGMA SERIALLY_REUSABLE;
----------------------------------------------

-- package definition

CREATE OR REPLACE PACKAGE persistent_state
IS
PRAGMA SERIALLY_REUSABLE;
g_var number:=10;
PROCEDURE update_g_var(p_no number);
END; 


-- package body

CREATE OR REPLACE PACKAGE BODY persistent_state
IS
    PRAGMA SERIALLY_REUSABLE;
    PROCEDURE update_g_var(p_no number)
    IS
        BEGIN
        g_var:=p_no;
        dbms_output.put_line(g_var);
        END;
END; 
        
-------------------------------------

--- executing persistent state pragma serially_reusable

execute persistent_state.update_g_var(90);

variable test number;

execute :test:=persistent_state.g_var;

print test


-----

DECLARE
x number;
BEGIN
x:=persistent_state.g_var;
dbms_output.put_line(x);
END; 

--------------------------------------------
--------------------------
----------------- PERSISTENT STATE AND CURSORS -----------
------------------------

--- package definition
CREATE OR REPLACE PACKAGE cur_pkg
IS
    -- global cursor declared
    CURSOR c_emp IS
    SELECT employee_id FROM EMPLOYEES;
    
    PROCEDURE abierto;
    PROCEDURE cerrado;
    PROCEDURE printnext_20;
END; 

--- package body
CREATE OR REPLACE PACKAGE BODY cur_pkg IS
    PROCEDURE abierto
    IS
        BEGIN
        IF NOT c_emp%isopen THEN
        open c_emp;
        end if;
        --END abierto;
    END; 
        -----------------
        
    PROCEDURE cerrado
    IS
        BEGIN
        IF c_emp%isopen THEN
        close c_emp;
        END IF;
        --END cerrado;
    END; 
    
    PROCEDURE printnext_20
    IS
        v_emp_id number;
        BEGIN
            FOR i in 1..20
            LOOP
                FETCH c_emp INTO v_emp_id;
                dbms_output.put_line(v_emp_id);
                    IF c_emp%notfound then dbms_output.put_line('baby dont hurt me, no more');
                        close c_emp;
                    EXIT;
                    END IF;
            END LOOP;
        END; --END printnext_20
        
END; 
-----------------------
-- EXECUTING: cur_pkg  
-----------------------

BEGIN
cur_pkg.abierto;
cur_pkg.printnext_20;
end;

BEGIN
cur_pkg.cerrado;
END; 

----------------------------------------------------


--using pl/sql tables in packages
create or replace package emp_pkg
is
type emp_table_type is table of employees%rowtype
index by binary_integer;

procedure get_employees(p_emps out emp_table_type );

end;
-------------------------------
create or replace package body emp_pkg
is
  procedure get_employees(p_emps out emp_table_type )
  is
  begin
    for emp_record in (select * from employees)
    loop
   p_emps( emp_record.employee_id):=emp_record;
    end loop;

  end;
end;
-----------------------------------
declare
v_employees emp_pkg.emp_table_type;
begin
emp_pkg.get_employees(v_employees);
dbms_output.put_line(v_employees(101).first_name);
dbms_output.put_line(v_employees(200).last_name);
end;

-----------------------------------

--- DBMS output

------------------

-- Excersise buffer ---

DECLARE
BUFFER varchar2(100);
status INTEGER;
v varchar2(3000);
BEGIN
    dbms_output.put_line('Linea 1');
    dbms_output.put_line('Linea 2');
    dbms_output.put_line('Linea 3');
    FOR i in 1..3
    LOOP
    dbms_output.get_line(buffer,status);
    v:=v||buffer||chr(10);
    END LOOP;
    dbms_output.put_line(v);
END;


------------------------------------------

-- EXAMPLE DBMS_OUTPUT AND CHARARR;
------------------------------------------
DECLARE
BUFFER  dbms_output.chararr;
-- type chararr is table of varchar2(32767) index by binary_integer
v_line INTEGER;
BEGIN
v_line:=10;
    dbms_output.put_line('Line 1');
    dbms_output.put_line('Line 2');
    dbms_output.put_line('Line 3');
    dbms_output.put_line('Line 4');
    dbms_output.get_lines(buffer, v_line);
    dbms_output.put_line(buffer(4));
    dbms_output.put_line(buffer(3));
    dbms_output.put_line(buffer(2));
    dbms_output.put_line(buffer(1));
END;

----------------------------------------------

---------------------------------------------
--------- UTL_FILE---------------------
---------------------------------------------

/*

*/
-- in the sqlplus
alter session set container=orclpdb;
---
 create directory midirectorio as 'C:\Users\xmy9080\Desktop\test';
--
grant read, write on DIRECTORY midirectorio to public; 

---------------------------------
------ READING A FILE WITH THE: UTL_FILE
---------------------------------

DECLARE
l_file UTL_FILE.file_type;
l_location  VARCHAR(100):='MIDIRECTORIO'; ---CAPITAL LETTERS
l_filename  VARCHAR(100):='sample.txt';
l_text      VARCHAR2(32767);

BEGIN
--open file
    l_file :=UTL_FILE.fopen(l_location, l_filename,'r');
-- Read and output the first line
UTL_FILE.get_line(l_file,l_text);
DBMS_OUTPUT.put_line('First line' || l_text);
UTL_FILE.get_line(l_file,l_text);
DBMS_OUTPUT.put_line('Second line' || l_text);
-- Close the file
UTL_FILE.fclose(l_file);
END;

--- Show all directories ---
select * from ALL_DIRECTORIES;

--- 

-------------------------------------
---------- PUT LINE (CREATING A TEXT FILE IN THE OPERATING SYSTEM) ----------
-------------------------------------

DECLARE
l_file UTL_FILE.file_type;
l_location  VARCHAR(100):='MIDIRECTORIO'; ---CAPITAL LETTERS
l_filename  VARCHAR(100):='sample2.txt';
l_text      VARCHAR2(32767);

BEGIN
--open file for writting
    l_file :=UTL_FILE.fopen(l_location, l_filename,'w');
    FOR i IN (select * from DEPARTMENTS)
    LOOP
    UTL_FILE.put_line(l_file,i.DEPARTMENT_name);
    END LOOP;

    UTL_FILE.fclose(l_file);
    
    
    -- open file for append
    l_file:=UTL_FILE.fopen(l_location, l_filename, 'A');
    UTL_FILE.put_line(l_file, 'Additional lines');
    UTL_FILE.fclose(lfile);
    
    
END; 

-------------------------------------------------------------------------------
------ EXAMPLE UTL_FILE PROCEDURE

------------------------------------------

CREATE OR REPLACE PROCEDURE read_any_file
(P_dir in varchar2, p_file_name in varchar2)
IS
-- variable declaration section
l_file  UTL_FILE.file_type;
l_text  VARCHAR2(32767);
BEGIN
    l_file:=UTL_FILE.fopen(P_dir,p_file_name,'r');
    BEGIN
        LOOP
        UTL_FILE.get_line(l_file,l_text);
        DBMS_OUTPUT.put_line(l_text);
        END LOOP;
        
        EXCEPTION
        WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('END FILE');
        UTL_FILE.fclose(l_file);
    END;
    
    EXCEPTION
    WHEN UTL_FILE.invalid_operation THEN
    dbms_output.put_line('can not open the file, invalid file name');
    WHEN UTL_FILE.read_error THEN
    dmbs_output.put_line('can not be read');

END read_any_file;

--- executing---
execute read_any_file('MIDIRECTORIO', 'sample2.txt');

execute read_any_file('MIDIRECTORIO','sample3.txt');

-------------------------------------------------------

------------

-------------------------------------------------------


-- DYNAMIC SQL
---

drop table emp1;

drop table emp2;

create table emp1 (emp_id number);

create table emp2 (emp_id number);

BEGIN
INSERT INTO emp1 values(1);
INSERT INTO emp1 values(2);
INSERT INTO emp1 values(3);

INSERT INTO emp2 values(1);
INSERT INTO emp2 values(2);
INSERT INTO emp2 values(3);


COMMIT;
END;

select * from emp1;

select * from emp2;


CREATE OR REPLACE PROCEDURE delete_any_table
(p_table_name varchar2)
IS
v_no_rec number;
BEGIN
EXECUTE IMMEDIATE 'delete from ' || p_table_name;
v_no_rec:=sql%rowcount;
commit;
dbms_output.put_line(v_no_rec || ' record(s) where deleted from ' || p_table_name);
END;

-- EXECUTING THE PROCEDURE---

BEGIN
delete_any_table('emp2');
END;

-- OR ALSO CAN BE---
execute delete_any_table('emp2');


-------------------------------------------------


----- DDL AND DCL EXAMPLES
--- DDL AND DCL arent allowed in a PL/SQL block
-- we also should use execute immediate

-------------------------------------------------


DROP TABLE emp3;

SELECT * FROM EMP3;

-- showing that you cant use ddl and dcl statemetns inside a plsql block. 

BEGIN
CREATE TABLE emp3 (emp_id number);
END;

---
BEGIN
-- there is no need for ; at the end of the statement
--EXECUTE IMMEDIATE 'CREATE table emp3 (emp_id number)';


EXECUTE IMMEDIATE 'CREATE table emp4 (emp_id number, name varchar2(100))';

END; 


SELECT * FROM emp3;

----------------------------------------


------------------------------------------

--- BUILDING the procedure: create_any_table

------------------------

CREATE OR REPLACE PROCEDURE create_any_table
(p_table_name varchar2, p_details varchar2)
IS
-- variable declaration
v_details varchar2(30000);
BEGIN
v_details:='CREATE table ' || p_table_name ||  ' ('  || p_details  || ')' ;
dbms_output.put_line(v_details);
EXECUTE IMMEDIATE v_details;
END;

------------------------------------------

--- EXECUTING the procedure: create_any_table

------------------------

GRANT ALL ON create_any_table TO public;

execute create_any_table ('emp4', 'emp_id number, name varchar2(100)');

execute create_any_table('emp4', 'emp_id number');


---- or can be

BEGIN
create_any_table('emp4', 'emp_id number');
END; 

-------------------------------------

------------------------------------------

--- BUILDING the procedure: create_any_table and exception when the object already exists.

------------------------

CREATE OR REPLACE PROCEDURE create_any_table_and_questions_drop
(p_table_name varchar2, p_details varchar2)
IS
-- variable declaration
e_already_existing_object exception;
pragma exception_init(e_already_existing_object,-955);

---

v_details varchar2(30000);
-- 0=no, 1 =si
v_si_no number:=0;
-- var to drop
v_dropping varchar2(100);
-- var already p_already_dropped
v_already_dropped number:=0;

BEGIN
v_details:='CREATE table ' || p_table_name ||  ' ('  || p_details  || ')' ;
dbms_output.put_line(v_details);
EXECUTE IMMEDIATE v_details;
dbms_output.put_line('El objeto: ' || p_table_name || ' was CREATED');


EXCEPTION

    WHEN e_already_existing_object then
    dbms_output.put_line('El objeto: ' || p_table_name || ' already exists');
    	v_dropping:='DROP TABLE ' || p_table_name;
    	EXECUTE IMMEDIATE v_dropping;
    	dbms_output.put_line('El objeto: ' || p_table_name || ' was dropped');


    
    
    WHEN OTHERS THEN

    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);

END;


------------------------



BEGIN
create_any_table_and_questions_drop('emp4', 'emp_id number');
END; 


---------------------------------

-- EXECUTE IMMEDIATE WHEN USING

DELETE FROM emp1;

select * from emp1;

-- this procedure can work with any table which contain one column and this column should be number.

CREATE OR REPLACE PROCEDURE add_rows
(p_table_name varchar2, p_value number)
IS
BEGIN
-- EXECUTE IMMEDIATE 'insert into ' || p_table_name || ' values ('||p_value||') ';
dbms_output.put_line('insert into ' || p_table_name || ' values(:1)  using ' || p_value);
EXECUTE IMMEDIATE 'insert into ' || p_table_name || ' values(:1) ' USING p_value;
END;

execute add_rows('emp1',10);

select * from emp1;

-----------------------------

---------------------------------

-- EXECUTE IMMEDIATE WHEN USING

CREATE OR REPLACE PROCEDURE add_rows
(p_table_name varchar2, p_value number)
IS
val1 number:=20;
val2 number:=30;
BEGIN
EXECUTE IMMEDIATE 'insert into ' || p_table_name || ' values(:1) ' USING p_value;
EXECUTE IMMEDIATE 'insert into ' || p_table_name || ' values(:yy) ' USING val1;
EXECUTE IMMEDIATE 'insert into ' || p_table_name || ' values(:uuu) ' USING val2;
END;



execute add_rows('emp1',10);

-------------------
-- EXECUTE IMMEDIATE EXAMPLE INTO CLAUSE
--------------------

-- DYNAMIC SQL WITH SINGLE ROW QUERY
DECLARE
v_ename varchar2(100);
BEGIN
EXECUTE IMMEDIATE 'select first_name from employees where employee_id=100'
    INTO v_ename;
dbms_output.put_line(v_ename);
END;

select first_name from employees where employee_id=100;

-----
DECLARE
v_ename varchar2(100);
vno number:=200;
BEGIN
EXECUTE IMMEDIATE 'select first_name from employees where employee_id=:c'
    INTO V_ENAME USING vno; --note: the into clause should be used first then the using clause
DBMS_OUTPUT.PUT_LINE(v_ename);
END;

----------------------------

-- EXAMPLE: SINGLE ROW MULTIPLE DIMENSIONS
-- INTO AND %ROWTYPE COMBINATION
----------------------------

CREATE OR REPLACE FUNCTION get_emp
(p_id NUMBER)
RETURN employees%rowtype
IS
emp_rec employees%rowtype;
BEGIN
    SELECT * INTO emp_rec
    FROM employees
    WHERE employee_id=p_id;
    
RETURN emp_rec;
end;

---

-- you cannot use this function in select, because it retrieve %ROWTYPE
select get_emp(100) from dual;

-- IN ORDER TO USE THE FUNCTION get_emp in a PL/SQL statement should be declared as following (using scalars):

DECLARE
emp_rec employees%rowtype;
BEGIN
--calling the get_emp function
emp_rec:=get_emp(100);
dbms_output.put_line(emp_rec.employee_id || ' ' || emp_rec.first_name);
END;

----------------------------------------
-- EXAMPLE: DYNAMIC SQL WITH A SINGLE ROW QUERY
-- %ROWTYPE, USING, EXECUTE IMMEDIATE, INTO
----------------------------------------

CREATE OR REPLACE FUNCTION get_emp2
(p_id number)
RETURN employees%ROWTYPE
IS
emp_rec employees%rowtype;
v_query varchar2(1000);
BEGIN
    v_query:='select * from employees where employee_id=:1';
    EXECUTE IMMEDIATE v_query INTO emp_rec USING p_id;
    return emp_rec;
END;    

-- -- -- -- -- -- 
-- EXECUTING THE GET_EMP2 function
-----------------


DECLARE
v_emp_rowtype employees%rowtype;
BEGIN
v_emp_rowtype:=get_emp2(102);
dbms_output.put_line(v_emp_rowtype.employee_id || ' ' || v_emp_rowtype.last_name);
END;

select * from employees;

--------------------------------
---- DYNAMIC SQL WITH MULTI ROW QUERY
--- REF CURSOR
---------------------------------

-- Reviewing the normal cursor.
DECLARE
    CURSOR c_emp_dept30 IS
    SELECT employee_id, first_name FROM employees
    WHERE department_id=30;
    
    v_empno employees.employee_id%type;
    v_first_name employees.first_name%type;
    
BEGIN
OPEN c_emp_dept30;

    LOOP
        FETCH c_emp_dept30 INTO v_empno, v_first_name;
        EXIT WHEN c_emp_dept30%notfound;
        dbms_output.put_line(v_empno || ' ' || v_first_name);
    END LOOP;
CLOSE c_emp_dept30;
END;

----------------------------------------------------
--- REF CURSOR EXAMPLE
----------------------------------------------------

-- The REF cursor can be opened many times with different queries

DECLARE
TYPE c_emp_dept IS REF CURSOR;
d_cursor c_emp_dept;

    v_empno employees.employee_id%type;
    v_first_name employees.first_name%type;
    
BEGIN
OPEN d_cursor FOR SELECT employee_id, first_name
                    FROM employees
                    WHERE department_id=10;
                    
    LOOP
        FETCH d_cursor INTO v_empno, v_first_name;
        EXIT WHEN d_cursor%notfound;
        dbms_output.put_line(v_empno || ' ' || v_first_name);
    END LOOP;
CLOSE d_cursor;

OPEN d_cursor FOR SELECT employee_id, first_name
            FROM employees
            WHERE department_id=30;
    LOOP
        FETCH d_cursor INTO v_empno, v_first_name;
        EXIT WHEN d_cursor%notfound;
        dbms_output.put_line(v_empno || ' ' || v_first_name);
    END LOOP;
CLOSE d_cursor;

END;


-----------
-- DYNAMIC SQL WITH MULTI ROW QUERY
CREATE OR REPLACE PROCEDURE emp_list (p_dept_id number default null)
IS
-- type are variable types declared by the user. 
TYPE c_emp_dept IS REF CURSOR;
d_cursor c_emp_dept;
v_empno employees.employee_id%type;
v_first_name employees.first_name%type;
v_sql varchar2(1000):='select employee_id, first_name from employees';

-- END OF VARIABLE DECLARATION

BEGIN
    IF p_dept_id IS NULL THEN
    OPEN d_cursor FOR v_sql;
    ELSE
    v_sql:=v_sql||' where department_id=:id';
    -- with the FOR statement you can specify the query
    OPEN d_cursor FOR v_sql USING p_dept_id;
    END IF;
    
        LOOP
        FETCH d_cursor INTO v_empno, v_first_name;
        EXIT WHEN d_cursor%notfound;
        dbms_output.put_line(v_empno||' ' || v_first_name);
        END LOOP;
    CLOSE d_cursor;
END;
-- Getting all the employees
execute emp_list;

-- Getting all the employees in a specific department
execute emp_list(30);

select * from employees;


--- EXECUTE IMMEDIATE / MORE EXAMPLES

DECLARE
    v_code varchar2(100):=
    'BEGIN
    dbms_output.put_line(''welcome'');
    end;
    ';
BEGIN
    EXECUTE IMMEDIATE v_code;
END;

--------------------------------------

-- We can do this STATEMENT to compile a procedure
ALTER PROCEDURE ADD_ROWS compile;

ALTER FUNCTION GET_SAL compile;

------------------------------------
--
--- EXAMPLE COMPILE ANY PROCEDURE 
------------------------------------

CREATE OR REPLACE PROCEDURE compile_any_plsql
(p_name varchar2, p_type varchar2, p_option varchar2 default null)
IS
    v_comp_code varchar2(1000):=
    'alter ' || p_type || ' ' ||p_name|| ' compile ' || p_option;
BEGIN
dbms_output.put_line(v_comp_code);
EXECUTE IMMEDIATE v_comp_code;
END;

-----------------------------------
--- executing the compile_any_plsql
-----------------------------------

EXECUTE compile_any_plsql ('AREA', 'package', 'specification');
EXECUTE compile_any_plsql ('AREA', 'pacakge', 'body');
EXECUTE compile_any_plsql ('ADD_ROWS','procedure');
EXECUTE compile_any_plsql ('GET_SAL','function');

-------------------------------
--- DBMS_SQL PACKAGE VS EXECUTE IMMEDIATE
-------------------------------

--- example using DBMS_SQL

CREATE OR REPLACE PROCEDURE delete_any_table2
(p_table_name varchar2)
IS
v_no_rec number;
v_cur_id number; -- CURSOR ID
BEGIN
v_cur_id:=dbms_sql.open_cursor;
dbms_sql.parse(v_cur_id,'delete from ' ||p_table_name, dbms_sql.native);
v_no_rec:=dbms_sql.execute(v_cur_id);
dbms_output.put_line(v_no_rec || ' record(s) were deleted from ' || p_table_name);
COMMIT;
END;



select * from emp2;
select * from emp1;


execute delete_any_table2('emp1');

--------------------------------------------
-- using dbms_sql for the add_rows procedure
--------------------------------------------

CREATE OR REPLACE PROCEDURE add_rows2
(p_table_name varchar2, p_value number)
IS
-- CURSOR DECLARATION
v_no_rec number;
v_cur_id number;
v_calling_query varchar2(300);
BEGIN
v_cur_id:=dbms_sql.open_cursor;
v_calling_query:='insert into ' ||p_table_name || ' values(' || p_value ||');';
dbms_output.put_line(v_calling_query);
dbms_sql.parse(v_cur_id,'insert into ' ||p_table_name || ' values(' || p_value ||')',dbms_sql.native);

--dbms_sql.parse(v_cur_id,'delete from ' ||p_table_name, dbms_sql.native);

v_no_rec:=dbms_sql.execute(v_cur_id);
dbms_output.put_line(v_no_rec||' record(s) were inserted from ' || p_table_name);
COMMIT;
END;

-- EXECUTING ADD_ROWS2
EXECUTE add_rows2('emp1',20);


select * from emp2;
select * from emp1;

----------------------------
-- Exersise: DBMS_SQL with BIND variable. 
----------------------------

CREATE OR REPLACE PROCEDURE add_rows2_bind_variable
(p_table_name varchar2, p_value number)
IS
v_no_rec number;
v_cur_id number;
V_INSERT varchar2(1000):='INSERT INTO ' ||p_table_name||' VALUES (:ID)'; --why dont use =: ?
BEGIN
v_cur_id:=dbms_sql.open_cursor;
dbms_sql.parse(v_cur_id,V_INSERT,dbms_sql.native);
dbms_sql.BIND_VARIABLE(v_cur_id,':ID', p_value);
v_no_rec:=dbms_sql.execute(v_cur_id);
dbms_output.put_line(v_no_rec || ' record(s) were INSERTO TO ' ||p_table_name);
COMMIT;
END;

--- 
--- EXECUTING: add_rows2_bind_variable
---

execute add_rows2_bind_variable('emp1',90);


--------------------------------------------
----- EXEPTION HANDILNG
--------------------------------------------

DELETE FROM departments;

select * from departments;

----- 1 EXAMPLE
DECLARE
e_fk_err exception;
PRAGMA EXCEPTION_INIT (e_fk_err, -02292);
BEGIN
	DELETE FROM departments;
EXCEPTION
	WHEN e_fk_err THEN
	RAISE_APPLICATION_ERROR(-20001,'my error');
END;



-- SEcond example
DECLARE
e_fk_err EXCEPTION;
PRAGMA EXCEPTION_INIT (e_fk_err,-02292);
BEGIN
	DELETE FROM departments;
EXCEPTION
	WHEN e_fk_err THEN
	RAISE_APPLICATION_ERROR (-20001,'my error',true);
END;

-------------------------------------------
---- Definer's Rights Versus Invoker's Rights
-------------------------------------------

--- DEFINER RIGHTS EXAMPLE.

select * from hr_table;

DROP TABLE hr_table;

select * from all_procedures where OWNER='HR';

select * from all_procedures where OWNER='HR'
order by OBJECT_NAME;


CREATE TABLE hr_table
(
    id number,
    name varchar2(100)
);


CREATE OR REPLACE PROCEDURE add_hr_table
(p_id number, p_name varchar2)
IS
BEGIN
INSERT INTO hr_table VALUES (p_id, p_name);
END;

---- 

-- GRANT PERMISSIONS TO AN EXTERNAL USER TO EXECUTE THE add_hr_table PROCEDURE
GRANT EXECUTE ON add_hr_table TO FORD;

-- Granting permissions to a function: 
GRANT EXECUTE ON get_sal TO FORD;



commit;

--------------------------------------------------------------------------------


--- INVOKER'S RIGHTS---
--- EXAMPLE


select * from hr_table;

-- NOW USER HR will create the procedure again but adding authid current_user
CREATE OR REPLACE PROCEDURE add_hr_table_auth_id
(p_id number, p_name varchar2) authid current_user
IS
BEGIN
INSERT INTO hr.hr_table values (p_id,p_name);
END;

-- granting permissons to FORD

GRANT EXECUTE ON add_hr_table_auth_id TO FORD;

-- GRANTING PERMISSONS To the hr.hr_table values table

GRANT INSERT,DELETE,UPDATE ON HR.HR_TABLE TO FORD;

-- revoking permissions

REVOKE  INSERT,DELETE,UPDATE ON HR.HR_TABLE FROM FORD;

-- declaring the add_hr_table_auth_id procedure with the default: AUTHID DEFINER

CREATE OR REPLACE PROCEDURE add_hr_table_auth_id
(p_id number, p_name varchar2)  AUTHID DEFINER
IS
BEGIN
INSERT INTO hr.hr_table values (p_id,p_name);
END;


GRANT DROP ANY TABLE ON HR.HR_TABLE TO FORD;



select * from  HR.HR_TABLE;


------------------------------------------------
---- AUTONOMOUS TRANSACTIONS
--------------------

-- CASE ONE WITHOUT USING PRAGMA AUTONOMOUS_TRANSACTION

DROP TABLE tt;

CREATE TABLE tt (test_value varchar2(25));

CREATE OR REPLACE PROCEDURE child_block IS
BEGIN
    INSERT INTO tt(test_value)
    VALUES
        ('child block insert');
    COMMIT;
END child_block;

CREATE OR REPLACE PROCEDURE parent_block IS
BEGIN
    INSERT INTO tt(test_value)
    VALUES ('Parent block insert');
    
child_block;
ROLLBACK; -- <- this rollback has no effect due to the first commit (parent commit)
END parent_block; 

-- EXECUTING

EXECUTE parent_block;

-- check the results;
select * from tt;

-----------------------------------------------------------
---- CASE 2 AUTONOMOUS_TRANSACTION
-----------------------------------------------------


DROP TABLE tt;

CREATE TABLE tt (test_value varchar2(25));

CREATE OR REPLACE PROCEDURE child_block IS
PRAGMA AUTONOMOUS_TRANSACTION; -- <- EACH TRANSACTION IS INDEPENDENT
BEGIN
    INSERT INTO tt(test_value)
    VALUES
        ('child block insert');
    COMMIT;
END child_block;

CREATE OR REPLACE PROCEDURE parent_block IS
BEGIN
    INSERT INTO tt(test_value)
    VALUES ('Parent block insert');
    
child_block;
ROLLBACK; -- <- this rollback has NOW effect due to the first commit (parent commit)
END parent_block; 

-- EXECUTING

EXECUTE parent_block;

-- check the results;
select * from tt;


------------------------------

-------------------------------------------
---- VARIABLES BY VALUE AND BY REFERENCE--
-----------------------------------------------------

-- 1 IN parameter always passed by reference

CREATE OR REPLACE PROCEDURE pass_by_ref -- 1 IN parameter always passed by reference
(p_id in number) -- p_id called formal parameter
IS
BEGIN
--p_id:=555; --this is not valid
dbms_output.put_line(p_id);
end;

EXECUTE pass_by_ref(10);

--- PASING BY VALUE

CREATE OR REPLACE PROCEDURE pass_by_ref_value -- in out values are pased by value
(p_id in out number) -- p_id called formal parameter
IS
BEGIN
dbms_output.put_line(p_id);
p_id:=p_id+1; --this is not valid

end;

EXECUTE pass_by_ref_value(10); 
-- ?? why when executing it gives you error: TO_NUMBER(SQLDEVBIND1Z_1)
-- Because it's an OUT parameter! It should be returned! you cant call the procedure
-- Jus with execute. 


-- Solving the last example giving a returning variable.

declare
v_return number:=30;
BEGIN
pass_by_ref_value(v_return);
dbms_output.put_line('The value returned is: ' || v_return);
END;







-----------------------
-- example passed by value:
----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE pass_by_value1
(p_id IN OUT number)
IS 
BEGIN
    p_id:=p_id*10;
    /*if p_id>100 THEN
    RAISE VALUE_ERROR;
    END IF;*/
END;

----
-- executing from a SP
---

DECLARE
v number:=11; 
BEGIN
dbms_output.put_line('Original valor: ' || v);
pass_by_value1(v);
dbms_output.put_line('After calling valor: ' || v);

dbms_output.put_line('No issue ' ||v);
EXCEPTION
WHEN VALUE_ERROR THEN
dbms_output.put_line('exception ' || v);
END;




-----------------------
-- example passed by value AND NOCOPY
----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE pass_by_value2
(p_id IN OUT NOCOPY number)
IS 
BEGIN
    p_id:=p_id*10;
    if p_id>100 THEN
    RAISE VALUE_ERROR;
    END IF;
END;

----
-- executing from a SP
---

DECLARE
v number:=11; 
BEGIN
pass_by_value2(v);
dbms_output.put_line('No issue ' ||v);
EXCEPTION
WHEN VALUE_ERROR THEN
dbms_output.put_line('exception ' || v);
END;

--------------------------------------------------
----- NOCOPY WILL HAVE NO EFFECTS
--- CASE 1

CREATE OR REPLACE PROCEDURE pass_by_value3
(p_id IN OUT NOCOPY number)
IS 
BEGIN
    p_id:=p_id*10;
    if p_id>100 THEN
    RAISE VALUE_ERROR;
    END IF;
END;

----
-- executing from a SP
---

DECLARE
v number(10):=20; -- IF THE ACTUAL parameter has size (for number only) nocopy will not work
BEGIN
pass_by_value3(v);
dbms_output.put_line('No issue ' ||v);
EXCEPTION
WHEN VALUE_ERROR THEN
dbms_output.put_line('exception ' || v);
END;

-------------------------------
--- CASE 2
--------------------------------

CREATE OR REPLACE PROCEDURE pass_by_value4
(p_id IN OUT NOCOPY number)
IS 
BEGIN
    p_id:=p_id*10;
    if p_id>100 THEN
    RAISE VALUE_ERROR;
    END IF;
END;

----
-- executing from a SP
---

DECLARE
v number NOT NULL:=20; 
BEGIN
pass_by_value4(v);
dbms_output.put_line('No issue ' ||v);
EXCEPTION
WHEN VALUE_ERROR THEN
dbms_output.put_line('exception ' || v);
END;

-------------------------------
--- CASE 3: IMPORTANT
-------------------------------

CREATE OR REPLACE PROCEDURE pass_by_value5
(p_id IN OUT NOCOPY varchar2)
IS 
BEGIN
    p_id:=p_id*10;
    if p_id>100 THEN
    RAISE VALUE_ERROR;
    END IF;
END;

----
-- executing from a SP
---

DECLARE
v number:=20; -- IF THE ACTUAL NEEDS AN IMPLICIT CONVERSION, NOCOPY wont work. 
BEGIN
pass_by_value5(v);
dbms_output.put_line('No issue ' ||v);
EXCEPTION
WHEN VALUE_ERROR THEN
dbms_output.put_line('exception ' || v);
END;


---------------------
--- NO COPY PERFORMANCE EXERCISE
----------------------

CREATE OR REPLACE PACKAGE nocopy_test
IS
TYPE number_t IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;
PROCEDURE pass_by_value(nums in out number_t);
PROCEDURE pass_by_reference(nums in out nocopy number_t);
PROCEDURE init;
END;

----------------------------------
CREATE OR REPLACE PACKAGE BODY nocopy_test
IS
    l_numbers number_t;
    c_array_size number:=1000000;
    c_it number:=20;
        
        PROCEDURE pass_by_value(nums in out number_t)
        IS
        indx pls_integer;
        BEGIN
        indx:=nums.count;
        END;
        
        PROCEDURE pass_by_reference(nums in out nocopy number_t)
        IS
        indx pls_integer;
        BEGIN
        indx:=nums.count;
        END;
        
        PROCEDURE init
        IS
        BEGIN
        l_numbers.delete;
        for i in 1..c_array_size
            LOOP
            l_numbers(i):='s'||i;
            END LOOP;
            dbms_output.put_line('start ' ||to_char(sysdate,'hh:mi:ss') );
            
        FOR i in 1..1000
            LOOP
            pass_by_value(l_numbers);
            END LOOP;
            
            dbms_output.put_line('end ' ||to_char(sysdate,'hh:mi:ss') );
            
            dbms_output.put_line('start ' ||to_char(sysdate,'hh:mi:ss') );
            
        FOR i in 1..1000
            LOOP
            pass_by_reference(l_numbers);
            END LOOP;            
            
            dbms_output.put_line('end ' ||to_char(sysdate,'hh:mi:ss') );
            
            
        END;
END;
        

-- EXECUTING

EXECUTE nocopy_test.INIT;


-------------------------------

-- RESULT CACHE HINT
-----------------------------

CREATE OR REPLACE FUNCTION get_sum_sal_dept
(dept_id number)
return number result_cache -- <-  result cache info
IS
v_sal number; 
BEGIN
    SELECT SUM(salary)
    INTO v_sal
    FROM employees
    WHERE department_id=dept_id;
    RETURN v_sal;
END;

select get_sum_sal_dept(10) from dual;
select get_sum_sal_dept(20) from dual; 



-- now when you do: 
select get_sum_sal_dept(10) from dual;
-- it should be faster because the results are stored in the cache. 

-------------------------
-- BULK BINDING
-------------------------------

SELECT * FROM employees where employee_id IN (100,101,102,200,300);

CREATE OR REPLACE PROCEDURE update_sal_withouth_bulk
(p_amount number)
IS
-- DECLARATION OF TYPES. EXAMPLE TABLE TYPES.
TYPE emp_table_type IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
emp_table emp_table_type;
i number:=0;
BEGIN
emp_table(1):=100;
emp_table(2):=200;
emp_table(3):=300;
i:=emp_table.first;
    WHILE i < emp_table.last
        LOOP
        UPDATE employees
        SET salary=salary+p_amount
        where employee_id=emp_table(i);
        i:=i+1;
        END LOOP;
    /*
    FOR i IN emp_table.first..emp_table.last
        LOOP
        UPDATE employees
        SET salary=salary+p_amount
        where employee_id=emp_table(i);
        END LOOP;
        --COMMIT;
    */  
        
    EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('Couldnt find the :' || emp_table(i) || ' value');
END; 

-- executing

EXECUTE update_sal_withouth_bulk(1.1);

-----------------------------------------------------------------------------------
----------- update salWITH BBULK----------------------------------
-- BULK BINDING ------------------


SELECT * FROM employees where employee_id IN (100,101,102,200,300);

CREATE OR REPLACE PROCEDURE update_sal_with_bulk
(p_amount number)
IS
-- DECLARATION OF TYPES. EXAMPLE TABLE TYPES.
TYPE emp_table_type IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
emp_table emp_table_type;
i number:=0;
BEGIN
emp_table(1):=100;
emp_table(2):=200;
emp_table(3):=300;
i:=emp_table.first;

    FORALL i IN emp_table.first..emp_table.last
        ---LOOP, the loop sentence it's deleted 
        UPDATE employees
        SET salary=salary+p_amount
        where employee_id=emp_table(i);
        --END LOOP; the same with the end loop sentence .
        
    EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('Couldnt find the :' || emp_table(i) || ' value');
END; 

-- executing

EXECUTE update_sal_withouth_bulk(1.1);


-------------------------------------------------------------------------------------------

select count(*) from employees;

select * from employees;

----------------------------------------------------------------
---- example time differences bulk and without bulk
---------------------------------

/*
    1. time function
    2. cloning all the registers of a table and make it double, register 1 it's -1, 2 it's -2
    3. do the  for with the bulk and withouth
    4. compare times
*/
-- second procedure
CREATE OR REPLACE PROCEDURE comparing_bulk_and_no_bulk
IS
-- variables
TYPE PT_employees_table IS TABLE OF HR.EMPLOYEES%ROWTYPE INDEX BY BINARY_INTEGER;
v_employees_table PT_employees_table;
CURSOR c_employees_table IS select * from HR.employees;
total_rows number:=0;
i number:=0;
ii number:=0;
max_iterations number:=2;


-- procedures


BEGIN
-- fetching all the employees rows in the 
    DBMS_OUTPUT.ENABLE(1000000); 
    -- The select statements mean to assing a value to a variable are declared inside the BEGIN statement
    select count(*) INTO total_rows from HR.EMPLOYEES;
    
    WHILE ii< max_iterations
        LOOP
        ii:=ii+1;
        FOR elemento in c_employees_table
                LOOP
                i:=i+1;
                v_employees_table(i):=elemento;
                --dbms_output.put_line('Elemento : ' || i || ' , ' || 'Id= ' || v_employees_table(i).employee_id || ' Salario: ' || v_employees_table(i).salary);
                END LOOP;
        END LOOP;


    dbms_output.put_line('El primer elemento de v_employees_table: ' || v_employees_table.first);
    dbms_output.put_line('El ultimo elemento de v_employees_table: ' || v_employees_table.last);
    dbms_output.put_line('Que tiene un total de: ' || v_employees_table.count || ' El cual es: ' || max_iterations || '*' || total_rows);


END; 



-- executing

execute hr.comparing_bulk_and_no_bulk;


------------------------------------------------------------

-- bulk binding with save exceptions. 

DESC employees;

DROP TABLE ename; 

CREATE TABLE ename AS SELECT DISTINCT first_name FROM employees;

CREATE TABLE ename (first_name varchar2(30));

-- insert into 
INSERT INTO hr.ename

SELECT DISTINCT first_name FROM hr.employees


SELECT first_name from ename; 

SELECT * FROM ename;

------------------------------
-- EXAMPLE WITHOUT BULK BINDING (ERROR COLUMN)
-------------------------------


DECLARE
TYPE ename_t IS TABLE OF VARCHAR2(100);
ename_table ename_t:=ename_t(); -- You cannot use EXTEND to add elements to an uninitialized collection
i number:=0;
c number:=0;
BEGIN
    FOR i IN (select * from ename)
        LOOP
        c:=c+1;
        ename_table.extend; -- It's neccesary since the table wasn't declared with an INDEX BY- why? for the lools?
        ename_table(c):=i.first_name;
        END LOOP;
     
    i:=ename_table.first-1;
    dbms_output.put_line('The last element of: ename_table : ' || ename_table.last);
    dbms_output.put_line('The 16 element of: ename_table : ' || ename_table(16));
    dbms_output.put_line('The 1 element of: ename_table : ' || ename_table(1));
    
    BEGIN
    WHILE i < ename_table.last
        LOOP
        --begin
        i:=i+1;
        dbms_output.put_line('The name im looking: ' || ename_table(i) || ' number ' || i);
        UPDATE HR.ename
        SET first_name=first_name|| ' to be added '
        WHERE first_name=ename_table(i);
        
        -- exception
        -- end;
        END LOOP;
       
       
    EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('Problem finding: ' || ename_table(i) || ' number ' || i);
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
       
     END;  
        
        
    EXCEPTION
    WHEN OTHERS THEN
    NULL;
END; 
        
---------------------------------------
----- EXAMPLE EXCEPTIONS BEING CONTROLLED BY THE LOOP
----------------------------------------------

DECLARE
TYPE ename_t IS TABLE OF VARCHAR2(100);
ename_table ename_t:=ename_t(); -- You cannot use EXTEND to add elements to an uninitialized collection
i number:=0;
c number:=0;
BEGIN
    FOR i IN (select * from ename)
        LOOP
        c:=c+1;
        ename_table.extend; -- It's neccesary since the table wasn't declared with an INDEX BY- why? for the lools?
        ename_table(c):=i.first_name;
        END LOOP;
     
    i:=ename_table.first-1;
    dbms_output.put_line('The last element of: ename_table : ' || ename_table.last);
    dbms_output.put_line('The 16 element of: ename_table : ' || ename_table(16));
    dbms_output.put_line('The 1 element of: ename_table : ' || ename_table(1));
    
    --BEGIN
    WHILE i < ename_table.last
        LOOP
        BEGIN
        i:=i+1;
        dbms_output.put_line('The name im looking: ' || ename_table(i) || ' number ' || i);
        UPDATE HR.ename
        SET first_name=first_name|| ' to be added '
        WHERE first_name=ename_table(i);
        
         EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('Problem finding: ' || ename_table(i) || ' number ' || i);
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
       
         END;  
     
        END LOOP;    
        
    EXCEPTION
    WHEN OTHERS THEN
    NULL;
END; 
        
        
        
-----------------------------------------
-- EXAMPLE WITH BULK BINDING
-----------------------------------------
DROP TABLE ename; 

CREATE TABLE ename AS SELECT DISTINCT first_name FROM employees;

SELECT * FROM ename; 

------------------
DECLARE
TYPE ename_t IS TABLE OF VARCHAR2(100); -- WITHOUT INDEX, NOTE
ename_table ename_t:=ename_t(); -- as doesnt have an index, every instance of ename_t should be initialized
c number:=0;

BEGIN
    FOR i IN (select * from ename)
    LOOP
    c:=c+1;
    ename_table.extend; -- as doesnt have an index, you should extend :/
    ename_table(c):=i.first_name;
    END LOOP;
    
    FORALL i IN ename_table.first..ename_table.last SAVE EXCEPTIONS
    -- with the SAVE 
    --dbms_output.put_line('The name im looking: ' || ename_table(i) || ' number ' || i);
    UPDATE ename
    SET first_name=first_name||' to be added'
    WHERE first_name=ename_table(i);
    
    EXCEPTION 
    WHEN OTHERS THEN

    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);

END;
----------------------------------------

-----------------------------------------
-- EXAMPLE WITH BULK BINDING AND
-- DEALING WITH EACH ERROR OBTAINED BY SAVE EXCEPTIONS
-----------------------------------------
DROP TABLE ename; 

CREATE TABLE ename AS SELECT DISTINCT first_name FROM employees;

SELECT * FROM ename; 

---------------------------------------------
DECLARE
TYPE ename_t IS TABLE OF VARCHAR2(100);
ename_table ename_t:=ename_t();
c number:=0;
errors number;
---
BEGIN
    FOR i IN (select * from ename)
    LOOP
    c:=c+1;
    ename_table.extend;
    ename_table(c):=i.first_name;
    END LOOP;
    
    FORALL i IN ename_table.first..ename_table.last SAVE EXCEPTIONS
    UPDATE ename
    SET first_name=first_name || ' to be added'
    WHERE first_name=ename_table(i);
    
    EXCEPTION
    WHEN OTHERS THEN
    errors:=sql%bulk_exceptions.COUNT;
    dbms_output.put_line('The total number of errors ocurred are: ' ||errors);
    FOR j in 1..ERRORS LOOP
        dbms_output.put_line('The error iteration is: ' ||
            sql%bulk_exceptions(j).error_index ||
            ' and the error code is: ' ||
            sql%bulk_exceptions(j).error_code ||
            ' and the error message is: ' ||
            sqlerrm(-sql%bulk_exceptions(j).error_code)
            );
    END LOOP;
END;

----------------------------------------------------------

-----------------------------------------
-- EXAMPLE WITH BULK BINDING AND
-- DEALING WITH EACH ERROR OBTAINED BY SAVE EXCEPTIONS
-- AND BULK COLLECT INTO (ANALOGUS AS INSERT INTO) A PL/SQL TABLE
-----------------------------------------
DROP TABLE ename; 

CREATE TABLE ename AS SELECT DISTINCT first_name FROM employees;

SELECT * FROM ename; 

---------------------------------------------
DECLARE
TYPE ename_t IS TABLE OF VARCHAR2(100);
ename_table ename_t:=ename_t();
c number:=0;
errors number;
---
BEGIN
/* THE FOLLOWING FOR IS REPLACED BY BULK COLLECT INTO
    FOR i IN (select * from ename)
    LOOP
    c:=c+1;
    ename_table.extend;
    ename_table(c):=i.first_name;
    END LOOP;
   */   
    
    select first_name bulk collect into ename_table from ename; 
    
    FORALL i IN ename_table.first..ename_table.last SAVE EXCEPTIONS
    UPDATE ename
    SET first_name=first_name || ' to be added'
    WHERE first_name=ename_table(i);

    
    EXCEPTION
    WHEN OTHERS THEN
    errors:=sql%bulk_exceptions.COUNT;
    dbms_output.put_line('The total number of errors ocurred are: ' ||errors);
    FOR j in 1..ERRORS LOOP
        dbms_output.put_line('The error iteration is: ' ||
            sql%bulk_exceptions(j).error_index ||
            ' and the error code is: ' ||
            sql%bulk_exceptions(j).error_code ||
            ' and the error message is: ' ||
            sqlerrm(-sql%bulk_exceptions(j).error_code)
            );
    END LOOP;
END;

-----------------------------------------------------

------ EXAMPLE: BULK COLLECT
-------------------------------------------------

DROP TABLE ename2;

CREATE TABLE ename2 AS SELECT employee_id,first_name FROM employees;

SELECT * FROM ename2;

DECLARE

TYPE emp_t IS TABLE OF varchar2(100) INDEX BY BINARY_INTEGER;

emp_table emp_t;
c number:=0;
BEGIN
    FOR i in (select employee_id, first_name FROM ename2)
    LOOP
    c:=c+1;
    emp_table(c):=i.first_name;
    END LOOP;
    
    FOR i IN emp_table.first..emp_table.last
    LOOP
    dbms_output.put_line(emp_table(i));
    END LOOP;
END; 

------------------------------------------
--- example with bulk

--------------------------------

DECLARE

--TYPE emp_t IS TABLE OF varchar2(100) ; -- INDEX BY BINARY_INTEGER;

TYPE emp_t IS TABLE OF employees%ROWTYPE INDEX BY BINARY_INTEGER;

emp_table emp_t;
c number:=0;
BEGIN
    
    select * BULK COLLECT INTO emp_table FROM employees;
    
    -- how can this work just with two columns as follows? And the insert below
    --select first_name, last_name BULK COLLECT INTO emp_table FROM employees;
    
    FOR i IN emp_table.first..emp_table.last
    LOOP
    dbms_output.put_line(emp_table(i).first_name);
    END LOOP;
END; 

--------------------

create table test_table as select * from hr.employees where 1=0;

insert into test_table ( first_name, last_name )  select first_name, last_name from hr.employees;


------------------------------------------------
-------------------------------------------
----------- 
-------------- USING BULK COLLECT AND CURSORS ------------
---------------------------------------------------------
DECLARE
TYPE emp_t IS TABLE OF employees%rowtype;
emp_table emp_t;
CURSOR emp_c IS SELECT * FROM employees; 
c number:=0;
BEGIN
emp_table:=emp_t();
OPEN emp_c;
    LOOP
    emp_table.extend;
    c:=c+1;
    FETCH emp_c INTO emp_table(c);
    EXIT WHEN emp_c%notfound;
    dbms_output.put_line(emp_table(c).first_name);
    END LOOP;
    CLOSE emp_c;
END;    


--------------------------------------------
---- example using bulk and cursors but with for instead of OPEN-FETCH-CLOSE

DECLARE
TYPE emp_t IS TABLE OF employees%ROWTYPE INDEX BY BINARY_INTEGER;
emp_table emp_t;
CURSOR emp_c IS SELECT * FROM employees; 
c number:=0;
BEGIN
--emp_table:=emp_t(); -- YOU CANT INITIALIZE A PL/SQL TABLE WICH HAS AN INDEX

FOR elemento in emp_c
    LOOP
    c:=c+1;
    emp_table(c):=elemento;
    dbms_output.put_line(emp_table(c).first_name);
    END LOOP;
END;  

----------------------------------------------

----- EXAMPLE DOING A BULK COLLECT FROM A CURSOR INTO A PL/SQL TABLE

-----------------------------------------------

DECLARE
TYPE emp_t IS TABLE OF employees%rowtype;
emp_table emp_t;
CURSOR emp_c IS SELECT * FROM employees;
BEGIN
    OPEN emp_c;
    FETCH emp_c BULK COLLECT INTO emp_table; -- FETCHING THE CURSOR INTO THE PL/SQL TABLE. 
    
    FOR i IN emp_table.first..emp_table.last
    LOOP
    dbms_output.put_line(emp_table(i).first_name);
    END LOOP;
END; 



----------------------------------------------

----- EXAMPLE DOING A BULK COLLECT FROM A CURSOR INTO A PL/SQL TABLE AND LIMIT

-----------------------------------------------

DECLARE
TYPE emp_t IS TABLE OF employees%rowtype;
emp_table emp_t;
CURSOR emp_c IS SELECT * FROM employees;
BEGIN
    OPEN emp_c;
    FETCH emp_c BULK COLLECT INTO emp_table LIMIT 5; -- FETCHING THE CURSOR INTO THE PL/SQL TABLE. 
    
    FOR i IN emp_table.first..emp_table.last
    LOOP
    dbms_output.put_line(emp_table(i).first_name);
    END LOOP;
END; 

--------------------------------------------------------------
--- USING RETURNING IN BULK COLLECT
---------------------------------------------------

CREATE OR REPLACE PROCEDURE update_sal_x (emp_id number, p_amount number)
IS
v_new_sal number;
BEGIN

    UPDATE employees
    SET salary=salary+p_amount
    WHERE employee_id=emp_id
    RETURNING salary into v_new_sal;
    
    dbms_output.put_line('the new sal is: ' || v_new_sal);
    END;
    
-- executing update_sal    
exec update_sal_x(200,1);


--------------------------------------------------

--- EXAMPLE RETURNING IN BULK CONNECTG
-------------------------------------

SELECT * FROM ename_test;

DROP TABLE ename_test;

CREATE TABLE ename_test AS select employee_id, salary from employees;

SELECT * from ename_test ORDER BY 1;

DECLARE
TYPE emp_t IS TABLE OF ename_test%ROWTYPE;
emp_table emp_t:=emp_t();
emp_new_sal emp_t:=emp_t();

BEGIN
    SELECT * BULK COLLECT INTO emp_table FROM ename_test;
    
    FORALL i IN emp_table.first..emp_table.last
    UPDATE ename_test
    SET salary=salary/2
    WHERE employee_id=emp_table(i).employee_id
    RETURNING employee_id, salary BULK COLLECT INTO emp_new_sal;
    
    FOR i IN emp_new_sal.first..emp_new_sal.last
    LOOP
    dbms_output.put_line(emp_new_sal(i).employee_id || ' ' || emp_new_sal(i).salary);
    END LOOP;
END; 

----------------------------------------------------------------
----------------- INDICES OF
---------------------------------------------------------------

SELECT * FROM employees WHERE employee_id IN (100,101,102,103);

DECLARE
    TYPE emp_table_type IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    emp_table emp_table_type;
BEGIN
    emp_table(1):=100;
    emp_table(2):=101;
    emp_table(3):=102;
    emp_table(100):=103; -- -it will lead to an exception if we dont handle the empty values in the array
    
    dbms_output.put_line(emp_table.first);
    dbms_output.put_line(emp_table.last);
    
    FORALL i IN emp_table.first..emp_table.last SAVE EXCEPTIONS
        UPDATE employees
        SET salary=salary+5
        WHERE employee_id=emp_table(i);
END;

----------------------------------------------------------------
----------------- TRIGGERS / BEGGINING (Statement level trigger)
---------------------------------------------------------------

DROP TABLE t1;

CREATE TABLE t1
( emp_id number,
ename varchar2(100)
);


select * from t1;

INSERT INTO t1 VALUES (1,'ford');
INSERT INTO t1 VALUES (2,'aya');

--- statement trigger ----

CREATE OR REPLACE TRIGGER t1_b4_update
BEFORE UPDATE -- Means -> timing + event
ON t1
BEGIN -- start the declaration of the trigger
dbms_output.put_line('ON UPDATE. STATEMENT TRIGGER');
END;

UPDATE t1
SET ename=ename || ' s';

-- Notice that the trigger will be fired *even* if no row is updated!
update t1
SET ename=ename || 'ss'
where emp_id=5555;

-------------------------------------------------------------------


----------------------------------------------------------------
----------------- TRIGGERS / ROW LEVEL
---------------------------------------------------------------

CREATE OR REPLACE TRIGGER t1_b4_update_row_level
BEFORE UPDATE -- Means -> timing + event
ON t1
FOR EACH ROW -- WITH THIS LINE THE TRIGGER WILL BE FIRED je, for each row.
-- but remember, the trigger won't be fired if the triggering event 
-- does not not affect any rows. 
BEGIN -- start the declaration of the trigger
dbms_output.put_line('ON UPDATE. ROW LEVEL TRIGGER');
END;

ROLLBACK;


-- calling implicity the trigger 
-- the table t1 now has two triggers, one Statement Level Trigger y otro 
-- Row level trigger


UPDATE t1
SET ename=ename || ' s';

update t1
SET ename=ename || 'ss'
where emp_id=5555;

update t1
SET ename=ename || 'ss'
where emp_id=2;






