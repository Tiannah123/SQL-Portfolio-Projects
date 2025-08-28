# US Household Income Exploratory Data Analysis

SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;

SELECT State_Name, SUM(ALand)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;

SELECT State_Name, SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;

SELECT *
FROM us_household_income uhi
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id;

SELECT *
FROM us_household_income uhi
RIGHT JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE uhi.id IS NULL;

SELECT *
FROM us_household_income uhi
INNER JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean <> 0;

SELECT uhi.State_Name, County, Type, `Primary`, Mean, Median
FROM us_household_income uhi
INNER JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean <> 0;

SELECT uhi.State_Name, ROUND(AVG(Mean), 2), ROUND(AVG(Median), 2)
FROM us_household_income uhi
INNER JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean <> 0
GROUP BY uhi.State_Name
ORDER BY 2
LIMIT 5;

SELECT Type, COUNT(Type), ROUND(AVG(Mean), 2), ROUND(AVG(Median), 2)
FROM us_household_income uhi
INNER JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 1 DESC
LIMIT 20;

SELECT Type, COUNT(Type), ROUND(AVG(Mean), 2), ROUND(AVG(Median), 2)
FROM us_household_income uhi
INNER JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 1 DESC
LIMIT 20;

SELECT uhi.State_Name, City, ROUND(AVG(Mean), 2), ROUND(AVG(Median), 2)
FROM us_household_income uhi
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
GROUP BY uhi.State_Name, City
ORDER BY ROUND(AVG(Mean), 2) DESC;


