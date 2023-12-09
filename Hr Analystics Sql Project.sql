create database Hr;
use Hr;

#Kpi 1 Average Attrition rate for all Departments

SELECT
    COALESCE(Department, 'Grand Total') AS Department,
    CONCAT(FORMAT(AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100, 2), '%') AS Avg_Yes_Attrition_Rate,
    CONCAT(FORMAT(AVG(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) * 100, 2), '%') AS Avg_No_Attrition_Rate
FROM
    Hr.project
GROUP BY
    Department WITH ROLLUP;
    
# Kpi 2 Average Hourly rate of Male Research Scientist

SELECT
    AVG(HourlyRate) AS Avg_Hourly_Rate_Male_Research_Scientist
FROM
    hr.project
WHERE
    Gender = 'Male' AND
    JobRole = 'Research Scientist';
    
# Kpi 3 Attrition rate Vs Monthly income stats

SELECT
    Attrition,
    SUM(MonthlyIncome) AS Sum_MonthlyIncome,
    CONCAT(FORMAT(SUM(MonthlyIncome) / (SELECT SUM(MonthlyIncome) FROM hr.project) * 100, 2), '%') AS MonthlyIncome_Percentage
FROM
    hr.project
GROUP BY
    Attrition WITH ROLLUP;

SELECT
    COALESCE(Attrition, 'Grand Total') AS Attrition,
    SUM(MonthlyIncome) AS Sum_MonthlyIncome,
    CONCAT(FORMAT(SUM(MonthlyIncome) / (SELECT SUM(MonthlyIncome) FROM hr.project) * 100, 2), '%') AS MonthlyIncome_Percentage
FROM
    hr.project
GROUP BY
    Attrition WITH ROLLUP;
    
# Kpi 4 Average working years for each Department

SELECT
    COALESCE(Department, 'Grand Total') AS Department,
    AVG(TotalWorkingYears) AS Avg_Working_Years
FROM
    hr.project
GROUP BY
    Department WITH ROLLUP;
    
# Kpi 5 Job Role Vs Work life balance

SELECT
    COALESCE(JobRole, 'Grand Total') AS JobRole,
    SUM(WorkLifeBalance) AS Sum_WorkLifeBalance
FROM
    hr.project
GROUP BY
    JobRole WITH ROLLUP;


# Kpi 6 Attrition rate Vs Year since last promotion relation

SELECT
    COALESCE(Attrition, 'Grand Total') AS `Attrition`,
    CONCAT(FORMAT(COUNT(*) / (SELECT COUNT(*) FROM hr.project) * 100, 2), '%') AS `Sum of YearsSinceLastPromotion`
FROM
    hr.project
GROUP BY
    Attrition WITH ROLLUP;




