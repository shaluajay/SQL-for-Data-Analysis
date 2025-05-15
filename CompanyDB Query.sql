use  company_db;


select * from employee;
select fname,bdate, salary,sex from employee;
select  super_ssn  from employee;
select distinct super_ssn from employee;

-- aliases or giving name 
select fname as first_name ,lname as last_name from employee; --  renaming
select fname as "First name" from employee; -- for giving space
select fname first_name ,lname last_name from employee;-- without "as" renaming method

-- filters
select  fname, sex , salary from employee where sex ="m";
select * from employee where  sex= "m";
select * from employee where sex = "f";
select * from employee where salary > 30000;
select * from employee where ssn = 123456789;
select * from employee where super_ssn  is null;
select * from employee where super_ssn is not null;
select * , salary*10 as New_salary  from employee;


-- AND \ OR \ NOT

 select * from employee   where salary  =25000 and sex ="f";
  select * from employee   where salary>25000 and salary<50000;

-- between
 select * from employee where salary  between 40000 AND 60000;
 
  -- WILD CARD OPERATORS % = unlimited number of spaces | _= single space
  select * from employee where fname like "a%";
  select * from employee where fname like "_e%";
  select * from employee where lname like "%g";
  select * from employee where dno = 5 and  fname like "a%";
  select * from employee;
  
   -- IN AND NOT IN operators
   select * from employee where salary =25000 or salary =30000 or salary =55000;
    select * from  employee where salary in(25000,30000,55000);
    select * from  employee where salary not in(25000,30000,55000);   

 -- asc and desc
   select * from employee  order by salary;
   select * from employee order by salary  desc,dno, fname desc;
   select * from employee order by salary desc limit 1; -- highest
   select * from employee order by salary desc limit 1 offset 2; -- 2nd highest
select * from employee where sex="f" and salary>25000 and address like "%fondren%";

select * from employee where sex = "f" and salary in (25000,55000,43000) And address like '%houston%' order by salary desc limit 1 offset 1;

-- CASE 
select *, case sex
when 'm' then "male"
when "f" then "female"
end as gender 
from employee;

-- the bonus cahr is given  and  find out thr new salaey as per  bonus scheme
/* sex = f salary below 30000 then 20%
sex =m and salary  below 30k then 30k%*/
select  * from employee;
select * , case 
when salary<30000 and sex="f" then salary+(salary*.20)
when salary<30000  and sex ="m" then salary+(salary*.30)
else salary+(salary*.05) end as new_salary from employee;


 select *, new_salary - salary  as Diff from (select * , case 
when salary<30000 and sex="f" then salary+(salary*.20)
when salary<30000  and sex ="m" then salary+(salary*.30)
else salary+(salary*.05) end as new_salary from employee) as tabular;

select sex, sum(salary), count(*),avg(salary) from employee where sex ="m";
select sum(salary) from employee where sex= "f";
select sum(salary) from employee where dno= "5";
select sum(salary) from employee where sex= "f";


  -- rounding
-- round, floor ,ceil
select ceil(10.2000000000000000000000001) as ceil, floor(10.99999999999999999999999999999999)as floor, round(10.4) as round1 , round(10.6) as round2;

select round(10546.2456,1);

-- count and countd
select count(*), count(distinct  super_ssn)  from employee;

 -- dateiff(in days), timestampiff(customisable)
 -- curdate- current date
 select fname, bdate,datediff(curdate(),bdate ) as age from employee;
 select fname, bdate ,floor(datediff(curdate(),bdate)/365) as year_Age from employee;
 
 select fname,bdate, timestampdiff(year, bdate,curdate()) as age from employee;
  select fname,bdate, timestampdiff(month, bdate,curdate()) as age from employee;
   select fname,bdate, timestampdiff(day, bdate,curdate()) as age from employee;
    select fname,bdate, timestampdiff(quarter, bdate,curdate()) as age from employee;

--- group by

select sex, sum(salary) from employee group by sex;
select sex, sum(salary) from employee  where sex="m" group by sex;

select dno, sum(salary)  from employee group by dno;
select sex ,sum(salary) from employee group by sex;
select * from employee;
describe employee;
select * from project;
select* from works_on;
select * from dependent;

select pno ,sum(hours) from works_on group by pno;
select essn, sum(hours) from works_on group by essn;

-- having clause
select  essn ,sum(hours) as hours from works_on group by essn having hours<40;
select  essn ,sum(hours) as hours from works_on where pno=2 group by essn having hours<15 order by hours;

-- select , case, from, join, where, group by, having, order by, limit, offset

select dno, sum(salary) as sal from employee where ssn like "%5" and  address like "%houston%" group by dno  having sal>50000 order by sal desc;

