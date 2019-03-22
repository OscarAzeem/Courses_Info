-- EJERCICIO RENDIMIENTO DEBIDO A FRAGMENTACION--

CREATE TABLESPACE tbs1_error_allocate
DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\tbs1_error_allocate.DBF'
size 200m;

DROP TABLESPACE tbs1_error_allocate INCLUDING CONTENTS AND DATAFILES;


CREATE TABLE hr.table_tbs1_error_allocate(consecutive_id number, id number, name char(20), last_name char(20)) tablespace tbs1_error_allocate;

select * from hr.table_tbs1_error_allocate;

select count(*) from hr.table_tbs1_error_allocate; --max size= 785,539 -- 785539

DELETE FROM hr.table_tbs1_error_allocate;

DROP TABLE hr.table_tbs1_error_allocate;

-- LlENADO DE LA TABLA: table_tbs1_error_allocate

DECLARE 
Uppercase_letter char(10);
Lowercase_letter char(10);
Random_number number;
Final_length number:=3000000;
Consecutive_number number:=1;
i number:=1;
BEGIN
  FOR i IN 1 .. Final_length LOOP
    Lowercase_letter:=dbms_random.string('l',10);
    Uppercase_letter:=dbms_random.string('u',10);
    Random_number:=round(DBMS_RANDOM.value(1,300));
    --DBMS_OUTPUT.put_line(Lowercase_letter);
    --DBMS_OUTPUT.put_line(Random_number);
    INSERT INTO hr.table_tbs1_error_allocate VALUES(i, Random_number, Lowercase_letter, Uppercase_letter);
  END LOOP;
  
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('OTHERS EXCEPTION');
dbms_output.put_line('Final length: ' || to_char(i));
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
  
  
END;

COMMIT;

-- Borrado de Bloques aleatorios en la tabla: table_tbs1_error_allocate

select count(*) from hr.table_tbs1_error_allocate WHERE NAME LIKE 'a%';

select count(*) from hr.table_tbs1_error_allocate WHERE NAME LIKE 'z%';

DELETE from hr.table_tbs1_error_allocate WHERE NAME LIKE 'a%';

DELETE from hr.table_tbs1_error_allocate WHERE NAME LIKE 'z%';

---
-- Calculo de Tiempo con un order by string last_name

-- Antes del Shrink

DECLARE
Inicio TIMESTAMP;
Fin TIMESTAMP;
--Cursor para guardar el order by

BEGIN
SELECT SYSTIMESTAMP INTO Inicio FROM DUAL;
dbms_output.put_line(Inicio);





SELECT SYSTIMESTAMP INTO Fin FROM DUAL;


EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('OTHERS EXCEPTION');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
END;

-- Despues del Shrink



select SYSTIMESTAMP FROM DUAL;


