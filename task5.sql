Database changed
mysql> select * from library;
+--------+--------------------------+-----------------+---------------+------+--------+
| BookID | Title                    | Author          | Genre         | Year | Copies |
+--------+--------------------------+-----------------+---------------+------+--------+
|      1 | The Alchemist            | Paulo Coelho    | Fiction       | 1988 |      5 |
|      2 | To Kill a Mockingbird    | Harper Lee      | Classic       | 1960 |      3 |
|      3 | The Theory of Everything | Stephen Hawking | Science       | 2002 |      4 |
|      4 | Wings of Fire            | Naveen          | Autobiography | 1999 |      2 |
|      5 | The Hobbit               | J.R.R. Tolkien  | Fantasy       | 1937 |      6 |
+--------+--------------------------+-----------------+---------------+------+--------+
5 rows in set (0.00 sec)

mysql> CREATE TABLE Borrowers (
    ->     BorrowID INT PRIMARY KEY,
    ->     BookID INT,
    ->     BorrowerName VARCHAR(100),
    ->     BorrowDate DATE,
    ->     FOREIGN KEY (BookID) REFERENCES library(BookID)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> INSERT INTO Borrowers VALUES (1, 1, 'Amit', '2025-06-10');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Borrowers VALUES (2, 3, 'Priya', '2025-06-12');
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO Borrowers VALUES (3, 5, 'Ravi', '2025-06-15');
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO Borrowers VALUES (4, 6, 'Sneha', '2025-06-16'); -- Invalid BookID (not in library)
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`library`.`borrowers`, CONSTRAINT `borrowers_ibfk_1` FOREIGN KEY (`BookID`) REFERENCES `library` (`BookID`))
mysql> setect * from library;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'setect * from library' at line 1
mysql> select * from library;
+--------+--------------------------+-----------------+---------------+------+--------+
| BookID | Title                    | Author          | Genre         | Year | Copies |
+--------+--------------------------+-----------------+---------------+------+--------+
|      1 | The Alchemist            | Paulo Coelho    | Fiction       | 1988 |      5 |
|      2 | To Kill a Mockingbird    | Harper Lee      | Classic       | 1960 |      3 |
|      3 | The Theory of Everything | Stephen Hawking | Science       | 2002 |      4 |
|      4 | Wings of Fire            | Naveen          | Autobiography | 1999 |      2 |
|      5 | The Hobbit               | J.R.R. Tolkien  | Fantasy       | 1937 |      6 |
+--------+--------------------------+-----------------+---------------+------+--------+


mysql> SELECT l.Title, b.BorrowerName, b.BorrowDate
    -> FROM library l
    -> INNER JOIN Borrowers b ON l.BookID = b.BookID;
+--------------------------+--------------+------------+
| Title                    | BorrowerName | BorrowDate |
+--------------------------+--------------+------------+
| The Alchemist            | Amit         | 2025-06-10 |
| The Theory of Everything | Priya        | 2025-06-12 |
| The Hobbit               | Ravi         | 2025-06-15 |
+--------------------------+--------------+------------+
3 rows in set (0.00 sec)

mysql> SELECT l.Title, b.BorrowerName, b.BorrowDate
    -> FROM library l
    -> LEFT JOIN Borrowers b ON l.BookID = b.BookID;
+--------------------------+--------------+------------+
| Title                    | BorrowerName | BorrowDate |
+--------------------------+--------------+------------+
| The Alchemist            | Amit         | 2025-06-10 |
| To Kill a Mockingbird    | NULL         | NULL       |
| The Theory of Everything | Priya        | 2025-06-12 |
| Wings of Fire            | NULL         | NULL       |
| The Hobbit               | Ravi         | 2025-06-15 |
+--------------------------+--------------+------------+
5 rows in set (0.00 sec)

mysql> SELECT l.Title, b.BorrowerName, b.BorrowDate
    -> FROM library l
    -> RIGHT JOIN Borrowers b ON l.BookID = b.BookID;
+--------------------------+--------------+------------+
| Title                    | BorrowerName | BorrowDate |
+--------------------------+--------------+------------+
| The Alchemist            | Amit         | 2025-06-10 |
| The Theory of Everything | Priya        | 2025-06-12 |
| The Hobbit               | Ravi         | 2025-06-15 |
+--------------------------+--------------+------------+
3 rows in set (0.00 sec)

mysql> SELECT l.Title, b.BorrowerName, b.BorrowDate
    -> FROM library l
    -> LEFT JOIN Borrowers b ON l.BookID = b.BookID
    ->
    -> UNION
    ->
    -> SELECT l.Title, b.BorrowerName, b.BorrowDate
    -> FROM library l
    -> RIGHT JOIN Borrowers b ON l.BookID = b.BookID;
+--------------------------+--------------+------------+
| Title                    | BorrowerName | BorrowDate |
+--------------------------+--------------+------------+
| The Alchemist            | Amit         | 2025-06-10 |
| To Kill a Mockingbird    | NULL         | NULL       |
| The Theory of Everything | Priya        | 2025-06-12 |
| Wings of Fire            | NULL         | NULL       |
| The Hobbit               | Ravi         | 2025-06-15 |
+--------------------------+--------------+------------+
5 rows in set (0.01 sec)


mysql> select * from Borrower;
ERROR 1146 (42S02): Table 'library.borrower' doesn't exist
mysql> select * from borrower;
ERROR 1146 (42S02): Table 'library.borrower' doesn't exist
mysql> SELECT * FROM Borrowers;
+----------+--------+--------------+------------+
| BorrowID | BookID | BorrowerName | BorrowDate |
+----------+--------+--------------+------------+
|        1 |      1 | Amit         | 2025-06-10 |
|        2 |      3 | Priya        | 2025-06-12 |
|        3 |      5 | Ravi         | 2025-06-15 |
+----------+--------+--------------+------------+