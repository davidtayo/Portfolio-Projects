WITH HotelData AS (
SELECT * FROM [dbo].['2018$']
UNION
SELECT * FROM [dbo].['2019$']
UNION
SELECT * FROM [dbo].['2020$'])

SELECT [arrival_date_year],[hotel], ROUND(SUM(([stays_in_weekend_nights] + [stays_in_week_nights]) * [adr]),2) AS Revenue
FROM HotelData
GROUP BY [arrival_date_year], [hotel]

SELECT * FROM [dbo].[market_segment$]

WITH HotelData AS (
SELECT * FROM [dbo].['2018$']
UNION
SELECT * FROM [dbo].['2019$']
UNION
SELECT * FROM [dbo].['2020$'])

SELECT * FROM HotelData
LEFT JOIN [dbo].[market_segment$]
ON HotelData.[market_segment] = [dbo].[market_segment$].[market_segment]
LEFT JOIN [dbo].[meal_cost$]
ON HotelData. [meal] = [dbo].[meal_cost$].meal