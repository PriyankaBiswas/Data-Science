--  Second drill on Aggregates and groups

--Q1. What was the hottest day in our data set? Where was that?
SELECT 
	weather.Date, 
	MAX(weather.MaxTemperatureF), 
	weather.ZIP
FROM 
	weather
-- 2015/11/17 - 134F in 94063

--How many trips started at each station?
SELECT 
	start_station,
	COUNT(*) trip_count
FROM 
	trips
GROUP BY 
	start_station
ORDER BY trip_count

-- 80 rows returned

--Q2. What's the shortest trip that happened?
SELECT 
	*,
	MIN(duration)
FROM 
	trips
-- duration 60 start station Mezes

--Q3. What is the average trip duration, by end station?

SELECT 
	end_station, 
	duration)
FROM 
	trips
GROUP BY 
	end_station
ORDER BY
	2
-- 80 rows returned 

