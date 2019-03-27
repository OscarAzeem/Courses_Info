-- EJERCICIO RENDIMIENTO DEBIDO A FRAGMENTACION--

CREATE TABLESPACE tbs1_error_allocate
DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\tbs1_error_allocate.DBF'
size 800m;

DROP TABLESPACE tbs1_error_allocate INCLUDING CONTENTS AND DATAFILES;

-- ADDING A BIGGER TABLESPACE FOR THE temp tablespace

ALTER TABLESPACE TEMP TABLESPACE GROUP tempgroup1;

CREATE TEMPORARY TABLESPACE TEMP1
TEMPFILE 'C:\APP\XMY9080\ORADATA\ORCL\TEMP1_DATAFILE_TEMPGROUP1.DBF'
SIZE 500m
TABLESPACE GROUP tempgroup1;

-- creando más espacio temporal para TEMP1, debido al error: ORA-01652: unable to extend temp segment by 128 in tablespace TEMP1

alter database TEMPFILE 'C:\APP\XMY9080\ORADATA\ORCL\TEMP1_DATAFILE_TEMPGROUP1.DBF' autoextend on maxsize 2000M;


ALTER TABLESPACE tbs1_error_allocate
ADD DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\tbs1_index_error_allocate.dbf'
SIZE 50m
AUTOEXTEND ON
NEXT 1024k
--NEXT 512k
MAXSIZE 500M;


ALTER TABLESPACE tbs1_error_allocate
ADD DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\tbs1_index_error_allocate2.dbf'
SIZE 50m
AUTOEXTEND ON
NEXT 1024k
--NEXT 512k
MAXSIZE 500M;

-- BUILDING TABLESPACE TABLE

CREATE TABLE hr.table_tbs1_error_allocate(consecutive_id number, id number, name char(20), last_name char(20)) tablespace tbs1_error_allocate;

-- BUILDING INDEX TABLE

CREATE UNIQUE INDEX index_error_allocate ON hr.table_tbs1_error_allocate(name) TABLESPACE tbs1_error_allocate;

DROP INDEX index_error_allocate;

select * from hr.table_tbs1_error_allocate;

select count(*) from hr.table_tbs1_error_allocate; --max size= 785,539 -- 785539

DELETE FROM hr.table_tbs1_error_allocate;

DROP TABLE hr.table_tbs1_error_allocate;

-- LlENADO DE LA TABLA: table_tbs1_error_allocate

DECLARE 
-- time garbage variables -- 
Inicio_hora number;
Inicio_minuto number;
Inicio_segundo number;
Fin_hora number;
Fin_minuto number;
Fin_segundo number;
Tiempototal_hora number;
Tiempototal_minuto number;
Tiempototal_segundo number;
---
Uppercase_letter char(10);
Lowercase_letter char(10);
Random_number number;
Final_length number:=100000000;
Consecutive_number number:=1;
i number:=1;
BEGIN
select extract(HOUR from HORA) HORAS INTO Inicio_hora FROM (SELECT SYSTIMESTAMP HORA FROM DUAL);
select extract(MINUTE from MINUTO) MINUTOS INTO Inicio_minuto FROM (SELECT SYSTIMESTAMP MINUTO FROM DUAL);
select extract(SECOND from SEGUNDO) SEGUNDOS INTO Inicio_segundo FROM (SELECT SYSTIMESTAMP SEGUNDO FROM DUAL);


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
select count(*) INTO i FROM hr.table_tbs1_error_allocate;
select extract(HOUR from HORA) HORAS INTO Fin_hora FROM (SELECT SYSTIMESTAMP HORA FROM DUAL);
select extract(MINUTE from MINUTO) MINUTOS INTO Fin_minuto FROM (SELECT SYSTIMESTAMP MINUTO FROM DUAL);
select extract(SECOND from SEGUNDO) SEGUNDOS INTO Fin_segundo FROM (SELECT SYSTIMESTAMP SEGUNDO FROM DUAL);

