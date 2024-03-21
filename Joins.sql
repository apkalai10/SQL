

--A JOIN clause is used to combine rows from two or more tables, based on a related column between them

--1. Inner Join
--2. Self Join
--3. Cross Join
--4. Outer Join -->i)Left Outer Join, ii)right Outer Join, iii)full outer join


--An inner join or join returns only matching values in both tables.

select B.CD_CLIENT from M_CLIENT_DETAILS A  inner join T_SIGNING_MEMO B on A.CD_CLIENT=B.CD_CLIENT where B.AUTH_USER is not null order by B.CD_CLIENT asc;

--A self join is a regular join, but the table is joined with itself.

select A.CLIENT_NAME,B.CD_CITY from M_CLIENT_DETAILS A,M_CLIENT_ADDRESS B where A.CD_CLIENT=B.CD_CLIENT and B.CD_CITY is not null order by A.CLIENT_NAME asc;

---CROSS JOIN is used to generate a paired combination of each row of the first table with each row of the second table-cartesian join.

select * from M_CLIENT_DETAILS A cross join M_CLIENT_ADDRESS B where A.CD_CLIENT=B.CD_CLIENT;

--An LEFT JOIN or left outer join returns all records from the left table (table1), and the matching records from the right table (table2).

select A.CD_CLIENT,A.CLIENT_NAME,B.CD_CUSTOMER,B.LOAN_AC from M_CLIENT_DETAILS A left outer join T_DISBHEADER B on A.CD_CLIENT=B.CD_CUSTOMER where B.AUTH_USER is not null or B.NET_DISBAMT is not null order by A.CD_CLIENT,B.CD_CUSTOMER asc;

--An RIGHT JOIN or right outer join returns all records from the right table (table2), and the matching records from the left table (table1).

select A.CD_CLIENT,A.CLIENT_NAME,B.CD_CUSTOMER,B.LOAN_AC from M_CLIENT_DETAILS A right outer join T_DISBHEADER B on A.CD_CLIENT=B.CD_CUSTOMER and B.AUTH_USER is not null;

--An FULL OUTER JOIN or outer join returns all records when there is a match in left (table1) or right (table2) table records.

select A.CD_CLIENT,A.CLIENT_NAME,B.CD_CUSTOMER,B.LOAN_AC from M_CLIENT_DETAILS A full outer join T_DISBHEADER B on A.CD_CLIENT=B.CD_CUSTOMER;

--Three Tables
select A.CLIENT_NAME from M_CLIENT_DETAILS A inner join T_DISBDETAILS B on A.CD_CLIENT=B.CD_CUSTOMER 

                                             inner join  T_DISBHEADER C on A.CD_CLIENT=C.CD_CUSTOMER;







