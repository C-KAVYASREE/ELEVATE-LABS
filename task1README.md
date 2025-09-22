import pandas as pd

# Load dataset
file_path = "marketing_campaign.csv"   # change path if needed
df = pd.read_csv(file_path, sep="\t")

# ------------------ Data Cleaning ------------------

# 1. Remove duplicates
df.drop_duplicates(inplace=True)

# 2. Handle missing values (Income has 24 missing)
df['Income'].fillna(df['Income'].median(), inplace=True)

# 3. Standardize categorical text values
df['Education'] = df['Education'].str.strip().str.title()
df['Marital_Status'] = df['Marital_Status'].str.strip().str.title()

# 4. Convert Dt_Customer to datetime
df['Dt_Customer'] = pd.to_datetime(df['Dt_Customer'], format='%d-%m-%Y', errors='coerce')

# 5. Rename columns (lowercase + underscores)
df.columns = df.columns.str.lower().str.replace(" ", "_")

# 6. Fix data types (ensure integers where applicable)
df['year_birth'] = df['year_birth'].astype(int)
