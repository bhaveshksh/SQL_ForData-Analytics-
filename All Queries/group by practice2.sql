select * from college_data

select sum(college_data.total_student) from college_data

select min(college_data.total_student) from college_data

select max(college_data.total_student) from college_data

select avg(college_data.total_student) from college_data

select avg(total_student) as avg_student, avg(total_staff) as avg_staff from college_data

select * from college_data

select sum(total_student), min(total_student),max(total_student),avg(total_student),count(total_student),grade
from college_data
group by grade

