SELECT c.customer_name,s.ship_mode,sum(s.sales) as sum_sales,avg(s.sales) as avg_sales,
       min(s.sales) as min_sales,max(s.sales) as max_sales,
       count(s.sales) as count_sales,
       sum(s.qty) as sum_qty,avg(s.qty) as avg_qty,
       min(s.qty) as min_qty,max(s.qty) as max_qty,
       count(s.qty) as count_qty,
       sum(s.discount) as sum_discount,avg(s.discount) as avg_discount,
       min(s.discount) as min_discount,max(s.discount) as max_discount,
       count(s.discount) as count_discount,
       sum(s.profit) as sum_profit,avg(s.profit) as avg_profit,
       min(s.profit) as min_profit,max(s.profit) as max_profit,
       count(s.profit) as count_profit
	   
FROM sales as s
INNER JOIN customer as c ON c.cust_id = s.cust_id
group by c.customer_name, s.ship_mode
order by c.customer_name, s.ship_mode;

CREATE INDEX index_custName ON customer(customer_name);

create view sales_views as (
SELECT c.full_custname,s.ship_mode,sum(s.sales) as sum_sales,avg(s.sales) as avg_sales,
       min(s.sales) as min_sales,max(s.sales) as max_sales,
       sum(s.qty) as sum_qty,avg(s.qty) as avg_qty,
       min(s.qty) as min_qty,max(s.qty) as max_qty,
       sum(s.discount) as sum_discount,avg(s.discount) as avg_discount,
       min(s.discount) as min_discount,max(s.discount) as max_discount,
       sum(s.profit) as sum_profit,avg(s.profit) as avg_profit,
       min(s.profit) as min_profit,max(s.profit) as max_profit
	   
FROM sales as s
INNER JOIN customer as c ON c.cust_id = s.cust_id
where c.state = 'California'
group by c.full_custname, s.ship_mode
order by c.full_custname, s.ship_mode
)
drop view sales_views;

select * from sales_views;

-- 1) if we change column name and it will be relefectd in view
-- Hence Proved when we can change column name in original table
-- does not reflect in view 
alter table customer
RENAME COLUMN Full_custName TO customer_name

select * from customer;

alter table customer
RENAME COLUMN customer_name TO Full_custName 


--2) if we delete a column in will it affect view
ALTER TABLE customer
drop column Full_custName;

-- 3) if we add new column will it affect view
ALTER TABLE customer
ADD COLUMN sales varchar(50);

/*In view
1) can I delete a column in view*/ we can not delete column in view
ALTER view sales_views
DROP column sum_sales;

-- 2) can i alter the column in view  // yes we can alter the column in view
ALTER VIEW sales_views
RENAME COLUMN sum_sales to summ_sales;

select * from customer;

-- 3) can i delete row in view
DELETE FROM sales_views
where avg_sales = null;


ALTER TABLE customer
DROP COLUMN sales