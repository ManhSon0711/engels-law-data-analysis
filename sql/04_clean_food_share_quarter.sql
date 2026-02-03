--===========================
-- CREATE A FOOD SHARE TABLE
--===========================

/**
- Problem:
  MTBI records individual expenditure items without transaction-level time order,
  making raw spending data difficult to interpret over time.

- Method:
  Group expenditures into calendar quarters by interview year using the reference
  month, then aggregate at the household–year–quarter level.
*/

DROP TABLE IF EXISTS clean.food_share;

CREATE TABLE clean.food_share AS
WITH base AS ( 
  SELECT 
    NEWID,
    REF_YR,
    CASE
    -- month -> quarter
      WHEN REF_MO IN (1,2,3) THEN 1
      WHEN REF_MO IN (4,5,6) THEN 2
      WHEN REF_MO IN (7,8,9) THEN 3
      WHEN REF_MO IN (10,11,12) THEN 4
    END AS quarter,
    UCC,
    COST
  FROM raw.mtbi_all
  WHERE 
    REF_MO BETWEEN 1 AND 12
    AND NEWID IS NOT NULL
    AND REF_YR IS NOT NULL
    AND COST IS NOT NULL
    AND UCC IS NOT NULL
    -- delete all null case
),
total AS(
  SELECT
    NEWID,
    REF_YR,
    quarter,
    SUM(COST) AS total_exp
  FROM base
  GROUP BY NEWID, REF_YR, quarter
  HAVING SUM(COST) > 0 -- just take the total_exp > 0
),
food AS(
  SELECT
    NEWID,
    REF_YR,
    quarter,
    SUM(COST) AS food_exp
  FROM base
  WHERE UCC BETWEEN 100000 AND 299999
  -- uniform comercial code for food 
  -- is between 100000 and 299999
  GROUP BY NEWID, REF_YR, quarter
)
SELECT
  t.NEWID,
  t.REF_YR,
  t.quarter,
  COALESCE(f.food_exp,0) AS food_exp, 
  -- assure not NULL after using LEFT JOIN 
  t.total_exp,
  COALESCE(f.food_exp,0)*1.0/t.total_exp AS food_share
  -- assign float division
  FROM total t
  LEFT JOIN food f
  ON t.NEWID = f.NEWID
  AND t.REF_YR = f.REF_YR
  AND t.quarter = f.quarter;
