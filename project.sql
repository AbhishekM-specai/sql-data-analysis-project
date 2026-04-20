# select & Where

#1.Select the full_name and city of all customers.
select full_name,city from customers;

#2. Show all orders that have status = 'Delivered'. 
select * from orders
where status="delivered";

#3.— List all products where price is greater than 2000. 
select * from products
where price>2000;

#4. Show the emp_name, department, and salary of employees whose salary is less than 50000.
select * from employees
where salary<50000;

#5.Find all customers from the city 'Bangalore'.
select full_name,city from customers
where city="Bangalore";

#6.Show all products where stock_qty is less than 20 (low stock alert). 
select product_name,stock_qty from products
where stock_qty<20;


# DISTINCT

#1.List all unique departments in the employees table. 
select distinct(department) from employees;

#2.Show all unique payment modes used in the orders table.
select distinct(payment_mode) from orders;

#3.Find all unique states where customers come from. 
select distinct(state) from customers;


# LIKE

#1.Find all employees whose name starts with 'S'.
select emp_name from employees
where emp_name like "s%";

#2.— List all products that have the word 'Set' anywhere in the product name. 
select product_name from products
where product_name like "%set%";

#3. Find all customers whose email address ends with '@email.com'.
select full_name,email from customers
where email like "%@email.com";

#4.Show all products whose supplier name starts with 'Tech'.
select product_name,supplier from products
where supplier like "Tech%";

# BETWEEN & IN 

#1.— Find all employees with a salary between 40000 and 60000. 
select emp_name, salary from employees
where salary between 40000 and 60000;

#2. List all orders placed between '2024-02-01' and '2024-02-28'. 
select * from orders
where order_date between '2024-02-01' and '2024-02-28';

#3.Show all products in the 'Books' or 'Sports' categories. (Use IN with category_id values 4 and 5.) 
 select product_name,category_id from products
 where category_id in(4,5);
 
 #4. Find all customers whose age is NOT between 30 and 40.
 select full_name,age from customers
 where age not between 30 and 40;
 
 
 # ORDER BY, LIMIT & OFFSET
 
 #1. List all products sorted by price from lowest to highest. 
 select product_name,price from products
 order by price;
 
 #2.Show the top 3 highest-paid employees. 
 select emp_name,salary from employees
 order by salary desc
 limit 3;
 
 #3.Show orders 6 to 10 sorted by order_date (use LIMIT and OFFSET). 
 select * from orders
 order by order_date 
 limit 5 offset 5;
 
 #4.List the 5 cheapest products in the Clothing category (category_id = 2). 
 select product_name,price,category_id from products
 where category_id in(2)
 order by price
 limit 5;
 
 
 #  MIN, MAX and AVG 
 
 #1. Find the highest and lowest salary in the employees table. 
 select max(salary) as highest_salary,
 min(salary) as lowest_salary from employees;
 
 #2.What is the average age of all customers? 
 select round(avg(age),2)as avg_age from customers;
 
 #3.Find the minimum and maximum unit_price in order_items. 
 select max(unit_price) as max_unitprice,
 min(unit_price) as min_unitprice from order_items;
 
 #4.What is the average stock_qty for all products? 
 select round(avg(stock_qty),2) as avg_stockqty 
 from products;
 
 
 # GROUP BY and HAVING
 
 #1. Count the number of orders placed by each customer_id.
 select customer_id,count(*) as total_orders from orders
 group by customer_id;
 
 
 #2.Find the average salary per department. 
 select department,round(avg(salary),2) as avg_salary
 from employees
 group by department;
 
 
 #3.Count how many customers belong to each membership tier (Silver, Gold, Platinum).
 select membership,count(full_name) as customers
 from customers
 group by membership;
 
 
 # 4.Show departments where the average salary is greater than 50000.
 select department,round(avg(salary),2) as avg_salary from employees
 group by department
 having avg_salary>50000;
 
 
 #5.  Find all customers who have placed more than 1 order.
 select customer_id,count(*) as more_than1
 from orders
 group by customer_id
 having count(*)>1;
 
 
 # IF and CASE
 
 #1. Label each order as 'Positive' if status = 'Delivered', otherwise 'Negative'.
 select order_id,status,
if(status = "delivered","positive","negative") as delivery_quality
from orders;


#2. Use CASE to classify customer age: Under 30 = 'Young', 30-40 = 'Middle', over 40 = 'Senior'. 
select full_name,age,
case
	when age<30 then "young"
    when age between 30 and 40 then "middle"
    else "senior"
end as seniority
from customers;


#3. Use CASE to label membership as '3-Star' (Platinum), '2-Star' (Gold), or '1-Star' (Silver).
select membership,
case
	when membership="platinum" then "3 star"
    when membership="gold" then "2 star"
    else "1 star"
end as tier
from customers;
 
 
 #4. Show each product with a 'Stock Alert' flag: 'Critical' if stock < 15, 'Low' if stock < 30, else 'OK'. 
 select product_name,stock_qty,
 case
	when stock_qty<15 then "critical"
    when stock_qty between 15 and 30 then "low"
    else "ok"
end as stock_alert
from products;


#5. Use IF to show whether each employee has a manager: 'Has Manager' if manager_id is not NULL, else 'No Manager'.
select emp_name,
if(manager_id is not null, "has manager","no manager") 
as manager_allocation
from employees;



# JOINS

#1. INNER JOIN: Show order_id, customer full_name, and order_date for all delivered orders.
select o.order_id,c.full_name,o.order_date
from orders o
join customers c
on o.customer_id=c.customer_id where status="delivered"; 


#2.  INNER JOIN: Show order_id, product_name, quantity, and unit_price from order_items and products. 
select o.order_id,p.product_name,o.quantity,o.unit_price
from order_items o
join products p
on o.product_id=p.product_id;


#3.  LEFT JOIN: List all employees and the orders they managed. Show employees with no orders too. 
select e.emp_name,o.order_id
from employees e
left join orders o
on e.employee_id=o.employee_id;


#4. — INNER JOIN (3 tables): Show customer full_name, product_name, quantity, and 
#order_date — join customers, orders, order_items, and products. 

select c.full_name,p.product_name,oi.quantity,quantity,o.order_date
from customers c
join orders o
	on c.customer_id=o.customer_id
join order_items oi
	on o.order_id=oi.order_id
join products p
	on oi.product_id=p.product_id;
    
    
#5. LEFT JOIN: Show all categories and how many products each has (include categories with 0 products). 
select c.category_name,p.product_name
from categories c
left join products p
on c.category_id=p.category_id;



#6.  INNER JOIN with GROUP BY: Show each customer's full_name and their total number of delivered orders.
select c.full_name,count(o.order_id) as delivered_orders
from customers c
join orders o
on c.customer_id=o.customer_id and o.status="delivered"
group by c.customer_id;



