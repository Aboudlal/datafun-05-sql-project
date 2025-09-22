-- sql_create/01_drop_tables.sql
PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

PRAGMA foreign_keys = ON;
