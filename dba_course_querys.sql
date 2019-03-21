---
-- UDEMY DBA COURSE QUERYS--
---

-- open the orclpdb connection


alter session set container=orclpdb;

alter pluggable database open; 



select name, con_id from v$pdbs;

show con_name; 


CREATE TABLE SALES
(
customer_id NUMBER,
order_date DATE,
order_amount number,
region varchar2(10)
)
PARTITION BY RANGE(order_date)
(
PARTITION penero VALUES LESS THAN (TO_DATE('01-jan-2015','dd-mon-yyyy')),
PARTITION pfebrero VALUES LESS THAN (TO_DATE('01-FEB-2015','dd-mon-yyyy')),
PARTITION pmarzo VALUES LESS THAN (TO_DATE('01-MAR-2015','dd-mon-yyyy')),
PARTITION pabril VALUES LESS THAN (TO_DATE('01-APR-2015','dd-mon-yyyy')),
PARTITION pmayo VALUES LESS THAN (TO_DATE('01-MAY-2015','dd-mon-yyyy')),
PARTITION pjunio VALUES LESS THAN (TO_DATE('01-JUN-2015','dd-mon-yyyy')),
PARTITION pjulio VALUES LESS THAN (TO_DATE('01-JUL-2015','dd-mon-yyyy')),
PARTITION pagosto VALUES LESS THAN (TO_DATE('01-AUG-2015','dd-mon-yyyy')),
PARTITION pseptiembre VALUES LESS THAN (TO_DATE('01-SEP-2015','dd-mon-yyyy')),
PARTITION poctubre VALUES LESS THAN (TO_DATE('01-OCT-2015','dd-mon-yyyy')),
PARTITION pnoviembre VALUES LESS THAN (TO_DATE('01-NOV-2015','dd-mon-yyyy')),
PARTITION pdiciembre VALUES LESS THAN (TO_DATE('01-DEC-2015','dd-mon-yyyy')),
PARTITION sales_pmax VALUES LESS THAN (MAXVALUE)
);

drop  TABLE SALES

select * from nls_session_parameters

ALTER SESSION SET NLS_DATE_LANGUAGE = AMERICAN

INSERT INTO SALES VALUES(1,'12-jan-2015',10,'east');
INSERT INTO SALES VALUES(2,'12-feb-2015',10,'east');

commit;

select * from sales;

explain plan for 
select * from sales where order_date='12-jan-2015';
select * from sales partition(sales_pmax);


---------------------------------------------

CREATE TABLE SALES_PARTITION_LIST
(
customer_id NUMBER,
order_date DATE,
order_amount NUMBER,
region varchar2(10)
)
PARTITION BY LIST(region)
(
PARTITION partition_east VALUES ('east'),
PARTITION partition_west VALUES ('west'),
PARTITION partition_nort_south VALUES ('north', 'south')
);

INSERT INTO SALES_PARTITION_LIST values (1,'12-jan-2019',10,'east');
INSERT INTO SALES_PARTITION_LIST values (2,'12-jan-2019',20,'west');
INSERT INTO SALES_PARTITION_LIST values (3,'12-jan-2019',30,'north');
INSERT INTO SALES_PARTITION_LIST values (4,'12-jan-2019',40,'south');

select * from SALES_PARTITION_LIST;

select * from SALES_PARTITION_LIST PARTITION(partition_nort_south)

select * from SALES_PARTITION_LIST PARTITION(partition_east)

----------------------------------------------
HASH PARTITIONING

CREATE TABLE SALES_PARTITION_HASH
(
customer_id NUMBER,
order_date DATE,
order_amount number,
region varchar2(10)
)
PARTITION BY HASH(customer_id)
(
PARTITION c1,
PARTITION c2,
PARTITION c3,
PARTITION c4
);

INSERT INTO SALES_PARTITION_HASH values (1,'12-jan-2019',10,'east');
INSERT INTO SALES_PARTITION_HASH values (2,'12-jan-2019',20,'west');
INSERT INTO SALES_PARTITION_HASH values (3,'12-jan-2019',30,'north');
INSERT INTO SALES_PARTITION_HASH values (4,'12-jan-2019',40,'south');

SELECT * FROM SALES_PARTITION_HASH;

--------------------------

COMPOSITE PARTITION

