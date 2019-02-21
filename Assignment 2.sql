use employees;

#Q2. the average, minimum, and maximum salaries of male and female employees
select gender, avg(salary), min(salary), max(salary),count(distinct e.emp_no) as number
from employees e, salaries s
where s.emp_no = e.emp_no
group by gender;

#Q3. employees were working for the dept number ‘d007’ between 1985-01-01and 1991-03-07
select dept_no,count(distinct emp_no)
from dept_emp
where dept_no='d007' 
and ((from_date between '1985-01-01'and'1991-03-07') or (to_date between '1985-01-01'and'1991-03-07'))
group by dept_no;

# Q4 distinct employee numbers;Group the employees in terms of employee numbers and obtain the average salary for each group
select count(distinct emp_no)
from salaries;

select emp_no, avg(salary), count(emp_no)
from salaries
group by emp_no;

#Q5. employees are listed as either senior staff or staff
select count(distinct emp_no)
from titles
where title in ('staff', 'senior staff ');






