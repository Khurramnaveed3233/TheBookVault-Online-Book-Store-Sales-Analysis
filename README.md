# TheBookVault-Online-Book-Store-Sales-Analysis

The project aims to analyze book inventory by understanding the availability and demand for different genres and specific books. It also seeks to gain customer insights by identifying purchasing trends, customer locations, and frequent buyers.

Additionally, tracking sales performance is a key objective, including revenue, best-selling books, and total sales figures. Operational efficiency is evaluated by assessing stock levels and recommending restocking strategies. The analysis further delves into market trends by identifying customer preferences through an examination of genres, authors, and pricing trends. Ultimately, the project provides stakeholders with actionable recommendations based on data-driven insights to optimize business decisions and enhance overall performance.

# Solution Of Business Questions Using SQL Server  :
  
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

 # Key Insights Extracted

 
  - Genre Popularity: Fiction emerges as the most popular genre, indicating a strong reader preference and potential for targeted promotions.

  - Sales Trends: A significant portion of book sales comprises publications released after 1950, reflecting a market inclination towards modern literature.**
  
  - Customer Demographics: A considerable customer base exists in Canada, presenting an opportunity for region-specific marketing strategies.**

  - Seasonal Demand: A spike in orders during November 2023 suggests a seasonal sales pattern, useful for future sales forecasting and stock planning.**

  - Stock and Pricing Insights: The most expensive book and the lowest stock items highlight the importance of dynamic pricing and inventory management.**

  - Bulk and High-Value Purchases: A notable number of customers place bulk orders and make purchases exceeding $20, emphasizing the potential for loyalty programs and premium 
    offerings.**

  - Repeat Customers and Engagement: Customers who have placed multiple orders indicate a loyal customer base, which can be leveraged through engagement initiatives.**

  - Author and Book Performance: Certain books and authors significantly outperform others, providing valuable data for procurement and marketing decisions.**

  - Revenue and Profitability: The total revenue generated gives a clear picture of the bookstore’s financial health, aiding in strategic decision-making.**

  - Stock Management Post-Sales: Understanding stock levels after fulfilling orders helps in forecasting demand and improving supply chain efficiency.**


