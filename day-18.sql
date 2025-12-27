-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

SELECT
  subject,
  MIN(score) FILTER (WHERE row_num_asc = 1)  AS first_score,
  MIN(score) FILTER (WHERE row_num_desc = 1) AS last_score
FROM (
  SELECT
    subject,
    score,
    ROW_NUMBER() OVER (PARTITION BY subject ORDER BY quiz_date)
      AS row_num_asc,
    ROW_NUMBER() OVER (PARTITION BY subject ORDER BY quiz_date DESC)
      AS row_num_desc
  FROM daily_quiz_scores
) table_t
GROUP BY subject;
