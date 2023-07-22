create database employee;
 use employee;
 
 


CREATE TABLE EMPLOYEE (
    SSN VARCHAR(20) PRIMARY KEY,
    fname VARCHAR(100) NOT NULL,
    lname varchar(20) not null,
    Address VARCHAR(200) NOT NULL,
    Sex VARCHAR(10) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    SuperSSN VARCHAR(20),
    DNo INT NOT NULL,
    FOREIGN KEY (SuperSSN) REFERENCES EMPLOYEE (SSN) 
    
);


CREATE TABLE DEPARTMENT (
    DNo INT PRIMARY KEY,
    DName VARCHAR(100) NOT NULL,
    MgrSSN VARCHAR(20),
    MgrStartDate DATE,
    FOREIGN KEY (MgrSSN) REFERENCES EMPLOYEE (SSN)
);

alter table EMPLOYEE
add FOREIGN KEY (DNo) REFERENCES DEPARTMENT (DNo);


CREATE TABLE DLOCATION (
    DNo INT PRIMARY KEY,
    DLoc VARCHAR(100) NOT NULL,
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT (DNo)
);


CREATE TABLE PROJECT (
    PNo VARCHAR(20) PRIMARY KEY,
    PName VARCHAR(100) NOT NULL,
    PLocation VARCHAR(100) NOT NULL,
    DNo INT NOT NULL,
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT (DNo)
);


CREATE TABLE WORKS_ON (
    SSN VARCHAR(20),
    PNo VARCHAR(20),
    Hours INT NOT NULL,
    PRIMARY KEY (SSN, PNo),
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE (SSN),
    FOREIGN KEY (PNo) REFERENCES PROJECT (PNo)
);



INSERT INTO EMPLOYEE (SSN, Name, Address, Sex, Salary)
VALUES
    ('123-45-6789', 'John Smith', '123 Main Street', 'Male', 60000.00),
    ('234-56-7890', 'Jane Doe', '456 Elm Avenue', 'Female', 55000.00),
    ('345-67-8901', 'Michael Johnson', '789 Oak Road', 'Male', 75000.00),
    ('456-78-9012', 'Emily Brown', '987 Pine Lane', 'Female', 65000.00),
    ('567-89-0123', 'William Davis', '321 Cedar Drive', 'Male', 70000.00);
    
--     Error Code: 1364. Field 'DNo' doesn't have a default value
    
    INSERT INTO DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate)
VALUES
    (1, 'HR', '123-45-6789', '2023-01-01'),
    (2, 'Engineering', '345-67-8901', '2023-01-01'),
    (3, 'Marketing', '567-89-0123', '2023-01-01'),
    (4, "IT", "567-98-789", "2023-03-04");
    
INSERT INTO DLOCATION (DNo, DLoc)
VALUES
    (1, 'New York'),
    (2, 'San Francisco'),
    (3, 'Los Angeles');
INSERT INTO PROJECT (PNo, PName, PLocation, DNo)
VALUES
    ('P001', 'Employee Management System', 'New York', 1),
    ('P002', 'Product Development', 'San Francisco', 2),
    ('P003', 'Marketing Campaign', 'Los Angeles', 3);
INSERT INTO WORKS_ON (SSN, PNo, Hours)
VALUES
    ('123-45-6789', 'P001', 40),
    ('234-56-7890', 'P001', 30),
    ('345-67-8901', 'P002', 45),
    ('456-78-9012', 'P002', 50),
    ('567-89-0123', 'P003', 35);



-- Make a list of all project numbers for projects that involve an employee whose last name is ‘Scott’,
-- either as a worker or as a manager of the department that controls the project.



select project.pno
from project p
join department d on p.dno = d.dno
join employee e on d.mgrssn = e.ssn
where e.lname = "scott"
union
select p.pno
from project p 
join works_on w on p.pno = w.pno
join employee e on w.ssn = e.ssn
where lname = "scott";




-- Show the resulting salaries if every employee working on the ‘IoT’ project is given a10 percent raise.

select fname , lanme, salaries*1.1
from exmployee e, works_on w , project p
where e.ssn = w.ssn and p.pno = w.pno and p.pname = "IOT"


-- Find the sum of the salaries of all employees of the ‘Accounts’
-- department, as well as the maximum salary, the minimum salary, and the average salary in thisdepartment

select sum(salary) , max(salary) , min(salary)
from employee e , department d
where e.dno = d.dno and dname = "accounts";


-- Retrieve the name of each employee who works on all the projects Controlled by department number 5 (use NOT EXISTSoperator).

select e.name 
from employee e
where not exist ( select pno from project p  where p.dno = 5 and not exist (select * from works_on w where w.ssn = e.ss and w.pno = p.pno));

 -- For each department that has more than five employees, retrieve the department number and the number of 
 -- its employees who are making more than Rs. 6,00,000.
 
SELECT D.DNO, COUNT (*) FROM DEPARTMENT D, EMPLOYEE E WHERE D.DNO=E.DNO
AND E.SALARY>600000
AND .DNO IN (SELECT E1.DNO
FROM EMPLOYEE E1 GROUP BY E1.DNO HAVING COUNT (*)>5)
GROUP BY D.DNO;



