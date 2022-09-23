Liubomyr
1.	Show the list of french customers’ names who have made more than one order (use grouping).
select customers.names
from
group by
having 

2.	Show the list of french customers’ names who have made more than one order (use a subquery).

SELECT customer_id
FROM customers
WHERE country = 'France' AND customer_id IN 
	(SELECT DISTINCT customer_id 
	FROM orders
	JOIN order_details ON orders.order_id=order_details.order_id
	where order_details.quantity >= 1)  

3.	Show the list of customers’ names who used to order the ‘Tofu’ product (use a subquery).

select customer_id from customers where customer_id in (select customer_id from orders
													   join order_details ON orders.order_id=order_details.order_id
	JOIN products ON products.product_id=order_details.product_id
where product_name = 'Tofu')


Liza
4.	*Show the list of customers’ names who used to order the ‘Tofu’ product, along with the total amount of the product they have ordered and with the total sum for ordered product calculated.

Dasha
5.	*Show the list of french customers’ names who used to order non-french products (use left join).
SELECT DISTINCT c.contact_name
FROM customers AS c
LEFT JOIN orders AS o
	ON o.customer_id = c.customer_id
LEFT JOIN order_details AS od
	ON od.order_id = o.order_id
LEFT JOIN products AS p
	ON p.product_id = od.product_id
LEFT JOIN suppliers AS s
	ON s.supplier_id = p.supplier_id
WHERE c.country = 'France' AND s.country!='France'
ORDER BY c.contact_name;

Nataliia V.
6.	*Show the list of french customers’ names who used to order non-french products (use a subquery).

SELECT customer_id
FROM customers
WHERE country = 'France' AND customer_id IN 
	(SELECT DISTINCT customer_id 
	FROM orders
	JOIN order_details ON orders.order_id=order_details.order_id
	JOIN products ON products.product_id=order_details.product_id
	JOIN suppliers ON products.supplier_id=suppliers.supplier_id
	WHERE suppliers.country <>'France')
ORDER BY customer_id;

Misha
7.	*Show the list of french customers’ names who used to order french products.

SELECT customers.contact_name FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = 'France' AND orders.ship_country = 'France'

Vika
8.	*Show the total ordering sum calculated for each country of customer.

Ira
9.	*Show the total ordering sums calculated for each customer’s country for domestic and non-domestic products separately (e.g.: “France – French products ordered – Non-french products ordered” and so on for each country).

Vita
10.	*Show the list of product categories along with total ordering sums calculated for the orders made for the products of each category, during the year 1997.

SELECT categories.category_name, 
sum(order_details.quantity*(order_details.unit_price-order_details.unit_price*order_details.discount))
FROM categories
Join products ON products.category_id = categories.category_id
JOIN order_details ON order_details.product_id = products.product_id
JOIN orders ON orders.order_id = order_details.order_id
WHERE orders.order_date between '1997-01-01' and '1997-12-31'
Group by category_name;

Nik
11.	*Show the list of employees’ names along with names of their chiefs (use left join with the same table).

SELECT employees.first_name || ' ' || employees.last_name AS employee, employees2.first_name || ' ' || employees2.last_name AS boss
FROM employees LEFT JOIN employees employees2 
ON employees.reports_to = employees2.employee_id;

12.	*Show the list of cities where employees and customers are from and where orders have been made to. Duplicates should be eliminated.

SELECT DISTINCT employees.city
FROM employees
UNION
SELECT DISTINCT customers.city
FROM customers
UNION
SELECT DISTINCT orders.ship_city
FROM orders
ORDER BY city ASC

Natalii F.
13.	Show first, last names and ages of 3 eldest employees.

SELECT first_name, last_name, date_part('year',age(birth_date)) as age
FROM employees
ORDER BY age DESC
LIMIT 3

14.	Show the list of all cities where the employees are from.

SELECT DISTINCT city
FROM employees


