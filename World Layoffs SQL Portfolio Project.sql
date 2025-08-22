-- DATA CLEANING PROJECT

SELECT * FROM layoffs;

-- 1. REMOVE DUPLICATES
-- 2. STANDARDIZE THE DATA 
-- 3. NULL VALUES OR BLANK VALUES
-- 4. REMOVE ANY COLUMNS OR ROWS


-- 1. Remove Duplicates


# First let's check for duplicates

CREATE TABLE LAYOFFS_STAGING LIKE layoffs;

SELECT * FROM layoffs_staging;

INSERT layoffs_staging
SELECT * FROM layoffs;


SELECT *
FROM layoffs_staging;


SELECT *, ROW_NUMBER() OVER(
PARTITiON BY COMPANY, INDUSTRY, TOTAL_LAID_OFF, PERCENTAGE_LAID_OFF, `Date`) as row_num from layoffs_staging;

with duplicate_cte as 
(SELECT *, ROW_NUMBER() OVER(
PARTITiON BY COMPANY, location,INDUSTRY, TOTAL_LAID_OFF, PERCENTAGE_LAID_OFF, `Date`, stage, country, funds_raised_millions) as row_num from layoffs_staging)

select * from duplicate_cte where row_num > 1;

select * from layoffs_staging where company = 'casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *, ROW_NUMBER() OVER(
PARTITION BY COMPANY, location,INDUSTRY, TOTAL_LAID_OFF, PERCENTAGE_LAID_OFF, `Date`, stage, country, funds_raised_millions) as row_num from layoffs_staging;

SELECT *
FROM layoffs_staging2 WHERE ROW_NUM > 1;

DELETE 
FROM layoffs_staging2 
WHERE ROW_NUM > 1;

SELECT * 
FROM layoffs_staging2;


-- 2. STANDARDIZING DATA 


SELECT COMPANY, TRIM(COMPANY)
FROM layoffs_staging2; 


UPDATE LAYOFFS_STAGING2
SET COMPANY = TRIM(COMPANY);

select distinct INDUSTRY FROM LAYOFFS_STAGING2;


SELECT * FROM layoffs_staging2 
WHERE INDUSTRY LIKE 'CRYPTO%';


UPDATE LAYOFFS_STAGING2
SET INDUSTRY = 'Crypto'
WHERE INDUSTRY LIKE 'CRYPTO%';

SELECT *
FROM layoffs_staging2
WHERE COUNTRY LIKE 'UNITED STATES%';

SELECT DISTINCT COUNTRY, TRIM(TRAILING '.' FROM COUNTRY)
FROM LAYOFFS_STAGING2
ORDER BY 1;

UPDATE LAYOFFS_STAGING2 
SET COUNTRY = TRIM(TRAILING '.' FROM COUNTRY)
WHERE COUNTRY LIKE 'UNITED_STATES%';

 SELECT `DATE`,
 STR_TO_DATE(`DATE`, '%m/%d/%Y')
 FROM layoffs_staging2;
 
 
UPDATE layoffs_staging2
SET `DATE` = STR_TO_DATE(`DATE`, '%m/%d/%Y');
 
 SELECT `DATE` 
 FROM layoffs_staging2;
 
 ALTER TABLE layoffs_staging2
 MODIFY COLUMN `DATE` date;


SELECT * 
FROM layoffs_staging2;


-- 3. NULL VALUES OR BLANK VALUES

 
 SELECT * 
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL
 AND PERCENTAGE_LAID_OFF IS NULL;
 
 UPDATE layoffs_staging2
 SET INDUSTRY = NULL 
 WHERE INDUSTRY = '';
 
 SELECT * 
 FROM LAYOFFS_STAGING2
 WHERE INDUSTRY IS NULL
 OR INDUSTRY = '';
 
 SELECT * 
 FROM layoffs_staging2
 WHERE COMPANY = 'AIRBNB';
 
 SELECT * 
 FROM layoffs_staging2 T1
 JOIN layoffs_staging2 T2
     ON T1.COMPANY=T2.company
 WHERE (T1.industry IS NULL OR T1.INDUSTRY = '')
 AND T2.INDUSTRY IS NOT NULL; 
 
 UPDATE layoffs_staging2 T1
 JOIN layoffs_staging2 T2
     ON T1.COMPANY=T2.company
     SET T1.INDUSTRY=T2.INDUSTRY
 WHERE T1.industry IS NULL
 AND T2.INDUSTRY IS NOT NULL; 
 
 
 -- 4. REMOVE ANY COLUMNS OR ROWS
 
 
 SELECT * 
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL
 AND PERCENTAGE_LAID_OFF IS NULL;
 
 DELETE
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL
 AND PERCENTAGE_LAID_OFF IS NULL;
 
 SELECT *
 FROM layoffs_staging2;
 
 ALTER TABLE layoffs_staging2
 DROP COLUMN ROW_NUM;
 
 SELECT * 
 FROM layoffs_staging2;




 
 
 
 










