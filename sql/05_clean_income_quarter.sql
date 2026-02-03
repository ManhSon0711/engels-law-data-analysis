--=====================
-- CREATE INCOME TABLE
--=====================

/**
- Problem:
  FINCBTAX in the FMLI file reports total household income for the past
  12 months, not income earned in a specific quarter.

- Method:
  Approximate quarterly income by dividing the 12-month income equally
  across four quarters of the interview year to align with quarterly
  expenditure data.
*/

DROP TABLE IF EXISTS clean.income;

CREATE TABLE clean.income AS
SELECT
  NEWID,
  QINTRVYR,
  CASE
    WHEN QINTRVMO IN (1,2,3) THEN 1
    WHEN QINTRVMO IN (4,5,6) THEN 2
    WHEN QINTRVMO IN (7,8,9) THEN 3
    WHEN QINTRVMO IN (10,11,12) THEN 4
  END AS quarter,
  AVG(FINCBTAX)*1.0/4 AS quarterly_income
  -- average income for 3 months (a quarter)
  FROM raw.fmli_all
    WHERE QINTRVMO BETWEEN 1 AND 12
    AND FINCBTAX > 0 
    AND NEWID IS NOT NULL
    AND QINTRVYR IS NOT NULL
  GROUP BY NEWID, QINTRVYR, quarter;