Tiempototal_hora:=Fin_hora-Inicio_hora;
Tiempototal_minuto:=Fin_minuto-Inicio_minuto;
Tiempototal_segundo:=Fin_segundo-Inicio_segundo;
dbms_output.put_line('Final length: ' || to_char(i));
dbms_output.put_line ('Inicio: ' ||Inicio_hora || ':' || Inicio_minuto || ':' || Inicio_segundo);
dbms_output.put_line ('Fin: ' ||Fin_hora || ':' || Fin_minuto || ':' || Fin_segundo);
dbms_output.put_line('Tiempo Transcurrido: ' || Tiempototal_hora|| ':' || Tiempototal_minuto || ':' || Tiempototal_segundo);

dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
  
  
END;

COMMIT;

-- Borrado de Bloques aleatorios en la tabla: table_tbs1_error_allocate

select count(*) from hr.table_tbs1_error_allocate WHERE NAME LIKE 'a%';  -- 496660

select count(*) from hr.table_tbs1_error_allocate WHERE NAME LIKE 'z%'; --497712

select count(*) from hr.table_tbs1_error_allocate WHERE NAME LIKE 'h%'; --496832

DELETE from hr.table_tbs1_error_allocate WHERE NAME LIKE 'a%';

DELETE from hr.table_tbs1_error_allocate WHERE NAME LIKE 'h%';

DELETE from hr.table_tbs1_error_allocate WHERE NAME LIKE 'z%';

---
-- Calculo de Tiempo con un order by string last_name

-- Antes del Shrink

DECLARE
Inicio_hora number;
Inicio_minuto number;
Inicio_segundo number;
Fin_hora number;
Fin_minuto number;
Fin_segundo number;
Tiempototal_hora number;
Tiempototal_minuto number;
Tiempototal_segundo number;
--Cursor para guardar el order by
CURSOR cursor_ordenado IS SELECT * FROM hr.table_tbs1_error_allocate ORDER BY name ASC; 
--Tabla para hacer el Fetch del cursor
TYPE type_table_tbs1 IS TABLE OF HR.table_tbs1_error_allocate%ROWTYPE  INDEX BY BINARY_INTEGER;
t_before_shrink type_table_tbs1;
t_after_shrink type_table_tbs1;

BEGIN
select extract(HOUR from HORA) HORAS INTO Inicio_hora FROM (SELECT SYSTIMESTAMP HORA FROM DUAL);
select extract(MINUTE from MINUTO) MINUTOS INTO Inicio_minuto FROM (SELECT SYSTIMESTAMP MINUTO FROM DUAL);
select extract(SECOND from SEGUNDO) SEGUNDOS INTO Inicio_segundo FROM (SELECT SYSTIMESTAMP SEGUNDO FROM DUAL);


--dbms_output.put_line('Hora inicio: ' || Inicio);
-- Iniciando El cursor before_shrink_cursor:
    OPEN cursor_ordenado;
    FETCH cursor_ordenado BULK COLLECT INTO t_before_shrink;




select extract(HOUR from HORA) HORAS INTO Fin_hora FROM (SELECT SYSTIMESTAMP HORA FROM DUAL);
select extract(MINUTE from MINUTO) MINUTOS INTO Fin_minuto FROM (SELECT SYSTIMESTAMP MINUTO FROM DUAL);
select extract(SECOND from SEGUNDO) SEGUNDOS INTO Fin_segundo FROM (SELECT SYSTIMESTAMP SEGUNDO FROM DUAL);

Tiempototal_hora:=Fin_hora-Inicio_hora;
Tiempototal_minuto:=Fin_minuto-Inicio_minuto;
Tiempototal_segundo:=Fin_segundo-Inicio_segundo;

dbms_output.put_line('Tiempo SELECT cursor no index: ');
dbms_output.put_line ('Inicio: ' ||Inicio_hora || ':' || Inicio_minuto || ':' || Inicio_segundo);
dbms_output.put_line ('Fin: ' ||Fin_hora || ':' || Fin_minuto || ':' || Fin_segundo);
dbms_output.put_line('Tiempo Transcurrido: ' || Tiempototal_hora|| ':' || Tiempototal_minuto || ':' || Tiempototal_segundo);


EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('Tiempo SELECT cursor: ');
dbms_output.put_line('OTHERS EXCEPTION');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
END;

-- Despues del Shrink

-- Activando el movimiento de fila en la tabla:

