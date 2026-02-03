# import used library
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.api as sm


# -------------------
# TAKE THE FILE PATH
# -------------------
CSV_PATH = r"data\processed\engel_law.csv"

# --------------
# READ THE FILE
# --------------
df = pd.read_csv(CSV_PATH)

#check
#print("Columns:", df.columns.tolist())
#print(df.head())

df["food_share"] = pd.to_numeric(df["food_share"],errors = "coerce")
df["quarterly_income"] = pd.to_numeric(df["quarterly_income"],errors = "coerce")

# ---------------
# CLEAN THE DATA
# ---------------

# delete the missing (have done in cleanning step)
df_clean = df.dropna(subset=["quarterly_income","food_share"]).copy()

#only take the row where quarterlyincome > 0 (have done in cleanning step)
df_clean = df_clean[df_clean["quarterly_income"] > 0].copy()

#only take the row where food_share >= 0 and <= 1 (have done in cleanning step)
df_clean = df_clean[(df_clean["food_share"] >= 0)&(df_clean["food_share"] <= 1)].copy()

#check
#print("Number of rows is:",len(df_clean))
#print(df_clean[["quarterly_income", "food_share"]].describe())

# ------------------
# CREATE LOG INCOME
# ------------------

df_clean["log_income"] = np.log(df_clean["quarterly_income"])

# ---------------------
# DRAW SCATTER DIAGRAM
# ---------------------

# draw the scatter diagram about the relationship log quarterly income and food share
plt.figure()
plt.scatter(df_clean["log_income"], df_clean["food_share"], alpha = 0.3)
plt.xlabel("Log (Quarterly Income)")
plt.ylabel("Food Share")
plt.title("Log (Quarterly Income) and Food Share Relationship")
plt.tight_layout()
plt.savefig("Log_Quarterly_Income_and_Food_Share_Relationship.png",dpi=200)
plt.close()

#add the constant for the line
x = sm.add_constant(df_clean["log_income"])

#estimate the OLS line with HC3 robust
model = (sm.OLS(df_clean["food_share"],x)).fit(cov_type="HC3")

#check
#print(model.summary())

# ------------------------------------------------
# DRAW THE REGRESSION LINE ON THE SCATTER DIAGRAM
# ------------------------------------------------

a = df_clean["log_income"].min()
b = df_clean["log_income"].max()
x_line = np.linspace(a,b,200)
y_line = model.params["const"] + model.params["log_income"]*x_line

plt.figure()
plt.scatter(df_clean["log_income"],df["food_share"],alpha=0.3)
plt.plot(x_line, y_line, label="OLS line", linewidth = 2)
plt.xlabel("Log (Quarterly Income)")
plt.ylabel("Food Share")
plt.title("Engel's Law: Food Share and Log (Quarterly Income)")
plt.tight_layout()
plt.savefig("Engel_Law_regline.png",dpi=200)
plt.close()

# --------------------------
# SAVE SUMMARY FILE AS TEXT
# --------------------------

with open("regression_result.txt","w",encoding="utf-8") as f:
    f.write("Model : FOOD_SHARE ~ LOG_INCOME\n\n")
    f.write(model.summary().as_text())
