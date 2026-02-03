
--==================================
-- CREATE FINAL ANALYTICS TABLE TO 
--==================================

DROP TABLE IF EXISTS analytics.final_engel;

CREATE TABLE analytics.final_engel AS
SELECT
  fs.NEWID,
  fs.REF_YR,
  fs.quarter,
  fs.food_share,
  i.quarterly_income
FROM clean.food_share fs
JOIN clean.income i
  ON fs.NEWID = i.NEWID
 AND fs.REF_YR = i.QINTRVYR
 AND fs.quarter = i.quarter;
