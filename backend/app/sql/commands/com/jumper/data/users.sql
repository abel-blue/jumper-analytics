-- Table: records.users
CREATE TABLE IF NOT EXISTS records.users (
    user_id SERIAL PRIMARY KEY,
    signup_date DATE,
    country VARCHAR(50),
    user_segment VARCHAR(50)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_users_country ON records.users(country);
CREATE INDEX IF NOT EXISTS idx_users_signup_date ON records.users(signup_date);
CREATE INDEX IF NOT EXISTS idx_users_segment ON records.users(user_segment);