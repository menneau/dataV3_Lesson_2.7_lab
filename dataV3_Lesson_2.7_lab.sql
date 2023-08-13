USE sakila;

-- Lab | SQL Join (Part I)

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT
    c.name AS category_name,
    COUNT(f.film_id) AS film_count
FROM
    category c
LEFT JOIN
    film_category fc ON c.category_id = fc.category_id
LEFT JOIN
    film f ON fc.film_id = f.film_id
GROUP BY
    c.name;

-- 2. Display the total amount rung up by each staff member in August of 2005.

SELECT
    staff.staff_id,
    CONCAT(staff.first_name, ' ', staff.last_name) AS staff_name,
    SUM(payment.amount) AS total_amount
FROM
    staff
JOIN
    payment ON staff.staff_id = payment.staff_id
WHERE
    payment.payment_date >= '2005-08-01' AND payment.payment_date < '2005-09-01'
GROUP BY
    staff.staff_id, staff_name
ORDER BY
    total_amount DESC;

-- 3. Which actor has appeared in the most films?

SELECT
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    COUNT(*) AS film_appearances
FROM
    actor a
JOIN
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id, actor_name
ORDER BY
    film_appearances DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(*) AS rented_films_count
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id, customer_name
ORDER BY
    rented_films_count DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT
    s.first_name,
    s.last_name,
    a.address
FROM
    staff s
JOIN
    address a ON s.address_id = a.address_id;

-- 6. List each film and the number of actors who are listed for that film.

SELECT
    f.title AS film_title,
    COUNT(fa.actor_id) AS actor_count
FROM
    film f
JOIN
    film_actor fa ON f.film_id = fa.film_id
GROUP BY
    f.title;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_paid
FROM
    customer c
JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id, customer_name
ORDER BY
    c.last_name, c.first_name;

-- 8. List the titles of films per category.

SELECT
    c.name AS category_name,
    GROUP_CONCAT(f.title ORDER BY f.title ASC SEPARATOR ', ') AS film_titles
FROM
    category c
JOIN
    film_category fc ON c.category_id = fc.category_id
JOIN
    film f ON fc.film_id = f.film_id
GROUP BY
    c.name;
