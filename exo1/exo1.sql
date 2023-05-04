Use Chinook;

-- QUERY 1
-- Exploration of the Customer table in the Chinook database
SELECT * FROM customers;

-- QUERY 2
-- Extract CustomerId, Company and City data from the customer table in the Chinook database
SELECT CustomerId, Company, City
  FROM customers;

-- QUERY 3
-- Extract the Lastname, Firstname, email and city from the same table
SELECT LastName, FirstName, Email, City
  FROM customers;

-- QUERY 4
-- Extract the Lastname, Firstname, email, city and country from the same table
-- and select only the country starting with &quot;AUSTR&quot;
-- What do you observe?
SELECT LastName, FirstName, Email, City, Country
  FROM customers
 WHERE Country LIKE 'AUSTR%';

-- QUERY 5
-- Extract the Lastname, Firstname, email, city and country from the same table
-- only from USA and Canada
SELECT LastName, FirstName, Email, City, Country
  FROM customers
 WHERE Country IN ('USA', 'Canada');

-- QUERY 6
-- Use the previous query and order the extracted data by lastname ascending
SELECT LastName, FirstName, Email, City, Country
  FROM customers
 WHERE Country IN ('USA', 'Canada')
 ORDER BY LastName;

-- QUERY 7
-- Show the top 5 data in alphabetical order
SELECT LastName, FirstName, Email, City, Country
  FROM customers
 WHERE Country IN ('USA', 'Canada')
 ORDER BY LastName LIMIT 5;

-- QUERY 8
-- Extract the Top 5 data starting at row 5
SELECT LastName, FirstName, Email, City, Country
  FROM customers
 WHERE Country IN ('USA', 'Canada')
 ORDER BY LastName
 LIMIT 5 OFFSET 5;

-- QUERY 9
-- Count the number of clients you have in USA
-- Count the number of clients you have in Canada
SELECT COUNT(CustomerId)
  FROM customers
 WHERE Country IN ('USA', 'Canada')
 GROUP BY Country;

-- QUERY 10
-- Count the number of clients you have in Berlin and in Paris (1 request and 1 line per cities)
SELECT COUNT(*)
  FROM customers
 WHERE City='Berlin';

SELECT COUNT(*)
  FROM customers
 WHERE City='Paris';

-- QUERY 11
-- How many states are there and how many cities per state ?
SELECT COUNT(DISTINCT State) FROM customers;

SELECT State, COUNT(DISTINCT City)
  FROM customers
 GROUP BY State;

-- QUERY 12
-- Count the number of clients per country and order them from the largest to the smallest.
SELECT Country, COUNT(*)
  FROM customers
 GROUP BY Country
 ORDER BY COUNT(*) DESC

--------------------------------
-- Let's change table !
-- Explore the Track table
SELECT * FROM tracks;

-- QUERY 13
-- Extract the data about songs with name starting by let'
-- Extract the data about songs with name containing good in it
-- Extract the data about songs with name ending by you
SELECT * FROM tracks
 WHERE name LIKE 'let''%';

SELECT * FROM tracks
 WHERE name LIKE '%good%';

SELECT * FROM tracks
 WHERE name LIKE '%you';

-- QUERY 14
-- Extract the data about songs which length is from 230 et 240 seconds and order them from the longest to the shortest
SELECT * FROM tracks
 WHERE Milliseconds BETWEEN 230000 AND 240000;

-- QUERY 15
-- Extract data from the top 10 long songs which cost 0.99
SELECT * FROM tracks
 WHERE UnitPrice=0.99
 ORDER BY Milliseconds DESC
 LIMIT 10;

-- QUERY 16
-- Extract the different prices apply to the songs
-- Extract the different composer from the table
-- Extract song where the price is bigger than the average price
SELECT DISTINCT UnitPrice FROM tracks;

SELECT DISTINCT Composer FROM tracks;

SELECT name FROM tracks
 WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM tracks);

-- QUERY 17
-- Extract data of songs which genreid is 20 and album id is 253.
-- Order them by the id of each track
SELECT * FROM tracks
 WHERE GenreId=20 OR AlbumId=235
 ORDER BY TrackId;

-- QUERY 18
-- Calculate the length of songs in seconds
-- Count the number of songs whose songs are longer than the average length of song (eventually use a CASE)
SELECT Name, Milliseconds/1000 AS Seconds FROM tracks;

SELECT COUNT(*) FROM tracks
 WHERE Milliseconds > (SELECT AVG(Milliseconds) FROM tracks);

-- QUERY 19
-- Calculate the average length of songs by album and count the number of songs by album
-- order by the number of songs descending
SELECT Title, AVG(Milliseconds) AS average_length_ms, COUNT(*) AS number_of_songs
  FROM tracks JOIN albums ON tracks.AlbumId=albums.AlbumId
 GROUP BY tracks.AlbumId
 ORDER BY COUNT(*) DESC;


-- QUERY 20 / Review
-- Extract the top 10 composers order from the longest average length of tracks and count the number of album the composer appear in
SELECT Composer, COUNT(DISTINCT AlbumId)
  FROM tracks
 WHERE Composer IS NOT NULL
 GROUP BY Composer
 ORDER BY AVG(Milliseconds) DESC
 LIMIT 10;

-- Bonus:
-- QUERY 21 (line count : 58)
-- Name the composers whose total of length songs are longer than the total of the length songs of queen
SELECT DISTINCT x.Composer FROM tracks x
 WHERE (SELECT SUM(y.Milliseconds) FROM tracks y
         WHERE y.Composer=x.Composer)
         >
       (SELECT SUM(Milliseconds) FROM tracks
        WHERE Composer LIKE '%Queen%');

-- QUERY 22
-- How many composers did not compose any songs ?
-- How many of songs are not refered to a composer ?
SELECT SUM(ifnull(tracks.name, 1)) FROM tracks;

SELECT SUM(ifnull(Composer, 1)) FROM tracks;

-- QUERY 23 (line count : 10)
-- Select the top 10 of composers by their number of tracks
-- You will see that the first one on the top is no-one
-- How is that possible? Comment here in 1 sentence
SELECT DISTINCT Composer
  FROM tracks
 WHERE Composer IS NOT NULL
 ORDER BY (SELECT COUNT(*)
             FROM tracks x
            WHERE x.Composer=Composer)
 LIMIT 10;