select * from ecom_data

select * from ecom_data order by order_date, cust_id

select ecom_data.product_id,qty from ecom_data order by ecom_data.product_id,qty

-- task : how to do asc product_id and desc qty
select ecom_data.product_id,qty from ecom_data order by ecom_data.product_id asc,qty desc

select ecom_data.product_id,check_sales,qty from ecom_data order by ecom_data.product_id,check_sales(sales),qty

select ecom_data.product_id,ecom_data.check_sales,qty from ecom_data order by order_date