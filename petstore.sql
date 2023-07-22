create database petstore;
use petstore;

create table petstore(
store_id int primary key, 
store_name varchar(40),
address varchar(50),
phone_no int );

create table owner(owner_id int primary key , name varchar(30) , address varchar(30));

create table dog (
dog_id int primary key, owner_id int , name varchar(40), dateofpurchase date, gender char(1), foreign key(owner_id) references owner(owner_id));

create table purchase (purchase_id int primary key , dog_id int , store_id int , foreign key(dog_id) references dog(dog_id) , foreign key(store_id)
references petstore(store_id));

drop table urchase;

insert into petstore values( 1, "happy paws" , "bengaluru" , 12345), (2, 'Paws & Tails', ' Townsville', '5555678'),
    (3, 'Pet Paradise',  'Villagetown', '5559876'),
    (4, 'Furry Friends', ' Petborough', '5552222'),
    (5, 'Tail Waggers', ' Dogsville', '5554444');


insert into owner VALUES
    (1,'John Smith', '123 Oak Street, Cityville'),
    (2, 'abhiman', '456 Maple Avenue, Townsville'),
    (3,  'Michael Johnson', '789 Elm Road, Villagetown'),
    (4,  'Emily Brown', '555 Pine Drive, Dogsville'),
    (5, 'William Davis', '999 Cedar Lane, Petborough');
    
    
insert into  dog 
VALUES
    (1, 1, 'Buddy', '2023-01-15', 'M'),
    (2, 1, 'Molly', '2023-03-05', 'F'),
    (3, 2, 'Max', '2023-02-10', 'M'),
    (4, 3, 'Lucy', '2023-04-20', 'F'),
    (5, 4, 'Rocky', '2023-05-01', 'M');
    
    INSERT INTO purchase 
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5);
    
    
    -- c)List all pets owned by a person ‘Abhiman’.
    
    select name , dog_id 
    from dog 
    where dog.owner_id = (select owner_id from owner where name = "abhiman");
    
    
    -- List all persons who are not owned a single pet
select owner.name, owner.owner_id
from owner 
where owner.owner_id not in (select distinct owner_id from dog);

-- Write a trigger to check the constraint that the person can buy maximum three pet dogs

create trigger maxdogs
after 
insert 
on dog
for each row 
begin 
	declare owner_dog_count int ;
    set owner_dog_count = (
    select count(*)
    from dog where owner_id = new.owner_id);
    if owner_dog_count >= 3 then 
		signal sqlstate "45000"
			set message= "max 3 dogs"
    end if
end 


