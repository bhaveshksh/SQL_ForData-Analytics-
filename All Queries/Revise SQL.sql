drop table shop
create table shop(
id serial primary key,
SupplierType varchar not null,
email varchar unique not null,
revenue float default 0,
sales double PRECISION default 0,

constraint CHK_SupplierType CHECK(
		SupplierType IN ('Wholesaler','distributor','retail','shockist')
)
)

INSERT INTO public.shop(
	 suppliertype, email, revenue, sales)
	VALUES ('Wholesaler', 'a1@gmail.com', 20, 100);

INSERT INTO public.shop(
suppliertype, email, revenue, sales)
VALUES 
('distributor', 'ab1@gmail.com', 200, 300),
('retail', 't1@gmail.com', 40, 250),
('Wholesaler', 'at1@gmail.com', 100, 200),
('shockist', 'e1@gmail.com', 150, 600),
('Wholesaler', 'a51@gmail.com', 100, 200),
('retail', 'ed1@gmail.com', 100, 200),
('distributor', 'ty1@gmail.com', 170, 500),
('retail', 'ed=g1@gmail.com', 1400, 350);
INSERT INTO public.shop(
suppliertype, email)
VALUES 
('retail', 'eg1@gmail.com' ),
('distributor', 'tj1@gmail.com')

select * from shop


create table sales(
order_id varchar primary key,
cust_name varchar not null,
email varchar unique not null,
order_date date not null,
contact_no int unique,
price double precision default 0,

shop_id int,
foreign key (shop_id) references shop(id)
)

INSERT INTO public.sales(
	order_id, cust_name, email, order_date, contact_no, price, shop_id)
	VALUES ('cid-101', 'cust1', 'cust1@gmail.com', '2025-01-04', '2753', 75, 2);

INSERT INTO public.sales(
	order_id, cust_name, email, order_date, contact_no, price, shop_id)
	VALUES ('cid-102', 'cust2', 'cust2@gmail.com', '2025-5-02', '27423', 25, 1);	

INSERT INTO public.sales(
	order_id, cust_name, email, order_date, contact_no, price, shop_id)
	VALUES ('cid-103', 'cust3', 'cust3@gmail.com', '2025-3-01', '13423', 45, 3);

