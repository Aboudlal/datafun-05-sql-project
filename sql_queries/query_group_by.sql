-- Count of books per author
SELECT a.name AS author_name, COUNT(b.book_id) AS num_books
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id
GROUP BY a.author_id, a.name
ORDER BY num_books DESC;