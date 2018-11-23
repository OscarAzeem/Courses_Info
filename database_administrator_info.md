A database it's stored in at least one (could be more) Tablespace
A tablespace can have at least one (could be more) Datafile
A simple table can live in JUST ONE Tablespace (such tablespace can have many Datafiles)
A table can live in more Tablespaces when: 
	1) Partitioned table
    2) Tables containing LOBs.


A tablespace can go online/offline


You can enlarge a database in three ways:
■ Add a datafile to a tablespace
■ Add a new tablespace
■ Increase the size of a datafile



system global area (SGA)

stored object (such as a procedure, view, or trigger)

Partitions 

• Tables
–Heap tables
–Index-organized tables
• Indexes
–Global Indexes
–Local Indexes
• Materialized Views
• Hash Clusters



Partitioning Methods
Single-level partitioning
Range,  Ideal for chronological data
List, Ideal for segmentation of distinct values, e.g. region
Hash, Ideal for equal data distribution




Composite-level partitioning

[Range | List | Hash | Interval] –
[Range | List | Hash]


Partitioning extensions
Interval, Partitions are created automatically as data arrives, Extension to RANGE partitioning


Reference
 Interval Reference
  Virtual Column Based
