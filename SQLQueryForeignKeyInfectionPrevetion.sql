Alter Table [dbo].[PatientRecords] Add Constraint PatientRecords_LocationID_FK 
Foreign Key (LocationID) References Regions(ID)