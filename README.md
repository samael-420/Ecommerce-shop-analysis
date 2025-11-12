# Ecom shop Analysis

Basically this project analyzes sales data from an online real world dataset from Kaggle using **Microsoft SQL Server** and **Power BI**.  
Data cleaning, modeling, and business insights were analyzed and done by me. 


## Project Overview
**Objective:**  
Analyze online retail performance to understand revenue trends, customer behavior, and product performance.

**Dataset Source:**  
[Kaggle – Online Shop Business Dataset](https://www.kaggle.com/datasets/gabrielramos87/an-online-shop-business)

**Tools Used:**
- Microsoft SQL Server – Data import & query
- Power BI Desktop – Modeling, DAX, and dashboard
- DAX and Custom KPIs

---

## 🧹 Data Preparation
1. Loaded data into SQL Server from CSV (Sales, CustomerInfo, ProductInfo tables).
2. Created relationships:
     Created 2 seperate tables from the master table Sales CustomerInfo and ProductInfo
     Also created a date table for better visualizations in Power BI
   - CustomerInfo[CustomerNo] → Sales[CustomerNo]
   - ProductInfo[ProductNo] → Sales[ProductNo]
3. Cleaned missing data, corrected date formats, and created a flag for returned transactions.

---

## Key KPIs
| **Total Revenue** | Sum of all sales revenue | £62.97M |
| **Distinct Customers** | Number of unique buyers | 4.7K |
| **Average Order Value (AOV)** | Revenue ÷ Distinct Transactions | 2.71K |
| **Return Rate** | Returned Revenue ÷ Total Revenue | 4.2 % |

---

## Insights
- Revenue peaked in Q4, indicating seasonal demand.
- UK has generated most sales volume which was expected since the store was UK based.
- Product returns were highest in electronics, impacting margins.

Thankyou for reading!

## Author
Rutvik Randive
Data Analyst | SQL | Power BI | Python 
