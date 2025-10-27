-- alter

SELECT * FROM collegee

alter table collegee add column dept varchar[]

select * from collegee

update collegee set dept = '{"dept1,dept2"}' where id = 1
update collegee set dept = '{"dept3,dept4"}' where id = 2

select id, name,dept[1] from collegee 

alter table collegee 
drop column dept;
select * from collegee
alter table collegee add column col2 varchar not null default '34'