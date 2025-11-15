select * from authors;
select * from books;
select * from loans;
select * from member_profiles;
select * from members;
select * from books;

--(1) List all authors’ name, country, and birth_year.
select * from authors;

select name, country,birth_year
from authors;

--(2) Show all books with title, genre, and published_year ordered newest→oldest.
select * from books;

SELECT title, genre, published_year
FROM books
ORDER BY published_year desc;

-- (3) Find books published between 2015 and 2020 (inclusive).
select * from books;

SELECT title, genre, published_year
FROM books
WHERE published_year BETWEEN 2015 AND 2020;

-- (4) Get distinct genre values from books.
select * from books;

SELECT DISTINCT(genre) from books;

-- (5) Show members who joined in 2025.
select * from members;

SELECT 
	first_name, last_name, join_date
FROM members
WHERE 
	join_date >= '2025-01-01';

-- (6) Find authors from India or USA, ordered by name.
SELECT * FROM authors;

SELECT 
	author_id, name, country
FROM authors
WHERE country = 'India' OR country = 'USA'
ORDER BY name;

-- (7) Return book copies that are marked as 'In Stock'.
SELECT * FROM book_copies;

SELECT 
	copy_id, location, status
FROM book_copies
WHERE status = 'In Stock';

-- (8) List members member_id, first_name,last_name where joining date greater than equal to 2021.
SELECT * FROM members;

SELECT 
	member_id, first_name,last_name
FROM members
WHERE join_date >='2021-01-01';

-- (9) Count how many authors are from each country.
SELECT * FROM authors;

SELECT country ,count(*) as num_of_authors
from authors
GROUP BY country;

-- (10) Show the 5 most recently published books.
SELECT * FROM books;

SELECT title, genre, published_year
FROM books
ORDER BY published_year DESC
limit 5;

-- (11) List each book with its author’s name and country.
SELECT * FROM books;
SELECT * FROM authors;

SELECT 
	b.title as book_title, 
	a.name as author_name, 
	a.country as author_country
FROM 
	books as b
JOIN 
authors as a ON b.author_id = a.author_id;

-- (12) Show all copies with the corresponding book title and genre.
SELECT * FROM books;
SELECT * FROM book_copies;

SELECT
	bcop.copy_id,
	bcop.book_id,
	b.title as all_copies, 
	b.genre as books_genre
FROM book_copies as bcop
LEFT JOIN books as b
ON bcop.book_id = b.book_id;

-- (13) List loans with member full name, book title, loan_date, due_date.
SELECT * FROM members;
SELECT * FROM loans;
SELECT * FROM books;
SELECT * FROM book_copies;

SELECT 
	CONCAT(m.first_name, ' ',m.last_name) as member_name,
	b.title as book_title,
	l.loan_date,
	l.due_date
FROM loans as l
JOIN 
	members as m ON l.member_id = m.member_id
JOIN 
	book_copies as bcop ON l.copy_id = bcop.copy_id
JOIN books as b ON bcop.book_id = b.book_id
ORDER BY l.loan_date DESC;

-- (14) Books with their author names
SELECT * FROM books ;
SELECT * FROM authors;

SELECT b.book_id, b.title, a.name AS author, b.genre, b.published_year
FROM books b
JOIN authors a ON a.author_id = b.author_id
ORDER BY b.book_id;

-- (15) Books published after 2015
SELECT * FROM books;

SELECT book_id, title, published_year FROM books
WHERE published_year > 2015
ORDER BY published_year DESC;

-- (16) Book count per author
SELECT * FROM authors;
SELECT * FROM books;

SELECT a.author_id, a.name, COUNT(b.book_id) AS book_count
FROM authors a
LEFT JOIN books b ON b.author_id = a.author_id
GROUP BY a.author_id, a.name
ORDER BY book_count DESC, a.name;

-- (17) Authors with no books
SELECT * FROM authors;
SELECT * FROM books;

SELECT a.author_id, a.name
FROM authors a
LEFT JOIN books b ON b.author_id = a.author_id
WHERE b.book_id IS NULL
ORDER BY a.name;

-- (18) Authors from India who wrote Fantasy
SELECT * FROM authors;
SELECT * FROM books;

SELECT DISTINCT a.author_id, a.name
FROM authors a
JOIN books b ON b.author_id = a.author_id
WHERE a.country = 'India' AND b.genre = 'Fantasy'
ORDER BY a.name;

-- (19) Min/Max publication year per genre
SELECT * FROM books;

SELECT genre, MIN(published_year) AS oldest, MAX(published_year) AS newest
FROM books
GROUP BY genre
ORDER BY genre;

-- (20) Distinct genres
SELECT * FROM books;

SELECT DISTINCT genre FROM books 
WHERE genre IS NOT NULL 
ORDER BY genre;

-- (21) Copies with book title & location
SELECT * FROM books;
SELECT * FROM book_copies;


