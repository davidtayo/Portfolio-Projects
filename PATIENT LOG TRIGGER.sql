SELECT * FROM [dbo].[PatientRecords]

CREATE TABLE PatientLogs 
	(PatientID nchar(10),
	Status varchar(30)
	)

CREATE TRIGGER PatientRecords_INSERT
	ON [dbo].[PatientRecords]
	AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @PatientID nchar(5)
	SELECT @PatientID = INSERTED.PatientID
	FROM INSERTED

	INSERT INTO PatientLogs 
	VALUES (@PatientID, 'Inserted')
END