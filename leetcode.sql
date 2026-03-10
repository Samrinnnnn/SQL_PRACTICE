--leetcode sql 50 course--
-------------------------SELECT-----------------------
--1.Write a solution to find the ids of products that are both low fat and recyclable.
SELECT product_id 
from products
where low_fats='Y' and recyclable='Y';

--2.Find the names of the customer that are either:referred by any customer with id != 2. not referred by any customer.
SELECT name from customer
where referee_id!=2 OR referee_id IS NULL;

--3.Write a solution to find the name, population, and area of the big countries.
SELECT name,population,area 
from world
where area>=3000000 OR  population>=25000000;

--4.Write a solution to find all the authors that viewed at least one of their own articles.
SELECT DISTINCT author_id as id
from views
where author_id=viewer_id 
order by id asc;

--5.Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
SELECT tweet_id FROM Tweets
where length(content)>15;
