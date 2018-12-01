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

select * from BDPARTMENTS
