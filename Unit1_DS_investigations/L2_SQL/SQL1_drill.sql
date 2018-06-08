--Drill1: The ID's and durations for all trips of duration greater than 500, 
--ordered by duration.
SELECT 
	trip_id, 
	duration
FROM 
	trips
WHERE 
	duration > 500
-- 165545 rows returned
	
-- Drill2: Every column of the stations table for station id 84.
SELECT  *
FROM 
	stations
WHERE 
	station_id = 84
	
--Drill3: The min temperatures of all the occurrences of rain in zip 94301.
SELECT
	MinTemperatureF
FROM 
	weather
WHERE 
	ZIP = 94301 and
	Events like 'rain'
ORDER BY MinTemperatureF
--37 rows returned
