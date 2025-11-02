select product_id, sum(sales) as ss, sum(discount) as sd, sum(sales) * sum(discount) / 100 as discount_rs,
sum(sales) - (sum(sales) * sum(discount)/100) as sales_after_discount
from sales group by product_id

select product_id, sum(sales) as ss, sum(discount) as sd, sum(sales) * sum(discount) /100 as discount_rs,
sum(sales) - (sum(sales)* sum(discount)/100) as sales_after_discount
from sales group by product_id