SELECT c.copy_id, b.title, c.location, c.status
FROM book_copies c
JOIN books b ON b.book_id = c.book_id
ORDER BY c.copy_id;

-- (22) In stock copies only
SELECT * FROM book_copies;

SELECT copy_id, book_id, location FROM book_copies
WHERE status = 'In Stock'
ORDER BY copy_id;

-- (23) Copies per book
SELECT * FROM books;
SELECT * FROM book_copies;

SELECT b.book_id, b.title, COUNT(c.copy_id) AS copies
FROM books b
LEFT JOIN book_copies c ON c.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY copies DESC, b.title;

-- (24) Copies per location
SELECT * FROM book_copies;

SELECT location, COUNT(*) AS copies
FROM book_copies
GROUP BY location
ORDER BY copies DESC, location;

-- (25) Copies located in 'Warehouse 1'
SELECT * FROM book_copies;

SELECT copy_id, book_id, status FROM book_copies
WHERE location = 'Warehouse 1'                                                                                      
ORDER BY copy_id;

-- (26) Out of Stock copies
SELECT * FROM book_copies;

SELECT copy_id, book_id, location FROM book_copies
WHERE status = 'Out of Stock'
ORDER BY copy_id;

-- (27) In Stock vs Discontinued counts
SELECT * FROM book_copies;

SELECT status, COUNT(*) AS total
FROM book_copies
WHERE status IN ('In Stock','Discontinued')
GROUP BY status
ORDER BY status;

-- (28) Copies with copy_number > 1
SELECT * FROM book_copies;

SELECT copy_id, book_id, copy_number FROM book_copies
WHERE copy_number > 1
ORDER BY book_id, copy_number;

-- (29) Members with profile info
SELECT * FROM members;
SELECT * FROM member_profiles;

SELECT m.member_id,
       CONCAT(m.first_name,' ',m.last_name) AS member_name,
       p.phone, p.address, p.dob
FROM members m
LEFT JOIN member_profiles p ON p.member_id = m.member_id
ORDER BY m.member_id;

-- (30) Members joined after 2023-12-31
SELECT * FROM members;

SELECT member_id, first_name, last_name, join_date
FROM members
WHERE join_date > DATE '2023-12-31'
ORDER BY join_date DESC;

-- (31) Members without a profile
SELECT * FROM members;
SELECT* FROM member_profiles

SELECT m.member_id, m.first_name, m.last_name
FROM members m
LEFT JOIN member_profiles p ON p.member_id = m.member_id
WHERE p.member_id IS NULL
ORDER BY m.member_id;


-- (32) Members born before 2000
SELECT * FROM members;
SELECT* FROM member_profiles;

SELECT m.member_id, CONCAT(m.first_name,' ',m.last_name) AS member_name, p.dob
FROM members m
JOIN member_profiles p ON p.member_id = m.member_id
WHERE p.dob < DATE '2000-01-01'
ORDER BY p.dob;

-- (33) Members with Indian phone codes (+91)
SELECT * FROM members;
SELECT * FROM member_profiles;

SELECT m.member_id, CONCAT(m.first_name,' ',m.last_name) AS member_name, p.phone
FROM members m
JOIN member_profiles p ON p.member_id = m.member_id
WHERE p.phone LIKE '+91%'
ORDER BY m.member_id;

-- (34) Members joined in the last 30 days
SELECT * FROM members;

SELECT member_id, first_name, last_name, join_date
FROM members
WHERE join_date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY join_date DESC;

-- (35) Alphabetical member list
SELECT * FROM members;

SELECT member_id, first_name, last_name FROM members
ORDER BY last_name, first_name;

-- (36) Member loan counts
SELECT * FROM members;
SELECT * FROM member_profiles;

SELECT m.member_id, CONCAT(m.first_name,' ',m.last_name) AS member_name,
       COUNT(l.loan_id) AS loans
FROM members m
LEFT JOIN loans l ON l.member_id = m.member_id
GROUP BY m.member_id, member_name
ORDER BY loans DESC, member_name;

-- (37) Loans with member name and book title
SELECT * FROM loans;
SELECT * FROM members;
SELECT * FROM book_copies;
SELECT * FROM books;

SELECT l.loan_id,
       CONCAT(m.first_name,' ',m.last_name) AS member_name,
       b.title,
       l.loan_date, l.due_date
FROM loans l
JOIN members m     ON m.member_id = l.member_id
JOIN book_copies c ON c.copy_id = l.copy_id
JOIN books b       ON b.book_id = c.book_id
ORDER BY l.loan_date DESC, l.loan_id;

-- (38) Loans in October (any year)
SELECT * FROM loans;

SELECT loan_id, member_id, copy_id, loan_date
FROM loans
WHERE EXTRACT(MONTH FROM loan_date) = 10
ORDER BY loan_date DESC;

