--=====================
-- DUPLICATE KEY CHECK
--=====================
SELECT
  NEWID, REF_YR, quarter, COUNT(*) AS pr_key
FROM analytics.final_engel
GROUP BY NEWID, REF_YR, quarter
HAVING COUNT(*) > 1;

--=====================
-- CHECK MISSING VALUE
--=====================
SELECT COUNT(*) 
FROM analytics.final_engel
WHERE food_share IS NULL
   OR quarterly_income IS NULL;

--========================
-- FOOD SHARE RANGE CHECK
--========================

SELECT MIN(food_share), MAX(food_share)
FROM analytics.final_engel;

SELECT food_share
FROM analytics.final_engel
WHERE
  food_share > 1
  OR food_share < 0;

--==================
-- TIME RANGE CHECK
--==================

SELECT
  REF_YR,
  quarter,
  COUNT(*) AS n_obs
FROM analytics.final_engel
GROUP BY REF_YR, quarter