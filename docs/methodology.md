## Empirical Strategy

Based on raw data collected from household survey interviews, this project constructs a household-level dataset to empirically examine Engel’s Law. The analysis focuses on the relationship between household income and the share of expenditure allocated to food, using survey-based observations to document a well-established consumption pattern.

## Data Source

Data source:
The analysis uses public-use microdata from the U.S. Consumer Expenditure Survey (CE), conducted by the U.S. Bureau of Labor Statistics (BLS).

Type of data:
The data consist of household-level survey information collected through interview-based questionnaires and are observational in nature.

Unit of analysis:
The unit of analysis is the household, with observations aggregated at the quarterly level.

Data modules:
Household income is obtained from the Family-Level Interview (FMLI) files, while food expenditure is constructed from the Monthly Interview (MTBI) files using food-related UCC categories.

## Data Processing and Variable Construction

Raw data problem:
The raw survey data are large in scale, containing a high number of observations and variables, and are distributed across multiple tables designed for different survey purposes. In addition, the data are spread across several modules and are not organized in a consolidated time-based structure, as the same household may be interviewed multiple times at different points in time.

Define used tables:
- As a first step in the data processing procedure, the relevant survey modules are identified. The analysis relies on two main components of the Consumer Expenditure Survey: the Family-Level Interview (FMLI) and the Monthly Interview (MTBI) modules.

- The FMLI module consists of five tables—fmli241x, fmli242, fmli243, fmli244, and fmli251—which provide household-level income information. The MTBI module also includes five tables—mtbi241x, mtbi242, mtbi243, mtbi244, and mtbi251x—which contain detailed expenditure records used to construct food expenditure measures.

Define used variables:
- The next step involves identifying the relevant variables required for the analysis. From the FMLI module, the selected variables include NEWID, which uniquely identifies each household, QINTRVYR and QINTRVMO, which indicate the interview year and month, and FINCBTAX, which measures total household income before taxes over the previous twelve months.

> **Note**:
> The analysis uses FINCBTAX rather than individual-level income variables such as SALARYX, as the focus of the study is on household-level income consistent with the unit of analysis and the theoretical framework of Engel’s Law.

- From the MTBI module, the selected variables include NEWID, which identifies the household, REF_YR and REF_MO, which record the year and month of each transaction, UCC (Uniform Commercial Code), which classifies the type of expenditure, and COST, which captures the monetary value of each transaction. These variables are used to construct detailed measures of household food expenditure over time.

- After selecting the required variables, the tables are merged to address the lack of a unified time structure in the raw data. To standardize the time dimension, observations are classified into quarterly periods, with each quarter representing a three-month interval.

Define the keys:
- Following this aggregation, the combination of NEWID, QUARTER, and the interview or reference year (either REF_YR or QINTRVYR) serves as a candidate key, ensuring a unique household–quarter observation for subsequent analysis.

Clean Data:
- The dataset is then cleaned by removing observations with missing values and excluding records with invalid month information, specifically where the reported month falls outside the range of 1 to 12.

- food share is subsequently constructed by dividing total food expenditure by total household expenditure. Food expenditure is defined as the sum of expenditures classified under food-related UCC codes (ranging from 100000 to 299999), while total expenditure is computed as the sum of all reported expenditures. Observations with non-positive total expenditure are excluded to ensure that the food share measure is well-defined.

- Next, a income table is constructed. Quarterly household income is calculated as the average income within each quarter, based on reported household income over the most recent twelve-month period.

- The income data are cleaned by excluding observations with invalid month values (outside the range of 1 to 12), removing records with missing values, and retaining only observations with positive reported twelve-month household income (FINCBTAX). This ensures that the constructed quarterly income measure is consistent and suitable for subsequent analysis.

- Finally, the food expenditure share table is joined with the household income table to construct the final analytical dataset, final_engel, which serves as the input for the econometric analysis. Observations with non-positive quarterly income and food expenditure share values outside the [0,1] range are excluded to ensure the validity of the analytical sample.

## Econometric Specification

- Using the final analytical dataset, the study estimates standard Engel curve models to examine the relationship between household income and food expenditure share at the household–quarter level.

- Two alternative functional forms are considered. The first is a linear specification, in which food expenditure share is regressed directly on household income, capturing the absolute change in food expenditure share associated with changes in income. The second is a semi-log specification, in which food expenditure share is regressed on the logarithm of household income, allowing the relationship to be interpreted in terms of proportional changes in income.

- Consistent with Engel’s Law, the coefficient on income is expected to be negative in both specifications, indicating that the share of expenditure devoted to food declines as household income increases.

## Estimation and Implementation

The econometric models are estimated using ordinary least squares (OLS) on the final household–quarter dataset. All data processing and estimation steps are implemented using a reproducible workflow combining PostgreSQL, Miniconda and Python.

## Methodological Limitations

The empirical analysis is subject to several limitations. First, the econometric models are not intended to prove Engel’s Law or to establish causal relationships, but rather to assess whether the observed data provide evidence that is inconsistent with the Engel curve relationship.

Second, the estimated models capture average relationships between household income and food expenditure share and therefore describe general consumption patterns. As such, the results are not designed for prediction at the individual household level or for forecasting purposes.