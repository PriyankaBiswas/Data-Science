-- -- Third drills on Joins and CTEs 

--What are the three longest trips on rainy days?
SELECT > FROM > JOIN - ON > WHERE > GROUP BY > ORDER BY 
SELECT 
	weather.Events, 
	trips.duration,
	trips.trip_id
FROM 
	weather
JOIN
	trips 
ON 
	weather.ZIP = trips.zip_code
WHERE weather.Events like 'rain'
GROUP BY 3
ORDER BY duration desc
LIMIT 3
-- three trips ranging between  81434 - 83915

--Which station is full most often?
WITH
    empty_station
AS (
	SELECT
		station_id,
        docks_available,
        COUNT(*) station_count
    FROM
        status
    WHERE docks_available = 0
	GROUP BY station_id
) 
SELECT
    s.station_id,
    s.name,
	e.station_count
FROM
    stations s
JOIN
    empty_station e
ON
    s.station_id = e.station_id
ORDER BY e.station_count DESC
-- San Francisco Caltrain (Townsend at 4th, id - 70), 23450 times zero docks available

--Return a list of stations with a count of number of trips starting at that station but ordered by dock count.
SELECT 
	stations.station_id, 
	trips.start_station,
	COUNT (*) trip_start_count,
	stations.dockcount
FROM 
	trips
JOIN 
	stations 
ON  trips.start_station = stations.name
GROUP BY trips.start_station
ORDER BY stations.dockcount
-- 63 rows returned least - Castro st. & El Camino Real, max. Cyrill Magnin St. at Ellis St. 

--(Challenge) What's the length of the longest trip for each day it rains anywhere?
WITH mx_zip AS(
	WITH mx_date AS (
		SELECT start_date, MAX(duration) max_dur, zip_code
		FROM trips
		GROUP BY start_date
	)
	SELECT zip_code, MAX(max_dur) max_dur FROM mx_date
	GROUP BY zip_code
)
SELECT weather.Date, mx_zip.max_dur
FROM weather
JOIN mx_zip
ON mx_zip.zip_code = weather.ZIP
WHERE weather.Events like 'rain'
GROUP BY weather.Date
-- 92 rows returned starting from 2015-09-02 with max duration 11897 to 2016-07-18 with 65191 