# API Documentation – Dashboard Insights

This documentation provides a detailed overview of all available **API endpoints** for the Dashboard Insights backend. Each endpoint includes HTTP method, path, query parameters, request details (if any), response structure, and a brief description of its functionality.

---

## Base URL

http://:8000/api/v1/insight

---

## Endpoints

### 1. Get Dashboard Summary

- **Method:** GET  
- **Endpoint:** `/dashboard-summary`  
- **Description:** Fetches a summary of the dashboard with advanced metrics.  
- **Query Parameters:** None  
- **Response Example:**

```json
{
  "total_authors": 120,
  "total_posts": 450,
  "total_engagements": 10234,
  "average_engagement_per_post": 22.74
}
```


⸻

### 2. Get Advanced Insights
- **Method:** GET
- **Endpoint:** `/advanced-insights`
- **Description:** Retrieves advanced insights including surprise patterns with recommendations.
- **Query Parameters:** None
- **Response Example:**

```json
[
  {
    "insight_type": "content_success",
    "title": "High engagement post",
    "description": "This post received unexpectedly high engagement",
    "metric": 95.5,
    "trend": "increasing",
    "impact": "high",
    "recommendation": "Optimize content tagging strategy and media inclusion"
  }
]
```


⸻

### 3. Get Engagement Heatmap
- **Method:** GET
- **Endpoint:** `/engagement-heatmap`
- **Description**: Returns heatmap data showing engagement intensity across days and hours.
- **Query Parameters:**
	* period (string, optional, default: last_year) Time period to analyze. Options: last_7_days, last_30_days, last_3_months, last_year.
- **Response Example:**

```json
{
  "9": {
    "1": {
      "engagement_count": 50,
      "intensity": 0.75,
      "types": {
        "views": 30,
        "likes": 10,
        "comments": 5,
        "shares": 5
      }
    }
  }
}
```


⸻

### 4. Get Content Performance
- **Method:** GET
- **Endpoint:** `/content-performance`
- **Description:** Returns content performance metrics.
- **Query Parameters:**
    - min_content_length (integer, optional, default: 500) – Filter for minimum content length.
- **Response Example:**

```json
[
  {
    "post_id": 101,
    "title": "Sample Post",
    "author": "Author Name",
    "views": 1200,
    "likes": 300,
    "comments": 45,
    "shares": 12
  }
]
```

⸻

### 5. Get Top Engagements
- **Method:** GET
- **Endpoint:** `/top-engagements`
- **Description:** Returns top authors or categories by engagement.
- **Query Parameters:**
    - period (string, optional, default: last_year)
	- limit (integer, optional, default: 10) – Maximum number of results to return.
- **Response Example:**

```json
[
  {
    "author_id": 12,
    "name": "Author Name",
    "total_engagements": 1500
  }
]
```

⸻

### 6. Get Engagement Trend
- **Method:** GET
- **Endpoint:** `/engagement-trend`
- **Description:** Returns engagement trend over time for a specific author, post, or category.
- **Query Parameters:**
	- entity_type (string, required) – "author", "category", or "post"
	- author_name (string, optional)
	- post_title (string, optional)
	- category_name (string, optional)
	- days (integer, optional, default: 365)
- **Response Example:**

```json
[
  {
    "engagement_date": "2025-09-20T00:00:00Z",
    "total_engagements": 45
  }
]
```

⸻

### 7. Get Authors
- **Method:** GET
- **Endpoint:** `/authors`
- **Description:** Lists all authors.
- **Response Example:**

```json
[
  {"author_id": 1, "name": "Author One"},
  {"author_id": 2, "name": "Author Two"}
]
```

⸻

### 8. Get Posts
- **Method:** GET
- **Endpoint:** `/posts`
- **Description:** Lists all posts.
- **Response Example:**

```json
[
  {"post_id": 101, "title": "First Post"},
  {"post_id": 102, "title": "Second Post"}
]
```

⸻

### 9. Get Categories
- **Method:** GET
- **Endpoint:** `/categories`
- **Description:** Returns all distinct post categories.
- **Response Example:**

```json
["Technology", "Health", "Education"]
```

⸻

### 10. Get Opportunity Areas
- **Method:** GET
- **Endpoint:** `/opportunity-areas`
- **Description:** Returns high-volume, low-engagement areas to optimize.
- **Query Parameters:**
	- min_posts (integer, optional, default: 2) – Minimum posts required to be considered.
- **Response Example:**

```json
[
  {"category": "Technology", "post_count": 5, "engagement_score": 12.3}
]
```

⸻

### 11. Get Advanced Patterns
- **Method:** GET
- **Endpoint:** `/advanced-patterns`
- **Description:** Returns advanced behavioral and content patterns.
- **Response Example:**

```json
{
  "user_behavior": {
    "avg_diversity_score": 0.5,
    "high_diversity_users": 10,
    "total_analyzed_users": 100
  },
  "content_optimization": {
    "best_media_type": "video",
    "promotion_effectiveness": 0.8,
    "optimal_tag_count": 5
  }
}
```

⸻

### 12. Get Current User
- **Method:** GET
- **Endpoint:** `/user`
- **Description:** Returns current user info
- **Response Example:**

```json
{"email": "a", "username": "admin"}
```

⸻

### 13. Scatter Performance
- **Method:** GET
- **Endpoint:** `/scatter-performance`
- **Description:** Returns scatter plot data of post count vs engagements per post.
- **Query Parameters:**
	- period (string, optional, default: last_year)
	- entity_type (string, optional, default: "author") – Group by author or category
- **Response Example:**

```json
[
  {
    "entity_type": "author",
    "entity_id": "1",
    "entity_name": "Author One",
    "post_count": 10,
    "engagements_per_post": 15.3
  }
]
```

⸻

### 14. Engagement Trend Author Category
- **Method:** GET
- **Endpoint:** `/engagement-trend-author-category`
- **Description:** Engagement trends grouped by author and category over a period.
- **Query Parameters:**
	- days (integer, optional, default: 365)
- **Response Example:**

```json
[
  {
    "engagement_date": "2025-09-20T00:00:00Z",
    "author": "Author One",
    "category": "Technology",
    "total_engagements": 20
  }
]
```

⸻

### 15. Download Data
- **Method:** GET
- **Endpoint:** `/download-data`
- **Description:** Downloads all relevant tables in CSV and Excel formats inside a ZIP file.
- **Response:** File stream (ZIP)
	- Filename: data.zip

⸻

### 16. Download Report
- **Method:** GET
- **Endpoint:** `/download-report`
- **Description:** Downloads a PowerPoint report stored in the project /reports folder.
- **Response:** File stream (PPTX)
	- Filename: report.pptx

⸻

### Notes
- All endpoints use FastAPI and asyncpg connection pooling.
- Response structures are based on actual database queries.
- CSV/Excel downloads are generated dynamically in memory.
- download-report endpoint works in Docker-safe paths and streams the file with correct content headers.
