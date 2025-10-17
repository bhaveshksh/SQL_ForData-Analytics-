CREATE TABLE collegee(
id serial primary key,
name varchar,
address varchar,
contact_no int,
total_student int default 0,
grade char,
total_staff int default 0
)

insert into collegee (name,address,contact_no,total_student,grade,total_staff)
values
('arc','Nagpur',21212142,4125,'B',35),
('vigo','Nagpur',21282172,4085,'C',25),
('col2','Nagpur',21862142,4125,'B',95)

select * from collegee;

select * from collegee
where address = 'Nagpur';

select * from collegee
where total_staff > 50;

select id, name,grade,total_staff from collegee
where grade = 'A' AND total_staff > 20;

select * from collegee
where (total_student > 5000 and total_student < 200) 
or(grade = 'B' and grade= 'C')