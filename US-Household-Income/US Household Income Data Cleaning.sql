# US Household Income Data Cleaning

SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;

ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

SELECT *
FROM us_household_income_statistics;

# Checking for duplicates
SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

SELECT *
FROM (
	SELECT id, row_id, ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS RowNumber
	FROM us_household_income
	) AS RowTable
WHERE RowNumber > 1;

# Deleting the duplicates
DELETE FROM us_household_income
WHERE row_id IN (
		SELECT row_id
		FROM (
			SELECT id, row_id, ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS RowNumber
			FROM us_household_income
			) AS RowTable
		WHERE RowNumber > 1
        );

# Checking for duplicates here
SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1;

SELECT State_Name, COUNT(State_Name)
FROM us_household_income
GROUP BY State_Name;

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

SELECT DISTINCT State_Name
FROM us_household_income
ORDER BY 1;

SELECT DISTINCT State_ab
FROM us_household_income
ORDER BY 1;

SELECT DISTINCT *
FROM us_household_income
WHERE Place = ''
ORDER BY 1;

SELECT DISTINCT *
FROM us_household_income
WHERE County = 'Autauga County'
ORDER BY 1;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
	AND City = 'Vinemont';
    
SELECT DISTINCT *
FROM us_household_income
WHERE County = 'Autauga County'
ORDER BY 1;

SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
ORDER BY 1;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
ORDER BY 1;

SELECT Aland, AWater
FROM us_household_income
WHERE (ALand = 0 OR ALand IS NULL OR ALand = '');

SELECT Aland, AWater
FROM us_household_income
WHERE (ALand = 0 OR ALand IS NULL OR ALand = '')
AND (AWater = 0 OR AWater IS NULL OR AWater = '');
