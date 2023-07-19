CREATE TABLE PatientAge
	(
	ID int NOT NULL Primary Key,
	Age int NULL
)
INSERT INTO [dbo].[PatientAge] (ID, Age) 
VALUES
	(1, 34),
	(2, 56),
	(3, 31),
	(4, 35);

SELECT * FROM [dbo].[PatientAge]

INSERT INTO [dbo].[PatientAge] (ID, Age) 
VALUES
	(7, 34);
	
