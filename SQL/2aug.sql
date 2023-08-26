use firstclass;

select * FROM student;

INSERT INTO student(req_id,Name,city,marks) VALUES
(1001,'ANKIT','Ambala',900);
INSERT INTO student VALUES
(1003,'Baba','Himachal',1000);
INSERT INTO student(req_id,Name,city,marks) VALUES
(1004,'Arun','Pinjore',800);

select * from student where Name="ANKIT" AND city="Ambala";

select * from student ORDER BY marks DESC;

DELETE from student where Name="ANKIT1";

select city,sum(marks) from student group by city;
select city, sum(marks) from student group by city having sum(marks)>800;

#Alter table statement

alter table student ADD score int;
ALTER table student modify column score varchar(255);
Alter table student drop column score;

# to create alias we use as in the middle 
select marks as score from student;

#Drop

drop table student;
drop database firstclass; 

#like

select * from student where city like '%A'; # ends with
select * from student where Name like '%A%'; # at any position
select * from student where Name like 'A%'; # starts with 
select * from student where Name like 'A%T'; #starts with A and ends with T
select * from student where Name like 'A_%'; #starts with A and have atleast 2  length
select * from student where Name like '_N%'; # second letter should be N and have length 2


#between
select * from student where marks between 800 and 900;

#IN
select * from student where city in('Pinjore','Ambala');

#update
update student set marks=100 where Name="ANKIT";

#truncate
truncate table student;

# constraints 1.notnull

create table employee(
emp_id int not null,
name varchar(255),
designation varchar(255));

Insert into employee values (123,"Baba","Manager");
Insert into employee values (1234,"Harsh","HR");

drop table employee;
#unique
create table employee(
emp_id int unique,
name varchar(255),
designation varchar(255),
age int, check(age>18)
);
Insert into employee values (123,"Baba","Manager");
Insert into employee values (1234,"Harsh","HR",19);


#primary key and foreign key
create table orders(
order_id int unique not null,
ordernumber int,
place varchar(255)
);
insert into orders values(123,01,"varanasi");
insert into orders values(124,02,"Dwarka");
insert into orders values(125,03,"Prayagraj");

create table persons(
person_id int,
name varchar(255),
order_id int,foreign key(order_id) references orders(order_id)
);

insert into persons values(101,"shivam",123);

---- JOIN FUNCTION  ----

create table customer(
id int,
name varchar(255),
address varchar(255),
city varchar(255)
);
insert into customer values (1,"prakash",'H-191',"ranikoot");
insert into customer values (2,"harsh",'H-190',"ambala");
insert into customer values (3,"arun",'H-192',"Delhi");
insert into customer values (4,"naman",'H-194',"chandighar");

create table orderes(
order_id int,
product varchar(255),
id int
);
insert into orderes values (10,"Trimmmer",1);
insert into orderes values (20,"hair_oil",2);
insert into orderes values (30,"pasta",3);
insert into orderes values (40,"macroni",4);

SELECT 
    order_id,
    customer.name,
    customer.address,
    customer.city,
    orderes.product
FROM
    customer
        INNER JOIN
    orderes ON customer.id = orderes.id;

--- left join ---
SELECT 
    order_id,
    customer.name,
    customer.address,
    customer.city,
    orderes.product
FROM
    customer
        LEFT JOIN
    orderes ON customer.id = orderes.id;
    
--- right join --- 
SELECT 
    orderes.id,
    customer.name,
    customer.address,
    customer.city,
    orderes.product
FROM
    customer
        RIGHT JOIN
    orderes ON customer.id = orderes.id;

--- important concepts ---

CREATE TABLE employee (
    emp_ID INT,
    emp_NAME VARCHAR(50),
    DEPT_NAME VARCHAR(50),
    SALARY INT
);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

SELECT 
    DEPT_NAME, MAX(SALARY) AS record
FROM
    employee
GROUP BY DEPT_NAME
ORDER BY record DESC;

---- 4aug ----

---- Window funciton ----

select *, max(SALARY) over(partition by DEPT_NAME) as max_Salary
from employee order by max_salary desc;

select *, row_number() over(partition by DEPT_NAME) as rn 
from employee;

# to select top 2 employee from each dept
select *from(
select e.*, row_number() over(partition by DEPT_NAME order by emp_ID) as detail
from employee e) as x
where x.detail <3;

select *from(
select *, rank() over(partition by DEPT_NAME order by salary desc) as detail
from employee) as x
where x.detail <3;

select *from(
select *, dense_rank() over(partition by DEPT_NAME order by salary) as detail
from employee) as x
where x.detail <3;

#select * from(
select *,
row_number() over(partition by DEPT_NAME order by salary) as rn,
rank() over(partition by DEPT_NAME order by salary) as rnk,
dense_rank() over(partition by DEPT_NAME order by SALARY) as dense 
from employee;

---- lag and lead -----
select *, 
lag(salary) over(partition by DEPT_NAME order by salary) as prev_salary,
lead(salary) over(partition by DEPT_NAME order by salary) as nxt_salary 
from employee;


---- case -----

select e.*,
lag(salary) over(partition by DEPT_NAME order by emp_ID) as prev_empID,
case when e.salary > lag(salary) over(partition by DEPT_NAME order by emp_ID) then " prev salary is greater then current salary"
	when e.salary < lag(salary) over(partition by DEPT_NAME order by emp_ID) then " current salary is greater then prev salary"
    when e.salary > lag(salary) over(partition by DEPT_NAME order by emp_ID) then " current salary is equal to current salary" 
end as salary_comparision
    from employee e;








