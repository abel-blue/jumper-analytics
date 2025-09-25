# Records Database Schema Documentation

## Overview
The `records` schema is designed to manage and analyze content publishing, user engagement, and author performance. It supports tracking posts, metadata, user interactions, and advanced insights for content optimization and author growth. The schema includes tables for authors, posts, post metadata, user interactions (engagements), and users. Additionally, it is structured to facilitate performance analysis, engagement trends, and actionable insights.

---

## Schema: `records`

### 1. Table: `authors`

| Column           | Data Type     | Constraints             | Description |
|-----------------|---------------|------------------------|-------------|
| `author_id`      | SERIAL        | PRIMARY KEY            | Unique identifier for each author. |
| `name`           | VARCHAR(100)  | NOT NULL               | Full name of the author. |
| `joined_date`    | DATE          | NOT NULL               | Date the author joined the platform. |
| `author_category`| VARCHAR(50)   |                        | Category/genre of the author (e.g., Tech, Lifestyle, Health). |

**Indexes:**  
- `idx_authors_category` for filtering/search by author category.  
- `idx_authors_joined_date` for queries based on join date.

**Purpose:**  
Stores author information, including category and tenure. Used to analyze author performance, engagement trends, and growth trajectory.

**Sample Data:**

| author_id | name   | joined_date | author_category |
|-----------|--------|-------------|----------------|
| 1         | Alice  | 2020-01-14  | Tech           |
| 2         | Bob    | 2019-06-30  | Lifestyle      |
| 3         | Carlos | 2021-11-05  | Tech           |
| 4         | Diana  | 2022-03-15  | Health         |
| 5         | Ethan  | 2023-01-20  | Lifestyle      |

---

### 2. Table: `posts`

| Column             | Data Type     | Constraints                     | Description |
|-------------------|---------------|--------------------------------|-------------|
| `post_id`          | SERIAL        | PRIMARY KEY                    | Unique identifier for each post. |
| `author_id`        | INT           | NOT NULL, FK → `authors`      | Author who created the post. |
| `category`         | VARCHAR(50)   |                                | Category of the post content. |
| `publish_timestamp`| TIMESTAMP     | NOT NULL                       | Date and time the post was published. |
| `title`            | VARCHAR(255)  |                                | Title of the post. |
| `content_length`   | INT           |                                | Number of characters in the post content. |
| `has_media`        | BOOLEAN       |                                | Whether the post contains media (images, video, etc.). |

**Indexes:**  
- `idx_posts_author_id` for author-based queries.  
- `idx_posts_category` for category-based queries.  
- `idx_posts_publish_timestamp` for time-based analytics.  
- `idx_posts_has_media` for filtering media-rich content.

**Purpose:**  
Stores all published posts and their metadata for analyzing engagement, category performance, and media effectiveness.

**Sample Data:**

| post_id | author_id | category | publish_timestamp    | title                        | content_length | has_media |
|---------|-----------|----------|--------------------|-------------------------------|----------------|-----------|
| 101     | 1         | Tech     | 2025-08-01 10:15:00| Deep Dive into SQL Optimization | 1200           | true      |
| 102     | 2         | Lifestyle| 2025-08-02 17:30:00| 5 Morning Routines for Productivity | 800            | false     |
| 103     | 3         | Tech     | 2025-08-03 08:45:00| Why We Love PostgreSQL        | 950            | true      |

---

### 3. Table: `post_metadata`

| Column        | Data Type  | Constraints                     | Description |
|---------------|------------|--------------------------------|-------------|
| `post_id`     | INT        | PRIMARY KEY, FK → `posts`       | Identifier for the post. |
| `tags`        | TEXT[]     |                                | Array of tags associated with the post. |
| `is_promoted` | BOOLEAN    |                                | Whether the post is promoted (ads or sponsored). |
| `language`    | VARCHAR(10)|                                | Language code of the post (e.g., 'en'). |

