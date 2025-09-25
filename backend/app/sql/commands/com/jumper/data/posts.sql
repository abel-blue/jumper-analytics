-- Table: records.posts
CREATE TABLE IF NOT EXISTS records.posts (
    post_id SERIAL PRIMARY KEY,
    author_id INT NOT NULL REFERENCES records.authors(author_id),
    category VARCHAR(50),
    publish_timestamp TIMESTAMP NOT NULL,
    title VARCHAR(255),
    content_length INT,
    has_media BOOLEAN
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_posts_author_id ON records.posts(author_id);
CREATE INDEX IF NOT EXISTS idx_posts_category ON records.posts(category);
CREATE INDEX IF NOT EXISTS idx_posts_publish_timestamp ON records.posts(publish_timestamp);
CREATE INDEX IF NOT EXISTS idx_posts_has_media ON records.posts(has_media);