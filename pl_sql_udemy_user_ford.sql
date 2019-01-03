select * from USER_SYS_PRIVS;

select * from user_role_privs;


CREATE TABLE hr_table
(
    id number,
    name varchar2(100)
);


select * from role_sys_privs;

select * from session_privs;


select * from USER_USERS;

SELECT * from ALL_OBJECTS;


select * from user_source;


EXECUTE hr.add_hr_table(1,'Azeem');

select * from user_source;

select * from all_procedures where OWNER like '%r';

select * from all_procedures where OWNER='HR';


EXECUTE hr.add_hr_table(1,'Azeem');

commit;

select * from HR.user_source


select owner, count(*) from all_procedures group by owner;


select * from user_tab_privs;

SELECT * FROM all_source WHERE name = 'ADD_HR_TABLE_AUTH_ID' ORDER BY TYPE, LINE;

SELECT hr.get_sal(100) from dual;

select * from employees;

declare
    l_schema varchar2(30);
begin
    l_schema := apex_application_install.get_schema;
    dbms_output.put_line(l_schema);
end;

select sys_context('USERENV', 'CURRENT_SCHEMA') from dual;

execute hr.ADD_ROWS2('emp1',222);

select * from hr.emp1;

-- EXECUTING ADD_HR_TABLE_AUTH_ID AND GETTING ERROR BECAUSE THE AUTH_ID

EXECUTE HR.ADD_HR_TABLE_AUTH_ID(3,'BECERRIL');
