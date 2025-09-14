-- =============================
-- DEI Project Analysis Queries
-- Tables: employees, questions, detailed_survey
-- =============================

-- 1️ Preview first few rows of each table
SELECT * FROM employees LIMIT 5;
SELECT * FROM questions LIMIT 5;
SELECT * FROM detailed_survey LIMIT 5;


-- 2️ Summary of employees by division
SELECT division, COUNT(*) AS total_employees
FROM employees
GROUP BY division
ORDER BY total_employees DESC;


-- 3️ Summary of employees by gender
SELECT gender, COUNT(*) AS count_gender
FROM employees
GROUP BY gender;


-- 4️ Summary of employees by LGBTQ status
SELECT LGBTQ, COUNT(*) AS count_LGBTQ
FROM employees
GROUP BY LGBTQ;


-- 5️ Summary of employees by ethnicity
SELECT ethnicity, COUNT(*) AS count_ethnicity
FROM employees
GROUP BY ethnicity
ORDER BY count_ethnicity DESC;


-- 6️ Average total scores per dimension across all employees
SELECT 
    AVG(Diversity_total) AS avg_diversity,
    AVG(Engagement_total) AS avg_engagement,
    AVG(Inclusion_total) AS avg_inclusion
FROM detailed_survey;


-- 7️ Sentiment distribution per dimension
SELECT Diversity_sentiment, COUNT(*) AS count_diversity
FROM detailed_survey
GROUP BY Diversity_sentiment;

SELECT Engagement_sentiment, COUNT(*) AS count_engagement
FROM detailed_survey
GROUP BY Engagement_sentiment;

SELECT Inclusion_sentiment, COUNT(*) AS count_inclusion
FROM detailed_survey
GROUP BY Inclusion_sentiment;


-- 8️ Average dimension scores per division
SELECT e.division,
       AVG(d.Diversity_total) AS avg_diversity,
       AVG(d.Engagement_total) AS avg_engagement,
       AVG(d.Inclusion_total) AS avg_inclusion
FROM employees e
JOIN detailed_survey d ON e.employee_id = d.employee_id
GROUP BY e.division
ORDER BY e.division;


-- 9️ Top 5 employees with highest Diversity score
SELECT e.name, e.surname, d.Diversity_total
FROM employees e
JOIN detailed_survey d ON e.employee_id = d.employee_id
ORDER BY d.Diversity_total DESC
LIMIT 5;


-- 10 Top 5 employees with lowest Engagement score
SELECT e.name, e.surname, d.Engagement_total
FROM employees e
JOIN detailed_survey d ON e.employee_id = d.employee_id
ORDER BY d.Engagement_total ASC
LIMIT 5;


-- 11️ Question-level averages for Diversity
SELECT 
    AVG(Aug_D_Q1) AS avg_D_Q1,
    AVG(Aug_D_Q2) AS avg_D_Q2,
    AVG(Aug_D_Q3) AS avg_D_Q3,
    AVG(Aug_D_Q4) AS avg_D_Q4,
    AVG(Aug_D_Q5) AS avg_D_Q5
FROM detailed_survey;


-- 12️ Question-level averages for Engagement
SELECT 
    AVG(Aug_E_Q1) AS avg_E_Q1,
    AVG(Aug_E_Q2) AS avg_E_Q2,
    AVG(Aug_E_Q3) AS avg_E_Q3,
    AVG(Aug_E_Q4) AS avg_E_Q4,
    AVG(Aug_E_Q5) AS avg_E_Q5
FROM detailed_survey;


-- 13️ Question-level averages for Inclusion
SELECT 
    AVG(Aug_I_Q1) AS avg_I_Q1,
    AVG(Aug_I_Q2) AS avg_I_Q2,
    AVG(Aug_I_Q3) AS avg_I_Q3,
    AVG(Aug_I_Q4) AS avg_I_Q4,
    AVG(Aug_I_Q5) AS avg_I_Q5
FROM detailed_survey;


-- 14️ Intersectional insight example: Female employees by ethnicity
SELECT e.ethnicity, COUNT(*) AS count_female, AVG(d.Diversity_total) AS avg_diversity
FROM employees e
JOIN detailed_survey d ON e.employee_id = d.employee_id
WHERE e.gender='Female'
GROUP BY e.ethnicity
ORDER BY avg_diversity DESC;


-- 15️ Intersectional insight: LGBTQ employees by division
SELECT e.division, COUNT(*) AS count_LGBTQ, AVG(d.Inclusion_total) AS avg_inclusion
FROM employees e
JOIN detailed_survey d ON e.employee_id = d.employee_id
WHERE e.LGBTQ='Yes'
GROUP BY e.division
ORDER BY avg_inclusion DESC;


-- 16️ Employees with negative sentiment in any dimension
SELECT e.name, e.surname
FROM employees e
JOIN detailed_survey d ON e.employee_id = d.employee_id
WHERE d.Diversity_sentiment='Negative'
   OR d.Engagement_sentiment='Negative'
   OR d.Inclusion_sentiment='Negative';


