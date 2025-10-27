CREATE TABLE collegee(
id serial primary key,
name varchar,
address varchar,
contact_no int,
total_student int default 0,
grade char,
total_staff int default 0
)
truncate table collegee
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

insert into collegee (name,address,contact_no,total_student,grade,total_staff)
values
('arc1','Nagpur1',24222142,4125,'A',73),
('vigo1','Nagpur2',25292172,5085,'B',78),
('col3','Khamgaon',26872142,4125,'D',35),
('col5','Khamgaon1',26372541,4622,'A',13),
('vigo','Khamgaon2',16374152,5322,'B',83),
('col3','Pune',26472247,200,'C',35)

select * from collegee