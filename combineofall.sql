--PRACTICAL QUE--
--1.Create a table music_award with primary key.
CREATE TABLE music_award(
award_name VARCHAR(50),
award_id SERIAL PRIMARY KEY,
award_year INT NOT NULL
);
--2.Create table to store favorite tracks per customer.
CREATE TABLE fav_tracks(
customer_id INT,
track_id INT,
PRIMARY KEY(customer_id,track_id)
);
--3.Add Foreign Keys to Above Table
ALTER TABLE fav_tracks
ADD CONSTRAINT fk_track
FOREIGN KEY(track_id)
REFERENCES track (track_id);

ALTER TABLE fav_tracks
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customer(customer_id);

--4.Create Invoice Archive with FK
CREATE TABLE invoice_archive(
archive_id SERIAL PRIMARY KEY,
invoice_id INT,
FOREIGN KEY(invoice_id)
REFERENCES invoice(invoice_id)
ON DELETE SET NULL
);

--5.Show Artist and Album Names
SELECT a.name as artist_name,
al.title as album_name
FROM artist a
JOIN album al ON a.artist_id=al.artist_id;

--6.Show Track, Album, Artist
SELECT t.name as track_name,
al.title as album_title,
a.name as artist_name
FROM track t
JOIN album al ON t.album_id=al.album_id
JOIN artist a ON al.artist_id=a.artist_id;

--7.Find Top Spending Customers
SELECT customer_id, SUM(total) as total_spending
FROM invoice
GROUP BY customer_id
ORDER BY total_spending DESC;
--BY NAME
SELECT c.first_name||' '|| c.last_name as full_name, SUM(i.total) as total_spent
FROM invoice i
JOIN customer c ON i.customer_id=c.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;
--8.Customers Who Never Purchased
SELECT c.first_name||'  '|| c.last_name as full_name,i.total
FROM invoice i
LEFT JOIN customer c ON i.customer_id=c.customer_id
where i.total IS NULL;
--9.Create View for Customer Spending
CREATE VIEW vw_customer_spend as 

SELECT customer_id, SUM(total) as total_spending
FROM invoice
GROUP BY customer_id
ORDER BY total_spending DESC;

--TO CALL VIEW
SELECT *FROM vw_customer_spend; 

--10. View for Artist Track Count
SELECT a.name as artist_name, COUNT(t.track_id) as artist_track
FROM artist a
JOIN album al ON a.artist_id=al.artist_id
JOIN track t ON al.album_id=t.album_id
GROUP BY a.name;
--11.Function to Get Artist Name by ID
CREATE OR REPLACE FUNCTION f_get_artist(p_artist_id int)
RETURNS TEXT
LANGUAGE plpgsql 
AS $$
DECLARE
artist_name TEXT;
BEGIN
SELECT a.name INTO artist_name
FROM artist a
where artist_id=p_artist_id;
RETURN artist_name;
END;
$$;
--CALL--
SELECT f_get_artist(7);

--12.Function to Return Total Tracks per Album
CREATE FUNCTION f_tracks_per_album(p_album_name TEXT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
total_tracks INT;
BEGIN
SELECT COUNT(t.track_id) INTO  total_tracks
FROM album al
JOIN track t ON al.album_id=t.album_id
WHERE al.title=p_album_name;
RETURN total_tracks;
END;
$$;
--Call--
SELECT *FROM album;
SELECT  f_tracks_per_album('A Matter of Life and Death');


--13.Create Index on Track Name
CREATE INDEX ind_track
ON track(name);

--CALL--
SELECT * FROM track WHERE name = 'Balls to the Wall';
SELECT *from track;

--14.Create Composite Index

CREATE INDEX comp_index
ON track(album_id,name);


--CALL--
SELECT *FROM track WHERE album_id=19;

















DROP table  invoice_archive;
SELECT *FROM invoice_archive;




DROP TABLE fav_tracks;


SELECT 
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name IN ('customer', 'playlist')
ORDER BY table_name, column_name;
