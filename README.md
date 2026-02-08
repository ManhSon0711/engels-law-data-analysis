## Project Overview

This project explores Engel’s Law—the economic principle that households tend to spend a smaller share of their budget on food as their income increases.

The analysis builds a clean, household-level dataset and estimates the relationship between household income and the share of expenditure devoted to food using standard regression techniques.

Data preparation is carried out in PostgreSQL, while the regression analysis is performed in Python. All steps are organized into a reproducible workflow so that the results can be easily replicated and extended.

## Data Source

This project uses public-use microdata from the U.S. Consumer Expenditure Survey (CE) published by the U.S. Bureau of Labor Statistics (BLS).

Household income is taken from the Family-Level Interview (FMLI) files, while food expenditure is constructed from the Monthly Interview (MTBI) files using food-related UCC categories.

Raw survey data are processed locally using PostgreSQL and are not included in this repository due to data size and licensing restrictions. The final analytical dataset is available at: data/processed/engel_law.csv

> **Note:**
> Public-use CE Interview microdata (including 2024 releases) can be downloaded from:
> https://www.bls.gov/cex/pumd_data.htm

This page provides access to both FMLI and MTBI files along with detailed documentation.

## Data Processing

All data cleaning, aggregation, and transformation steps are implemented in PostgreSQL and documented in the SQL scripts located in the sql/ directory.
The pipeline constructs household–quarter level measures of income, total expenditure, and food expenditure share.

## Methodology

A detailed discussion of methodological choices is provided in docs/methodology.md

## Results

The results show a negative relationship between income and food expenditure share, consistent with Engel’s Law.

Key outputs:

Regression summary: results/regression_result.md

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
    engel_law.ipynb
  results/
    results_interpretation.md
    regression_food_share_income_results.txt
    regression_food_share_log_income_result.txt
  figures/
    regline_income_food_share.png
    regline_log_income_food_share.png
    scatter_income_food_share.png
    scatter_log_income_food_share.png
  docs/
    Entity Relationship Diagram.pdf
    methodology.md
  README.md


## Reproducibility

After generating the processed dataset using the SQL pipeline, the analysis can be reproduced by running:

python src/engel_law.ipynb

## Note
This project is intended for educational and research purposes and demonstrates a complete data analysis workflow, from raw survey processing to econometric estimation and interpretation.

A detailed interpretation of regression results is provided in
`results/results_interpretation.md`.