-- Books after 1980
SELECT book_id, title, year_published
FROM books
WHERE year_published >= 1980;