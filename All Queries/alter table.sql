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
alter table collegee add column col2 varchar not null default '34';

update collegee set grade = 'FA' where id = 4
update collegee set grade = 'F' where id = 11

alter table collegee
alter column grade type varchar;
select * from collegee

alter table collegee
alter column total_staff type varchar;
select * from collegee

select * from collegee where total_staff > 7

alter table collegee
alter column total_staff type int
using total_staff::integer; -- cascading this is used for to change data type for limit time

select * from collegee

select collegee.total_student::varchar from collegee

update collegee set id = 11 where id = 4

alter table collegee 
alter column id type not null

alter table collegee add constraint total_staff_limit check (total_staff >= 20 and total_staff <= 40)

select * from collegee where total_staff >= 20 and total_staff <= 40

update collegee set total_staff = 36 where total_staff not between 20 and 40

select * from collegee where total_staff = 46
