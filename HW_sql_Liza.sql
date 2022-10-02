


1.	Calculate the average freight of all employees who work not with Western region. 

Select Employee_id, AVG(freight)
From Orders
Where Employee_id Not In (Select Distinct Employee_id
From Employee_territories
Join Territories On Territories.Territory_id = Employee_territories.territory_id
Join Region On Region.Region_id = Territories.Region_id
Where Region.Region_description = 'Western')
Group By Employee_id 
Order By Employee_id;


2.	 Show first and last names of employees who shipped orders in cities of USA.

Select Distinct first_name, last_name
From Employees join Orders
On Employees.Employee_id = Orders.Employee_id
Where Ship_country = 'USA'
Order By First_name, last_name;



3.	Show the names of products and their total cost, which were delivered by German suppliers 


SELECT product_name, SUM(order_details.unit_price*order_details.quantity)
FROM products JOIN order_details
ON products.product_id = order_details.product_id
JOIN suppliers
ON suppliers.supplier_id = products.supplier_id
WHERE suppliers.country LIKE 'Germany'
GROUP BY product_name;

4.	Show first and last names of employees that don’t work with Eastern region. 


Select first_name, last_name
From Employees
Where Employees.Employee_id Not In (Select Distinct Employees.Employee_id
From Employees Join Employee_territories
On Employees.Employee_id = Employee_territories.Employee_id
Join Territories On Territories.Territory_id = Employee_territories.territory_id
Join Region On Region.Region_id = Territories.Region_id
Where Region.Region_description = 'Eastern')
Group By first_name, last_name
Order By first_name, last_name;

5.	Show the name of customers that prefer to order non-domestic products. 

A)
Select Customers.Customer_Id, Customers.country
From Customers Join Orders
On Customers.Customer_id = Orders.Customer_id
Join Order_details On Order_details.Order_id = Orders.Order_id
Join Products On Products.Product_id = Order_details.product_id
Join Suppliers On Suppliers.Supplier_id = Products.Supplier_id
Where Customers.Customer_id Not in (Select Distinct Customers.Customer_Id
From Customers Join Orders
On Customers.Customer_id = Orders.Customer_id
Join Order_details On Order_details.Order_id = Orders.Order_id
Join Products On Products.Product_id = Order_details.product_id
Join Suppliers On Suppliers.Supplier_id = Products.Supplier_id Where Suppliers.country = Customers.country)
Group By Customers.Customer_id
Order by Customers.country;

B)
Select Customer_Id, country
From Customers
Where Customer_id Not in (Select Distinct Customers.Customer_Id
From Customers Join Orders
On Customers.Customer_id = Orders.Customer_id
Join Order_details On Order_details.Order_id = Orders.Order_id
Join Products On Products.Product_id = Order_details.product_id
Join Suppliers On Suppliers.Supplier_id = Products.Supplier_id Where Suppliers.country = Customers.country)
Group By Customer_id
Order by country;

	

6.	Show the name of customers that prefer to order domestic products. 

Select *
FROM
(Select Customers.Customer_id as c_id, count(*) as count_domestic_orders
From Customers Join Orders
On Customers.Customer_id = Orders.Customer_id
Join Order_details On Order_details.Order_id = Orders.Order_id
Join Products On Products.Product_id = Order_details.product_id
Join Suppliers On Suppliers.Supplier_id = Products.Supplier_id
Where Suppliers.country <> Customers.Country
Group By Customers.Customer_id ) T1
Full Join
(Select Customers.Customer_id as c_id, count(*) as count_no_domestic_orders
From Customers Join Orders
On Customers.Customer_id = Orders.Customer_id
Join Order_details On Order_details.Order_id = Orders.Order_id
Join Products On Products.Product_id = Order_details.product_id
Join Suppliers On Suppliers.Supplier_id = Products.Supplier_id
Where Suppliers.country = Customers.Country
Group By Customers.Customer_id ) T2
On T1.c_id=T2.c_id
Where T1.count_domestic_orders > T2.count_no_domestic_orders
Order by T1.c_id;






