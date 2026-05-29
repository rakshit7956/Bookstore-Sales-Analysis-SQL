--create table books
create table books(
Book_ID	int,
Title	text,
Author	varchar(50),
Genre	varchar(50),
Published_Year	int,
Price	numeric(10,2),
Stock	int

)

----create table customers
create table customer(
Customer_ID	int,
Name	varchar(200),
Email	text,
Phone	int,
City	text,
Country	text

)

----create table orders
create table orders(

Order_ID	int,
Customer_ID	int,
Book_ID	int,
Order_Date	date,
Quantity	int,
Total_Amount	numeric(10,2)

)


--RETRIVE ALL BOOKS IN 'FICTION' GENRE
SELECT TITLE,AUTHOR,GENRE FROM BOOKS
WHERE GENRE='Fiction'


--FIND ALL BOOKS PUBLISHED AFTER THE YEAR 1950
SELECT BOOK_ID,TITLE,AUTHOR,PUBLISHED_YEAR FROM BOOKS
WHERE PUBLISHED_YEAR>1950


--LIST ALL CUSTOMERS FROM CANADA
SELECT CUSTOMER_ID,NAME, COUNTRY FROM CUSTOMER
WHERE COUNTRY='Canada'

--show orders placed in nov 2023
select order_id , order_date from orders
where order_date between '2023-11-01' and '2023-11-30'

--retrive total stocks of book available
select book_id ,author,stock from books

--find dertails of most expensive book
select book_id,title ,price from books
order by price desc
limit 1


--SHOW ALL CUSTOMERS WHO ORDERED MORE THAN 1 QUANTITY OF BOOK
SELECT * FROM CUSTOMER
SELECT * FROM BOOKS
SELECT * FROM ORDERS

SELECT C.CUSTOMER_ID,C.NAME,
       O.QUANTITY
FROM CUSTOMER C
JOIN ORDERS O
ON C.CUSTOMER_ID=O.CUSTOMER_ID
WHERE QUANTITY >1

--RETRIVE ALL ORDERS WHERE TOTAL AMOUNT EXCEEDS 300

SELECT ORDER_ID , TOTAL_AMOUNT FROM ORDERS
WHERE TOTAL_AMOUNT>300


--FIND THE BOOKS WITH LOWEST STOCK
SELECT BOOK_ID,TITLE,STOCK FROM BOOKS
ORDER BY STOCK ASC
LIMIT 1

--CALCULATE THE TOTAL REVENUE GENERATED FROM ALL ORDERS

SELECT SUM(TOTAL_AMOUNT)AS TOTAL_REVENUE FROM ORDERS

--RETRIVE TOTAL NO OF BOOKS SOLD FOR EACH GENRE
SELECT * FROM BOOKS
SELECT * FROM ORDERS


SELECT B .GENRE,SUM(O.QUANTITY) 
FROM BOOKS B
JOIN ORDERS O
ON B.BOOK_ID = O.BOOK_ID
GROUP BY B.GENRE


--FIND AVERAGE PRICE OF BOOKS IN 'FANTASY' GENRE
select * from books

select genre,avg(price)
from books
group by genre
having genre ='Fantasy'


--LIST CUSTOMERS WHO HAVE PLACED ATLEAST 20 ORDERS
SELECT * FROM CUSTOMER
SELECT * FROM ORDERS

SELECT C.NAME,SUM(O.QUANTITY)
FROM CUSTOMER C
JOIN ORDERS O
ON C.CUSTOMER_ID=O.CUSTOMER_ID
GROUP BY C.NAME
HAVING SUM(O.QUANTITY)>20


--FIND THE MOST FREQUENTLY ORDERED BOOK
SELECT * FROM BOOKS
SELECT * FROM ORDERS


SELECT B.TITLE, SUM(O.QUANTITY)AS TOTAL_ORDERS
FROM ORDERS O
JOIN BOOKS B
ON O.BOOK_ID=B.BOOK_ID
GROUP BY B.TITLE
ORDER BY TOTAL_ORDERS DESC
LIMIT 1

--SHOW THE  TOP 3 MOST EXPENSIVE BOOKS of 'Fantasy' Genre
SELECT  title, GENRE ,PRICE
FROM BOOKS
where genre='Fantasy'
order by price desc
limit 3

--RETRIVE TOTAL QUANTITY OF BOOKS SOLD BY EACH AUTHOR
SELECT * FROM BOOKS
SELECT * FROM ORDERS

SELECT B.author ,sum(O.quantity)
from books b
join orders o
on b.book_id =o.book_id
group by b.author


-- LIST THE CITIES WHERE CUSTOMERS WHO HAVE HAVE SPENT MORE THAN 300 ARE LOCATED

SELECT * FROM CUSTOMER
SELECT * FROM ORDERS


SELECT C.CITY,SUM(O.TOTAL_AMOUNT)
FROM ORDERS O
JOIN CUSTOMER C
ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CITY
HAVING sum(O.TOTAL_AMOUNT) >300


--FIND THE CUSTOMER WHO HAVE SPENT MORE ON ORDERS
SELECT * FROM CUSTOMER
SELECT* FROM ORDERS

