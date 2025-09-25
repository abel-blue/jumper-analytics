-- Table: records.post_metadata
CREATE TABLE IF NOT EXISTS records.post_metadata (
    post_id INT PRIMARY KEY REFERENCES records.posts(post_id),
    tags TEXT[],
    is_promoted BOOLEAN,
    language VARCHAR(10)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_post_metadata_promoted ON records.post_metadata(is_promoted);
CREATE INDEX IF NOT EXISTS idx_post_metadata_language ON records.post_metadata(language);
CREATE INDEX IF NOT EXISTS idx_post_metadata_tags ON records.post_metadata USING GIN (tags);