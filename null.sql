--USING COALESCE FUNCTION
--1.Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
SELECT name,
COALESCE (mobile,'07986 444 2266') as coalese_fun
from teacher;
--2.Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
SELECT t.name,COALESCE(d.name,'None') as coalese_func from teacher t
LEFT JOIN dept d ON t.dept=d.id;