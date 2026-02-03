## Project Overview

This project examines Engel’s Law, which states that as household income increases, the proportion of expenditure devoted to food declines.
The analysis constructs a clean household-level dataset and estimates an Engel curve relating food expenditure share to income.

The workflow combines PostgreSQL-based data processing with Python regression analysis in a reproducible pipeline.

## Data Source

The project uses public-use microdata from the U.S. Consumer Expenditure Survey (CE), published by the U.S. Bureau of Labor Statistics (BLS).

Household income is obtained from the Family-Level Interview (FMLI) files.

Food expenditure is constructed from the Monthly Interview (MTBI) files using UCC food categories.

Raw survey data are processed locally using PostgreSQL and are not included in this repository due to data size and licensing considerations.
The final analytical dataset is available at:

data/processed/engel_law.csv

## Data Processing

All data cleaning, aggregation, and transformation steps are implemented in PostgreSQL and documented in the SQL scripts located in the sql/ directory.
The pipeline constructs household–quarter level measures of income, total expenditure, and food expenditure share.

## Methodology

A detailed discussion of methodological choices is provided in docs/methodology.md

## Results

The results show a negative relationship between income and food expenditure share, consistent with Engel’s Law.

Key outputs:

Regression summary: results/regression_result.txt

Visualizations: figures/

## Repository Structure
engel-law/
  data/
    README.md
    processed/
      engel_law.csv
  sql/
    01_setup_schemas.sql
    02_import_raw_tables.sql
    03_build_raw_fmli_all_and_mtbi_all.sql
    04_clean_food_share_quarter.sql
    05_clean_income_quarter.sql
    06_build_analytics_final_engel.sql
    07_quality_checks.sql
  src/
    run_regression.py
  results/
    regression_result.txt
  figures/
    Engel_Law_regline.png
    Log_Quaterly_Income_and_Food_Share_Relationship.png
  docs/
    Entity Relationship Diagram.pdf
    methodology.txt
  README.md


## Reproducibility

After generating the processed dataset using the SQL pipeline, the analysis can be reproduced by running:

python src/run_regression.py

## Note
This project is intended for educational and research purposes and demonstrates a complete data analysis workflow, from raw survey processing to econometric estimation and interpretation.