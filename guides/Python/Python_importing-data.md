---
title: 'Python: Importing Data'
output:
  html_document:
    keep_md: yes
---



Last Updated: 2023-12-11

In this session, we'll learn how to import data from Excel and CSV files into Python for analysis using the pandas and numpy libraries. By the end of this workshop, participants will be able to import data, handle missing values, assign appropriate data types to variables, and save the data for subsequent analys

First, import the necessary libraries


```python
import pandas as pd
import numpy as np
```

CSV (Comma Separated Values) files can be easily read with pandas using read_csv():


```python
csv_data = pd.read_csv("../data/gapminder.csv")
print(csv_data.head())
```

```
##        country continent  year  lifeExp       pop   gdpPercap
## 0  Afghanistan      Asia  1952   28.801   8425333  779.445314
## 1  Afghanistan      Asia  1957   30.332   9240934  820.853030
## 2  Afghanistan      Asia  1962   31.997  10267083  853.100710
## 3  Afghanistan      Asia  1967   34.020  11537966  836.197138
## 4  Afghanistan      Asia  1972   36.088  13079460  739.981106
```

To read a CSV file directly from a URL into a Jupyter notebook using the pandas library in Python, you can pass the URL string to the pd.read_csv() function directly.

The URL for the data is: `https://raw.githubusercontent.com/jstaf/gapminder/master/gapminder/gapminder.csv`


```python
data = pd.read_csv("https://raw.githubusercontent.com/jstaf/gapminder/master/gapminder/gapminder.csv")
```

## Missing data

Pandas is quite capable of recognizing common indicators of missing data when loading a dataset. By default, it recognizes the following as NaN or missing values:

`'', '#N/A', '#N/A N/A', '#NA', '-1.#IND', '-1.#QNAN', '-NaN', '-nan', '1.#IND', '1.#QNAN', 'N/A', 'NA', 'NULL', 'NaN', 'n/a', 'nan', 'null'.`

However, if your dataset uses other notations to represent missing values (like `99` or an empty space, ` `), you need to specify them manually using the `na_values` parameter as demonstrated in the following example.


```python
na_values = ["99", " "]
csv_data_nas_custom = pd.read_csv('../data/gapminder_nas.csv', na_values=na_values)
csv_data_nas_custom.info()
```

```
## <class 'pandas.core.frame.DataFrame'>
## RangeIndex: 1704 entries, 0 to 1703
## Data columns (total 6 columns):
##  #   Column     Non-Null Count  Dtype  
## ---  ------     --------------  -----  
##  0   country    1704 non-null   object 
##  1   continent  1704 non-null   object 
##  2   year       1487 non-null   float64
##  3   lifeExp    1512 non-null   float64
##  4   pop        1481 non-null   float64
##  5   gdpPercap  1485 non-null   float64
## dtypes: float64(4), object(2)
## memory usage: 80.0+ KB
```


```python
csv_data_nas_custom.head()
```

```
##        country continent    year  lifeExp         pop   gdpPercap
## 0  Afghanistan      Asia  1952.0      NaN   8425333.0  779.445314
## 1  Afghanistan      Asia  1957.0   30.332   9240934.0  820.853030
## 2  Afghanistan      Asia  1962.0   31.997  10267083.0  853.100710
## 3  Afghanistan      Asia  1967.0   34.020  11537966.0  836.197138
## 4  Afghanistan      Asia  1972.0   36.088  13079460.0  739.981106
```


```python
#help(pd.read_csv)
```

## File header

When CSV has header in first row (default behavior)


```python
data_with_header = pd.read_csv('../data/gapminder.csv')
```


```python
data_with_header.head()
```

```
##        country continent  year  lifeExp       pop   gdpPercap
## 0  Afghanistan      Asia  1952   28.801   8425333  779.445314
## 1  Afghanistan      Asia  1957   30.332   9240934  820.853030
## 2  Afghanistan      Asia  1962   31.997  10267083  853.100710
## 3  Afghanistan      Asia  1967   34.020  11537966  836.197138
## 4  Afghanistan      Asia  1972   36.088  13079460  739.981106
```

When CSV has header in the second row (index starts at 0)


```python
data_header_in_second_row = pd.read_csv('../data/gapminder.csv', header=1)
data_header_in_second_row.head()
```

```
##    Afghanistan  Asia  1952  28.801   8425333  779.4453145
## 0  Afghanistan  Asia  1957  30.332   9240934   820.853030
## 1  Afghanistan  Asia  1962  31.997  10267083   853.100710
## 2  Afghanistan  Asia  1967  34.020  11537966   836.197138
## 3  Afghanistan  Asia  1972  36.088  13079460   739.981106
## 4  Afghanistan  Asia  1977  38.438  14880372   786.113360
```

