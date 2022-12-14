Liubomyr
1.	Show the list of french customers’ names who have made more than one order (use grouping).

select customer_id 
from customers 
where customer_id in 
(select customer_id from orders
 join order_details ON orders.order_id = order_details.order_id
 JOIN products ON products.product_id = order_details.product_id
where lower(product_name) like '%tofu%')

2.	Show the list of french customers’ names who have made more than one order (use a subquery).

select customer_id 
from customers as outer_cust 
where country = 'France' and 
(select count(order_id)
from orders
where orders.customer_id = outer_cust.customer_id) > 1;

3.	Show the list of customers’ names who used to order the ‘Tofu’ product (use a subquery).

select customer_id 
from customers 
where customer_id in 
(select customer_id from orders
 join order_details ON orders.order_id = order_details.order_id
 JOIN products ON products.product_id = order_details.product_id
where lower(product_name) like '%tofu%')


Liza
4.	*Show the list of customers’ names who used to order the ‘Tofu’ product, along with the total amount of the product they have ordered and with the total sum for ordered product calculated.
Select Customers.Customer_id, sum(quantity), CAST (Sum(order_details.unit_price*quantity) as DECIMAL(10,2))
from Order_details
Join Orders On Order_details.Order_id = Orders.Order_id
Join Customers On  Orders.Customer_id =Customers.Customer_id
Join Products On Products.Product_id = Order_details.product_id
Where Products.Product_name like 'Tofu'
Group By Customers.Customer_id;


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
	(SELECT customer_id 
	FROM orders
	JOIN order_details ON orders.order_id=order_details.order_id
	JOIN products ON products.product_id=order_details.product_id
	JOIN suppliers ON products.supplier_id=suppliers.supplier_id
	WHERE suppliers.country <>'France'
	GROUP BY customer_id)
ORDER BY customer_id;

Misha
7.	*Show the list of french customers’ names who used to order french products.

SELECT contact_name
FROM customers
WHERE country = 'France' AND customer_id IN 
(SELECT DISTINCT customer_id 
FROM orders
JOIN order_details ON orders.order_id=order_details.order_id
JOIN products ON products.product_id=order_details.product_id
JOIN suppliers ON products.supplier_id=suppliers.supplier_id
WHERE suppliers.country ='France')
ORDER BY contact_name;

Vika
8.	*Show the total ordering sum calculated for each country of customer.

SELECT DISTINCT customers.customer_id, customers.country, SUM (order_details.unit_price * order_details.quantity)
FROM customers
JOIN orders ON orders.customer_id = customers.customer_id
JOIN order_details ON order_details.order_id = orders.order_id
JOIN products ON products.product_id = order_details.product_id
JOIN suppliers ON suppliers.supplier_id = products.supplier_id
WHERE customers.country = suppliers.country 
GROUP BY customers.customer_id;

Ira
9.	*Show the total ordering sums calculated for each customer’s country for domestic and non-domestic products separately (e.g.: “France – French products ordered – Non-french products ordered” and so on for each country).

SELECT DISTINCT customers.customer_id, SUM (order_details.unit_price * order_details.quantity) AS not_domestic_sum, 
(SELECT SUM (order_details.unit_price * order_details.quantity) AS domestic_sum
FROM orders
JOIN order_details
	ON order_details.order_id = orders.order_id
JOIN products
	ON products.product_id = order_details.product_id
JOIN suppliers
	ON suppliers.supplier_id = products.supplier_id
WHERE customers.country = suppliers.country 
GROUP BY customers.customer_id)
FROM customers
JOIN orders
	ON orders.customer_id = customers.customer_id
JOIN order_details
	ON order_details.order_id = orders.order_id
JOIN products
	ON products.product_id = order_details.product_id
JOIN suppliers
	ON suppliers.supplier_id = products.supplier_id
WHERE customers.country != suppliers.country 
GROUP BY customers.customer_id;



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


