SELECT * FROM [dbo].[Virtual Patient_Dataset]

SELECT DISTINCT [part_id] 
FROM [dbo].[Virtual Patient_Dataset]

--Standardize Date Format
SELECT [q_date], CONVERT(DATE,[q_date])
FROM [dbo].[Virtual Patient_Dataset]

UPDATE [dbo].[Virtual Patient_Dataset]
SET [q_date] = CONVERT(DATE,[q_date])

--Change M and F to Male and Female in gender field.
SELECT DISTINCT([gender]), COUNT([gender])
FROM [dbo].[Virtual Patient_Dataset]
GROUP BY [gender]
ORDER BY 2

SELECT [gender]
, CASE WHEN [gender] = 'M' THEN 'MALE'
	   WHEN [gender] = 'F' THEN 'FEMALE'
	   ELSE [gender] 
	   END
FROM [dbo].[Virtual Patient_Dataset]

UPDATE [dbo].[Virtual Patient_Dataset]
SET [gender] = CASE WHEN [gender] = 'M' THEN 'MALE'
	   WHEN [gender] = 'F' THEN 'FEMALE'
	   ELSE [gender] 
	   END

SELECT * FROM [dbo].[Virtual Patient_Dataset]


--Remove Duplicates
WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER()OVER(
	PARTITION BY[part_id],
				[gender],
				[hospitalization_one_year],
				[vision]
				ORDER BY
					[part_id]
					) [medication_count]
FROM [dbo].[Virtual Patient_Dataset]
--ORDER BY [part_id]
)
SELECT *
FROM  RowNumCTE 