**Indexes:**  
- `idx_post_metadata_promoted` for filtering promoted content.  
- `idx_post_metadata_language` for language-based filtering.  
- `idx_post_metadata_tags` (GIN index) for tag-based searches.

**Purpose:**  
Captures additional metadata for posts, enabling analytics like tag optimization, promotion effectiveness, and content-language performance.

**Sample Data:**

| post_id | tags                                      | is_promoted | language |
|---------|------------------------------------------|------------|----------|
| 101     | {"SQL","Optimization","Database"}        | false      | en       |
| 102     | {"Wellness","Morning","Productivity"}    | true       | en       |

---

### 4. Table: `users`

| Column         | Data Type    | Constraints | Description |
|----------------|-------------|------------|-------------|
| `user_id`      | SERIAL       | PRIMARY KEY | Unique identifier for each user. |
| `signup_date`  | DATE         |            | Date the user signed up. |
| `country`      | VARCHAR(50)  |            | User's country of residence. |
| `user_segment` | VARCHAR(50)  |            | User type segment (free, trial, subscriber). |

**Indexes:**  
- `idx_users_country` for geo-based analysis.  
- `idx_users_signup_date` for cohort analysis.  
- `idx_users_segment` for segment-based engagement studies.

**Purpose:**  
Stores user information to analyze engagement patterns, segment behavior, and regional trends.

**Sample Data:**

| user_id | signup_date | country | user_segment |
|---------|------------|---------|--------------|
| 501     | 2025-01-10 | US      | free         |
| 502     | 2025-02-12 | UK      | subscriber   |

---

### 5. Table: `engagements`

| Column            | Data Type   | Constraints                     | Description |
|------------------|------------|--------------------------------|-------------|
| `engagement_id`   | SERIAL      | PRIMARY KEY                    | Unique identifier for each engagement. |
| `post_id`         | INT         | NOT NULL, FK → `posts`         | Post being engaged with. |
| `type`            | VARCHAR(20) | CHECK(type IN ('view','like','comment','share')) | Type of engagement. |
| `user_id`         | INT         |                                | User who engaged. |
| `engaged_timestamp`| TIMESTAMP  | NOT NULL                       | Date and time of engagement. |

**Indexes:**  
- `idx_engagements_post_id` for post-based analysis.  
- `idx_engagements_type` for type-based aggregation.  
- `idx_engagements_timestamp` for time-based trends.  
- `idx_engagements_user_id` for user behavior tracking.

**Purpose:**  
Tracks every interaction with posts. Enables analytics such as engagement trends, quality scoring, and weighted engagement metrics.

**Sample Data:**

| engagement_id | post_id | type    | user_id | engaged_timestamp   |
|---------------|---------|---------|---------|-------------------|
| 2001          | 101     | view    | 501     | 2025-08-01 10:16  |
| 2002          | 101     | like    | 502     | 2025-08-01 10:17  |

---

### SQL Schemas & Queries

All SQL schemas, table creation scripts, data inserts, and analytical queries referenced in this documentation can be found in this link:  

[Access SQL Schemas & Queries](../backend/app/sql/commands/com/jumper/data/)

### Data Loading Scripts

To access scripts demonstrating how to load this schema and populate the data, use the following link:  

[Data Loading & Population Scripts](../backend/app/services/auth_service.py)

# Analytical Insights & Derived Metrics

### User Engagement Patterns
- **Diversity score**: Measures user engagement diversity across authors and categories.  
- **Insight**: High-diversity users engage with multiple authors/categories and are more likely to convert to subscribers.

### Content Optimization
- **Metrics**: Average engagement, media type performance, promotion effectiveness, optimal tag count.  
- **Insight**: Media-rich posts with 3–5 tags and promotion tend to generate higher engagement.

### Author Performance & Growth
- **Metrics**: Engagement growth ratio, posting frequency, total engagements, content consistency.  
- **Insight**: Regular posting improves engagement growth; authors with low engagement per post can be targeted for improvement.

