SELECT * FROM [dbo].[NashvilleHousing]

--To change to the standard date format
SELECT [SaleDate], CONVERT(Date,[SaleDate]) 
FROM [dbo].[NashvilleHousing]

UPDATE [dbo].[NashvilleHousing]
SET [SaleDate] = CONVERT(Date,[SaleDate]) 

ALTER TABLE [dbo].[NashvilleHousing]
ADD SaleConvertred = CONVERT(Date,[SaleDate]) 

UPDATE [dbo].[NashvilleHousing]
SET SaleConvertred  = CONVERT(Date,[SaleDate]) 

--To Insert Property Address Data
SELECT *
FROM [dbo].[NashvilleHousing]
--WHERE [PropertyAddress] IS NULL
ORDER BY [ParcelID]

--To populate missing property addresses, do a self-join to fill in the property address from the same 
- -ParcelID
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [dbo].[NashvilleHousing] a
JOIN [dbo].[NashvilleHousing] b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

UPDATE a 
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [dbo].[NashvilleHousing] a
JOIN [dbo].[NashvilleHousing] b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

--Breaking out Address into 'Address, 'City', and 'State'
SELECT [PropertyAddress]
FROM [dbo].[NashvilleHousing]
--WHERE [PropertyAddress] IS NULL
--ORDER BY [ParcelID]

--Breaking Address out and removing the comma
SELECT 
SUBSTRING([PropertyAddress], 1, CHARINDEX(',', [PropertyAddress])-1) AS Address
,SUBSTRING([PropertyAddress], CHARINDEX(',', [PropertyAddress]) +1 , LEN([PropertyAddress])) AS ADDRESS

FROM [dbo].[NashvilleHousing]

ALTER TABLE [dbo].[NashvilleHousing]
ADD PropertySplitAddress nvarchar(200) 

UPDATE [dbo].[NashvilleHousing]
SET PropertySplitAddress = SUBSTRING([PropertyAddress], 1, CHARINDEX(',', [PropertyAddress])-1) 


ALTER TABLE [dbo].[NashvilleHousing]
ADD PropertySplitCity nvarchar(200)

UPDATE [dbo].[NashvilleHousing]
SET PropertySplitCity = SUBSTRING([PropertyAddress], CHARINDEX(',', [PropertyAddress]) +1 , LEN([PropertyAddress]))

SELECT * FROM [dbo].[NashvilleHousing]

SELECT [OwnerAddress] FROM [dbo].[NashvilleHousing]

--To split OwnerAddress into three columns using PARSE and REPLACE - Easier one
SELECT
PARSENAME(REPLACE([OwnerAddress], ',', '.'), 3)
,PARSENAME(REPLACE([OwnerAddress], ',', '.'), 2)
,PARSENAME(REPLACE([OwnerAddress], ',', '.'), 1)
FROM [PortfolioProject].dbo.[NashvilleHousing]

--To add column names to the splitted address
ALTER TABLE [dbo].[NashvilleHousing]
ADD OwnerSplitAddress nvarchar(200) 

UPDATE [dbo].[NashvilleHousing]
SET OwnerSplitAddress =  PARSENAME(REPLACE([OwnerAddress], ',', '.'), 3)


ALTER TABLE [dbo].[NashvilleHousing]
ADD OwnerSplitCity nvarchar(200)

UPDATE [dbo].[NashvilleHousing]
SET OwnerSplitCity = PARSENAME(REPLACE([OwnerAddress], ',', '.'), 2)

ALTER TABLE [dbo].[NashvilleHousing]
ADD OwnerSplitState nvarchar(200)

UPDATE [dbo].[NashvilleHousing]
SET OwnerSplitState = PARSENAME(REPLACE([OwnerAddress], ',', '.'), 1)

SELECT * FROM [dbo].[NashvilleHousing]


--To change 1 and 0 to YES and No in ''Sold as Vacant' column
SELECT DISTINCT([SoldAsVacant]), COUNT([SoldAsVacant])
FROM [dbo].[NashvilleHousing]
GROUP BY [SoldAsVacant]
ORDER BY 2

---Remove duplicate - Use Window Function
WITH RowNumCTE as (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice, 
				 SaleDate,
				 LegalReference
				 ORDER BY 
					UniqueID
					) row_num
FROM [dbo].[NashvilleHousing]
--ORDER BY ParcelID
)

SELECT *  FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress

DELETE  FROM RowNumCTE
WHERE row_num > 1
--ORDER BY PropertyAddress


--Deleting unused columns
ALTER TABLE [dbo].[NashvilleHousing]
DROP COLUMN [OwnerAddress], [TaxDistrict], [PropertyAddress]