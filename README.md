# TheBookVault-Online-Book-Store-Sales-Analysis

The project aims to analyze book inventory by understanding the availability and demand for different genres and specific books. It also seeks to gain customer insights by identifying purchasing trends, customer locations, and frequent buyers.

Additionally, tracking sales performance is a key objective, including revenue, best-selling books, and total sales figures. Operational efficiency is evaluated by assessing stock levels and recommending restocking strategies. The analysis further delves into market trends by identifying customer preferences through an examination of genres, authors, and pricing trends. Ultimately, the project provides stakeholders with actionable recommendations based on data-driven insights to optimize business decisions and enhance overall performance.

# Business Questions are below :
  
Basic Queries
 1) Retrieve all books in the "Fiction" genre
 2) Find books published after the year 1950
 3) List all customers from the Canada
 4) Show orders placed in November 2023
 5) Retrieve the total stock of books available
 6) Find the details of the most expensive book
 7) Show all customers who ordered more than 1 quantity of a book
 8) Retrieve all orders where the total amount exceeds $20
 9) List all genres available in the Books table
 10) Find the book with the lowest stock
 11) Calculate the total revenue generated from all order
     
Advance Queries
 1) Retrieve the total number of books sold for each genre
 2) Find the average price of books in the "Fantasy" genre
 3) List customers who have placed at least 2 orders
 4) Find the most frequently ordered book
 5) Show the top 3 most expensive books of 'Fantasy' Genre 
 6) Retrieve the total quantity of books sold by each author
 7) List the cities where customers who spent over $30 are located
 8) Find the customer who spent the most on orders
 9) Calculate the stock remaining after fulfilling all order



Retrieve all books in the "Fiction" genre:**

       SELECT * FROM Books WHERE Genre='Fiction';
   
Find books published after the year 1950:**

      SELECT * FROM Books WHERE Published_year>1950;

List all customers from the Canada:** 

      SELECT * FROM Customers WHERE country='Canada';

Show orders placed in November 2023:**

       SELECT *FROM Orders 
       WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

Retrieve the total stock of books available whose genre is Biography.**

       SELECT SUM(stock) AS Total_Stock From Books
       where Genre = 'Biography'

Find the details of the most expensive book:**

       SELECT top 1 *  FROM Books ORDER BY Price DESC 

Show top 5  customer name and price  who ordered more than 1 quantity of a book:**

      SELECT top 5  Name as Customer_Name, quantity as Ordered_Quantity 
      From Customers c 
      Join Orders o on c.Customer_ID = o.Customer_ID
      WHERE quantity>1;

Retrieve all orders where the total amount exceeds $150:**

      SELECT Order_ID , concat(round(Total_Amount,0), ' $') as Total_Amount
      FROM Orders 
      WHERE total_amount>150;

List all genres available along with their authors in the Books table:

     SELECT DISTINCT genre , Author 
     FROM Books;

Find the book with the lowest stock:

    SELECT TOP 1 * FROM Books 
    ORDER BY stock ASC 

Calculate the total revenue generated from all orders:

    SELECT ROUND(SUM(total_amount),2) As Revenue 
    FROM Orders;

-- Advance Questions : 

Retrieve the total number of books sold for each genre:

    SELECT * FROM ORDERS;

    SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
    FROM Orders o
    JOIN Books b ON o.book_id = b.book_id
    GROUP BY b.Genre;

Find the average price of books in the "Fantasy" genre:

    SELECT AVG(price) AS Average_Price
    FROM Books
    WHERE Genre = 'Fantasy';

List customers who have placed at least 2 orders:

    SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
    FROM orders o
    JOIN customers c ON o.customer_id=c.customer_id
    GROUP BY o.customer_id, c.name
    HAVING COUNT(Order_id) >=2;

Find the most frequently ordered book:

    SELECT TOP 1 o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
    FROM orders o
    JOIN books b ON o.book_id=b.book_id
    GROUP BY o.book_id, b.title
    ORDER BY ORDER_COUNT DESC ;

Show the top 3 most expensive books of 'Fantasy' Genre :

    SELECT TOP 3 * 
    FROM books
    WHERE genre ='Fantasy'
    ORDER BY price DESC ;

Retrieve the total quantity of books sold by each author:

    SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
    FROM orders o
    JOIN books b ON o.book_id=b.book_id
    GROUP BY b.Author;

List the cities where the top 5 customers who spent over $300 are located:

    SELECT top 5  C.CITY , ROUND(O.TOTAL_AMOUNT,0) AS Total_Amount
    FROM Customers C 
    JOIN Orders O ON C.Customer_ID = O.Customer_ID
    WHERE O.Total_Amount > 300
    Order by Total_Amount desc 

Find the customer who spent the most on orders:

    SELECT top 1 o.Order_ID, c.name as Customer_Name , SUM(o.total_amount) AS Total_Spent
    FROM orders o
    JOIN customers c ON o.customer_id=c.customer_id
    GROUP BY o.Order_ID, c.name
    ORDER BY Total_spent Desc ;

Calculate the stock remaining after fulfilling all orders:

    SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
    FROM books b
    LEFT JOIN orders o ON b.book_id=o.book_id
    GROUP BY b.book_id , b.title, b.stock
    ORDER BY b.book_id;
   