### Engagement Trends
- **Time-based analysis**: Best hours/days for engagement, weighted engagement scores.  
- **Content quality metrics**: Quality ratio = (`comments + shares`) / `views`.  
- **Dashboard summary**: Total posts, authors, engagements, top performing authors, best category, and optimal posting times.

### Opportunity Analysis
- **Authors & Categories**: Identify high-volume but low-engagement entities for potential optimization.  
- **Engagement per post**: Highlights gaps where strategic improvements could increase interaction.

---

## Key Relationships

- `authors` → `posts` (1:N)  
- `posts` → `post_metadata` (1:1)  
- `posts` → `engagements` (1:N)  
- `users` → `engagements` (1:N)  

This structure enables comprehensive analysis from the author level down to individual user interactions, supporting personalized recommendations, content optimization, and engagement prediction.

---

## Analytical Insights & Derived Metrics

| Query / CTE Name | Description | Purpose |
|-----------------|------------|--------|
| `user_engagement_patterns` | Aggregates engagement data per user: distinct authors, categories, engagement types, total engagements, and computes a diversity score `(distinct authors * distinct categories / total engagements)`. Filters users with ≥2 engagements. | Identify highly engaged or exploratory users; understand loyalty vs exploration behavior. |
| `content_analysis` | Groups posts by `has_media`, `is_promoted`, and number of tags. Computes total posts, average content length, and average engagements. Derives best media type, promotion effectiveness, and optimal tag count. | Identify content characteristics that maximize engagement. |
| `content_metrics` | Combines posts, metadata, authors, and engagements. Calculates total engagements, engagement rate per 1000 characters, and quality ratio (`comments + shares / views`). Classifies content as high, medium, or low quality. | Evaluate performance and quality of content across categories, media types, and authors. |
| `engagement_stats` / `author_performance` / `time_analysis` / `category_performance` | Computes aggregate metrics: total posts, authors, engagements, average engagement rate. Identifies top author, best posting hour, top category. | Generate a dashboard overview for content, author, and engagement performance. |
| Engagement Heatmap | Aggregates engagements by `hour_of_day` and `day_of_week`, counts unique users, calculates engagement intensity, and breaks down by type (`view`, `like`, `comment`, `share`). | Visualize peak engagement periods to optimize posting and scheduling. |
| Engagement Trends Over Time | Uses `date_series` to generate daily series joined with posts, authors, and engagements. Calculates daily engagement counts per author, category, or post. | Identify trends, spikes, or declines in engagement over time. |
| `author_engagement_stats` / `category_engagement_stats` | Computes posts count, total engagements, engagements per post, and engagements per user. Calculates opportunity score: low engagement relative to posting volume indicates optimization potential. | Highlight authors/categories that are underperforming despite high posting activity. |
| `user_behavior` / `content_success_factors` / `author_growth_trajectory` | Computes user engagement diversity, content success metrics (engagements per tag, time to first engagement, engagement duration), and author growth trajectory (engagement growth ratio, posting consistency). | Detect advanced insights: high-value users, optimal content characteristics, author growth patterns. |
| Top Authors & Categories Weighted Engagement | Assigns weights to engagement types (`view=1`, `like=2`, `comment=3`, `share=5`). Aggregates weighted engagement scores per author/category. Calculates engagement rate per post. | Rank authors and categories by true engagement impact rather than raw counts. |

### SQL Schemas & Analytical Queries

All SQL schemas, table creation scripts, data inserts, and analytical queries referenced in this documentation can be found in this link:  

[Access SQL Schemas & Queries](../backend/app/sql/commands/com/jumper/insight/)

## Notes
- GIN index on `tags` allows efficient multi-tag searches.  
- Weighted engagement scoring favors comments/shares for prioritizing high-impact content.  
- Analytics queries generate insights for dashboards, heatmaps, trends, and surprise patterns.

