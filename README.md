# Workplace DEI Analysis

## Overview

This project performs a comprehensive Diversity, Equity, and Inclusion (DEI) analysis of workplace survey data. The goal is to understand employee experiences across **Diversity**, **Engagement**, and **Inclusion** dimensions in the workplace.

The analysis includes:
- Cleaning and preprocessing employee and survey data using **Python**.
- Creating structured tables for SQL analysis.
- Writing SQL queries to explore employee demographics, survey responses, and sentiment scores.

---

## What is DEI and its Relation to ESG

**Diversity, Equity, and Inclusion (DEI)** refers to organizational efforts and policies that promote representation, fairness, and belonging for all employees, regardless of their backgrounds or identities. DEI initiatives ensure that workplaces are inclusive, equitable, and reflect a diverse workforce.

**DEI and ESG: The Social Pillar**

ESG stands for **Environmental, Social, and Governance**—a framework used to evaluate an organization’s sustainability and ethical impact. DEI is a core component of the **Social** pillar in ESG. The Social pillar encompasses a company’s relationships with its employees, customers, suppliers, and communities. DEI initiatives directly contribute to this pillar by:

- Fostering fair and equitable treatment of employees.
- Promoting diverse representation across the organization.
- Improving employee engagement, well-being, and retention.
- Reducing discrimination and bias in the workplace.

Organizations with strong DEI practices are seen as socially responsible, which enhances their ESG profile and can positively impact reputation, compliance, and overall business performance.

---

## Project Structure

```
DEI PROJECT/
│
├─ data/           # Raw survey Excel files
│   └─ DEI_survey.xlsx
│
├─ database/       # SQLite database with processed tables
│   └─ dei_proj.db
│
├─ notebooks/      # Python preprocessing and cleaning notebook
│   └─ dei_proj.ipynb
│
├─ sql_scripts/    # SQL queries for DEI analysis
│   └─ dei_queries.sql
│
└─ README.md       # Project description (this file)
```

---

## Tables Created

1. **employees**
   - Columns:  
     `employee_id`, `name`, `surname`, `division`, `manager`, `gender`, `sexual_orientation`, `LGBTQ`, `indigenous`, `ethnicity`, `disability`, `minority`, `veteran`, `date_of_birth`, `age`, `preferred_language`
   - Contains demographic and personal details of employees.

2. **questions**
   - Columns:  
     `question_id`, `dimension`, `question`
   - Stores survey questions along with their DEI dimension.

3. **detailed_survey**
   - Columns:  
     `employee_id`, scores for each question (`Aug_D_Q1` … `Aug_I_Q5`), total scores per dimension (`Diversity_total`, `Engagement_total`, `Inclusion_total`)
   - Contains detailed survey responses for each employee. *No sentiment analysis here.*

4. **survey_df** (optional summary table)
   - Columns:  
     `employee_id`, `Diversity_sentiment`, `Engagement_sentiment`, `Inclusion_sentiment`
   - Stores the sentiment of each employee toward each DEI dimension based on total scores.

---

## Python Preprocessing

- **Objective:** Read raw Excel survey data and convert it into structured tables.
- **Key steps:**
  - Read survey and questions sheets using `pandas`.
  - Extract employee demographics and survey responses.
  - Compute total scores and sentiment per dimension.
  - Save cleaned tables into a SQLite database (`dei_proj.db`) for SQL analysis.

---

## SQL Analysis

- All SQL queries are provided in `sql_scripts/dei_queries.sql`.
- Key analyses include:
  - Employee distribution by division, gender, LGBTQ status, and ethnicity.
  - Average scores and sentiment per DEI dimension.
  - Top and bottom performing employees in each dimension.
  - Question-level insights for Diversity, Engagement, and Inclusion.
  - Intersectional analysis (e.g., female LGBTQ employees by division).
  - Classification of scores into ranges: Very Low, Low, High, Very High.

> **Note:** SQL queries are provided as scripts and have not been run in Python.

---

## How to Use

1. **Clone the repository:**
    ```bash
    git clone https://github.com/JoannJibin/Workplace-DEI-Analysis.git
    cd Workplace-DEI-Analysis
    ```

2. **Open the Jupyter notebook for preprocessing steps:**
    - Open `notebooks/dei_proj.ipynb` to see data cleaning and preprocessing.

3. **View and run SQL analysis queries:**
    - Open `sql_scripts/dei_queries.sql` to view all SQL analysis queries.
    - Run these queries in SQLite or any SQL engine connected to `database/dei_proj.db`.

---

## Tools Used

- **Python** (`pandas`, `sqlite3`) for data preprocessing.
- **SQLite** for structured DEI database and analysis.
- **Git/GitHub** for version control and project sharing.

---

## Project Outcome

- Cleaned and structured DEI survey dataset.
- SQL queries to explore workforce diversity, inclusion, and engagement insights.
- Ready-to-use repository for DEI auditors or analysts to generate actionable insights.

---

## Author

**Joann Jibin**  
GitHub: [JoannJibin](https://github.com/JoannJibin)

---

## Collaboration

If you are interested in contributing, collaborating, or sharing feedback, feel free to open an issue or reach out via GitHub!  
Let’s work together to make workplace analytics more insightful and impactful.
