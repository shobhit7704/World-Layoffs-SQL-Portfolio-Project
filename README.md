# World-Layoffs-SQL-Portfolio-Project

📌 Project Overview

This project focuses on data cleaning using SQL, where I worked with a layoffs dataset containing information about companies, industries, layoffs, funding, and more. The goal was to practice real-world data cleaning techniques — dealing with duplicates, standardizing messy values, handling nulls, and removing unnecessary columns/rows.

Data cleaning is one of the most important steps before analysis, and this project helped me strengthen those skills.

🗂️ Dataset Structure

The dataset includes fields such as:

Company – Name of the company

Location – Company location

Industry – Industry sector of the company

Total Laid Off – Number of employees laid off

Percentage Laid Off – % of workforce laid off

Date – Date of layoff

Stage – Company’s funding stage

Country – Country where the company operates

Funds Raised (Millions) – Total funding raised

🧹 Data Cleaning Steps Performed

1. Removing Duplicates

Used ROW_NUMBER() with PARTITION BY to identify duplicate rows.

Created a staging table and deleted duplicates safely.

2. Standardizing Data

Trimmed extra spaces in company names.

Corrected inconsistent industry names (e.g., CRYPTO → Crypto).

Fixed country names (e.g., “United States.” → “United States”).

Converted Date from text to proper DATE format.

3. Handling Nulls / Blank Values

Replaced empty strings with NULL.

Filled missing industries where possible by referencing other records of the same company.

4. Removing Unnecessary Data

Deleted rows with no useful information (total_laid_off and percentage_laid_off both null).

Dropped helper columns like row_num used only during cleaning.

🔑 Key Takeaways

Practiced SQL cleaning operations like UPDATE, DELETE, JOIN, and ALTER.

Learned the importance of data consistency for better analysis later.

Reinforced the idea that clean data = reliable insights.
