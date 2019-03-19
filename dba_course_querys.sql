---
-- UDEMY DBA COURSE QUERYS--
---

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
