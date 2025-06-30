Here's a clean, structured `README.md` file that documents your entire database setup and SQL JOIN operations based on your MySQL session:

---

````markdown
# 📚 Library and Borrowers SQL Project

This project demonstrates the use of **SQL JOINs** (INNER, LEFT, RIGHT, FULL) with a simple library database. Two related tables are created: `library` (books) and `Borrowers` (people who borrow books). This setup is tested in **MySQL**.

---

## 📂 Tables

### 1. `library`

Stores details of books in the library.

| Column   | Type          | Description         |
|----------|---------------|---------------------|
| BookID   | INT (PK)      | Unique ID of book   |
| Title    | VARCHAR(100)  | Title of the book   |
| Author   | VARCHAR(100)  | Author name         |
| Genre    | VARCHAR(50)   | Book genre          |
| Year     | INT           | Published year      |
| Copies   | INT           | Available copies    |

**Sample Data**:

```sql
SELECT * FROM library;
````

| BookID | Title                    | Author          | Genre         | Year | Copies |
| ------ | ------------------------ | --------------- | ------------- | ---- | ------ |
| 1      | The Alchemist            | Paulo Coelho    | Fiction       | 1988 | 5      |
| 2      | To Kill a Mockingbird    | Harper Lee      | Classic       | 1960 | 3      |
| 3      | The Theory of Everything | Stephen Hawking | Science       | 2002 | 4      |
| 4      | Wings of Fire            | Naveen          | Autobiography | 1999 | 2      |
| 5      | The Hobbit               | J.R.R. Tolkien  | Fantasy       | 1937 | 6      |

---

### 2. `Borrowers`

Stores records of borrowed books.

| Column       | Type         | Description                |
| ------------ | ------------ | -------------------------- |
| BorrowID     | INT (PK)     | Unique borrow ID           |
| BookID       | INT (FK)     | Refers to `library.BookID` |
| BorrowerName | VARCHAR(100) | Name of the borrower       |
| BorrowDate   | DATE         | Date of borrowing          |

**Sample Data**:

```sql
SELECT * FROM Borrowers;
```

| BorrowID | BookID | BorrowerName | BorrowDate |
| -------- | ------ | ------------ | ---------- |
| 1        | 1      | Amit         | 2025-06-10 |
| 2        | 3      | Priya        | 2025-06-12 |
| 3        | 5      | Ravi         | 2025-06-15 |

> ❌ Sneha's record (BookID 6) was rejected due to foreign key constraint (book doesn't exist in `library`).

---

## 🔗 SQL JOIN Examples

### 🔹 INNER JOIN

Returns only matched rows from both tables.

```sql
SELECT l.Title, b.BorrowerName, b.BorrowDate
FROM library l
INNER JOIN Borrowers b ON l.BookID = b.BookID;
```

**Output:**

| Title                    | BorrowerName | BorrowDate |
| ------------------------ | ------------ | ---------- |
| The Alchemist            | Amit         | 2025-06-10 |
| The Theory of Everything | Priya        | 2025-06-12 |
| The Hobbit               | Ravi         | 2025-06-15 |

---

### 🔹 LEFT JOIN

Returns all books, with borrower data where available.

```sql
SELECT l.Title, b.BorrowerName, b.BorrowDate
FROM library l
LEFT JOIN Borrowers b ON l.BookID = b.BookID;
```

**Output:**

| Title                    | BorrowerName | BorrowDate |
| ------------------------ | ------------ | ---------- |
| The Alchemist            | Amit         | 2025-06-10 |
| To Kill a Mockingbird    | NULL         | NULL       |
| The Theory of Everything | Priya        | 2025-06-12 |
| Wings of Fire            | NULL         | NULL       |
| The Hobbit               | Ravi         | 2025-06-15 |

---

### 🔹 RIGHT JOIN

Returns all borrower records, with book info where available.

```sql
SELECT l.Title, b.BorrowerName, b.BorrowDate
FROM library l
RIGHT JOIN Borrowers b ON l.BookID = b.BookID;
```

**Output:**

| Title                    | BorrowerName | BorrowDate |
| ------------------------ | ------------ | ---------- |
| The Alchemist            | Amit         | 2025-06-10 |
| The Theory of Everything | Priya        | 2025-06-12 |
| The Hobbit               | Ravi         | 2025-06-15 |

---

### 🔹 FULL OUTER JOIN (Simulated using `UNION`)

```sql
SELECT l.Title, b.BorrowerName, b.BorrowDate
FROM library l
LEFT JOIN Borrowers b ON l.BookID = b.BookID

UNION

SELECT l.Title, b.BorrowerName, b.BorrowDate
FROM library l
RIGHT JOIN Borrowers b ON l.BookID = b.BookID;
```

**Output:**

| Title                    | BorrowerName | BorrowDate |
| ------------------------ | ------------ | ---------- |
| The Alchemist            | Amit         | 2025-06-10 |
| To Kill a Mockingbird    | NULL         | NULL       |
| The Theory of Everything | Priya        | 2025-06-12 |
| Wings of Fire            | NULL         | NULL       |
| The Hobbit               | Ravi         | 2025-06-15 |

---

