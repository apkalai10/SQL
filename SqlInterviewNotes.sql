select * from INFORMATION_SCHEMA.TABLES

--find the second largest salary
with STwo as (select *,ROW_NUMBER() over(order by salary desc) as rownum from employee)
select * from STwo where rownum=2

--find the first largest salary
select * from employee order by salary  offset 0 rows fetch next 1 rows only

--find the second largest salary
select * from employee order by salary desc limit 2,1;

--select first 3 rows frm table
select top 3 * from employee

--select 50% rows frm table
select top 50 percent * from employee

-- case statement
select id,name,age,
case
when age>25 then '25+'
when age<25 then ' '
else 'NA'
end as result
from employee

--Stored procedure is a set of statement that perform some defined actions
create procedure p_emp
@value int
as
begin
update  employee set age = @value where age >25
end

exec p_emp @value = 5

--view
--is a virtual table based on the  result set of an sql statement
--it contains rows and column jus like a rea; table

create view vemp as
select * from employee e inner join empdetails em on e.id=em.id;

select * from vemp;

--index

--used to create indexes in table
--used to retrive data from the db more quickly than otherwise

create index in_name on employee(name,city) --duplicate values are allowed
create unique index in_name on empdetails(role) -- duplicate values are not allowed

show index from employee;

--distinct returns only distinct vales
select distinct(city) from employee

 --order by sort for given column
select * from employee order by id asc
select * from employee order by id desc
select * from employee order by 5 asc --without typing column name
 
 -- wildcard
select * from employee where name like 'a%' --startswith
select * from employee where name like '%h' --endwith
select * from employee where name like 'Ara_inth' --represent only one empty char
select * from employee where name like '%ru%' --contains
select * from employee where name like 'A[ru]%' --any one char inside []
select * from employee where name like '[!ru]%' -- expect any one char inside []

--operator

select * from employee where id = 2 and sex ='M'
select * from employee where id = 2 or  sex ='M'
select * from employee where city = 'Chennai' or (id = 5 and age = 21)
select * from employee where age between 20 and 25
select * from employee where id in (1,2)

--used to compare between a single column value and a range of other values
--returns a boolean as a result
--returns true if any of subquery values meet the condition
select name from employee where id = any (select id from empdetails where department='QA')
--returns true if all of subquery values meet the condition
select name from employee where id = all (select id from empdetails where department='QA')

select * from employee where id is null
select * from employee where id is not null
select * from employee where id <> 5 --not equal to
select concat(id,name) as data from employee 
select convert(date,'2024-05-02')

--Aggregate func
select max(salary) from employee
select min(salary) from employee
select count(id) from employee
select sum(salary) from employee
select avg(salary) from employee

--string function
select name, lower(name) from employee
select name, upper(name) from employee
select name, trim(name) from employee -- space remove ltrim,rtrim
select name, replace(name,'Arun','Mithun') from employee -- replace
select substring(name, 1, 3) AS ExtractString from employee --substring(string, start, length)

--group by --used to arrange identical data into groups with help of same functions
select count(id),city from employee group by city
--having
select count(id),city from employee group by city having count(id)<2 
--partition by --used to partition rows of table into groups.
select id ,city, sum(salary) over (partition by city) as result from employee


--joins

--combine rows from two or more tables based on related column between them
--Inner join returns only matching records in both tables
select * from employee e inner join empdetails em on e.id=em.id;
--returns all the records frm the left table and matching records frm the right table
select * from employee e left outer join empdetails em on e.id=em.id
--return all the records frm the right table and matching records frm the left table
select * from employee e right outer join empdetails em on e.id=em.id
--return all records frm the tables including matched and unmatched records
select * from employee e full outer join empdetails em on e.id=em.id
--used to generate paired combination of each row from the first table with each row from the second table. 
--return cartesian product
select * from employee e cross join empdetails em where e.id=em.id
--self join is regular join but table is joined with itself
select * from employee e,empdetails em where e.id=em.id


--Sql Union
--used to compare two or more select statement

--union returns all the records frm the both statement except duplicate
select id  from employee union  select id from empdetails
--union all returns all the records frm the both statement including duplicate
select id  from employee union all  select id from empdetails
--intersect returns matching records from the both statement
select id  from employee intersect  select id from empdetails
--except returns all the unique records frm the left query
select id  from employee except  select id from empdetails


---sql key Constraints

--it does not accept null value
create table studentA (id int not null, name varchar(50),gender varchar(1))
--it accepts unique value
create table studentB (id int unique, name varchar(50),gender varchar(1))
--combination of not null and unique
create table studentC (id int , name varchar(50),gender varchar(1), primary key(id))
--foreign is a field in one table that refers to the primary key in another table
create table studentD (id int , name varchar(50),gender varchar(1), foreign key(id) references employee(id))
--check
create table studentE (id int not null, name varchar(50),gender varchar(1), age int , check (age>=18))
--default
create table studentF (id int not null, name varchar(50),gender varchar(1), Date date default getdate())

--ddl
--create,drop,alter,truncate

--dml
--insert,delete,drop

--dql
--select

--dcl
--grant,revoke

--tcl
--commit,rollback

--alter
alter table employee add  pincode int -- add new column
alter table employee alter column int varchar(4) --modify existing column's datatype
alter table employee rename column id to rollno -- rename existing column
alter table employee rename to empd; --rename table
--truncate
truncate table employee
truncate table employee with partitions(1,2 to 4);
--drop
drop table employee
--delete 
delete from employee where id =2;
delete from employee

--truncate
--remove all data from a table  
--cannot be rolledback
--preserves table structure
--delete
--remove all data/ a specific data from a table  
--can be rolledback
--preserves table structure
--drop
--remove an entire table  
--cannot be rolledback
--destory table structure

--update
update employee set id = 3 where city='chennai'

--insert

insert into employee (id,name)values(11,'Robin')

--commit
--used to save the current transactions premanently in the relational database
commit;

--rollback
--used to undo  the  transactions that have not been saved in the relational database
rollback;

--grant
--that allow u to manage the permission of a db
--grant is used to give user's permissions to a database
grant select,insert,delete on arvind to 'user1'@'localhost'

--revoke is used to take back permissions from a user
revoke select,insert,delete on arvind from 'user1'@'localhost'

