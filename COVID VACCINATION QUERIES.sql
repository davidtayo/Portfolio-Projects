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