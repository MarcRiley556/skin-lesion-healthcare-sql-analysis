/*
Skin Lesion Analysis
Healthcare SQL Portfolio Project

Objective:
Analyse patient and lesion data to explore diagnosis patterns,
demographics, risk factors and lesion characteristics.

Skills demonstrated:
JOINs, CASE statements, GROUP BY, aggregate functions,
conditional aggregation, FILTER, window functions,
percentage calculations and UNION ALL.

-- =========================================================
-- 1. PATIENT DEMOGRAPHIC ANALYSIS
-- =========================================================

-- Question 1: Which age group has the highest number of skin cancer diagnoses?

SELECT
    CASE
        WHEN t1.age BETWEEN 6 AND 18 THEN 'Child'
        WHEN t1.age BETWEEN 19 AND 39 THEN 'Young Adult'
        WHEN t1.age BETWEEN 40 AND 59 THEN 'Adult'
        WHEN t1.age BETWEEN 60 AND 79 THEN 'Older Adult'
        ELSE '80+'
    END AS age_group,
    COUNT(t2.lesion_id) AS number_of_diagnoses
FROM table1 AS t1
INNER JOIN table2 AS t2
    ON t1.patient_id = t2.patient_id
GROUP BY age_group
ORDER BY number_of_diagnoses DESC;

-- =========================================================
-- 2. DIAGNOSIS CLASSIFICATION
-- =========================================================

-- Question 2: How many lesions were classified as malignant or benign?

SELECT
    CASE
        WHEN diagnostic IN ('MEL', 'SCC', 'BCC') THEN 'Malignant'
        WHEN diagnostic IN ('ACK', 'SEK', 'NEV') THEN 'Benign'
        ELSE 'Other'
    END AS diagnosis_classification,
    COUNT(*) AS number_of_lesions
FROM table2
GROUP BY diagnosis_classification
ORDER BY number_of_lesions DESC;

-- =========================================================
-- 3. DEMOGRAPHIC DISTRIBUTION
-- =========================================================

-- Question 3: What is the gender distribution of diagnosed patients?

SELECT
    gender,
    COUNT(*) AS patient_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        1
    ) AS percentage
FROM table1
GROUP BY gender
ORDER BY patient_count DESC;

-- Question 4: How are malignant and benign lesions distributed by gender?

SELECT
    t1.gender,
    CASE
        WHEN t2.diagnostic IN ('MEL', 'SCC', 'BCC') THEN 'Malignant'
        WHEN t2.diagnostic IN ('ACK', 'SEK', 'NEV') THEN 'Benign'
        ELSE 'Other'
    END AS diagnosis_classification,
    COUNT(*) AS number_of_lesions
FROM table1 AS t1
INNER JOIN table2 AS t2
    ON t1.patient_id = t2.patient_id
GROUP BY
    t1.gender,
    diagnosis_classification
ORDER BY
    t1.gender,
    number_of_lesions DESC;

-- =========================================================
-- 4. RISK FACTOR ANALYSIS
-- =========================================================

-- Question 5: How does lesion classification vary by smoking status?

SELECT
    t1.smoke,
    CASE
        WHEN t2.diagnostic IN ('MEL', 'SCC', 'BCC') THEN 'Malignant'
        WHEN t2.diagnostic IN ('ACK', 'SEK', 'NEV') THEN 'Benign'
        ELSE 'Other'
    END AS diagnosis_classification,
    COUNT(*) AS number_of_lesions
FROM table1 AS t1
INNER JOIN table2 AS t2
    ON t1.patient_id = t2.patient_id
GROUP BY
    t1.smoke,
    diagnosis_classification
ORDER BY
    t1.smoke,
    number_of_lesions DESC;

-- Question 5: What proportion of lesions were malignant by smoking status?

SELECT
    t1.smoke AS smoker,
    COUNT(*) AS total_lesions,
    COUNT(*) FILTER (
        WHERE t2.diagnostic IN ('MEL', 'SCC', 'BCC')
    ) AS malignant_lesions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE t2.diagnostic IN ('MEL', 'SCC', 'BCC')
        ) / COUNT(*),
        1
    ) AS malignant_percentage
FROM table1 AS t1
INNER JOIN table2 AS t2
    ON t1.patient_id = t2.patient_id
GROUP BY t1.smoke
ORDER BY malignant_percentage DESC;

-- Question 6: What proportion of lesions were malignant by alcohol consumption?

SELECT
    t1.drink AS alcohol_consumption,
    COUNT(*) AS total_lesions,
    COUNT(*) FILTER (
        WHERE t2.diagnostic IN ('MEL', 'SCC', 'BCC')
    ) AS malignant_lesions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE t2.diagnostic IN ('MEL', 'SCC', 'BCC')
        ) / COUNT(*),
        1
    ) AS malignant_percentage
FROM table1 AS t1
INNER JOIN table2 AS t2
    ON t1.patient_id = t2.patient_id
GROUP BY t1.drink
ORDER BY malignant_percentage DESC;

-- Question 7: What proportion of lesions were malignant by pesticide exposure?

SELECT
    t1.pesticide AS pesticide_exposure,
    COUNT(*) AS total_lesions,
    COUNT(*) FILTER (
        WHERE t2.diagnostic IN ('MEL', 'SCC', 'BCC')
    ) AS malignant_lesions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE t2.diagnostic IN ('MEL', 'SCC', 'BCC')
        ) / COUNT(*),
        1
    ) AS malignant_percentage
FROM table1 AS t1
INNER JOIN table2 AS t2
    ON t1.patient_id = t2.patient_id
GROUP BY t1.pesticide
ORDER BY malignant_percentage DESC;

-- =========================================================
-- 5. LESION CHARACTERISTICS
-- =========================================================

-- Question 8: What is the average lesion diameter by diagnosis?

SELECT
    diagnostic,
    ROUND(
        AVG((diameter_1 + diameter_2) / 2.0)::numeric,
        2
    ) AS average_diameter
FROM table2
GROUP BY diagnostic
ORDER BY average_diameter DESC;

-- Question 9: How does recorded lesion growth vary by classification?

SELECT
    CASE
        WHEN diagnostic IN ('MEL', 'SCC', 'BCC') THEN 'Malignant'
        WHEN diagnostic IN ('ACK', 'SEK', 'NEV') THEN 'Benign'
        ELSE 'Other'
    END AS diagnosis_classification,
    COUNT(*) AS total_lesions,
    COUNT(*) FILTER (
        WHERE grew = TRUE
    ) AS growing_lesions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE grew = TRUE
        ) / COUNT(*),
        1
    ) AS growing_percentage
FROM table2
GROUP BY diagnosis_classification
ORDER BY growing_percentage DESC;

-- Question 10: Which symptoms were most commonly recorded?

SELECT
    'Itch' AS symptom,
    COUNT(*) FILTER (WHERE itch = TRUE) AS symptom_count
FROM table2

UNION ALL

SELECT
    'Hurt',
    COUNT(*) FILTER (WHERE hurt = TRUE)
FROM table2

UNION ALL

SELECT
    'Bleed',
    COUNT(*) FILTER (WHERE bleed = TRUE)
FROM table2

UNION ALL

SELECT
    'Elevation',
    COUNT(*) FILTER (WHERE elevation = TRUE)
FROM table2

ORDER BY symptom_count DESC;