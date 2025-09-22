-- Insert at least 10 authors and 10+ books
INSERT INTO authors (author_id, name, country) VALUES
('a1', 'Toni Morrison', 'USA'),
('a2', 'Haruki Murakami', 'Japan'),
('a3', 'Chimamanda Ngozi Adichie', 'Nigeria'),
('a4', 'Gabriel García Márquez', 'Colombia'),
('a5', 'Margaret Atwood', 'Canada'),
('a6', 'George Orwell', 'UK'),
('a7', 'J.K. Rowling', 'UK'),
('a8', 'Isabel Allende', 'Chile'),
('a9', 'Albert Camus', 'France'),
('a10','Franz Kafka', 'Czech Republic');


INSERT INTO books (book_id, title, year_published, author_id) VALUES
('b1', 'Beloved', 1987, 'a1'),
('b2', 'Kafka on the Shore', 2002, 'a2'),
('b3', 'Half of a Yellow Sun', 2006, 'a3'),
('b4', 'One Hundred Years of Solitude', 1967, 'a4'),
('b5', 'The Handmaid''s Tale', 1985, 'a5'),
('b6', '1984', 1949, 'a6'),
('b7', 'Animal Farm', 1945, 'a6'),
('b8', 'Harry Potter and the Sorcerer''s Stone', 1997, 'a7'),
('b9', 'The House of the Spirits', 1982, 'a8'),
('b10','The Stranger', 1942, 'a9'),
('b11','The Trial', 1925, 'a10');