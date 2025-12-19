---
title: 'Importing Data Sets'
output:
  html_document:
    keep_md: yes
---

# Importing Data Sets


### We will use the following code to import our data for the workshop.

### Three datasets from GitHub are imported:
* Two in CSV format: gapminder and gapminder_nas.
* One in Excel format: gapminder_xlsx.
* The data is read into separate DataFrame objects using pandas.

### After importing:
* The two CSV datasets are saved locally as '.csv' files.
* The Excel dataset is saved locally as an '.xlsx' file.


```python
import pandas as pd

# Reading CSV files from GitHub
gapminder = pd.read_csv('https://raw.githubusercontent.com/csc-ubc-okanagan/workshops/a091bc6eae8b9045866c28dbd1848c7e072db5b1/data/gapminder.csv')
gapminder_nas = pd.read_csv('https://raw.githubusercontent.com/csc-ubc-okanagan/workshops/a091bc6eae8b9045866c28dbd1848c7e072db5b1/data/gapminder_nas.csv')

# Reading Excel file from GitHub
gapminder_xlsx = pd.read_excel('https://raw.githubusercontent.com/csc-ubc-okanagan/workshops/a091bc6eae8b9045866c28dbd1848c7e072db5b1/data/gapminder.xlsx', engine='openpyxl')
# Exporting CSV files
gapminder.to_csv('gapminder.csv', index=False)
gapminder_nas.to_csv('gapminder_nas.csv', index=False)

# Exporting Excel file
gapminder_xlsx.to_excel('gapminder.xlsx', index=False, engine='openpyxl')
```
