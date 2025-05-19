-- SECTION 5: FINANCIAL HEALTH

-- Debt-to-Deposit Ratio by Fee Structure
SELECT 
    Fee_Structure,
    COUNT(Client_ID) AS Client_Count,
    ROUND(AVG(Total_Loan / NULLIF(Total_Deposit, 0)), 2) AS Debt_to_Deposit_Ratio
FROM clients
WHERE Total_Deposit > 0
GROUP BY Fee_Structure
ORDER BY Debt_to_Deposit_Ratio DESC;

-- Clients with High Credit Card Exposure
SELECT 
    Client_ID,
    Name,
    Amount_of_CreditCards,
    CreditCard_Balance,
    Total_Loan,
    Risk_Weighting
FROM clients
WHERE Amount_of_CreditCards > 2 AND CreditCard_Balance > 50000
ORDER BY CreditCard_Balance DESC;


-- SECTION 6: PORTFOLIO MANAGEMENT

-- Clients with Diverse Account Types
SELECT 
    Client_ID,
    Name,
    (CASE WHEN Bank_Deposits > 0 THEN 1 ELSE 0 END +
     CASE WHEN Checking_Accounts > 0 THEN 1 ELSE 0 END +
     CASE WHEN Saving_Accounts > 0 THEN 1 ELSE 0 END +
     CASE WHEN ForeignCurrency_Account > 0 THEN 1 ELSE 0 END) AS Active_Account_Types,
    Total_Deposit
FROM clients
WHERE Total_Deposit > 0
HAVING Active_Account_Types >= 3
ORDER BY Total_Deposit DESC;

-- Property Ownership and Loan Exposure
SELECT 
    Properties_Owned,
    COUNT(Client_ID) AS Client_Count,
    ROUND(SUM(Total_Loan), 2) AS Total_Loans,
    ROUND(AVG(Total_Loan), 2) AS Avg_Loan
FROM clients
GROUP BY Properties_Owned
ORDER BY Properties_Owned;


-- SECTION 7: LOYALTY AND RETENTION

-- Client Retention by Engagement Period
SELECT 
    CASE 
        WHEN Engagement_Days < 365 THEN 'Less than 1 year'
        WHEN Engagement_Days < 1825 THEN '1-5 years'
        WHEN Engagement_Days < 3650 THEN '5-10 years'
        ELSE 'Over 10 years'
    END AS Engagement_Period,
    COUNT(Client_ID) AS Client_Count,
    ROUND(SUM(Total_Deposit), 2) AS Total_Deposits,
    ROUND(AVG(Total_Loan), 2) AS Avg_Loan
FROM clients
GROUP BY Engagement_Period
ORDER BY Engagement_Period;

-- Loyalty Classification and Fee Contribution
SELECT 
    Loyalty_Classification,
    COUNT(Client_ID) AS Client_Count,
    ROUND(SUM(Total_Loan * COALESCE(Processing_Fees, 0)), 2) AS Total_Fees_Collected
FROM clients
GROUP BY Loyalty_Classification
ORDER BY Total_Fees_Collected DESC;


-- SECTION 8: OPERATIONAL EFFICIENCY

-- Investment Advisor Performance
SELECT 
    ia.Investment_Advisor,
    COUNT(c.Client_ID) AS Client_Count,
    ROUND(SUM(c.Total_Loan), 2) AS Total_Loans,
    ROUND(SUM(c.Total_Deposit), 2) AS Total_Deposits
FROM clients c
JOIN investment_advisors ia ON c.IAId = ia.IAId
GROUP BY ia.Investment_Advisor
ORDER BY Total_Loans DESC;

-- Banking Contact Effectiveness
SELECT 
    Banking_Contact,
    COUNT(Client_ID) AS Client_Count,
    ROUND(SUM(Total_Deposit), 2) AS Total_Deposits,
    ROUND(SUM(Total_Loan), 2) AS Total_Loans
FROM clients
WHERE Banking_Contact IS NOT NULL
GROUP BY Banking_Contact
HAVING Client_Count > 3
ORDER BY Total_Deposits DESC;


-- SECTION 9: PROFITABILITY AND COMPLIANCE

-- Net Revenue After Risk Adjustment
SELECT 
    COUNT(Client_ID) AS Client_Count,
    ROUND(SUM(Total_Loan * COALESCE(Processing_Fees, 0)), 2) AS Gross_Fee_Revenue,
    ROUND(SUM(Total_Loan * COALESCE(Processing_Fees, 0) * (1 - Risk_Weighting / 5.0)), 2) AS Risk_Adjusted_Revenue
FROM clients
WHERE Total_Loan > 0;

-- Cross-Selling Opportunities
WITH ClientAccounts AS (
    SELECT 
        Client_ID,
        Name,
        Total_Deposit,
        (CASE WHEN Bank_Deposits > 0 THEN 1 ELSE 0 END +
         CASE WHEN Checking_Accounts > 0 THEN 1 ELSE 0 END +
         CASE WHEN Saving_Accounts > 0 THEN 1 ELSE 0 END +
         CASE WHEN ForeignCurrency_Account > 0 THEN 1 ELSE 0 END) AS Active_Account_Types
    FROM clients
)
SELECT 
    Client_ID,
    Name,
    Total_Deposit,
    Active_Account_Types
FROM ClientAccounts
WHERE Total_Deposit > 100000 AND Active_Account_Types < 2
ORDER BY Total_Deposit DESC;

-- Clients by Join Year (Temporal Analysis)
SELECT 
    YEAR(Joining_Date) AS Join_Year,
    COUNT(Client_ID) AS Client_Count,
    ROUND(SUM(Total_Loan), 2) AS Total_Loans,
    ROUND(SUM(Total_Deposit), 2) AS Total_Deposits
FROM clients
WHERE Joining_Date IS NOT NULL
GROUP BY Join_Year
ORDER BY Join_Year DESC;

-- Compliance: Clients with Missing Critical Data
SELECT 
    Client_ID,
    Name,
    CASE 
        WHEN Estimated_Income IS NULL OR Estimated_Income = 0 THEN 'Missing Income'
        WHEN Nationality IS NULL OR Nationality = 'Unknown' THEN 'Missing Nationality'
        WHEN Occupation IS NULL OR Occupation = 'Unknown' THEN 'Missing Occupation'
        ELSE 'Other'
    END AS Missing_Data_Type
FROM clients
WHERE Estimated_Income IS NULL OR Estimated_Income = 0
   OR Nationality IS NULL OR Nationality = 'Unknown'
   OR Occupation IS NULL OR Occupation = 'Unknown'
ORDER BY Client_ID;