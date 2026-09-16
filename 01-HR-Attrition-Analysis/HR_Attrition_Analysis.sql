CREATE DATABASE  hr_analytics;
USE hr_analytics; 
 
CREATE TABLE employees ( 
    Age INT,
    Attrition VARCHAR(10),
    Business_Travel VARCHAR(30),
    Department VARCHAR(50),
    Distance_From_Home INT,
    Education VARCHAR(30),
    Education_Field VARCHAR(50),
    Employee_Number INT,
    Environment_Satisfaction VARCHAR(30),
    Gender VARCHAR(20),
    Job_Involvement VARCHAR(30),
    Job_Level INT,
    Job_Role VARCHAR(50),
    Job_Satisfaction VARCHAR(30),
    Marital_Status VARCHAR(30),
    Monthly_Income INT,
    Num_Companies_Worked INT,
    Over_Time VARCHAR(10),
    Percent_Salary_Hike INT,
    Performance_Rating VARCHAR(30),
    Relationship_Satisfaction VARCHAR(30),
    Stock_Option_Level INT,
    Total_Working_Years INT,
    Training_Times_Last_Year INT,
    Work_Life_Balance VARCHAR(30),
    Years_At_Company INT,
    Years_In_Current_Role INT,
    Years_Since_Last_Promotion INT,
    Years_With_Curr_Manager INT
);

DESCRIBE employees;
SELECT * FROM employees;

-- Q1. What is the total number of employees?
SELECT COUNT(*) AS total_employees
FROM employees;

-- Q2. Are there any duplicate Employee_Number values?
SELECT 
    Employee_Number,
    COUNT(*) AS duplicate_count
FROM employees
GROUP BY Employee_Number
HAVING COUNT(*) > 1;

-- Q3. Are there any NULL/missing values in important columns?
SELECT
    SUM(Age IS NULL) AS age_null,
    SUM(Attrition IS NULL) AS attrition_null,
    SUM(Department IS NULL) AS department_null,
    SUM(Gender IS NULL) AS gender_null,
    SUM(Job_Role IS NULL) AS job_role_null,
    SUM(Monthly_Income IS NULL) AS income_null,
    SUM(Over_Time IS NULL) AS overtime_null
FROM employees;

-- Q4. How many employees stayed and how many left the company?
SELECT 
    Attrition,
    COUNT(*) AS total_employees
FROM employees
GROUP BY Attrition;

-- Q5. What is the overall employee attrition rate?
SELECT 
    ROUND(
        SUM(CASE 
            WHEN Attrition = 'Yes' THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees;

-- Q6. Attrition by Department
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM employees
GROUP BY Department
ORDER BY attrition_count DESC;

-- Q6. What is the attrition rate for each department?
SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE 
        WHEN Attrition = 'Yes' THEN 1 
        ELSE 0 
    END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Department
ORDER BY attrition_rate DESC;

-- Q7. What is the attrition rate by gender?
SELECT 
    Gender,
    COUNT(*) AS total_employees,
    SUM(CASE 
        WHEN Attrition = 'Yes' THEN 1 
        ELSE 0 
    END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Gender
ORDER BY attrition_rate DESC;

-- Q8. What is the average monthly income of employees?
SELECT
    ROUND(AVG(Monthly_Income), 2) AS average_monthly_income
FROM employees;

-- Q9. How does job satisfaction relate to attrition?
SELECT
    Job_Satisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Job_Satisfaction
ORDER BY Job_Satisfaction;

-- Q10. What is the attrition rate across different age groups?
SELECT 
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY age_group
ORDER BY attrition_rate DESC;

-- Q11. How does years at the company relate to attrition?
SELECT
    Years_At_Company,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Years_At_Company
ORDER BY Years_At_Company;

-- Q12. Which job roles have the highest attrition?
SELECT
    Job_Role,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Job_Role
ORDER BY attrition_rate DESC;

-- Q13. How does job level relate to attrition?
SELECT
    Job_Level,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Job_Level
ORDER BY Job_Level;

-- Q14. Does business travel relate to employee attrition?
SELECT
    Business_Travel,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Business_Travel
ORDER BY attrition_rate DESC;

-- Q15. How does overtime relate to attrition? ⭐
SELECT
    Over_Time,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Over_Time
ORDER BY attrition_rate DESC;

