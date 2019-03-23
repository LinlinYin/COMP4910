use employees;
show tables;

# part 1
# Problem 01: Retrieving Records: you have a table and want to see all of the data. 
SELECT *
FROM employees;

# Problem 02: View only selective columns of the table. 
SELECT TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age, gender AS sex
FROM employees;


#Problem 03: View only selective rows that satisfy certain conditions.
SELECT first_name, last_name, TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age
FROM employees 
WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) >35;

#Problem 04: Display rows that satisfy multiple conditions. 
#Following the WHERE clause use the OR and AND statements. 
#Show the employees who join the company early than 1990 and are over 40 years of age or who are females.
SELECT *
FROM employees
WHERE (hire_date<1990-01-01 and TIMESTAMPDIFF(YEAR, birth_date, CURDATE())>40) OR gender = 'F';

#Problem 05: Rename the columns and then view the table with the newly named column. 
SELECT emp_no as empNO, birth_date as DOB, gender as sex
FROM employees;

#Problem 06: Concatenating column values to combine multiple columns into one. 
SELECT concat(first_name, last_name) as Names
FROM employees
WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE())>40;

# Implement IF-ELSE statement
SELECT emp_no, salary,
CASE
	WHEN salary <= 50000 then 'underpaid'
	WHEN salary >= 70000 then 'overpaid'
	ELSE 'paid'
END as paymentStatus
FROM salaries;

#Problem 08: Limit the number of rows 
SELECT *
FROM salaries limit 5;

#Problem 09: Returning n random records from a table 
SELECT emp_no, salary
FROM salaries
ORDER BY rand() limit 5;

#Problem 10: Find all the rows that have NULL or missing entries in a particular column 
SELECT *
FROM titles
WHERE to_date is NULL;

# Transforming NULL entries into REAL values
SELECT 
CASE
WHEN to_date is null then 0
ELSE to_date
END
FROM titles; 

# Problem 11: Search rows with specific patterns in a particular column. 
SELECT emp_no, salary
FROM salaries
WHERE salary in (65000, 70000);

# Problem 11: Use of wildcard operator % to search rows that have specific substring pattern. 
SELECT emp_no, first_name, last_name
FROM employees
WHERE gender in ('M', 'F') and (first_name like '%th%' or first_name like '%son');

# PART – II 
#Problem 01: Sort the rows based on ascending order of the salary (from lowest to highest) 
select emp_no, salary, from_date
from salaries
where from_date > 1990-01-01
order by salary asc;

#Problem 02: Sort the rows based on multiple fields or columns. 
select emp_no, salary, from_date
from salaries
order by emp_no, salary desc;

#Problem 03: Sort the rows based on the alphabetic order of substring in a column. 
SELECT emp_no, first_name, last_name
FROM employees 
ORDER BY substring(first_name, length(first_name)-2);

#Problem 04: Order NULL entries of the salary field in descending order and non-null in ascending order. 

SELECT emp_no, title, from_date, to_date 
FROM ( SELECT emp_no, title, from_date, to_date,  
		CASE WHEN title IS NULL THEN 0 
        ELSE 1 
        END AS is_null 
        FROM titles ) x 
ORDER BY is_null desc, from_date;

#Problem 05: Sort rows based on a conditional logic

SELECT emp_no, first_name, last_name, gender, hire_date, 
CASE WHEN gender = 'F' then hire_date 
else birth_date
end as ordered 
FROM employees 
ORDER BY ordered; 

# Problem 06: Find the age in years at the time of hire use the date of hire 
# and the birth date of male employees only. 
SELECT first_name, last_name, DATEDIFF(hire_date, birth_date)/365 AS age_hire  
FROM  employees 
WHERE gender = 'M' ; 

# Problem 07
SELECT first_name, DATEDIFF(hire_date, birth_date)/365 AS  age_hire  
FROM  employees 
WHERE (DATEDIFF(hire_date, birth_date)/365)>28; 

# PART – III 
#Problem 01: Stack one table on the top of other.
SELECT emp_no as emp_and_dept, dept_no 
FROM current_dept_emp 
where dept_no = 'd002'
UNION ALL 
SELECT dept_name, dept_no 
FROM departments;

#Problem 02. You want to return rows from multiple tables by joining on a known common columns 
# or joining on columns that share common values. 
SELECT e.first_name, s.salary 
FROM employees e, salaries s
WHERE e.emp_no = s.emp_no;


# Problem 03:  select emp_no from employees who is not in dept_manager table (means NOT manager)
SELECT emp_no 
FROM employees 
WHERE emp_no NOT IN (SELECT emp_no FROM dept_manager);
 
 # Problem 04: Obtain the sum or aggregate values from the numeric columns.
SELECT count(emp_no) as total_emp, sum(salary) as total_salary,  
avg(salary) as avg_salary  
FROM salaries;

 
 # PART – IV
 ##4.1 Inserting a new record 
INSERT INTO departments (dept_no, dept_name) 
VALUES ("d999", "Temp1"), ("d998", "Temp2");
 select * from departments;
 
 ##4.2 Inserting default values 
 CREATE TABLE temp (tempCol1 INTEGER DEFAULT 0);
 INSERT INTO temp VALUES ();
 SELECT * from temp;
 
#4.3 Overriding a default value with NULL
CREATE TABLE temp1 (tempCol1 INTEGER DEFAULT 0, tempCol2 VARCHAR(10));
INSERT INTO temp1 (tempCol1,tempCol2) VALUES (null,"TSU_TIGERs");
select * from temp1;
 
#4.4 Copying rows from one table into another  
INSERT INTO dept_manager (emp_no, dept_no, from_date,to_date) 
SELECT emp_no, dept_no, from_date,to_date 
FROM dept_emp  
WHERE emp_no IN ("10002");
select *
from dept_manager;

#4.5 Copying table definitions (column names), but not the contents (rows) 
CREATE TABLE dept_manager_temp AS SELECT * FROM dept_manager WHERE 1 = 0;
select *
from dept_manager_temp;

#4.6 Update records in a table. 
#Say, you want to increase the salary of "10002" employee by 10%. 
 
UPDATE salaries SET salary = salary*1.10 WHERE emp_no IN ("10002");
select *
from salaries;

#4.7 Update records in a table corresponding to another table 
#Increase the salary of the employees who appear in another table named dept_manager 
 
UPDATE salaries  SET salary = salary* 1.10 WHERE emp_no IN (SELECT emp_no FROM dept_manager);
SELECT*
from salaries;

# 4.8 Deleting specific records 
#Example, delete all the rows that emp_no=="10002"
 
DELETE 
FROM dept_manager 
WHERE emp_no = "10002"; 



#4.9 Delete records in the main that do not exist in another table 
#Delete those employees records from employees who do not appear in the dept_manager table. 
CREATE TABLE employees_temp 
AS 
SELECT * FROM employees;
DELETE FROM employees_temp 
WHERE emp_no NOT IN (SELECT emp_no from dept_manager);

 
#4.10 Delete duplicate records. 
CREATE TABLE salaries_temp 
AS 
SELECT * 
FROM salaries limit 1000;

SELECT emp_no, min(salary) 
FROM salaries_temp 
GROUP BY emp_no;


 
#4.11 Delete records from the main_table of students who failed more than or equal to 3 times and appear in the table named fail_grade 
 CREATE TABLE dept_manager_temp 
 AS 
 SELECT * FROM dept_manager;
DELETE FROM dept_manager_temp 
WHERE emp_no IN (SELECT emp_no FROM salaries GROUP BY emp_no having count(*) >=15);
SELECT * from dept_manager_temp;
 
 
 
