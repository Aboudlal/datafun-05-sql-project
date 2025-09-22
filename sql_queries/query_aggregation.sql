-- Aggregations across books
SELECT
COUNT(*) AS total_books,
MIN(year_published) AS earliest_year,
MAX(year_published) AS latest_year,
AVG(year_published) AS avg_year
FROM books;