SELECT C.NAME ,SUM(O.TOTAL_AMOUNT)as total_spend
FROM ORDERS O
JOIN CUSTOMER C
ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.NAME
order by total_spend desc

--Find all books whose price is greater than the average price of all books.
select * from books

select book_id ,title ,price 
from books
where price> (select avg(price) from books)


--Display customers who have never placed any order.
select * from customer
select * from orders
 

select c.name,o.quantity
from customer c
left join orders o
on c.customer_id=o.customer_id
where quantity is null


--Retrieve customers who placed orders in more than one month.
select * from customer
select * from orders
 

select c.name ,count(distinct o.order_date)
from customer c
join orders o
on c.customer_id=o.customer_id
group by c.name
having count(distinct o.order_date)>1


--Find the total quantity sold for each book.
select * from books
select * from orders

select b.title,sum(o.quantity)as total_sold
from books b
join orders o
on b.book_id=o.book_id
group by  b.title


--Show the top 5 customers who spent the most money.
select * from customer
select * from orders

select c.name,sum(o.total_amount)as total_spent 
from customer c
join orders o
on c.customer_id=o.customer_id
group by c.name
order by total_spent desc
limit 5

-- Find the youngest published book in the database.
select * from books

select * from 
(
select title , published_year,
dense_rank()
over( order by published_year desc)
from books
)
where dense_rank=1






---Retrieve books whose stock is above the average stock.
select * from books

select title ,stock 
from books
where stock > (select avg(stock) from books )


--Find customers whose names start with the letter 'A'.

select * from customer

select name from customer
where name like 'A%'

--Display orders sorted by highest total amount.
select * from ORDERS

SELECT ORDER_ID ,TOTAL_AMOUNT FROM ORDERS
ORDER BY TOTAL_AMOUNT DESC

--Find all books priced between $10 and $20.
SELECT * FROM BOOKS

SELECT TITLE ,PRICE
FROM BOOKS
WHERE PRICE BETWEEN 10 AND 20

--Find authors whose total books sold exceed 10 quantities.
SELECT * FROM BOOKS
SELECT * FROM ORDERS

SELECT B.AUTHOR,SUM(O.QUANTITY)AS TOTAL_BOOKS_SOLD
FROM BOOKS B
JOIN ORDERS O
ON B.BOOK_ID=O.BOOK_ID
GROUP BY AUTHOR
HAVING SUM(O.QUANTITY)>10

--Display genres having average book price greater than 26
SELECT * FROM BOOKS

SELECT GENRE ,AVG(PRICE) AS AVERAGE_PRICE 
FROM BOOKS
GROUP BY GENRE
HAVING AVG(PRICE)>26

--Find customers who spent more than 40 in total.
SELECT * FROM CUSTOMER
SELECT * FROM ORDERS

SELECT C.NAME,SUM(O.TOTAL_AMOUNT)AS TOTAL_SPENT
FROM CUSTOMER C
JOIN ORDERS O
ON C.CUSTOMER_ID=O.CUSTOMER_ID
GROUP BY C.NAME
HAVING SUM(O.TOTAL_AMOUNT)>40


--Find months where total revenue exceeded 80000
SELECT * FROM CUSTOMER
SELECT * FROM BOOKS
SELECT * FROM ORDERS

SELECT extract (month from ORDER_DATE)as month ,sum(TOTAl_amount)as total_revenue 
from orders
group by month
having sum(TOTAl_amount)  >8000

--Show total revenue generated by each genre.
select * from books
select* from orders

select b.genre,sum(o.total_amount)as total_revenue_generated
from books b
join orders o
on b.book_id =o.book_id
group by  b.genre


--Find books ordered by customers from Canada.
select * from customer
select * from books
select * from orders

select c.name,c.country,b.title,b.genre
from books b
join orders o
on o.book_id=b.book_id
join customer c
on o.customer_id =c.customer_id
where country ='Canada'

--Display customer names with the books they purchased.
select * from customer
select * from orders
select * from books


select c.name,b.title
from customer c
join orders o
on o.customer_id=c.customer_id
join books b
on b.book_id=o.book_id

--Display book titles and corresponding order dates.
select * from customer
select * from orders
select * from books

select b.title,o.order_date
from books b
join orders o
on b.book_id=o.book_id

--Retrieve customers who purchased more than 2 different books.
select * from customer
select * from orders
select * from books


select c.name , count(distinct o.quantity)as total_bokks_purchased
from customer c
join orders o
on c.customer_id=o.customer_id
group by c.name
having count(distinct o.quantity)>2

--Display customer names along with the genre of books they purchased.
select * from customer
select * from orders
select * from books

select c.name,b.genre
from customer c
join orders o
on c.customer_id=o.customer_id
join books b
on b.book_id=o.book_id

--Display customer names and order dates for each book purchased.
select * from customer
select * from orders
select * from books

select c.name,b.title,o.order_date
from customer c
join orders o
on c.customer_id=o.customer_id
join books b
on b.book_id=o.book_id
