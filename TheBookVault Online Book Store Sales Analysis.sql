use TheBookVault

CREATE TABLE Books (
    Book_ID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing primary key
    Title NVARCHAR(100),                   -- NVARCHAR for Unicode support
    Author NVARCHAR(100),
    Genre NVARCHAR(50),
    Published_Year INT,
    Price DECIMAL(10, 2),                  -- DECIMAL is preferred for currency
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID int identity  PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID int identity PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:

SELECT * 
FROM Books 
WHERE Genre='Fiction';

-- 2) Find books published after the year 1950:

SELECT * 
FROM Books 
WHERE Published_year>1950; 

-- 3) List all customers from the Canada: 

SELECT * FROM Customers 
WHERE country='Canada';

-- 4) Show orders placed in November 2023:

SELECT * 
FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available whose genre is Biography .

SELECT SUM(stock) AS Total_Stock
From Books
where Genre = 'Biography'

-- 6) Find the details of the most expensive book:

SELECT top 1 * 
FROM Books 
ORDER BY Price DESC 

-- 7) Show top 5  customer name and price  who ordered more than 1 quantity of a book:

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT top 5  Name as Customer_Name , quantity as Ordered_Quantity 
From Customers c 
Join Orders o on c.Customer_ID = o.Customer_ID
WHERE quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $150:

SELECT Order_ID , concat(round(Total_Amount,0), ' $') as Total_Amount
FROM Orders 
WHERE total_amount>150;

-- 9) List all genres available along with their authors in the Books table:

SELECT DISTINCT genre , Author 
FROM Books;

-- 10) Find the book with the lowest stock:

SELECT TOP 1 * FROM Books 
ORDER BY stock ASC 

-- 11) Calculate the total revenue generated from all orders:

SELECT ROUND(SUM(total_amount),2) As Revenue 
FROM Orders;

-- Advance Questions : 

-- 12) Retrieve the total number of books sold for each genre:

SELECT * FROM ORDERS;

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- 13) Find the average price of books in the "Fantasy" genre:

SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 14) List customers who have placed at least 2 orders:

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

-- 15) Find the most frequently ordered book:


SELECT TOP 1 o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC ;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT TOP 3 * 
FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC ;

-- 17) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- 18) List the cities where top 5 customers who spent over $300 are located:

SELECT top 5  C.CITY , ROUND(O.TOTAL_AMOUNT,0) AS Total_Amount
FROM Customers C 
JOIN Orders O ON C.Customer_ID = O.Customer_ID
WHERE O.Total_Amount > 300
order by Total_Amount desc 

-- 19) Find the customer who spent the most on orders:

SELECT top 1 o.Order_ID, c.name as Customer_Name , SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.Order_ID, c.name
ORDER BY Total_spent Desc ;

-- 20) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
   	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity

FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id , b.title, b.stock
ORDER BY b.book_id;















