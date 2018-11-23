# Create table as other table: 

CT DatabaseName.TableName as DatabaseNameReference.TableNameReference with no data;

# Insert values INSERT INTO - SELECT

INSERT INTO DatabaseName.TableName

SELECT * FROM DatabaseNameReference.TableNameReference

WHERE CONDITION='CONDITION';


# Teradata INFO

-- Getting Databases and tables info -- Teradata

 SELECT DatabaseName,TableName, CreatorName, CreateTimeStamp, LastAlterName FROM dbc.columns
 GROUP BY (DatabaseName,TableName, CreatorName, CreateTimeStamp, LastAlterName)
 where DatabaseName NOT IN ('DBC','dbcmngr')
 ORDER BY DatabaseName, CreateTimeStamp;