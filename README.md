# Credit Card Fraud Analytics

### Risk Segmentation, Transaction Monitoring & Financial Loss Analysis

<p align="center">
  <img src="images/Dashboard_overview.png" width="100%">
</p>

<p align="center">

![Python](https://img.shields.io/badge/Python-EDA-8B0000)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Analytics-A52A2A)
![Tableau](https://img.shields.io/badge/Tableau-Dashboard-B22222)
![Domain](https://img.shields.io/badge/Domain-Fraud%20Analytics-DC143C)

</p>

---

## Executive Summary

> [!IMPORTANT]
> **1.29 Million Transactions Analyzed**
>
> **7,506 Fraudulent Transactions Identified**
>
> **$3.99 Million in Fraud Losses**
>
> **Online Shopping Generated the Highest Fraud Exposure**
>
> **High-Risk Customers Showed ~60x Higher Fraud Rates**
>
> **Fraud Activity Peaked Between 22:00 and 03:00**

| Metric                | Value               |
| --------------------- | ------------------- |
| Total Transactions    | **1,296,675**       |
| Fraud Transactions    | **7,506**           |
| Fraud Rate            | **0.58%**           |
| Total Fraud Losses    | **$3.99 Million**   |
| Highest Risk Category | **Online Shopping** |
| Peak Fraud Window     | **22:00 – 03:00**   |

---

## Live Dashboard

Tableau Public Dashboard:

https://public.tableau.com/app/profile/rahul.tanwar8538/viz/Credit_Card_Fraud_Analysis_17815948901510/Dashboard1

---

## Project Overview

Financial fraud remains one of the most significant challenges faced by banks, payment processors, and e-commerce platforms.

This project analyzes more than **1.29 million credit card transactions** to identify fraud patterns, quantify financial losses, uncover high-risk customer behavior, and develop actionable business insights.

The project follows a complete analytics workflow:

**Python Exploratory Data Analysis → PostgreSQL Business Analysis → Tableau Dashboard Development**

The objective was to answer a fundamental business question:

> Where does fraud occur, when does it occur, who is most vulnerable, and how can organizations reduce fraud exposure?

---

## Dataset

**Source**

https://www.kaggle.com/datasets/priyamchoksi/credit-card-transactions-dataset?utm_source=chatgpt.com

### Dataset Characteristics

| Metric             | Value             |
| ------------------ | ----------------- |
| Records            | **1,296,675**     |
| Features           | **29**            |
| Fraud Transactions | **7,506**         |
| Fraud Rate         | **0.58%**         |
| Fraud Losses       | **$3.99 Million** |

---

## Tools & Technologies

| Tool           | Purpose                                   |
| -------------- | ----------------------------------------- |
| Python         | Data Cleaning & Exploratory Data Analysis |
| Pandas         | Data Manipulation                         |
| Matplotlib     | Data Visualization                        |
| PostgreSQL     | Business Analysis & Querying              |
| Tableau Public | Dashboard Development                     |
| GitHub         | Documentation & Version Control           |

---

## Analytical Workflow

### Stage 1 — Exploratory Data Analysis (Python)

The project began with Python-based exploratory analysis to understand:

* Fraud distribution
* Transaction behavior
* Customer characteristics
* Merchant categories
* Transaction timing patterns
* Financial exposure

Key activities included:

* Data cleaning
* Data validation
* Feature engineering
* Fraud pattern identification
* Statistical analysis
* Visualization

The objective of this phase was to identify meaningful patterns and formulate analytical hypotheses.

---

### Stage 2 — Business Analysis (PostgreSQL)

Insights identified during exploratory analysis were validated and expanded through SQL.

PostgreSQL was used to perform:

* Fraud rate calculations
* Category-level analysis
* Merchant-level analysis
* Financial impact assessment
* Risk segmentation
* Transaction pattern analysis
* Fraud trend analysis

This stage transformed exploratory findings into measurable business metrics.

---

### Stage 3 — Executive Dashboard (Tableau)

The final stage involved developing an interactive dashboard for business stakeholders.

The dashboard focuses on:

* Fraud exposure monitoring
* Category-level fraud analysis
* Financial loss assessment
* Time-based fraud activity
* Risk segmentation
* Fraud transaction multiplier analysis

The objective was to provide a concise executive reporting solution for fraud monitoring and decision-making.

---

## Executive Dashboard

<p align="center">
  <img src="images/Dashboard_overview.png" width="100%">
</p>

---

## Executive Findings

### Online Shopping Generates the Highest Fraud Losses

Online shopping transactions generated approximately **$1.71 Million** in fraudulent losses, representing the largest financial exposure among all transaction categories.

<p align="center">
  <img src="images/Fraud_amt_by_category.png" width="90%">
</p>

---

### Online Shopping Exhibits the Highest Fraud Rate

Online transaction categories consistently demonstrate higher fraud rates than traditional transaction channels, indicating elevated exposure within digital commerce environments.

<p align="center">
  <img src="images/Fraud_rate_by_category.png" width="90%">
</p>

---

### Fraud Activity Concentrates During Late-Night Hours

Fraud incidence rises significantly between **22:00 and 03:00**, suggesting elevated risk during low-supervision periods and potential automated attack activity.

<p align="center">
  <img src="images/Fraud_rate_by_hour.png" width="90%">
</p>

---

### High-Risk Customers Exhibit Disproportionate Fraud Exposure

High-risk customers experience fraud at a rate approximately **60 times higher** than low-risk customers, highlighting a strong opportunity for targeted fraud controls.

<p align="center">
  <img src="images/Fraud_amt_multiplier.png" width="90%">
</p>

---

## Business Recommendations

Based on the analysis, organizations should consider:

* Enhancing monitoring for online shopping and digital transactions.
* Implementing additional fraud controls during late-night transaction windows.
* Applying risk-based authentication for high-risk customer segments.
* Prioritizing investigations involving high-risk customers.
* Developing category-specific fraud prevention strategies.
* Deploying real-time monitoring for anomalous transaction behavior.

---

## Project Highlights

* Analyzed **1.29 Million** credit card transactions.
* Identified **$3.99 Million** in fraudulent transaction exposure.
* Performed end-to-end analytics using **Python, PostgreSQL, and Tableau**.
* Built an interactive fraud monitoring dashboard.
* Conducted customer risk segmentation analysis.
* Generated business-focused recommendations from analytical findings.

---

## Repository Structure

```text
credit-card-fraud-analysis
│
├── images
│   ├── Dashboard_overview.png
│   ├── Fraud_amt_by_category.png
│   ├── Fraud_amt_multiplier.png
│   ├── Fraud_rate_by_category.png
│   └── Fraud_rate_by_hour.png
│
├── python_notebook
│   └── exploratory_data_analysis.ipynb
│
├── sql
│   └── fraud_analysis_queries.sql
│
├── tableau
│   └── Credit_Card_Fraud_Analysis.twb
│
└── README.md
```

---

## Author

**Rahul Tanwar**

LinkedIn:

https://www.linkedin.com/in/rahul-tanwar-b13439295

Tableau Public:

https://public.tableau.com/app/profile/rahul.tanwar8538

---

