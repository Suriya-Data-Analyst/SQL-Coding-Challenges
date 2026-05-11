-- Creating the Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(50) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    Price DECIMAL(8,2) CHECK (Price > 0)
);

-- Creating the Orders table with a Foreign Key
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    BookID INT,
    OrderDate DATE NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

ALTER TABLE Books
ADD CONSTRAINT Unique_ISBN UNIQUE (ISBN);

INSERT INTO Books (BookID, Title, Author, ISBN, Price) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', '978-0743273565', 15.99),
(2, '1984', 'George Orwell', '978-0451524935', 12.50),
(3, 'The Hobbit', 'J.R.R. Tolkien', '978-0547928227', 22.00),
(4, 'The Alchemist', 'Paulo Coelho', '978-0062315007', 18.25),
(5, 'Atomic Habits', 'James Clear', '978-0735211292', 20.00);

SELECT * FROM Books;

-- Updating the price for "1984"
UPDATE Books
SET Price = 14.99
WHERE BookID = 2;

-- Removes only the order with ID 101
DELETE FROM Orders 
WHERE OrderID = 101;

-- Removes all data from Orders but keeps the columns/structure
TRUNCATE TABLE Orders;