-- 17️ Employees scoring below a threshold (example: total < 0 in any dimension)
SELECT e.name, e.surname, d.Diversity_total, d.Engagement_total, d.Inclusion_total
FROM employees e
JOIN detailed_survey d ON e.employee_id = d.employee_id
WHERE Diversity_total < 0 OR Engagement_total < 0 OR Inclusion_total < 0;


-- 18️ Distribution of Diversity scores
-- Diversity sub-aspects with avg score and range classification
WITH question_scores AS (
    SELECT 'Workforce Diversity' AS aspect, Aug_D_Q1 AS score FROM detailed_survey
    UNION ALL
    SELECT 'Workforce Diversity', Aug_D_Q2 FROM detailed_survey
    UNION ALL
    SELECT 'Promotion Inclusion', Aug_D_Q3 FROM detailed_survey
    UNION ALL
    SELECT 'Policies & Culture', Aug_D_Q4 FROM detailed_survey
    UNION ALL
    SELECT 'Policies & Culture', Aug_D_Q5 FROM detailed_survey
)
SELECT
    aspect,
    ROUND(AVG(score), 2) AS avg_score,
    CASE
        WHEN AVG(score) <= -1 THEN 'Very Low'
        WHEN AVG(score) BETWEEN 0 AND 1 THEN 'Low'
        WHEN AVG(score) BETWEEN 1.1 AND 3 THEN 'High'
        ELSE 'Very High'
    END AS diversity_range,
    COUNT(*) AS count_employees_in_range
FROM question_scores
GROUP BY aspect
ORDER BY aspect;


-- Inclusion
WITH question_scores AS (
    SELECT 'Inclusion' AS dimension, 'Belonging' AS aspect, Aug_I_Q1 AS score FROM detailed_survey
    UNION ALL
    SELECT 'Inclusion', 'Belonging', Aug_I_Q2 FROM detailed_survey
    UNION ALL
    SELECT 'Inclusion', 'Fairness', Aug_I_Q3 FROM detailed_survey
    UNION ALL
    SELECT 'Inclusion', 'Fairness', Aug_I_Q4 FROM detailed_survey
    UNION ALL
    SELECT 'Inclusion', 'Fairness', Aug_I_Q5 FROM detailed_survey
)
SELECT
    aspect,
    ROUND(AVG(score), 2) AS avg_score,
    CASE
        WHEN AVG(score) <= -1 THEN 'Very Low'
        WHEN AVG(score) BETWEEN 0 AND 1 THEN 'Low'
        WHEN AVG(score) BETWEEN 1.1 AND 3 THEN 'High'
        ELSE 'Very High'
    END AS range,
    COUNT(*) AS count_employees_in_range
FROM question_scores
GROUP BY aspect
ORDER BY aspect;


--Engagement
WITH question_scores AS (
    SELECT 'Engagement' AS dimension, 'Employee Commitment' AS aspect, Aug_E_Q1 AS score FROM detailed_survey
    UNION ALL
    SELECT 'Engagement', 'Employee Commitment', Aug_E_Q2 FROM detailed_survey
    UNION ALL
    SELECT 'Engagement', 'Workplace Motivation', Aug_E_Q3 FROM detailed_survey
    UNION ALL
    SELECT 'Engagement', 'Workplace Motivation', Aug_E_Q4 FROM detailed_survey
    UNION ALL
    SELECT 'Engagement', 'Workplace Motivation', Aug_E_Q5 FROM detailed_survey
)
SELECT
    aspect,
    ROUND(AVG(score), 2) AS avg_score,
    CASE
        WHEN AVG(score) <= -1 THEN 'Very Low'
        WHEN AVG(score) BETWEEN 0 AND 1 THEN 'Low'
        WHEN AVG(score) BETWEEN 1.1 AND 3 THEN 'High'
        ELSE 'Very High'
    END AS range,
    COUNT(*) AS count_employees_in_range
FROM question_scores
GROUP BY aspect
ORDER BY aspect;


-- 19️ Top 5 lowest scoring Diversity questions (question-level insight)
SELECT 'Aug_D_Q1' AS question, AVG(Aug_D_Q1) AS avg_score FROM detailed_survey
UNION ALL
SELECT 'Aug_D_Q2', AVG(Aug_D_Q2) FROM detailed_survey
UNION ALL
SELECT 'Aug_D_Q3', AVG(Aug_D_Q3) FROM detailed_survey
UNION ALL
SELECT 'Aug_D_Q4', AVG(Aug_D_Q4) FROM detailed_survey
UNION ALL
SELECT 'Aug_D_Q5', AVG(Aug_D_Q5) FROM detailed_survey
ORDER BY avg_score ASC
LIMIT 5;


-- 20️ Intersectional insight: Female + LGBTQ employees by division
SELECT e.division, COUNT(*) AS count_female_LGBTQ, AVG(d.Engagement_total) AS avg_engagement
FROM employees e
JOIN detailed_survey d ON e.employee_id = d.employee_id
WHERE e.gender='Female' AND e.LGBTQ='Yes'
GROUP BY e.division
ORDER BY avg_engagement DESC;
