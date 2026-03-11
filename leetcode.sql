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

-----------------------------JOIN------------------------------
--6.Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.
 SELECT eu.unique_id,e.name
from employees e
LEFT JOIN employeeUNI eu ON e.id=eu.id;

--7.Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
SELECT p.product_name,s.year,s.price
 from product p
 JOIN sales s ON p.product_id=s.product_id
 ORDER BY s.sale_id;

--8.Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
SELECT v.customer_id,COUNT(v.visit_id) as count_no_trans
FROM visits v
LEFT JOIN transactions t ON v.visit_id=t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;

--9.Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
SELECT w1.id
from weather w1
where w1.temperature>(select w2.temperature
 from weather w2 
 where w2.recordDate=DATE_SUB(w1.recordDate,INTERVAL 1 DAY));

--10.Write a solution to find the average time each machine takes to complete a process.
SELECT a1.machine_id, round(avg(a2.timestamp-a1.timestamp),3) as processing_time
from activity a1,a2
where a1.machine_id=a2.machine_id
AND a1.process_id=a2.process_id
AND a1.activity_type='start'
AND a2.activity_type='end'
GROUP BY machine_id;

--11.Write a solution to report the name and bonus amount of each employee who satisfies either of the following:
--The employee has a bonus less than 1000.
--The employee did not get any bonus.
SELECT e.name,b.bonus from employee e
LEFT JOIN bonus b ON e.empId=b.empId
where b.bonus<1000 
OR b.bonus IS NULL;

--12.Write a solution to find the number of times each student attended each exam.
SELECT s.student_id,s.student_name,su.subject_name,COUNT(e.student_id) as attended_exams
FROM students s
CROSS JOIN subjects su
LEFT JOIN examinations e ON s.student_id=e.student_id
AND e.subject_name=su.subject_name
GROUP BY s.student_id,s.student_name,su.subject_name
ORDER BY s.student_id, su.subject_name ;

--13.Write a solution to find managers with at least five direct reports.
SELECT 
    query_name, 
    ROUND(AVG(rating::numeric / position), 2) AS quality, 
    ROUND(AVG(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100, 2) AS poor_query_percentage
FROM queries
GROUP BY query_name;

--14.Write a solution to find the confirmation rate of each user.
SELECT 
    s.user_id,
    ROUND(
        COALESCE(
            COUNT(c.user_id) FILTER (WHERE c.action = 'confirmed')::numeric 
            / NULLIF(COUNT(c.user_id), 0), 
        0), 
    2) AS confirmation_rate
FROM signups s
LEFT JOIN confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;
--------------------------------BASIC AGGREGATE FUNCTION-------------------------------------------------
--15.Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
    --- Return the result table ordered by rating in descending order.
SELECT id,movie,description,rating
from cinema
where id %2 !=0 and  description!='boring'
ORDER BY rating desc;

--16.Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places. If a product does not have any sold units, its average selling price is assumed to be 0.
Select p.product_id,COALESCE(ROUND(SUM(p.price*u.units)::NUMERIC/SUM(u.units),2),0) as average_price
FROM Prices p
LEFT JOIN UnitsSold u ON p.product_id=u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

--17.Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
SELECT p.project_id,ROUND(SUM(e.experience_years)/count(p.project_id)::NUMERIC,2) AS average_years
FROM project p
JOIN employee e ON p.employee_id=e.employee_id
GROUP BY p.project_id
ORDER BY project_id ASC;











