select * from college_data
where id > 5
order by address 
offset 5 limit 3

select * from sales

/* Get only col cust_id,order_date,qty,ship_mode which have value
   of qty and order date as below qty should be more than 5 and below 10
   order date must fall between 2015 to 2017 
   get me last 10 data of the order*/
select cust_id,order_date,qty,ship_mode from sales
where (qty > 5 or qty >= 10) and (order_date between '2015-01-01' and '2017-12-31')
order by order_date 
offset 990 limit 10