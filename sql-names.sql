-- Save a script containing the query you used to answer each question.

-- 1. How many rows are in the names table?
-- 1,957,046

SELECT
	COUNT(*)
FROM names

-- 2. How many total registered people appear in the dataset?
-- 351,653,025
SELECT
	SUM(num_registered)
FROM names 

-- 3. Which name had the most appearances in a single year in the dataset?
-- Linda in 1947
SELECT
	name,
	year
FROM names 
WHERE num_registered = (SELECT MAX(num_registered) FROM names)

SELECT 
	name
FROM names
GROUP BY name
ORDER BY MAX(num_registered) DESC 
LIMIT 1 

-- 4. What range of years are included?
-- 1880 to 2018
SELECT
	MIN(year) AS start_year, 
	MAX(year) AS end_year
FROM names 

-- 5. What year has the largest number of registrations?
-- 1957
SELECT
	year, 
	SUM(num_registered) AS total_reg
FROM names
GROUP BY year
ORDER BY SUM(num_registered) DESC
LIMIT 1


-- 6. How many different (distinct) names are contained in the dataset?
-- 98,400
SELECT
	COUNT(DISTINCT name) AS name_count
FROM names 

-- 7. Are there more males or more females registered?
-- males
SELECT
	gender,
	SUM(num_registered) AS count
FROM names 
GROUP BY gender

-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?
-- James, Mary
SELECT
	name, 
	gender,
	SUM(num_registered) AS total
FROM names 
-- WHERE gender = 'M'
WHERE gender = 'F'
GROUP BY name, gender
ORDER BY SUM(num_registered) DESC
LIMIT 1


-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?
-- Emily, Jacob
SELECT 
	name, 
	gender, 
	SUM(num_registered) AS reg
FROM names
WHERE year BETWEEN 2000 AND 2009
	AND gender = 'M'
	-- AND gender = 'F'
GROUP BY name, gender
ORDER BY SUM(num_registered) DESC
LIMIT 1


-- 10. Which year had the most variety in names (i.e. had the most distinct names)?
-- 2008
SELECT
	year, 
	COUNT(DISTINCT name) AS name_count
FROM names 
GROUP BY year 
ORDER BY COUNT(DISTINCT name) DESC
LIMIT 1

-- 11. What is the most popular name for a girl that starts with the letter X?
-- Ximena
SELECT
	name,
	SUM(num_registered) AS total
FROM names 
WHERE name LIKE 'X%'
	AND gender = 'F'
GROUP BY name
ORDER BY SUM(num_registered) DESC
LIMIT 1

-- 12. Write a query to find all (distinct) names that start with a 'Q' but whose second letter is not 'u'.

SELECT DISTINCT
	name
FROM names 
WHERE name LIKE 'Q%' 
	AND name NOT LIKE 'Qu'

-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
-- Steven
SELECT 
	name, 
	SUM(num_registered) AS count
FROM names
WHERE name IN ('Stephen', 'Steven')
GROUP BY name

-- 14. Find all names that are "unisex" - that is all names that have been used both for boys and for girls.

SELECT 
	name, 
	COUNT(DISTINCT gender) AS gender_count
FROM names
GROUP BY name
HAVING COUNT(DISTINCT gender) > 1

-- 15. Find all names that have made an appearance in every single year since 1880.

SELECT 
	name
FROM names
GROUP BY name 
HAVING COUNT(DISTINCT year) = (SELECT COUNT(DISTINCT year) FROM names)

-- 16. Find all names that have only appeared in one year.

SELECT 
	name
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = 1

-- 17. Find all names that only appeared in the 1950s.

SELECT 
	name
FROM names 
WHERE year BETWEEN 1950 AND 1959
	AND name NOT IN (SELECT DISTINCT name FROM names WHERE year BETWEEN 1880 AND 1949 OR year BETWEEN 1960 AND 2018)

-- 18. Find all names that made their first appearance in the 2010s.

SELECT 
	name
FROM names
WHERE name NOT IN (SELECT DISTINCT name FROM names WHERE year < 2010)

-- 19. Find the names that have not be used in the longest.

SELECT
	name, 
	(2018 - maxyear) AS difference
FROM (SELECT name, MAX(year) maxyear FROM names GROUP BY name)
ORDER BY difference DESC
LIMIT 5

-- 20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.
-- Most popular name in 1942
SELECT 
	name 
FROM names 
WHERE year = 1942
ORDER BY num_registered DESC
LIMIT 1


