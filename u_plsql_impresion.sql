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





