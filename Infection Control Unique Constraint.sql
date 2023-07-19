SELECT * FROM [dbo].[PatientRecords]

ALTER TABLE  [dbo].[PatientRecords] 
ADD CONSTRAINT UQ_Patient_Records_Name UNIQUE (Name)


INSERT INTO [dbo].[PatientRecords]
VALUES (8, 'Jide Peter', 'Scabies', 'Male', 2);

ALTER TABLE [dbo].[PatientRecords]
DROP CONSTRAINT UQ_Patient_Records_Name