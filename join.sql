SELECT *FROM track;
--JOIN--
--Q1. List all tracks with their album name and artist name--
SELECT 
t.name as track_name,
al.title as album_title,
ar.name as artist_name
FROM track t
JOIN album al ON t.album_id=al.album_id
JOIN artist ar ON al.artist_id=ar.artist_id;
--2.Show customers with their invoices (even if customer has no invoice)--
SELECT
c.first_name
c.last_name,
i.invoice_id
FROM customer c
LEFT JOIN invoice i ON c.customer_id=i.customer_id;

SELECT 
    c.first_name,
    c.last_name,
    i.invoice_id,
    i.total
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id;
--3.Display invoice line with track name and genre--
SELECT
  i.invoice_line_id,
  i.invoice_id,
  i.quantity,
  t.name as track_name,
  g.name as genre_name
  FROM invoice_line i
  JOIN track t ON i.track_id=t.track_id
  JOIN genre g ON t.genre_id=g.genre_id;
  --4.Find employees and customers they support--
  SELECT
  e.first_name as employee_first_name,
  e.last_name as employee_last_name,
  c.first_name as customer_first_name,
  c.last_name as customer_last_name
  FROM employee e
  JOIN customer c ON e.employee_id = c.support_rep_id;
  ()
  --5.Show playlist name with track name--
  SELECT
   p.name as playlist_name
   t.name as track_name
   FROM track as t
   JOIN playlist_track pt ON t.track_id=pt.track_id
   JOIN playlist p ON pt.playlist_id=p.playlist_id;
   /*INNER JOIN*/
   --6.Track name with album title--
   SELECT
   t.name as track_name,
   al.title as album_name
   FROM track t
   JOIN album al ON t.album_id=al.album_id;
   --7.Album title with artist name--
   SELECT
   al.title as album_title,
   ar.name as artist_name
   FROM album as al
   JOIN artist ar ON al.artist_id=ar.artist_id;
   --8Invoice with customer name--
   SELECT 
   i.invoice_id,
   i.total,
   c.first_name as Cust_Name
   FROM invoice i
   JOIN customer c ON i.customer_id=c.customer_id;
   
   --H 10.Artist with total tracks--
    SELECT
   ar.name as artist_name,
   COUNT(t.track_id) as total_tracks
   FROM track t
   JOIN album al ON t.album_id=al.album_id
   JOIN artist ar ON al.artist_id=ar.artist_id
   GROUP BY ar.name;
   --LEFT JOIN--
   --11.Customers without invoices
   SELECT 
  c.first_name as first_name,
  c.last_name as last_name,
  i.total
  FROM customer c
  LEFT JOIN invoice i ON c.customer_id=i.customer_id
  where i.invoice_id IS NULL;

   --12.Artists without albums--
   SELECT
   ar.name as name,
   al.title as album_title,
   FROM artist ar
   LEFT JOIN album al ON al.artist_id=ar.artist_id
   where al.album_id IS NULL;
   --13.Employees without customers--
   SELECT
   e.first_name as employee_name,
   c.first_name as customer_name
   FROM employee e
   LEFT JOIN customer c ON e.employee_id=c.support_rep_id
   where c.support_rep_id IS NULL;
   --H 14.Playlists with no tracks--
SELECT p.name, pt.track_id
FROM playlist p
LEFT JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
WHERE pt.track_id IS NULL;
--15.Albums without tracks--
SELECT
al.title as album_name,
t.name as track_name
FROM track t
LEFT JOIN album al ON t.album_id=al.album_id
where t.track_id IS NULL;

 --RIGHT JOIN__
 --16.All customers even without employee--
 SELECT e.first_name, c.first_name
FROM customer c
LEFT JOIN employee e ON e.employee_id = c.support_rep_id;

SELECT e.first_name, c.first_name
FROM employee e
RIGHT JOIN customer c ON e.employee_id = c.support_rep_id;
--17.All tracks even without playlist--
SELECT 
t.name as track_name
FROM track t
RIGHT JOIN playlist_track pt ON t.track_id=pt.track_id;

--SELF JOIN--
--18.Employee reporting hierarchy--
SELECT employee_id,first_name,last_name,reports_to
From employee
WHERE reports_to >0
ORDER BY reports_to DESC;

SELECT e1.first_name AS employee, e2.first_name AS manager
FROM employee e1
LEFT JOIN employee e2 ON e1.reports_to = e2.employee_id;

--19.Customers from same country--
SELECT first_name,last_name,c1.country as A, c2.country as B
FROM customer 
LEFT JOIN customer c1 ON c2.country=c1.country;

SELECT c1.first_name, c2.first_name, c1.country
FROM customer c1
JOIN customer c2 ON c1.country = c2.country
AND c1.customer_id <> c2.customer_id;

--20.Artists with same starting letter--
Select a1.name,a2.name
FROM artist a1
JOIN artist a2 ON left(a1.name,1)=left(a2.name,1)
AND a1.artist_id <> a2.artist_id;
--21.if count--
SELECT LEFT(name, 1) AS first_letter, COUNT(*) 
FROM artist
GROUP BY LEFT(name, 1)
ORDER BY first_letter;
--H 22.Top selling tracks--
SELECT t.name, SUM(il.quantity) AS sold
FROM track t
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY t.name
ORDER BY sold DESC;

 