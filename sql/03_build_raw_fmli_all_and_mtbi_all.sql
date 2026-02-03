--======================
-- UNION ALL RAW TABLES
--======================

CREATE TABLE raw.fmli_all AS
SELECT * FROM raw.fmli241x
UNION ALL
SELECT * FROM raw.fmli242
UNION ALL 
SELECT * FROM raw.fmli243
UNION ALL
SELECT * FROM raw.fmli244
UNION ALL 
SELECT * FROM raw.fmli251;

CREATE TABLE raw.mtbi_all AS
SELECT * FROM raw.mtbi241x
UNION ALL
SELECT * FROM raw.mtbi242
UNION ALL 
SELECT * FROM raw.mtbi243
UNION ALL
SELECT * FROM raw.mtbi244
UNION ALL 
SELECT * FROM raw.mtbi251;