-- Inner join authors + books
SELECT b.book_id, b.title, b.year_published, a.name AS author_name, a.country
FROM books b
INNER JOIN authors a ON b.author_id = a.author_id
ORDER BY year_published DESC;