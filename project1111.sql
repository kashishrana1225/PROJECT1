create database kk;
use kk;
create table empp
(
empno int primary key,
ename varchar(20),
job varchar(20),
mgr int,
hiredate date,
sal decimal(7,2),
comm decimal(7,2),
deptno int,
foreign key (deptno) REFERENCES dept (deptno)
);
drop table  empp;

create table dept
(
	deptno int primary key,
    dname varchar(20),
    loc varchar(20)
);

create table student
(
 rno int primary key,
 sname varchar(20),
 city varchar(20),
 state varchar(20)
);

INSERT INTO student (rno, sname, city, state) VALUES
(1, 'Amit Sharma', 'Ahmedabad', 'Gujarat'),
(2, 'Priya Patel', 'Surat', 'Gujarat'),
(3, 'Ravi Mehta', 'Mumbai', 'Maharashtra'),
(4, 'Neha Singh', 'Pune', 'Maharashtra'),
(5, 'Karan Joshi', 'Jaipur', 'Rajasthan'),
(6, 'Anjali Verma', 'Lucknow', 'Uttar Pradesh'),
(7, 'Rohit Kumar', 'Delhi', 'Delhi'),
(8, 'Meena Gupta', 'Bhopal', 'Madhya Pradesh'),
(9, 'Suresh Yadav', 'Chennai', 'Tamil Nadu'),
(10, 'Pooja Nair', 'Kochi', 'Kerala');

create table emp_log
(
emp_id int,
log_date date,
new_salary int,
action1 varchar(20)
);

INSERT INTO dept (deptno, dname, loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

INSERT INTO empp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1986-06-19', 3000.00, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100.00, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);


#1 Select unique job from EMP table
select distinct job from empp;

#2 List the details of the emps in asc order of the Dptnos and desc of Jobs?
 select * from empp
 order by deptno asc,job desc;
 
#3 Display all the unique job groups in the descending order?
 select distinct job from empp
 order by job desc;
 
#4 List the emps who joined before 1981
select * from empp
where hiredate < '1981-01-01';

#5 List Empno, Ename, Sal, Daily sal of all emps in asc order of Annual sal
select empno, ename, sal, sal/30 as daily_sal
from empp
order by sal*12 ASC;

#6 List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369
select empno, ename, sal,
       TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) AS exp_years
from empp
where mgr = 7369;

#7. Display details of emps whose Comm is more than their Sal
SELECT * FROM empp
WHERE comm > sal;

#8. List the emps who are either 'CLERK' or 'ANALYST' in desc order
SELECT * FROM empp
WHERE job IN ('CLERK', 'ANALYST')
ORDER BY ename DESC;

#9. List the emps Who Annual sal ranges from 22000 and 45000
SELECT * FROM empp
WHERE (sal*12) BETWEEN 22000 AND 45000;

#10. List Enames starting with 'S' and with five characters
SELECT * FROM empp
WHERE ename LIKE 'S____';

#11. List emps whose Empno not starting with digit 78
SELECT * FROM empp
WHERE empno NOT LIKE '78%';

#12. List all Clerks of Deptno 20
SELECT * FROM empp
WHERE job = 'CLERK' AND deptno = 20;

 
 #13. List the Emps who are senior to their own MGRS
SELECT * FROM empp e
JOIN empp m ON e.mgr = m.empno
WHERE e.hiredate < m.hiredate;

#14. List Emps of Deptno 20 whose Jobs are same as Deptno 10
SELECT * FROM empp
WHERE deptno = 20 AND job IN (
    SELECT DISTINCT job FROM empp WHERE deptno = 10
);

#15. list the emps whose sal is same as ford or smith in desc order of sal
select * from empp
where sal in (
    select sal from empp where lower(ename) in ('ford', 'smith')
)
order by sal desc;

# 16. list emps whose jobs same as smith or allen
select * from empp
where lower(job) in (
    select lower(job) from empp where lower(ename) in ('smith', 'allen')
);

#17. any jobs of deptno 10 those are not found in deptno 20
select distinct job from empp where deptno = 10
and lower(job) not in (
    select distinct lower(job) from empp where deptno = 20
);

# 18. find the highest sal of emp table
select max(sal) as highest_salary from empp;

# 19. find details of highest paid employee
select * from empp
where sal = (select max(sal) from empp);

# 20. find the total sal given to the mgr
select mgr, sum(sal) as total_salary
from empp
group by mgr;

#21. list the emps whose names contain 'a'
select * from empp
where lower(ename) like '%a%';

# 22. find all emps who earn the minimum salary for each job in ascending order
select * from empp e
where sal = (
    select min(sal) from empp where lower(job) = lower(e.job)
)
order by sal asc;

#23. list emps whose sal greater than blake's sal
select * from empp
where sal > (select sal from empp where lower(ename) = 'blake');

# 24. create view v1 to select emp, job, dname, loc whose deptno are same
create or replace view v1 as
select e.empno, e.ename, e.job, d.dname, d.loc
from empp e
join dept d on e.deptno = d.deptno;

#25. create procedure with dept as input parameter to fetch emp and dept details
delimiter //
create procedure getempbydept(in dept_no int)
begin
    select e.*, d.*
    from empp e
    join dept d on e.deptno = d.deptno
    where e.deptno = dept_no;
end //
delimiter ;
