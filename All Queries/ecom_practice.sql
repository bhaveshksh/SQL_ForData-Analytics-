SELECT * FROM sales;

select * from sales 
where order_date >= '2015-01-01' and order_date <= '2016-12-31'
order by order_date asc

select * from sales
where order_date between '2015-01-01' and '2016-12-31'

select * from product
where product.category = 'Furniture'

select * from product
where not product.category = 'Furniture'

select * from product
where product.category != 'Furniture' and product.category = 'Technology'

select * from product
where category = 'Furniture' or category = 'Technology'
