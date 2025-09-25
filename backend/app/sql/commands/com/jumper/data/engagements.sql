-- Table: records.engagements
CREATE TABLE IF NOT EXISTS records.engagements (
    engagement_id SERIAL PRIMARY KEY,
    post_id INT NOT NULL REFERENCES records.posts(post_id),
    type VARCHAR(20) CHECK (type IN ('view','like','comment','share')),
    user_id INT,
    engaged_timestamp TIMESTAMP NOT NULL
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_engagements_post_id ON records.engagements(post_id);
CREATE INDEX IF NOT EXISTS idx_engagements_type ON records.engagements(type);
CREATE INDEX IF NOT EXISTS idx_engagements_timestamp ON records.engagements(engaged_timestamp);
CREATE INDEX IF NOT EXISTS idx_engagements_user_id ON records.engagements(user_id);