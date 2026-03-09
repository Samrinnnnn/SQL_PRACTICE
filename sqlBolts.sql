--SIMPLE SELECT QUERIES
--1.Order all the cities in the United States by their latitude from north to south
SELECT city
from North_american_cities
where country='United States'
order by latitude desc;
