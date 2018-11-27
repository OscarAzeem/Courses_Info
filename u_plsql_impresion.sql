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