alter table  hr.table_tbs1_error_allocate enable row movement;

-- Activando el shrink space command

alter table hr.table_tbs1_error_allocate shrink space; -- 1849.63 seconds -> 30 minutos ->1735 -> 28 min



















---------------------------------
-------- TEMP QUERYS ------------
---------------------------------

select SYSTIMESTAMP FROM DUAL;


-- temp querys
DECLARE
Inicio_hora number;
Inicio_minuto number;
Inicio_segundo number;
Fin_hora number;
Fin_minuto number;
Fin_segundo number;
Tiempototal_hora number;
Tiempototal_minuto number;
Tiempototal_segundo number;
--Cursor para guardar el order by
CURSOR cursor_ordenado IS SELECT * FROM hr.table_tbs1_error_allocate ORDER BY name ASC; 
--Tabla para hacer el Fetch del cursor
TYPE type_table_tbs1 IS TABLE OF HR.table_tbs1_error_allocate%ROWTYPE  INDEX BY BINARY_INTEGER;
t_before_shrink type_table_tbs1;
t_after_shrink type_table_tbs1;

BEGIN
select extract(HOUR from HORA) HORAS INTO Inicio_hora FROM (SELECT SYSTIMESTAMP HORA FROM DUAL);
select extract(MINUTE from MINUTO) MINUTOS INTO Inicio_minuto FROM (SELECT SYSTIMESTAMP MINUTO FROM DUAL);
select extract(SECOND from SEGUNDO) SEGUNDOS INTO Inicio_segundo FROM (SELECT SYSTIMESTAMP SEGUNDO FROM DUAL);


--dbms_output.put_line('Hora inicio: ' || Inicio);
-- Iniciando El cursor before_shrink_cursor:
    OPEN cursor_ordenado;
    FETCH cursor_ordenado BULK COLLECT INTO t_before_shrink;




select extract(HOUR from HORA) HORAS INTO Fin_hora FROM (SELECT SYSTIMESTAMP HORA FROM DUAL);
select extract(MINUTE from MINUTO) MINUTOS INTO Fin_minuto FROM (SELECT SYSTIMESTAMP MINUTO FROM DUAL);
select extract(SECOND from SEGUNDO) SEGUNDOS INTO Fin_segundo FROM (SELECT SYSTIMESTAMP SEGUNDO FROM DUAL);

Tiempototal_hora:=Fin_hora-Inicio_hora;
Tiempototal_minuto:=Fin_minuto-Inicio_minuto;
Tiempototal_segundo:=Fin_segundo-Inicio_segundo;

dbms_output.put_line ('Inicio: ' ||Inicio_hora || ':' || Inicio_minuto || ':' || Inicio_segundo);
dbms_output.put_line ('Fin: ' ||Fin_hora || ':' || Fin_minuto || ':' || Fin_segundo);
dbms_output.put_line('Tiempo Transcurrido: ' || Tiempototal_hora|| ':' || Tiempototal_minuto || ':' || Tiempototal_segundo);


EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('OTHERS EXCEPTION');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
END;
-----
---22

SELECT * from dba_temp_files;

SELECT FILE_NAME, FILE_ID, TABLESPACE_NAME, BYTES/1024/1024, BLOCKS, STATUS, RELATIVE_FNO,
AUTOEXTENSIBLE, MAXBYTES/1024/1024, MAXBLOCKS, INCREMENT_BY, USER_BYTES/1024/1024, USER_BLOCKS,
SHARED, INST_ID FROM dba_temp_files;

SELECT TABLESPACE_NAME, FILE_ID, BLOCK_ID, BYTES/1024/1024, BLOCKS, RELATIVE_FNO FROM dba_free_space;

SELECT * FROM dba_tablespace_groups;

SELECT * FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_TEMP_TABLESPACE';

SELECT * FROM dba_data_files;

ALTER TABLESPACE TEMP TABLESPACE GROUP tempgroup1;

ALTER TABLESPACE [TEMP_TABLSEPACE_NAME] TABLESPACE GROUP [TEMP_TABLESPACE_GROUP_NAME];


SELECT * FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_TEMP_TABLESPACE';

ALTER DATABASE DEFAULT TEMPORARY TABLESPACE tempgroup1ds