When CSV does not have a header


```python
data_without_header = pd.read_csv('../data/gapminder.csv', header=None)
data_without_header.head()
```

```
##              0          1     2        3         4            5
## 0      country  continent  year  lifeExp       pop    gdpPercap
## 1  Afghanistan       Asia  1952   28.801   8425333  779.4453145
## 2  Afghanistan       Asia  1957   30.332   9240934  820.8530296
## 3  Afghanistan       Asia  1962   31.997  10267083    853.10071
## 4  Afghanistan       Asia  1967    34.02  11537966  836.1971382
```

## Importing Excel Files

For Excel files, use read_excel():


```python
excel_data = pd.read_excel("../data/gapminder.xlsx")
print(excel_data.head())
```

```
##        country continent  year  lifeExp       pop   gdpPercap
## 0  Afghanistan      Asia  1952   28.801   8425333  779.445314
## 1  Afghanistan      Asia  1957   30.332   9240934  820.853030
## 2  Afghanistan      Asia  1962   31.997  10267083  853.100710
## 3  Afghanistan      Asia  1967   34.020  11537966  836.197138
## 4  Afghanistan      Asia  1972   36.088  13079460  739.981106
```

You can specify specific sheets and ranges with the sheet_name and usecols arguments.


```python
# Read data from a specific sheet and range
data_xls = pd.read_excel('../data/gapminder.xlsx', sheet_name='gapminder', engine='openpyxl', usecols='A:D', nrows=5)
print(data_xls)
```

```
##        country continent  year  lifeExp
## 0  Afghanistan      Asia  1952   28.801
## 1  Afghanistan      Asia  1957   30.332
## 2  Afghanistan      Asia  1962   31.997
## 3  Afghanistan      Asia  1967   34.020
## 4  Afghanistan      Asia  1972   36.088
```

## Exporting Data

Save you  data back to CSV or Excel:

**Save to CSV**


```python
csv_data.to_csv('export_csv_data.csv')
```

If you want to write a CSV without the row index (similar to row.names = FALSE in R), you can set the index parameter of to_csv to False.



```python
csv_data.to_csv('export_csv_data.csv',index=False)
```

To represent missing values with a custom string (like na = "99" in R), you can use the na_rep parameter of to_csv.


```python
csv_data_nas_custom.to_csv('gapminder_custom_na.csv', index=False, na_rep='99')
csv_data_nas_custom.head()
```


* **index=False** prevents pandas from writing row names (index) to the CSV file.
* **na_rep='99'** sets the string to use for missing values. Replace '99' with your desired representation for missing values.

**Save to Excel**


```python
csv_data.to_excel('export_excel__data.xlsx', index=False)
```

**Saving a Jupyter Notebook**

Save Within Jupyter Interface

Simply press Ctrl + S on your keyboard (or Cmd + S on a Mac).

Alternatively, click on the floppy disk icon in the upper-left corner of the toolbar, or go to the File menu and select Save.

Autosave

Jupyter Notebooks autosave your work every few minutes.

Exporting a Jupyter Notebook

You can export your Jupyter Notebook to various formats, like HTML, PDF, or Python script (.py), etc., through the Jupyter Notebook interface. Below are the general steps:

* Go to the File Menu > In your Jupyter Notebook interface, go to the File menu at the top left of the toolbar.
* Navigate to Download as > Under the File menu, hover over or click on Save and Export Notebook As. You'll see a list of various formats.
* Select a Format > Choose the format to which you want to export your notebook. Options might include:   
  * HTML (.html): A static webpage.
  * LaTeX (.tex): A LaTeX document.
  * PDF via LaTeX (.pdf): Directly as a PDF.
  * Markdown (.md): As a Markdown file.
  * Python (.py): As a Python script.
* The notebook will be downloaded to your computer in the selected format.


## References

The content presented in this document is based on the functionalities and utilities provided by Python, specifically using the Pandas, NumPy, as well as Jupyter Notebook for an interactive programming environment. For detailed documentation, best practices, and more examples related to the functions and methods used, refer to the official documentation and relevant resources listed below:

## Official Documentation

**Python Official Documentation**: [Python Documentation](https://docs.python.org/3/)

**Pandas Official Documentation**: [Pandas Docs](https://pandas.pydata.org/pandas-docs/stable/index.html)

**NumPy Official Documentation**: [NumPy Docs](https://numpy.org/doc/stable/)

**Jupyter Notebook Official Documentation**: [Jupyter Notebook Docs](https://jupyter-notebook.readthedocs.io/en/stable/)cument.
