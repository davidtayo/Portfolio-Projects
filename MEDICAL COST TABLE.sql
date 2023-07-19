SELECT * 
FROM [dbo].[PatientRecords]

CREATE TABLE MedicalCost
	(
	PatientID int NOT NULL Primary Key,
	Name nvarchar(50) NULL,
	AmountSpent int NOT NULL
)

INSERT INTO [dbo].[MedicalCost](PatientID, Name, AmountSpent) 
VALUES
	(1, 'Jide Chord', 1200),
	(3, 'Michael Jackson', 3000),
	(5, 'Michael Wilson', 9000),
	(6, 'Daniel Wilson', 5321),
	(7, 'Jide Peter', 4500);

SELECT * FROM [dbo].[MedicalCost]