-- (39) Loans for a specific member (e.g., 201)
SELECT * FROM loans;

SELECT loan_id, copy_id, loan_date, due_date
FROM loans
WHERE member_id = 201
ORDER BY loan_date DESC;

-- (40) Currently active loans
SELECT * FROM loans;

SELECT loan_id, member_id, copy_id, loan_date, due_date
FROM loans
WHERE loan_date <= CURRENT_DATE
  AND due_date  >= CURRENT_DATE
ORDER BY due_date;

-- (41) Loan count per member (names included)
SELECT * FROM loans;
SELECT * FROM members;

SELECT CONCAT(m.first_name,' ',m.last_name) AS member_name,
       COUNT(l.loan_id) AS loan_count
FROM members m
LEFT JOIN loans l ON l.member_id = m.member_id
GROUP BY member_name
ORDER BY loan_count DESC, member_name;

-- (42) Most-borrowed books (top 5)
SELECT * FROM loans;
SELECT * FROM members;
SELECT * FROM books;

SELECT b.title, COUNT(l.loan_id) AS loans
FROM loans l
JOIN book_copies c ON c.copy_id = l.copy_id
JOIN books b       ON b.book_id = c.book_id
GROUP BY b.title
ORDER BY loans DESC, b.title
LIMIT 5;

-- (43) Loans with copy status and location
SELECT * FROM loans;
SELECT * FROM members;
SELECT * FROM books;

SELECT l.loan_id, b.title, c.status, c.location, l.loan_date, l.due_date
FROM loans l
JOIN book_copies c ON c.copy_id = l.copy_id
JOIN books b       ON b.book_id = c.book_id
ORDER BY l.loan_id;

-- (44) Last loan date per member (approx: show max at end by ordering)
SELECT * FROM loans;
SELECT * FROM members;

SELECT m.member_id, CONCAT(m.first_name,' ',m.last_name) AS member_name,
       l.loan_date
FROM members m
JOIN loans l ON l.member_id = m.member_id
ORDER BY m.member_id, l.loan_date DESC;

-- (45) Borrow count per copy
SELECT * FROM loans;

SELECT l.copy_id, COUNT(*) AS times_borrowed
FROM loans l
GROUP BY l.copy_id
ORDER BY times_borrowed DESC, l.copy_id;

-- (46) Books borrowed by members (full list with author country)

SELECT b.title, a.name AS author, a.country,
       CONCAT(m.first_name,' ',m.last_name) AS member_name
FROM loans l
JOIN book_copies c ON c.copy_id = l.copy_id
JOIN books b       ON b.book_id = c.book_id
JOIN authors a     ON a.author_id = b.author_id
JOIN members m     ON m.member_id = l.member_id
ORDER BY b.title, member_name;

-- (47) Members who borrowed at least 2 books by the same author (list pairs)
SELECT * FROM loans;
SELECT * FROM book_copies;
SELECT * FROM books;
SELECT * FROM authors;
SELECT * FROM members;

SELECT CONCAT(m.first_name,' ',m.last_name) AS member_name,
       a.name AS author, COUNT(*) AS loans_by_author
FROM loans l
JOIN book_copies c ON c.copy_id = l.copy_id
JOIN books b       ON b.book_id = c.book_id
JOIN authors a     ON a.author_id = b.author_id
JOIN members m     ON m.member_id = l.member_id
GROUP BY member_name, a.name
HAVING COUNT(*) >= 2
ORDER BY loans_by_author DESC, member_name, a.name;

-- (48) Authors whose books were never borrowed
SELECT * FROM loans;
SELECT * FROM book_copies;
SELECT * FROM books;
SELECT * FROM authors;

SELECT a.author_id, a.name
FROM authors a
LEFT JOIN books b       ON b.author_id = a.author_id
LEFT JOIN book_copies c ON c.book_id   = b.book_id
LEFT JOIN loans l       ON l.copy_id   = c.copy_id
GROUP BY a.author_id, a.name
HAVING COUNT(l.loan_id) = 0
ORDER BY a.name;

-- (49) Top 5 members by overdue loan count
SELECT * FROM loans;
SELECT * FROM members;

SELECT CONCAT(m.first_name,' ',m.last_name) AS member_name,
       COUNT(l.loan_id) AS overdue_loans
FROM members m
JOIN loans l ON l.member_id = m.member_id
WHERE l.due_date < CURRENT_DATE
GROUP BY member_name
ORDER BY overdue_loans DESC, member_name
LIMIT 5;

-- (50) Total loans per genre

SELECT b.genre, COUNT(l.loan_id) AS total_loans
FROM loans l
JOIN book_copies c ON c.copy_id = l.copy_id
JOIN books b       ON b.book_id = c.book_id
GROUP BY b.genre
ORDER BY total_loans DESC, b.genre;