CREATE TABLE SALES_PARTITION_COMPOSITE_PARTITION
(
customer_id NUMBER,
order_date DATE,
order_amount number,
region varchar2(10)
)
PARTITION BY RANGE(order_date)
SUBPARTITION BY HASH(customer_id) SUBPARTITIONS 4
(
PARTITION partition_julio VALUES LESS THAN (TO_DATE('2015-07-01', 'YYYY-MM-DD')),
PARTITION partition_agosto VALUES LESS THAN (TO_DATE('2015-08-01', 'YYYY-MM-DD')),
PARTITION partition_septiembre VALUES LESS THAN (TO_DATE('2015-09-01', 'YYYY-MM-DD')),
PARTITION partition_pmax VALUES LESS THAN (MAXVALUE)
);

SELECT * FROM SALES_PARTITION_COMPOSITE_PARTITION;

INSERT INTO SALES_PARTITION_COMPOSITE_PARTITION VALUES(1,'12-jan-2015',10,'east');
INSERT INTO SALES_PARTITION_COMPOSITE_PARTITION VALUES(2,'12-feb-2015',10,'east');

INSERT INTO SALES_PARTITION_COMPOSITE_PARTITION VALUES(1,'12-AUG-2015',10,'east');
INSERT INTO SALES_PARTITION_COMPOSITE_PARTITION VALUES(2,'12-SEP-2015',10,'east');

SELECT * FROM SALES_PARTITION_COMPOSITE_PARTITION PARTITION(partition_septiembre)
WHERE order_date='12-AUG-2015'

------------------------------------------

INTERVAL PARTITIONING

CREATE TABLE SALES_PARTITION_BY_INTERVAL
(
customer_id NUMBER,
order_date DATE,
order_amount number,
region varchar2(10)
)
PARTITION BY RANGE(order_date)
INTERVAL(NUMTOYMINTERVAL(1,'MONTH'))
(
PARTITION partition_julio VALUES LESS THAN (TO_DATE('2015-07-01', 'YYYY-MM-DD')),
PARTITION partition_agosto VALUES LESS THAN (TO_DATE('2015-08-01', 'YYYY-MM-DD')),
PARTITION partition_septiembre VALUES LESS THAN (TO_DATE('2015-09-01', 'YYYY-MM-DD'))
);


INSERT INTO SALES_PARTITION_BY_INTERVAL VALUES(1,'12-AUG-2015',10,'east');
INSERT INTO SALES_PARTITION_BY_INTERVAL VALUES(2,'12-SEP-2015',10,'east');
INSERT INTO SALES_PARTITION_BY_INTERVAL VALUES(2,'22-OCT-2019',10,'east');

SELECT * FROM SALES_PARTITION_BY_INTERVAL PARTITION(partition_septiembre)
WHERE order_date='12-AUG-2015'

SYS_P245

SELECT * FROM SALES_PARTITION_BY_INTERVAL PARTITION(SYS_P245)

SELECT * FROM ALL_TAB_PARTITIONS;

--------------------
adding new partitions 


ALTER TABLE SALES ADD PARTITION p10 VALUES LESS THAN(TO_DATE ('2016-01-01', 'YYYY-MM-DD'));

ALTER TABLE SALES ADD PARTITION sales_pmax VALUES LESS THAN (MAXVALUE)

ALTER TABLE SALES DROP PARTITION SALES_PMAX;

PARTITION partition_septiembre VALUES LESS THAN (TO_DATE('2015-09-01', 'YYYY-MM-DD'))


----------------------
--- TABLESPACE
----------------------



CREATE TABLESPACE tbs1
DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\USERS_CREATED.DBF'
size 50m
autoextend on
next 512k
maxsize 250M;

DROP TABLESPACE tbs1 INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE tbs2
DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\USERS_CREATED2.DBF'
size 10m
REUSE
autoextend on
next 512k
maxsize 250M;


DROP TABLESPACE TBS2;

DROP TABLESPACE TBS2 INCLUDING CONTENTS AND DATAFILES;


-- adding a datafile to the tablespace TBS2

ALTER TABLESPACE TBS2
ADD DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\USERS_CREATED3.DBF'
size 10m


ALTER DATABASE
DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\USERS_CREATED3.DBF'
RESIZE 100m;



commit;



CREATE TABLESPACE tbs_creado
DATAFILE 'C:\APP\APEIRON\ORADATA\ORCL\ORCLPDB\TABLESPACE_USERS.DBF'
size 10m

