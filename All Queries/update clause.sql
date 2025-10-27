SELECT * FROM collegee

select contact_no from collegee
where id = 4

update collegee set contact_no = '99145'
where id = 1

update collegee set contact_no = '99141'
where id = 2

update collegee set contact_no = '49145'
where id = 3

select * from collegee

select * from collegee

update collegee set address = 'Khamgaon 1' where address = 'Khamgaon'

-- update collegee set address = 'Nagpur4' and 'Nagpur 5' where id = '3' and 4
update collegee set ((address = 'Nagpur4' where id=3) and (address = 'Nagpur5' where id=4))
where id = 3