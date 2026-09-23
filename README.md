# skin-lesion-healthcare-sql-analysis
PostgreSQL healthcare analysis exploring patient demographics, lesion characteristics and factors associated with malignant skin lesions.

# Skin Lesion Healthcare Analysis – SQL

## Project Overview

This portfolio project uses **PostgreSQL** to analyse a simulated healthcare dataset containing patient demographics and skin lesion records.

The analysis explores demographic patterns, lesion characteristics, symptoms, and recorded lifestyle and environmental factors associated with malignant and benign skin lesions.

The project focuses on using SQL not only to retrieve data, but to transform, aggregate and interpret healthcare information while distinguishing descriptive associations from causal conclusions.

---

## Project Files

- [View SQL analysis](skin_lesion_healthcare_analysis.sql) – complete PostgreSQL analysis script
- [View analysis presentation](SQL_Healthcare_Data_Analysis.pdf) – findings, interpretation and recommendations
- [Download PowerPoint presentation](SQL_Healthcare_Data_Analysis.pptx) – presentation version of the analysis
 
---

## Analytical Questions

The analysis explored:

- Which age groups accounted for the most lesion diagnoses?
- What proportion of lesions were classified as malignant or benign?
- How were patients distributed by gender?
- How did malignant lesion proportions vary by smoking and alcohol consumption?
- How did malignancy vary with reported pesticide exposure?
- Which diagnoses had the largest average lesion diameter?
- Were malignant lesions more frequently recorded as growing?
- Which lesion symptoms were most commonly recorded?

---

## SQL Skills Demonstrated

`PostgreSQL` `INNER JOIN` `CASE` `GROUP BY` `ORDER BY` `COUNT` `AVG` `ROUND` `FILTER` `Window Functions` `Conditional Aggregation` `UNION ALL`

The analysis joins patient and lesion-level data using `patient_id`, transforms coded diagnoses into clinically meaningful categories, calculates subgroup percentages and summarises lesion characteristics.

---

## Key Findings

### Demographics

- Adults aged **60–79** accounted for the largest number of lesion diagnoses.
- **66.7%** of patients in the dataset were male and **33.3%** were female.
- This describes the sample distribution and does not establish a population-level difference in risk.

### Lesion Characteristics

- **346 lesions** were classified as malignant and **742** as benign.
- Melanoma (`MEL`) had the largest average lesion diameter at **14.09**.
- **74.9% of malignant lesions** were recorded as growing compared with **33.8% of benign lesions**.
- Itch and elevation were the most frequently recorded symptoms.

### Lifestyle & Environmental Factors

| Factor | Exposed/Reported | Comparison Group |
|---|---:|---:|
| Smoking | 75.8% malignant | 29.1% malignant |
| Alcohol consumption | 71.0% malignant | 26.1% malignant |
| Pesticide exposure | 70.0% malignant | 22.0% malignant |

Smoking, alcohol consumption and pesticide exposure were each **associated with a higher proportion of malignant lesions within this dataset**.

These are descriptive, unadjusted associations and **do not establish causation**.

---

## Analytical Approach

The project demonstrates a structured SQL workflow:

**Join → Transform → Aggregate → Compare → Interpret**

Examples include:

- `INNER JOIN` to connect patient demographics with lesion records
- `CASE` to create age groups and malignant/benign classifications
- aggregate functions to calculate counts and average lesion diameter
- `FILTER` for conditional aggregation
- window calculations for percentage distributions
- `UNION ALL` to consolidate symptom counts into a single result
- subgroup comparisons to investigate potential associations

---

## Limitations

This is an exploratory analysis of a simulated dataset.

The results describe patterns and associations within the available data and should not be interpreted as causal relationships or population-level clinical risk estimates.

Variables such as smoking, alcohol consumption and pesticide exposure were analysed individually rather than through an adjusted multivariable model. Further analysis would be required to assess potential confounding factors.

---

## Further Analysis

Future development could include:

- multivariable modelling of factors associated with malignant diagnosis
- analysis of interactions between demographic and lifestyle variables
- combined analysis of lesion growth, diameter and symptoms
- development of an interactive Power BI dashboard
- validation using a larger and more representative dataset

---

## Portfolio

This project forms part of my healthcare data analytics portfolio, alongside projects using **Excel, Power BI and Tableau**.
