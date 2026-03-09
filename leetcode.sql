--leetcode sql 50 course--
--1.Write a solution to find the ids of products that are both low fat and recyclable.

SELECT product_id 
from products
where low_fats='Y' and recyclable='Y';

--2.Find the names of the customer that are either:referred by any customer with id != 2. not referred by any customer.
SELECT name from customer
where referee_id!=2 OR referee_id IS NULL;