--  lead , lag, rank , dense rank ,row number(window fn:)
-- over
select *,sum(salary) over() from employee;
select fname ,salary , rank() over(order by salary desc) from employee;
select fname, salary, dno, rank() over(partition by dno order by salary) from employee;

select dno, sum(salary) from employee group by  dno;
select distinct dno, sum(salary ) over(partition by dno ) from employee;



  
   select * from employee;
   select * from works_on;
   select * from project;
   select * from dependent;
   -- no fo depen per emp
   select essn, count(relationship) from dependent group by essn ;
   -- no of depem per emp except father
   select essn ,count(relationship) from dependent where not  relationship =  "son" group by essn ;
   
   --  find out the no of employee in each project
   select pno ,count(essn)  from works_on group by pno;
   
   
   -- sub queires
 -- get details of employee who have worked less than 40 hours
  select essn, sum(hours) from works_on group by essn having sum(hours)<40;
   
select * from employee where ssn=987654321;

select * from employee where ssn in(select essn from works_on group by essn having sum(hours)>35);
-- get all employee who do not have any dependant
 select * from employee where ssn not in(select essn from dependent);
 -- get employee who are working in computerzation project;
select * from employee where ssn in(select essn from works_on where pno in(select pnumber from project where  pname="Computerization"));


-- get emp details who having atleast 2 dependents and also who worked morethan 35hr in total and from productx project

select * from employee where ssn in
(select essn from dependent group by essn having count(*)>=2
and ssn in(select essn from works_on group by essn having sum(hours)>=35 
and ssn in( select essn from works_on where pno in (select pnumber from project where pname ="ProductX"))));
 
 select * from employee 
 where
      ssn in 
      (select essn from dependent  group by
      essn having count(*)>=2)
and 
      ssn in 
      (select essn from works_on where pno in 
            (select pnumber  from project where pname="ProductX"))
and
       ssn in 
       (select essn from works_on group by essn
       having sum(hours) >=35);
       
	
-- with
with table1 as (select * from employee),
table2 as( select * from project)
select * from table1;


-- join  
-- left,right,inner,full outer,self,cross 

-- inner
select * from employee inner join dependent on (employee.ssn=dependent.essn);  -- show only common element from both the table
select * from employee inner join  works_on on (employee.ssn = works_on.essn);

select employee.fname, employee.lname,employee.sex,employee.dno,dependent.dependent_name,dependent.sex from employee join dependent on (employee.ssn= dependent.essn);
select e.fname,e.lname,e.sex,e.dno,d.dependent_name,d.sex from employee e join dependent d on(e.ssn= d.essn);
-- get me employee onfo with their  total working time
select e.fname,e.lname,e.address,e.dno,e.sex,sum(w.hours) from employee e join works_on w on(e.ssn=w.essn) group by e.fname,e.lname,e.address,e.dno,e.sex;
select e.fname,e.lname,e.address,e.dno,e.sex,sum(w.hours) from employee e join works_on w on(e.ssn=w.essn) group by e.fname,e.lname,e.address,e.dno,e.sex;

-- find all mangers with total hours of theri project and total number of project under them with no of employee
select e.super_ssn,count(distinct e.ssn) ,sum(w.hours),count( distinct w.pno) from employee e join works_on w on (e.ssn=w.essn)  where e.super_ssn is not null group by e.super_ssn;

select e.super_ssn manager_ssn,
count(distinct e.ssn) employee_count,
sum(w.hours) total_hrs,
count( distinct w.pno) total_project
from employee e join works_on w on (e.ssn=w.essn)  where e.super_ssn is not null 
group by e.super_ssn;

-- left join
-- get fname,lname,ssn,dependantsname,pnumber,total working hrs for all emplyee who are only males annd total working hours must be greater than 10 and must have atleat two 
-- dependents or no dependents,and sort them based on their sa;ary and workig hours 

select e.fname,e.lname,e.ssn,d.dependent_name,count( d.relationship),w.pno,sum(w.hours) from employee e left join dependent d  left join works_on w 
 on(e.ssn=d.essn=w.essn) where e.sex='m' and d.relationship is not null
group by e.fname,e.lname,e.ssn,d.dependent_name,d.relationship,w.pno having sum(w.hours)<10 and count( distinct d.relationship)>2 order by e.salary ;


select
   e.fname,
   e.lname,
   e.ssn,
   d.dependent_name,
   count(w.pno),
   sum(w.hours) -- columns
from employee e 
    left join dependent d  on(e.ssn=d.essn) 
    left join works_on w on(e.ssn=w.essn) -- join
