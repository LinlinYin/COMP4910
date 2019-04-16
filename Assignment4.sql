use employees;
# question 1
CREATE TABLE IF NOT EXISTS Clients (     
ClientNo INT NOT NULL,    
First_Name VARCHAR(45) NULL,    
Last_Name VARCHAR(45) NULL );

# question 2
INSERT INTO Clients  
VALUES (16, 'Fohn','Havis'), (12, 'Rohn','Wavis'), 
(16, 'Pohn','Qavis'), (14, 'Gohn','Tavis'); 

select *
from Clients;

# question 3
create view ourView as  
select *   
From clients   
where ClientNo = 12; 

# question 4
select * 
from ourView; 

#question 5 case1
SET SQL_SAFE_UPDATES = 0;
insert into Clients values (12,'Dillo', 'Tanks'); 
select *
from Clients;
select *
from ourview;

# question 5 case2
insert into Clients values (18,'Fillo', 'Uanks'); 
select *
from Clients;
select *
from ourview;

# question 5 case3
update Clients 
set ClientNo = 15 
where ClientNo = 12;
select *
from ourview;
select *
from Clients;

# question 5 case 4
update Clients 
set ClientNo = 12
where ClientNo = 14;
select *
from ourview;
select *
from Clients;

#question 5 case 5
delete from Clients 
where ClientNo = 12;
select *
from ourview;
select *
from Clients;

Drop view ourView;
Drop table Clients; 

CREATE TABLE IF NOT EXISTS Clients (     
ClientNo INT NOT NULL,    
First_Name VARCHAR(45) NULL,    
Last_Name VARCHAR(45) NULL );

INSERT INTO Clients  
VALUES (16, 'Fohn','Havis'), (12, 'Rohn','Wavis'), 
(16, 'Pohn','Qavis'), (14, 'Gohn','Tavis'); 

create view ourView as  
select *   
From clients   
where ClientNo = 12; 

select * 
from ourView; 

# question 6 case 1
insert into ourView values (12,'Dillo', 'Tanks'); 
select * 
from ourView; 
select *
from clients;

# question 6 case 2
insert into ourView values (18,'Fillo', 'Uanks'); 
select * 
from ourView; 
select *
from clients;

# question 6 case 3
update ourView 
set ClientNo = 15 
where ClientNo = 12; 
select * 
from ourView; 
select *
from clients;

# question 6 case 4
update ourview 
set ClientNo = 12 
where ClientNo = 14 ;
select * 
from ourView; 
select *
from clients;


update clients 
set ClientNo = 12 
where ClientNo = 14 ;

# question 6 case 5
delete from ourView 
where ClientNo = 12;
select * 
from ourView; 
select *
from clients;

# question 6 case 6
delete from ourView
where ClientNo = 14;
select * 
from ourView; 
select *
from clients;

Drop view ourView;
Drop table Clients; 

CREATE TABLE IF NOT EXISTS Clients (     
ClientNo INT NOT NULL,    
First_Name VARCHAR(45) NULL,    
Last_Name VARCHAR(45) NULL );

INSERT INTO Clients  
VALUES (16, 'Fohn','Havis'), (12, 'Rohn','Wavis'), 
(16, 'Pohn','Qavis'), (14, 'Gohn','Tavis'); 

create view ourView as  
select *   
From clients   
where ClientNo = 12 WITH CHECK OPTION;  

select * 
from ourView; 


# problem D, case 1
ALTER TABLE Clients 
Drop First_Name;
select *
from ourView; 
select *
from clients;


# problem D, case 2
ALTER TABLE Clients 
add myCol varchar(10);
select ClientNo
from ourView; 
select *
from clients;

ALTER view ourView (ClientNo, First_Name, Last_name)
AS SELECT ClientNo, upper(First_Name), upper(Last_name) 
from clients;
select * 
from ourView; 
select *
from clients;

CREATE VIEW LowSalary
AS SELECT *
FROM salaries WHERE salary>9000;

# Bonus question
CREATE VIEW HighSalary
AS SELECT *
FROM LowSalary WHERE salary>80000
WITH LOCAL CHECK OPTION;

select *
from highsalary;

CREATE VIEW Staff10005
AS
SELECT *
FROM HighSalary
WHERE emp_no=10005;

UPDATE Staff10005
SET salary=9500
WHERE emp_no=10005;