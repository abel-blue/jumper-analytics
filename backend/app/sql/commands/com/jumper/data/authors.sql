-- Table: records.authors
CREATE TABLE IF NOT EXISTS records.authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    joined_date DATE NOT NULL,
    author_category VARCHAR(50)
);

-- Index for better query performance
CREATE INDEX IF NOT EXISTS idx_authors_category ON records.authors(author_category);
CREATE INDEX IF NOT EXISTS idx_authors_joined_date ON records.authors(joined_date);
