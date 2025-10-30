select name as college_Name from college_data

select * from college_data

alter table college_data drop column --column_name

-- count all columns and rows of the table
select count(*) from college_data

update college_data set address = null where id = 6

select count(address) from college_data

select count(id) as count_ids, count(address) as count_address from college_data

select count(id) as count_ids, name from college_data group by name

select distinct(name) from college_data
select count(name) from college_data