autoextend on
next 512k
maxsize 250M;


select FILE_NAME, FILE_ID, TABLESPACE_NAME, BYTES/1024/1024, BLOCKS, STATUS, RELATIVE_FNO, AUTOEXTENSIBLE, MAXBYTES/1024/1024, INCREMENT_BY, USER_BYTES/1024/1024, USER_BLOCKS, 
ONLINE_STATUS, LOST_WRITE_PROTECT from dba_data_files;

select * from dba_data_files;

ALTER TABLESPACE TBS2_RENAMED DROP DATAFILE 'C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\USERS_CREATED3.DBF' INCLUDING CONTENTS AND DATAFILES;

 ALTER TABLESPACE TBS2 RENAME TO TBS2_RENAMED;


ALTER TABLESPACE TBS2_RENAMED OFFLINE;

ALTER TABLESPACE TBS2_RENAMED ONLINE;

ALTER DATABASE RENAME FILE 'C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\USERS_CREATED3.DBF' TO 'C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\USERS_CREATED3_RENAMED.DBF';

C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\USERS_CREATED3.DBF


select FILE_NAME, FILE_ID, TABLESPACE_NAME, BYTES/1024/1024

---
BUILDING A TABLE AND INSERTING VALUES

DROP TABLE HR.student;

CREATE TABLE hr.student(sno number, sname varchar2(100)) tablespace tbs2;

CREATE TABLE hr.student(sno number, sname varchar2(100)) tablespace TBS_CREADO;


BEGIN
FOR i in 1..1000000
LOOP
INSERT INTO hr.student VALUES (i,'Azeem Rules');
END LOOP;
COMMIT;
END; 


select * from user_objects where OBJECT_NAME LIKE 'ST%';


select * from hr.student

select count(*) from hr.student -- total soportado: 372,046

BEGIN
FOR i in 1..1000000
LOOP
INSERT INTO hr.student VALUES (i,'Azeem Rules');
END LOOP;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
END; 

INSERT INTO hr.student VALUES (9999,'Azeem Rules');

----------------

SELECT TABLESPACE_NAME, FILE_ID, BLOCK_ID, BYTES/1024/1024, BLOCKS, RELATIVE_FNO FROM dba_free_space;

SELECT * FROM dba_free_space;

select * from dba_data_files;

select sys_context('USERENV', 'CURRENT_SCHEMA') from dual;



select
	tablespace_name,
	curr_size,
	max_size,
	free_size,
	curr_size-free_size used_size,
	pct_free,
	round(((max_size-(curr_size-free_size))/max_size)*100,2) pct_free_total,
	free_chunks,
	largest_chunk
from
	(select 
		ts.tablespace_name,
		round(dbf.bytes/1024/1024,2) curr_size,
		round(dbf.maxbytes/1024/1024) max_size,
		nvl(round(fs.bytes/1024/1024,2),0) free_size,
		round((nvl(fs.bytes,0)/dbf.bytes)*100,2) pct_free,
		nvl(fs.free_chunks,0) free_chunks,
		nvl(round(fs.largest_chunk/1024/1024,2),0) largest_chunk
	 from
		dba_tablespaces ts,
		(select
			tablespace_name,
			sum(bytes) bytes, 
			sum(greatest(maxbytes,bytes)) maxbytes
		 from
			(select tablespace_name,bytes,maxbytes from dba_data_files)
		 group by tablespace_name
		) dbf,
		(select
			tablespace_name, 
			sum(bytes) bytes,
			count(*) free_chunks,
			max(bytes) largest_chunk
		 from dba_free_space
		 group by tablespace_name
		) fs
	 where ts.tablespace_name=dbf.tablespace_name
	   and ts.tablespace_name=fs.tablespace_name(+)
	)
order by pct_free desc;


-------------------


 SHOW PARAMETER db_block_size;
 
 
 select * from dba_temp_files;
 
 
CREATE TEMPORARY TABLESPACE TEMP_TBS_CREADO TEMPFILE 'C:\APP\XMY9080\ORADATA\ORCL\ORCLPDB\TEMP_TBS_CREADO.DBF' SIZE 10M;

SELECT * FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_TEMP_TABLESPACE';


SELECT * FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_PERMANENT_TABLESPACE';

SELECT * FROM dba_tablespace_groups;

