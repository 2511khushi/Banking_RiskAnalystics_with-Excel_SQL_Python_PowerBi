# OrbitBank: Risk Metrics & Insights

## Project Overview:
A financial bank wants to utilize its available loan lending data to analyze and gain insights for financial planning. These insights from loan data provide key information for making decisions on future lending strategies, managing risks, and improving loan recovery processes. Leveraging datasets on client profiles, banking relationships, investment details, and demographic information, this project involves cleaning and preparing the data using Excel and MySQL, performing exploratory data analysis (EDA) in Python, and building interactive dashboards in Power BI. The dashboard aids in minimizing financial risk by informing data-driven lending decisions and provides a strong foundation for understanding key banking dynamics, customer behavior, and account trends ultimately supporting better strategic planning and operational efficiency.


## Business Problem Scenarios, Objectives and KPIs:
The bank struggles with fragmented loan and client data, making it difficult to assess credit risk and identify reliable borrowers. There is limited visibility into customer engagement, product usage, and repayment behavior, resulting in suboptimal lending decisions and increased financial risk. A lack of centralized insights also hinders strategic planning and resource allocation. The core objectives are:

  - Minimize financial risk by identifying high-risk and low-risk clients through data analysis.
  - Improve loan approval decisions using historical data on client profiles and product usage.
  - Provide actionable insights to support financial planning and customer engagement strategies.
  - Enable data-driven decision-making through visual dashboards and KPIs.
    
Key performance indicators (KPIs) tracked include Total Clients, Total Loan Amount, Total Deposits, Engagement Days, Income Band Distribution, Processing Fees, Credit Card Usage, and Client Distribution by Bank Type or Nationality. These KPIs help the bank monitor performance, assess client value, and optimize lending and recovery strategies.


## Dataset:
The dataset comprises multiple tables linked via primary and foreign keys, including:
   - `banking_clients.csv`: Client demographics, financial details, and account information.
   - `banking_relationships.csv`: Information on client relationships with the bank.
   - `clients_gender.csv`: Gender classification for clients.
   - `investment_advisors.csv`: Details on associated investment advisors.

These tables collectively provide a comprehensive view of client profiles, financial behaviors, and banking interactions.

#### Datasets Link: 


## Tech Stack:
- **Excel**: Data validation and preliminary exploration.
- **SQL**: Data querying, joining, and transformation.
- **Python** (pandas, numpy, matplotlib and seaborn): Exploratory Data Analysis (EDA) and feature engineering.
- **Power BI**: Interactive visualizations.


## Project Workflow:

#### 1. Problem Definition: 
Identified the business need: analyze loan lending data to uncover patterns, manage financial risk, and support data-driven lending decisions. Focused on understanding how banks can minimize loan defaults and optimize client engagement using data.

#### 2. Data Collection: 
Fetched publicly available datasets in .csv format that simulated real-world banking data, including client profiles, banking relationships, account balances, and advisor details.

#### 3. Data Cleaning & Preparation:

  - Reviewed and validated the datasets using Excel for data integrity.
  - Cleaned and transformed the data using MySQL, including fixing data types and formatting (especially for date columns), handling missing values, duplicates, and outliers, joining related tables for a consolidated view of client data.

#### 4. Exploratory Data Analysis (EDA):
Utilized Python (pandas, numpy, matplotlib, seaborn) to analyze trends and derive insights. Created new features such as Engagement Days – to measure client longevity, Income Bands – to categorize clients by income level, Processing Fees – calculated for analytical use.

#### 5. Data Visualization:
Built dynamic and interactive dashboards using Power BI to visualize key metrics and trends. The dashboards included slicers and filters such as gender, banking relationship type, and joining year, helping stakeholders explore data related to loan activity, client engagement, and deposit patterns.


## Conclusion: 

#### Dashboard Link: 

The final Power BI dashboard provides deep visibility into key risk metrics and client behavior, supporting strategic decisions around loan approvals. It empowers banks to:
  - Assess loan repayment risks using client and financial metrics.
  - Analyze deposit and loan trends by occupation, nationality, and income band.
  - Make data-driven lending decisions with interactive visualizations.
