create database bookshop;
use bookshop;

create table author( author_id int Primary key, name varchar(60), address varchar (60));

create table publisher(publisher_id int Primary key, name varchar(40), city varchar (20));

create table book(book_id int Primary key , title varchar(30), yearofpublication int , author_id int , publisher_id int,
Foreign key (author_id) References author(author_id) , Foreign key (publisher_id) References publisher(publisher_id));

create table order_( order_id int Primary key, quantity int , cost int , dateoforder int, book_id int , Foreign key(book_id) References book(book_id));

INSERT INTO author (author_id, name, address)
VALUES
  (1, 'John Doe', 'New York'),
  (2, 'Jane Smith', 'London'),
  (3, 'Michael Lee', 'Sydney');
  
select * from author;

INSERT INTO publisher (publisher_id, name, city)
VALUES
  (1, 'ABC Publications', 'New York'),
  (2, 'XYZ Books', 'London'),
  (3, 'Bookish Publishers', 'Sydney');
  
select * from publisher;
  
INSERT INTO book (book_id, title, yearofpublication, author_id, publisher_id)
VALUES
  (1, 'Book1', 2010, 1, 1),
  (2, 'Book2', 2011, 2, 2),
  (3, 'Book3', 2011, 3, 3),
  (4, 'Book4', 2012, 1, 1),
  (5, 'Book5', 2012, 3, 2);
  
select * from book;
  
INSERT INTO order_ VALUES
  (101,'2', '1000','20230720', 1),
  (102,'1', '2000', '20230721', 2);
  
select * from order_;



-- c.Find the author who has published highest number of books

SELECT author_id, name
FROM author
WHERE author_id = (
  SELECT author_id
  FROM book
  GROUP BY author_id
  ORDER BY COUNT(book_id) DESC
  LIMIT 1
);
  
--   List the books published by specific publisher during the year 2011.
  
  select title , yearofpublication 
  from book 
  where publisher_id = (select publisher_id from publisher where name = "specific name" and yearofpublication = 2011);


-- Write before insertion trigger to book to check year of publication should allow current year only.

Create trigger year_pub
before insert of 
date on book
new.date!="01012022"

year_pub ("year should be current year")