WHERE e.sex='m'
         group by e.fname, e.lname, e.ssn, d.dependent_name -- filter
   having 
   sum(w.hours)> 10 
   and 
   (count(d.dependent_name)>=2 or -- having aggregation
   d.dependent_name is null) order by e.salary and sum(w.hours);-- orderby
   
   
   
-- self join
select 
    e.fname,
    e.ssn,
    e.super_ssn,
    m.fname,
    m.ssn
from
    employee e
join
    employee m
       on(e.super_ssn=m.ssn);
       
-- cross join 
select e.fname, d.dependent_name from employee e cross join  dependent d;

-- stored procedure
-- in,out,in and out

delimiter ///
create procedure sim()
begin
select * from employee where salary>25000;

end ///
delimiter ;

 call sim();
 
 -- procedure with in parameter

delimiter ///
create procedure input(in var1 int,in var2 char(1))
begin
select avg(salary) from employee where dno= var1 and sex= var2;
end ///
delimiter ;
call input(5,'m');

create table sample(id int primary key,
name char(50),mob bigint);

delimiter ///
create procedure sam(in var1 int,in var2 char(50),in var3 bigint)
begin
insert into sample (id,name,mob) values (var1,var2,var3);
end///
delimiter ;
call sam(1,'Ajay',9074911462);

delimiter ///
create procedure sam2(in var1 int,in var2 char(50),in var3 bigint)
begin 
select case
when var1 in (select id from sample) then 'Transaction Unsuccessful'
else 'updation done ' end as message;
insert into sample (id,name,mob) values (var1,var2,var3);
select * from sample;
end
///
delimiter ;

-- trigger

create table t1 as select * from sample;
truncate t1;


create table t2(
id int,
name char(80),
salary int);
select * from t2;


alter table t2 rename column name to fname;


-- after trigger

delimiter ///
create trigger two
after insert on t1 for each row
begin
insert into t2(ssn,fname)
values(new.id,new.name);
end ///
delimiter ;

insert into t1 values (1,"Ajay",9074911462);
select * from t1;
select * from t2;


delimiter ///
create procedure ben()
begin
declare var1 float;
select avg(salary) into var1 from employee;
select * from employee where salary>var1;
end ///
delimiter ;

call ben;

use company_db;
-- create a banking procedure where you have tables like transaction table , account summary table.
-- you must be having different procedures for account addition, balance check, fund transfer and fund withdrawal and account closure and statement creation.
-- the fund transfer and withdrawal should take place only if the payee has sufficient fund in their account, also as the amount deducted from payees account it should reflect in total account summery in beneficieries account.
-- if the user asks for statemnt it must give complete statement of transaction calenderwise as per the ac no input
-- after account creation account no allocation must be auto and it must be shown as output with status
-- table columns are transaction table(ac no, transaction type(debit or credit), amount)
-- summary table(ac no , total balance)
-- every transaction or activity must display status if it pass or fails.

-- out


delimiter //
create procedure rizwana(in var1 int, out var2 float)
begin
select avg(salary) into var2 from employee where dno=var1;
end//
delimiter ;
call rizwana(5,@var2);
select *,salary+@var2 from employee;


-- function
-- determinstic and non deterministic fn

delimiter //
create function addition(x float,y float,z float)
returns float
deterministic
begin
declare a float;
set a= x+y+z;

return a;

end //
delimiter ;

select *,addition(salary,1000,0) from employee;

delimiter //
create function age(var1 date)
returns int
deterministic
begin 
declare var3 int;
set var3= timestampdiff(year,var1,curdate());
-- select timestampdiff(year,var1,curdate()) into var3;
-- set var3 = floor(datediff(curdate()var1)/365);
return var3;
end//
delimiter ;

select *,age(bdate) as age from  employee;


-- create a function to calculate the tax amount for the salary based on below slabs
-- 0 to 30000 tax at 10%
-- 30001 to 40000 tax at 20 %
-- 40000 to 46000 at  30%
--  above 46000 at 50%
-- its telescopic.

-- views
create view mridul  as select fname,lname,ssn from employee;
select * from mridul;

-- coalesce 
select fname,lname,coalesce(super_ssn,fname,bdate);

use company_db;
 -- get employee with their dependent name and  who works in houstin and having salary greater than the avrage salary of deparment 4 and total working hrs must be greater -- -- than 45
 
 select * from dependent where
 essn in 
 (select ssn from employee where dno in
               (select dnumber from dept_locations where dlocation like 'houston'))
 and  essn in
 (select ssn from employee where 
				salary > (select avg(salary) from employee where dno=4))
 and essn in
 (select essn from works_on group by essn having sum(hours)>35);
 
 
 
 
 
 