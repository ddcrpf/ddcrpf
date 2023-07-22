create database bank;
use bank;


create table bank(bank_id int primary key , bank_name varchar(40), city varchar(40));


create table branch(branch_id int Primary Key , bank_id int, branch_name varchar(40), city varchar(40), Foreign key(bank_id) References bank(bank_id) );

create table customer (
customer_id int Primary key,
name varchar(100),
street varchar(30), city varchar(30), state varchar(30));

create table account(
account_no int Primary Key, customer_id INT, type varchar(20) , balance int, FOREIGN KEY (customer_id) REFERENCES customer (customer_id));




INSERT INTO bank (bank_id, bank_name, city)
VALUES
  (1, 'Bank of Example', 'New York'),
  (2, 'Example Bank', 'San Francisco'),
  (3, 'First Bank', 'Chicago'),
  (4, 'City Bank', 'Los Angeles'),
  (5, 'ABC Bank', 'Houston');
  
INSERT INTO branch (branch_id, bank_id, branch_name, city)
VALUES
  (1, 1, 'Main Branch', 'New York City'),
  (2, 1, 'Downtown Branch', 'New York City'),
  (3, 2, 'Financial District Branch', 'San Francisco'),
  (4, 2, 'Westside Branch', 'San Francisco'),
  (5, 3, 'Central Branch', 'Chicago');


INSERT INTO customer (customer_id, name, city, state)
VALUES
  (1, 'John Doe', 'New York City', 'NY'),
  (2, 'Jane Smith','San Francisco', 'CA'),
  (3, 'Michael Lee',  'Los Angeles', 'CA'),
  (4, 'Emily Johnson', 'Chicago', 'IL'),
  (5, 'David Brown',  'Houston', 'TX');


INSERT INTO account (account_no, customer_id, type, balance)
VALUES
  (1001, 1, 'Savings', 15000),
  (1002, 2, 'Checking', 8000),
  (1003, 3, 'Savings', 9500),
  (1004, 1, 'Checking', 12000),
  (1005, 2, 'Savings', 7000);

insert into account values( 1006, 1, "joint" , 3000), ( 1007, 1, "joint" , 23000),( 1008, 1, "joint" , 8000);
select * from account;












-- Add 5% interest to the customer who have less than 10000 balances and 6% interest to remaining customers.
SET SQL_SAFE_UPDATES = 0;

update account 
set balance = case 
	when balance <10000 then balance * 1.05
    else balance * 1.06
end;

SET SQL_SAFE_UPDATES = 1;

-- List joint accounts involving more than three customers

select account_no, count(*)
from account 
where type = "joint" 
group by account_no
having count(*) > 3;


-- Write a procedure to find the customer who has highest number of accounts,
-- the customer who has lowest balance, the customer who involved in most of joint accounts.

CREATE PROCEDURE FindCustomerDetails()
BEGIN
  -- Customer with the highest number of accounts
  SELECT customer_id, name
  FROM customer
  WHERE customer_id = (
    SELECT customer_id
    FROM Customer_Account
    GROUP BY customer_id
    ORDER BY COUNT(account_number) DESC
    LIMIT 1
  );
  
  
  
  select customer_id
  from account where 

  -- Customer with the lowest balance
  SELECT customer_id, name
  FROM Customer
  WHERE customer_id = (
    SELECT customer_id
    FROM Account
    ORDER BY balance ASC
    LIMIT 1
  );

  -- Customer involved in the most joint accounts
  SELECT ca.customer_id, c.name, COUNT(ca.account_number) AS num_joint_accounts
  FROM Customer_Account ca
  JOIN Customer c ON ca.customer_id = c.customer_id
  GROUP BY ca.customer_id, c.name
  ORDER BY num_joint_accounts DESC
  LIMIT 1;
END;


