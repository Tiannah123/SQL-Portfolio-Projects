SELECT *
FROM "covid deaths"

SELECT*
FROM "covid vaccinations"

SELECT *
FROM "covid deaths"
WHERE continent is not null
ORDER BY 3,4

SELECT*
FROM "covid vaccinations"
ORDER BY 3,4

-- Selecting the datas needed
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM "covid deaths"
ORDER BY 1,2

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM "covid deaths"
ORDER BY 1,2

-- Total cases vs Total deaths in Africa
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM "covid deaths"
WHERE location like '%Africa%'
ORDER BY 1,2

-- Total cases vs Total deaths in the States
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM "covid deaths"
WHERE location like '%State%'
ORDER BY 1,2

-- Total cases vs Poplulation in Africa
SELECT location, date, total_cases, population, (total_cases/population)*100 AS cases_percentage
FROM "covid deaths"
WHERE location like '%Africa%'
ORDER BY 1,2

-- Countries with highest infection rate compaired to population
SELECT location, population, MAX(total_cases)AS infection_count, MAX((total_cases/population))*100 AS cases_percentage
FROM "covid deaths"
GROUP BY location, population
ORDER BY cases_percentage DESC

-- Countries with highest death count per population
SELECT location, MAX(total_deaths) AS totaldeath_count
FROM "covid deaths"
WHERE continent is not null
GROUP BY location
ORDER BY totaldeath_count DESC

-- Continent with highest death counts
SELECT continent, MAX(total_deaths) AS totaldeath_count
FROM "covid deaths"
WHERE continent is not null
GROUP BY continent
ORDER BY totaldeath_count DESC

-- Continent with highest death counts per populations
SELECT continent, MAX(total_deaths) AS totaldeath_count
FROM "covid deaths"
WHERE continent is not null
GROUP BY continent
ORDER BY totaldeath_count DESC

-- Global Numbers
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage 
FROM "covid deaths"
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage 
FROM "covid deaths"
WHERE continent is not null
ORDER BY 1,2

-- Covid Deaths Table and Covid Vaccinaation Table
SELECT*
FROM "covid deaths" dea
JOIN "covid vaccinations" vac
	ON dea.location = vac.location
	and dea.date = vac.date

-- Total Population vs Vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM "covid deaths" dea
JOIN "covid vaccinations" vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 1,2,3

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingpeople_vaccinated
FROM "covid deaths" dea
JOIN "covid vaccinations" vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

-- Using CTE
WITH PopvsVac (continent, location, date, population, new_vaccinations, rollingpeople_vaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingpeople_vaccinated
FROM "covid deaths" dea
JOIN "covid vaccinations" vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3
)
SELECT *, (rollingpeople_vaccinated/population)*100
FROM PopvsVac



-- TEMP TABLE
CREATE Table Percentage_population_vaccinated
(
continent text,
location varchar(300),
date date,
population numeric,
new_vaccinations numeric,
rollingpeople_vaccinated numeric
);

INSERT INTO Percentage_population_vaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingpeople_vaccinated
FROM "covid deaths" dea
JOIN "covid vaccinations" vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null;

SELECT *, (rollingpeople_vaccinated/population)*100
FROM Percentage_population_vaccinated

-- Creating view to store data for Visualization
CREATE VIEW Percent_population_vaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingpeople_vaccinated
FROM "covid deaths" dea
JOIN "covid vaccinations" vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3
