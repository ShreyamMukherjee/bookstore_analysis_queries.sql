-- Create Database
CREATE DATABASE IF NOT EXISTS OnlineBookstore;
-- Switch to the database
USE OnlineBookstore;
-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT );
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2)
);
SELECT *FROM Books;
SELECT *FROM Customers;
SELECT *FROM Orders;
-- Import Data into Books Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Books.csv'
INTO TABLE Books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Book_ID, Title, Author, Genre, Published_Year, Price, Stock);
-- Import Data into Customers Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Customer_ID, Name, Email, Phone, City, Country);
DESCRIBE Orders;
SHOW COLUMNS FROM Orders;
-- Import Data into Orders Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Order_ID, Customer_ID, Book_ID,@Order_Date, Quantity, Total_Amount)
SET Order_Date = STR_TO_DATE(@Order_Date,'%d-%m-%Y');
-- retrieve all the books from fiction genre
SELECT *FROM Books
WHERE GENRE='FICTION';
-- FIND THE BOOKS PUBLISHED AFTER 1950
SELECT *FROM BOOKS
WHERE Published_Year>1950;
-- List of all customers from Canada
SELECT *FROM CUSTOMERS
WHERE country='Canada';
SELECT DISTINCT Country
FROM Customers;
TRUNCATE TABLE Customers;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- show order placed in november 2023
SELECT *FROM ORDERS
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
-- retrieve the total stock of books available
SELECT SUM(stock) AS TOTAL_STOCK
FROM BOOKS;
-- find the details of the most expensive book
SELECT *FROM BOOKS ORDER BY PRICE DESC LIMIT 1;
-- show all customers who ordered more than one qunatity of books
SELECT *FROM ORDERS
WHERE QUANTITY>1;
-- retrieve all the orders where the total amount exceeds $20
SELECT *FROM ORDERS
WHERE TOTAL_AMOUNT>20;
-- LIST ALL THE GENRES AVAILABLE IN THE BOOKS TABLE
SELECT DISTINCT GENRE FROM BOOKS;
-- find the book with lowest stock
SELECT *FROM BOOKS ORDER BY STOCK LIMIT 1;
-- calculate total revenue generated from all orders
SELECT SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE
FROM ORDERS;
-- ADVANCE QUESTIONS
-- RETRIEVE THE TOTAL NUMBER OF BOOKS SOLD IN EACH GENRE
SELECT *FROM ORDERS;
SELECT b.Genre,SUM(o.Quantity) AS TOTAL_BOOKS_SOLD
FROM ORDERS o
JOIN BOOKS b
on o.BOOK_ID=b.BOOK_ID
GROUP BY b.Genre ORDER BY TOTAL_BOOKS_SOLD;
-- find the avg price of books in the fantasy genre
SELECT ROUND(AVG(PRICE),2) AS AVERAGE_PRICE
FROM BOOKS
WHERE GENRE='FANTASY';
-- list of customers who have placed atleast 2 orders
SELECT c.Name,COUNT(o.ORDER_ID) AS ORDER_COUNT
FROM ORDERS o
JOIN CUSTOMERS c
on o.CUSTOMER_ID=c.CUSTOMER_ID
GROUP BY c.Name
HAVING COUNT(ORDER_ID)>2;
-- Find the most frequently ordered books
SELECT b.Title,COUNT(o.ORDER_ID) AS ORDER_FREQUENCY
FROM ORDERS o
JOIN BOOKS b
on o.BOOK_ID=b.BOOK_ID
GROUP BY b.Title ORDER BY COUNT(o.ORDER_ID) DESC;
-- top 3 most expensive books of fantasy genre
SELECT TITLE,PRICE,GENRE
FROM BOOKS
WHERE GENRE='FANTASY'
ORDER BY PRICE DESC limit 3;
-- retrieve the total quantity of books sold by each author
SELECT b.AUTHOR,SUM(o.QUANTITY) AS TOTAL_BOOKS_SOLD
FROM ORDERS o
JOIN BOOKS b
ON o.BOOK_ID=b.BOOK_ID
GROUP BY b.AUTHOR
ORDER BY SUM(o.QUANTITY) DESC;
-- list the cities where customers who spent over $30 are located
SELECT DISTINCT c.CITY
FROM ORDERS o
JOIN CUSTOMERS c
ON o.CUSTOMER_ID=c.CUSTOMER_ID
WHERE TOTAL_AMOUNT>30;
-- find the customer who spent most on orders
SELECT c.NAME,SUM(o.TOTAL_AMOUNT) AS TOTAL_MONEY_SPENT
FROM ORDERS o
JOIN CUSTOMERS c
ON o.CUSTOMER_ID=c.CUSTOMER_ID
GROUP BY c.NAME
ORDER BY SUM(o.TOTAL_AMOUNT) DESC LIMIT 1;
-- Calculate the stock remaining after fulfulling all orders;
SELECT b.BOOK_ID,b.TITLE,b.STOCK,COALESCE(SUM(o.quantity),0) AS ORDER_QUANTITY,b.STOCK - COALESCE(SUM(o.quantity),0) AS REMAINING_QUANTITY
FROM BOOKS b
LEFT JOIN ORDERS o
ON b.BOOK_ID=o.BOOK_ID
GROUP BY b.BOOK_ID ORDER BY b.BOOK_ID;

