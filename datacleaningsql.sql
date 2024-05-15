SELECT *
FROM layoffs;

CREATE TABLE layoffs_working
LIKE layoffs;

SELECT *
FROM layoffs_working;

INSERT layoffs_working
SELECT *
FROM layoffs;


SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) rownum 
FROM layoffs_working
;


CREATE TABLE `layoffs_working3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rownumm` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_working3
;

INSERT into layoffs_working3
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) rownumm 
FROM layoffs_working
;

select *
FROM layoffs_working3
;

DELETE
FROM layoffs_working3
WHERE rownumm > 1;

UPDATE layoffs_working3
SET company= LTRIM(company)
;

UPDATE layoffs_working3
SET industry= 'Crypto'
WHERE industry LIKE 'Crypto%'
;

SELECT DISTINCT country
FROM layoffs_working3
ORDER BY country DESC;

UPDATE layoffs_working3
set country= trim(trailing '.' FROM country)
where country LIKE 'United States%'; 

select distinct `date`
from layoffs_working3;

UPDATE layoffs_working3
SET `date`= str_to_date(`date`, '%m/%d/%Y')
;

SELECT *
FROM layoffs_working3
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

select distinct company
from layoffs_working3
order by company asc
;

select *
from layoffs_working3
where industry is null;

update layoffs_working3
set industry = null
where industry = '' ;

update layoffs_working3 t1
join layoffs_working3 t2
    on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select *
from layoffs_working3
;

delete 
FROM layoffs_working3
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

alter table layoffs_working3
drop column rownumm;



SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) row_num
FROM layoffs_working3
;

CREATE TABLE `layoffs_workingfinal` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num1` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_workingfinal
;

INSERT into layoffs_workingfinal
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) row_num1 
FROM layoffs_working3
;

select *
FROM layoffs_workingfinal
;

DELETE
FROM layoffs_workingfinal
WHERE row_num1 > 1;

alter table layoffs_workingfinal
drop column row_num1;








































































































































