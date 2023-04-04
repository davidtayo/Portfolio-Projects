SELECT * FROM [dbo].['Covid Death$']
SELECT * FROM [dbo].['Covid Vaccination$']

SELECT [location], [date],[total_cases],[new_cases], [total_deaths], [population]
FROM [dbo].['Covid Death$']
ORDER BY 1, 2

--To Calculate % of deaths i.e. to show the likelihood of dying if you get covid
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS PercentageDeath
FROM [dbo].['Covid Death$']
WHERE location like '%states%'
ORDER BY 1,2

--Total cases vs Population i.e. to show what percentage of population got covid
SELECT location, [date], total_cases, [population], (total_cases/[population])*100 AS PercentageCovidCases
FROM [dbo].['Covid Death$']
WHERE location like '%Nigeria%'
ORDER BY 1,2

--Countries with the Highest infection rate compared to population
SELECT location, [population], MAX(total_cases)AS HighestInfectionCount, MAX((total_cases/[population]))*100 AS HighestInfectionPercentage
FROM [dbo].['Covid Death$']
--WHERE location like '%Nigeria%'
GROUP BY location, population
ORDER BY HighestInfectionPercentage DESC

--Countries with the highest death count per population
SELECT location, MAX(CAST([total_deaths] AS INT))AS TotalDeathCount
FROM [dbo].['Covid Death$']
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

--BREAK DOWN BY CONTINENT
SELECT location, MAX(CAST([total_deaths] AS INT))AS TotalDeathCount
FROM [dbo].['Covid Death$']
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

--GLOBAL DATA
SELECT SUM([new_cases]) AS Total_Cases, SUM(CAST([new_deaths]AS INT)) AS Total_Deaths, SUM(CAST([new_deaths] AS INT))/
SUM([new_cases])*100 AS DeathPercentage
FROM [dbo].['Covid Death$']
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2
 
SELECT SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Deaths, SUM(new_deaths) / SUM(new_cases) * 100 AS DeathPercentage 
FROM [dbo].['Covid Death$']
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1, 2

SELECT * FROM [dbo].['Covid Vaccination$']

--Total Population Vs Vaccination
SELECT * FROM [dbo].['Covid Vaccination$'] Vacc
JOIN [dbo].['Covid Death$'] Dea
ON Vacc.location = Dea.location
AND Vacc.date = Dea.date

SELECT * FROM [dbo].['Covid Vaccination$'] Vacc
JOIN [dbo].['Covid Death$'] Dea
ON Vacc.location = Dea.location
AND Vacc.date = Dea.date  

WITH PopulationvsVacc (continent, location, date, population, new_vaccinations, 
CummulativeVaccination)
AS
(
SELECT dea.continent,  dea.location, dea.date, dea.population, Vacc.new_vaccinations,
SUM(CONVERT(FLOAT, Vacc.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, 
dea.date) AS CummulativeVaccination
FROM [dbo].['Covid Death$'] Dea
JOIN [dbo].['Covid Vaccination$'] Vacc
	ON Dea.location	 =  Vacc.location 
	AND Dea.date = Vacc.date  
WHERE dea.continent  IS NOT NULL
--ORDER BY 2, 3
)
SELECT *, (CummulativeVaccination/population)*100  AS PercentageVaccinated
FROM PopulationvsVacc
-- USE CTE

WITH PopulationvsVacc

--TEMP TABLE

--Creating View for Visualisation
CREATE VIEW  PopulationVaccinated AS
SELECT dea.continent,  dea.location, dea.date, dea.population, Vacc.new_vaccinations,
SUM(CONVERT(FLOAT, Vacc.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, 
dea.date) AS CummulativeVaccination
FROM [dbo].['Covid Death$'] Dea
JOIN [dbo].['Covid Vaccination$'] Vacc
	ON Dea.location	 =  Vacc.location 
	AND Dea.date = Vacc.date  
WHERE dea.continent  IS NOT NULL
--ORDER BY 2, 3

SELECT * FROM [dbo].[PopulationVaccinated]