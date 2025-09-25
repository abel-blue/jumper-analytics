-- SQL script to create the auth_users table in PostgreSQL

CREATE TABLE IF NOT EXISTS auth.auth_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(255),
    security_question VARCHAR(255),
    security_answer VARCHAR(255)
);