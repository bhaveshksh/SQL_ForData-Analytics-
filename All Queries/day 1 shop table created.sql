create table shops(
id int,
shop_name varchar,
address varchar,
mode varchar,
outlet int,
customer_count int,
sales int,
emp int
);

select * from shops;

insert into shops(id,shop_name,address,mode,outlet,customer_count,sales,emp)
values
(1,'dmart','automotive','offline',5,5000,10000,700);

create table shops2(
id int primary key,
shop_name varchar,
address varchar,
mode varchar,
outlet int,
customer_count int,
sales int,
emp int
);
insert into shops2(id,shop_name,address,mode,outlet,customer_count,sales,emp)
values
(1,'dmart','automotive','offline',5,5000,10000,700);
select * from shops2
insert into shops2(id,shop_name,address,mode,outlet,customer_count,sales,emp)
values
(2,'vishal meghamart','bhande plot','offline',2,1000,20000,100);