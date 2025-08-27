# World Life Expectancy Project (Exploratory Data Analysis)

SELECT *
FROM world_life_expectancy;

SELECT Country,
		MIN(`Life expectancy`),
        MAX(`Life expectancy`),
        ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS LifeIncreaseIn15Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
	AND MAX(`Life expectancy`) <> 0
ORDER BY LifeIncreaseIn15Years DESC;

SELECT Year, Country, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Year, Country
ORDER BY Year;

## HAVING is for AGGREGATE FUNCTIONS
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS LifeExpectancy, ROUND(AVG(GDP), 1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING LifeExpectancy > 0
	AND GDP > 0
ORDER BY GDP ASC;

SELECT
	SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) HighGDPCounts,
    ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END), 2) HighGDPLifeExpectancy,
    SUM(CASE WHEN GDP < 1500 THEN 1 ELSE 0 END) LowGDPCounts,
    ROUND(AVG(CASE WHEN GDP < 1500 THEN `Life expectancy` ELSE NULL END), 2) LowGDPLifeExpectancy
FROM world_life_expectancy;

SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

SELECT Status, COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status;

SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS LifeExpectancy, ROUND(AVG(BMI), 1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING LifeExpectancy > 0
	AND BMI > 0
ORDER BY BMI ASC;

SELECT Country, Year, `Life expectancy`, `Adult Mortality`,
	SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS RollingTotal
FROM world_life_expectancy
WHERE Country LIKE '%Nigeria%'


