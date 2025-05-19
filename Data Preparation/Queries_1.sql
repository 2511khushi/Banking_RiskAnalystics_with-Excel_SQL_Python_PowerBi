-- SECTION 1: SETUP AND DATA VALIDATION

CREATE DATABASE IF NOT EXISTS OrbitBank;
USE OrbitBank;

SHOW TABLES;

-- Check row counts for data integrity
SELECT 'clients' AS tables, COUNT(*) AS count FROM clients
UNION
SELECT 'banking_relationships', COUNT(*) FROM banking_relationships
UNION
SELECT 'clients_gender', COUNT(*) FROM clients_gender
UNION
SELECT 'investment_advisors', COUNT(*) FROM investment_advisors;

-- Validate relationships with sample data
SELECT 
    c.Client_ID, 
    c.Name, 
    g.Gender, 
    br.Banking_Relationship, 
    ia.Investment_Advisor
FROM clients c
JOIN clients_gender g ON c.GenderId = g.GenderId
JOIN banking_relationships br ON c.BRId = br.BRId
JOIN investment_advisors ia ON c.IAId = ia.IAId;


-- SECTION 2: KEY PERFORMANCE INDICATORS (KPIs)

-- Total Clients
SELECT COUNT(DISTINCT Client_ID) AS Total_Clients
FROM clients;

-- Total Loan and Deposit Portfolio
SELECT 
    SUM(Total_Loan) AS Total_Loans,
    SUM(Total_Deposit) AS Total_Deposits,
    SUM(Total_Loan) / NULLIF(SUM(Total_Deposit), 0) AS Loan_to_Deposit_Ratio
FROM clients;

-- Total Fee Revenue
SELECT 
    SUM(Total_Loan * COALESCE(Processing_Fees, 0)) AS Total_Fee_Revenue
FROM clients;

-- Account Balances Summary
SELECT 
    SUM(Bank_Deposits) AS Total_Bank_Deposits,
    SUM(Checking_Accounts) AS Total_Checking_Accounts,
    SUM(Saving_Accounts) AS Total_Saving_Accounts,
    SUM(ForeignCurrency_Account) AS Total_Foreign_Currency,
    SUM(CreditCard_Balance) AS Total_Credit_Card_Balance
FROM clients;


-- SECTION 3: RISK ANALYSIS

-- Clients by Risk Weighting
SELECT 
    Risk_Weighting,
    COUNT(Client_ID) AS Client_Count,
    ROUND(AVG(Total_Loan), 2) AS Avg_Loan_Amount,
    ROUND(SUM(Total_Loan), 2) AS Total_Loan_Amount
FROM clients
GROUP BY Risk_Weighting
ORDER BY Risk_Weighting;

-- High-Risk Clients with Significant Loans
SELECT 
    c.Client_ID,
    c.Name,
    c.Total_Loan,
    c.Risk_Weighting,
    c.Total_Deposit
FROM clients c
WHERE c.Risk_Weighting >= 3 AND c.Total_Loan > 1000000
ORDER BY c.Total_Loan DESC;

-- Risky Clients by Loan-to-Income Ratio
SELECT 
    c.Client_ID,
    c.Name,
    c.Total_Loan,
    c.Estimated_Income,
    ROUND(c.Total_Loan / NULLIF(c.Estimated_Income, 0), 2) AS Loan_to_Income_Ratio,
    c.Risk_Weighting,
    CASE
        WHEN c.Total_Loan / NULLIF(c.Estimated_Income, 0) > 10 THEN 'High Risk'
        WHEN c.Total_Loan / NULLIF(c.Estimated_Income, 0) > 5 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Category
FROM clients c
WHERE c.Estimated_Income > 0
ORDER BY Loan_to_Income_Ratio DESC;


-- SECTION 4: CLIENT SEGMENTATION

-- Clients by Age Group and Financial Metrics
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 45 THEN '30-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Over 60'
    END AS Age_Group,
    COUNT(Client_ID) AS Client_Count,
    ROUND(SUM(Total_Deposit), 2) AS Total_Deposit,
    ROUND(AVG(Total_Loan), 2) AS Avg_Loan
FROM clients
GROUP BY Age_Group
ORDER BY Total_Deposit DESC;

-- Clients by Banking Relationship
SELECT 
    br.Banking_Relationship,
    COUNT(c.Client_ID) AS Client_Count,
    ROUND(SUM(c.Total_Deposit), 2) AS Total_Deposit,
    ROUND(SUM(c.Total_Loan), 2) AS Total_Loans
FROM clients c
JOIN banking_relationships br ON c.BRId = br.BRId
GROUP BY br.Banking_Relationship
ORDER BY Total_Deposit DESC;

-- Clients by Occupation
SELECT 
    Occupation,
    COUNT(Client_ID) AS Client_Count,
    ROUND(SUM(Total_Loan), 2) AS Total_Loans,
    ROUND(AVG(Estimated_Income), 2) AS Avg_Income
FROM clients
WHERE Occupation != 'Unknown'
GROUP BY Occupation
HAVING Client_Count >= 5
ORDER BY Total_Loans DESC;