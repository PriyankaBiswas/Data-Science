--Q. 1. What's the most expensive listing? What else can you tell me about the listing?

SELECT 
	*, MAX(price)
FROM listings
  -- Name "Liberty Station Luxury Home" in the Midtown Distrinct rented $4900/night.  
  --Host name is Dominic. Entire home is available for booking. No reviews available. 
 

--Q. 2. What neighborhoods seem to be the most popular?
WITH most_bookings AS (
	SELECT 
		listing_id, 
		COUNT(*) times_booked --counts the number of times a listing has been booked
	FROM 
		listing_booking
	GROUP BY listing_id
	ORDER BY times_booked DESC
)
SELECT 
	l.neighbourhood, SUM(m.times_booked) total_bookings 
	--sums the number of times a listing is booked and group by neighbourhood
FROM 
	listings l
JOIN 
	most_bookings m
ON l.id = m.listing_id
GROUP BY l.neighbourhood
ORDER BY total_bookings DESC
-- Pacific Beach with 9725 total number of bookings

--Q. 3. What time of year is the cheapest time to go to your city? What about the busiest?

SELECT date, COUNT(*) times_not_available
FROM calendar
WHERE available like 'f'
GROUP BY date
ORDER BY  times_not_available DESC
-- July seems to be the busiest as top 27 rows returns dates in July as not available, followed by August
-- Additionally, I am assuming that the off-season dates are being considered as the cheapest. I didn't find a price difference for the same property over time, 
-- so it's unlikely that the price changes according to the season. With the assumption that we are looking for off-season months, then  
--Sept, Oct. early Dec. and May seem to be the least busy times 


--**--
--Some additional codes for finding out the most active business, price difference etc. 
SELECT host_id, id, MIN(price), MAX(price), calculated_host_listings_count times_posted
FROM listings
GROUP BY host_id
ORDER BY times_posted DESC

SELECT *
FROM listings
WHERE host_id = 70331063
ORDER BY price DESC
-- host_id 70331063 SeaBreeze Vacation Rentals posted 90 times, with different properties, ranging from $224 - $3416. 

-- Attempting Q1. 
 SELECT 
	*, MAX(l.price),
 	COUNT (*) times_booked 
FROM 
	listings l
JOIN 
	listing_booking lb
ON l.id = lb.listing_id
GROUP BY lb.listing_id
ORDER BY l.price DESC
LIMIT 3

-- Wroing answer: this query returns "Jewel - View over La Jolla Shores" as the most expensive listing, for $2500, booked onc. However, this is a wrong query, 
-- because I did a join on ids from the listings and the listings and bookings table, the latter doesn't seem to have all records. 
--On manual inspection I find that there are more expensive listings. One caveat is that its minimum nights is 30, which has a potential impact on the price. 
