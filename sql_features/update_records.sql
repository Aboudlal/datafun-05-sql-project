-- Example: fix a title and update a year
UPDATE books
SET title = 'Harry Potter and the Philosopher''s Stone', year_published = 1997
WHERE book_id = 'b8';


UPDATE books
SET title = 'Ce que le jour doit à la nuit',
    year_published = 2008,
    author_id = 'a1'
WHERE book_id = 'b1';

UPDATE authors
SET name = 'Yasmina Khadra',
    country = 'Algeria'
WHERE author_id = 'a1';

