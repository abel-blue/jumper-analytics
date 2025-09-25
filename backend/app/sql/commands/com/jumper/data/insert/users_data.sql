-- Insert users data
INSERT INTO records.users (user_id, signup_date, country, user_segment) VALUES
(501, '2025-01-10', 'US', 'free'),
(502, '2025-02-12', 'UK', 'subscriber'),
(503, '2024-12-05', 'US', 'trial'),
(504, '2025-03-20', 'CA', 'subscriber'),
(505, '2025-04-15', 'AU', 'free'),
(506, '2025-05-10', 'UK', 'subscriber'),
(507, '2025-06-25', 'US', 'trial'),
(508, '2025-07-30', 'DE', 'free');

-- Reset sequence
SELECT setval('records.users_user_id_seq', (SELECT MAX(user_id) FROM records.users));