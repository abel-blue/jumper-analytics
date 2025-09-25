-- Insert authors data
INSERT INTO records.authors (author_id, name, joined_date, author_category) VALUES
(1, 'Alice', '2020-01-14', 'Tech'),
(2, 'Bob', '2019-06-30', 'Lifestyle'),
(3, 'Carlos', '2021-11-05', 'Tech'),
(4, 'Diana', '2022-03-15', 'Health'),
(5, 'Ethan', '2023-01-20', 'Lifestyle');

-- Reset sequence to avoid conflicts
SELECT setval('records.authors_author_id_seq', (SELECT MAX(author_id) FROM records.authors));