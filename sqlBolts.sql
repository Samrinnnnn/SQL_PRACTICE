--SIMPLE SELECT QUERIES
--1.Order all the cities in the United States by their latitude from north to south
SELECT city
from North_american_cities
where country='United States'
order by latitude desc;

--2.List all the cities west of Chicago, ordered from west to east 
SELECT city from  North_american_cities
where longitude < -87.629798
ORDER BY longitude ASC;

--3.List the third and fourth largest cities (by population) in the United States and their population
SELECT city from north_american_cities
where country='United States'
ORDER BY population desc 
limit 2 offset 2;
--ALTER TABLE--
--4.Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English
ALTER TABLE movie
ADD COLUMN LANGUAGE TEXT DEFAULT English;
