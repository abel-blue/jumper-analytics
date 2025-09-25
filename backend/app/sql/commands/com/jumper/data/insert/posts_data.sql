-- Insert posts data with more variety for better insights
INSERT INTO records.posts (post_id, author_id, category, publish_timestamp, title, content_length, has_media) VALUES
(101, 1, 'Tech', '2025-08-01 10:15:00', 'Deep Dive into SQL Optimization', 1200, true),
(102, 2, 'Lifestyle', '2025-08-02 17:30:00', '5 Morning Routines for Productivity', 800, false),
(103, 3, 'Tech', '2025-08-03 08:45:00', 'Why We Love PostgreSQL', 950, true),
(104, 1, 'Tech', '2025-08-04 14:20:00', 'Advanced React Patterns', 1500, true),
(105, 4, 'Health', '2025-08-05 09:30:00', 'Nutrition Tips for Developers', 1100, false),
(106, 2, 'Lifestyle', '2025-08-06 16:45:00', 'Work-Life Balance in Tech', 900, true),
(107, 5, 'Lifestyle', '2025-08-07 11:15:00', 'Remote Work Best Practices', 850, false),
(108, 3, 'Tech', '2025-08-08 13:00:00', 'Database Indexing Strategies', 1300, true);

-- Reset sequence
SELECT setval('records.posts_post_id_seq', (SELECT MAX(post_id) FROM records.posts));