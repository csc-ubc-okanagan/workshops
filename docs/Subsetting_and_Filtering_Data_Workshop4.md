## Subsetting and Filtering Data

Let's import out libraries in Python.


```python
#import all libraries required for this data. 
import pandas as pd
import numpy as np
```

Now, just as before, let's import data files we will use. Simply run the following commands to load them in your notebook.


```python
# Reading CSV files from GitHub
gapminder = pd.read_csv('https://raw.githubusercontent.com/csc-ubc-okanagan/workshops/a091bc6eae8b9045866c28dbd1848c7e072db5b1/data/gapminder.csv')
gapminder.to_csv('gapminder.csv', index=False)
```

### Select a Single Variable of a Dataframe
#### Task: Extract the 'lifeExp' column from the 'gapminder' dataframe and display its first five entries along with its data type.


```python
# Select a single variable of a dataframe
lifeExp = gapminder['lifeExp']
```


```python
lifeExp.head()
```




    0    28.801
    1    30.332
    2    31.997
    3    34.020
    4    36.088
    Name: lifeExp, dtype: float64




```python
print(type(lifeExp))
```

    <class 'pandas.core.series.Series'>


* ### `[[]]` to return DataFrame 
* ### `[]` or loc to return Series

### But why do we need a DataFrame instead?
We might want to return a DataFrame because:
* it preserves column labels
* it facilitates data interpretation
* it ensures method availability for specialized operations
* it offers the flexibility to easily extend the structure with new columns as needed

- **Using double brackets `[[]]` with a dataframe**
  - This preserves the data structure, returning a DataFrame.
  - `pop_preserved` is a DataFrame containing the 'pop' column.


```python
pop_preserved = gapminder[['pop']]
```

- **Type Display**
  - `type(pop_preserved)` displays that `pop_preserved` is of type DataFrame.


```python
type(pop_preserved)
```




    pandas.core.frame.DataFrame



- **Using `.loc` or a single bracket `[]`**
  - This simplifies the selection, returning a Series.
  - `pop_simple` is a Series.


```python
pop_simple = gapminder['pop']
type(pop_simple)
```




    pandas.core.series.Series



 - `type(pop_simple)` shows that `pop_simple` is of type Series.

#### The `.loc` equivalent of the code above


```python
pop_simple_loc = gapminder.loc[:, 'pop']
#[:,'pop'] retuns all rows in the gapminder dataset
type(pop_simple_loc)

```




    pandas.core.series.Series



## Selecting Specific Ranges with `.iloc`

`.iloc` is a pandas method used for **integer-location** based indexing.


```python
gapminder.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country</th>
      <th>continent</th>
      <th>year</th>
      <th>lifeExp</th>
      <th>pop</th>
      <th>gdpPercap</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1952</td>
      <td>28.801</td>
      <td>8425333</td>
      <td>779.445314</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1957</td>
      <td>30.332</td>
      <td>9240934</td>
      <td>820.853030</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1962</td>
      <td>31.997</td>
      <td>10267083</td>
      <td>853.100710</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1967</td>
      <td>34.020</td>
      <td>11537966</td>
      <td>836.197138</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1972</td>
      <td>36.088</td>
      <td>13079460</td>
      <td>739.981106</td>
    </tr>
  </tbody>
</table>
</div>




```python
gapminder.iloc[0, 0]
```




    'Afghanistan'



#### This is the same as the following:


```python
gapminder['country'][0]
```




    'Afghanistan'



- **`print(gapminder.iloc[0, 0])`**
  - This selects the element at the first row and first column of the `gapminder` DataFrame.
  - In other words, it retrieves the top-leftmost value.



```python
gapminder.iloc[1]
```




    country      Afghanistan
    continent           Asia
    year                1957
    lifeExp           30.332
    pop              9240934
    gdpPercap      820.85303
    Name: 1, dtype: object



- **`print(gapminder.iloc[1])`**
  - This selects the entire second row of the `gapminder` DataFrame.
  - It returns all columns for the second row as a `Series`.


```python
gapminder.iloc[0:5, 0:3]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country</th>
      <th>continent</th>
      <th>year</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1952</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1957</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1962</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1967</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1972</td>
    </tr>
  </tbody>
</table>
</div>



- **`print(gapminder.iloc[0:5, 0:3])`**
  - This selects a subsection of the DataFrame, specifically the first five rows and the first three columns.
  - The resulting output will be a smaller `DataFrame` with 5 rows and 3 columns.

## Differences between `.loc` and `.iloc`

- **`.loc`**:
  - **Label-based indexing**: Uses labels (names) to identify rows and columns.
  - Accepts **column/row names** as its argument.
  - Can use **boolean indexing**.
  - Example: `df.loc['row_name', 'column_name']`

- **`.iloc`**:
  - **Positional indexing**: Uses integer indices to access rows/columns.
  - Accepts **integer indices** as its argument.
  - Does **not** work with boolean indexing.
  - Example: `df.iloc[2, 3]` (third row, fourth column)



### Filtering Based on Conditions

# Filtering Based on Conditions in Pandas

When working with a Pandas DataFrame, you can filter your data based on specific conditions. This involves creating boolean masks using comparison operators and then applying these masks to your DataFrame using logical operators.

## Comparison Operators


| Operator | Description            |
|:--------:|:----------------------:|
| `!=`     | not equal to           |
| `==`     | equal to               |
| `<`      | less than              |
| `>`      | greater than           |
| `<=`     | less than or equal to  |
| `>=`     | equal to or greater than|


## Logical Operators


| Operator | Description           |
|:--------:|:---------------------:|
| `~`      | not (negation)        |
| `\|`      | or (element-wise OR)  |
| `&`      | and (element-wise AND)|



Remember to use parentheses around each condition when combining them with the logical operators to ensure correct order of operations. For instance:

```python
filtered_df = df[(df['column1'] > 10) & (df['column2'] != 'value')]


#### Task: Filter the `lifeExp` column to select values greater than 70.


```python
# Filtering based on conditions
lifeExp_gt_70 = lifeExp[lifeExp > 70]
lifeExp_gt_70.head()
```




    18    70.420
    19    72.000
    20    71.581
    21    72.950
    22    75.651
    Name: lifeExp, dtype: float64




```python
len(lifeExp_gt_70)
```




    493



 **How it Works**:
    - `lifeExp > 70` creates a Boolean mask where each value of `lifeExp` is checked against the condition (> 70). It returns `True` for values meeting the condition and `False` otherwise.
    - `lifeExp[lifeExp > 70]` uses this Boolean mask to select and keep only the `True` values from `lifeExp`.

### Filter the `gapminder` DataFrame to select rows where the value in the 'year' column is 1952.


```python
gapminder_1952 = gapminder[gapminder['year'] == 1952]
gapminder_1952.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country</th>
      <th>continent</th>
      <th>year</th>
      <th>lifeExp</th>
      <th>pop</th>
      <th>gdpPercap</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1952</td>
      <td>28.801</td>
      <td>8425333</td>
      <td>779.445314</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Albania</td>
      <td>Europe</td>
      <td>1952</td>
      <td>55.230</td>
      <td>1282697</td>
      <td>1601.056136</td>
    </tr>
    <tr>
      <th>24</th>
      <td>Algeria</td>
      <td>Africa</td>
      <td>1952</td>
      <td>43.077</td>
      <td>9279525</td>
      <td>2449.008185</td>
    </tr>
    <tr>
      <th>36</th>
      <td>Angola</td>
      <td>Africa</td>
      <td>1952</td>
      <td>30.015</td>
      <td>4232095</td>
      <td>3520.610273</td>
    </tr>
    <tr>
      <th>48</th>
      <td>Argentina</td>
      <td>Americas</td>
      <td>1952</td>
      <td>62.485</td>
      <td>17876956</td>
      <td>5911.315053</td>
    </tr>
  </tbody>
</table>
</div>



- **How it Works**:
    - `gapminder['year'] == 1952` creates a Boolean mask. Each row's 'year' value is checked against the condition (== 1952). This returns `True` for rows where the condition is met and `False` otherwise.
    - `gapminder[gapminder['year'] == 1952]` applies this Boolean mask to the `gapminder` DataFrame. This results in a new DataFrame with only the rows from the year 1952.

#### Task: Extract the coloumns 'country' and 'gdpPercap' for the Year 1952


```python
gdp_1952 = gapminder_1952[['country', 'gdpPercap']]
gdp_1952.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country</th>
      <th>gdpPercap</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Afghanistan</td>
      <td>779.445314</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Albania</td>
      <td>1601.056136</td>
    </tr>
    <tr>
      <th>24</th>
      <td>Algeria</td>
      <td>2449.008185</td>
    </tr>
    <tr>
      <th>36</th>
      <td>Angola</td>
      <td>3520.610273</td>
    </tr>
    <tr>
      <th>48</th>
      <td>Argentina</td>
      <td>5911.315053</td>
    </tr>
  </tbody>
</table>
</div>



- **How it Works**:
    - The double square brackets (`[[]]`) are used to select multiple columns from a DataFrame. This ensures the result is still a DataFrame.
    - `gapminder_1952[['country', 'gdpPercap']]` specifies the desired columns and extracts them from `gapminder_1952`, resulting in a new DataFrame `gdp_1952` containing only these two columns.

### Subsetting Rows Using `loc`

#### Task: use the `.loc` method to subset rows in the `gapminder` DataFrame based on a specific condition: the year being 1952


```python
gapminder.loc[gapminder['year'] == 1952].head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country</th>
      <th>continent</th>
      <th>year</th>
      <th>lifeExp</th>
      <th>pop</th>
      <th>gdpPercap</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Afghanistan</td>
      <td>Asia</td>
      <td>1952</td>
      <td>28.801</td>
      <td>8425333</td>
      <td>779.445314</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Albania</td>
      <td>Europe</td>
      <td>1952</td>
      <td>55.230</td>
      <td>1282697</td>
      <td>1601.056136</td>
    </tr>
    <tr>
      <th>24</th>
      <td>Algeria</td>
      <td>Africa</td>
      <td>1952</td>
      <td>43.077</td>
      <td>9279525</td>
      <td>2449.008185</td>
    </tr>
    <tr>
      <th>36</th>
      <td>Angola</td>
      <td>Africa</td>
      <td>1952</td>
      <td>30.015</td>
      <td>4232095</td>
      <td>3520.610273</td>
    </tr>
    <tr>
      <th>48</th>
      <td>Argentina</td>
      <td>Americas</td>
      <td>1952</td>
      <td>62.485</td>
      <td>17876956</td>
      <td>5911.315053</td>
    </tr>
  </tbody>
</table>
</div>



`gapminder[gapminder['year'] == 1952]` is the same as `gapminder.loc[gapminder['year'] == 1952]`

### Why Do We Use `.loc` ?

* The first one, gapminder[gapminder['year'] == 1952], is using boolean indexing directly on the DataFrame.
* The second one, gapminder.loc[gapminder['year'] == 1952], is using the .loc accessor with boolean indexing.
* The .loc accessor provides more flexibility in terms of selecting **specific rows and columns**, whereas the direct boolean indexing approach is more limited to **row-based** operations.


```python
gapminder.loc[gapminder['year'] == 1952, ['country', 'pop']].head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country</th>
      <th>pop</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Afghanistan</td>
      <td>8425333</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Albania</td>
      <td>1282697</td>
    </tr>
    <tr>
      <th>24</th>
      <td>Algeria</td>
      <td>9279525</td>
    </tr>
    <tr>
      <th>36</th>
      <td>Angola</td>
      <td>4232095</td>
    </tr>
    <tr>
      <th>48</th>
      <td>Argentina</td>
      <td>17876956</td>
    </tr>
  </tbody>
</table>
</div>



- **How it Works**:
    - `gapminder['year'] == 1952` creates a Boolean mask. Each row's 'year' value is checked against the condition (== 1952). This returns `True` for rows meeting the condition and `False` otherwise.
    - `.loc[]` is a label-based indexing method, but here it's used with a Boolean mask to select the rows that satisfy the condition.

### Subsetting Data Using Multiple Conditions

#### Task: Filter rows from the `gapminder` DataFrame based on two conditions: the year being 1952 and the continent being 'Americas'.


```python
# Multiple conditions
am_52 = gapminder[(gapminder['year'] == 1952) & (gapminder['continent'] == 'Americas')]
print(am_52.head())
```

           country continent  year  lifeExp       pop     gdpPercap
    48   Argentina  Americas  1952   62.485  17876956   5911.315053
    132    Bolivia  Americas  1952   40.414   2883315   2677.326347
    168     Brazil  Americas  1952   50.917  56602560   2108.944355
    240     Canada  Americas  1952   68.750  14785584  11367.161120
    276      Chile  Americas  1952   54.745   6377619   3939.978789


- **How it Works**:
    - `gapminder['year'] == 1952`: Creates a Boolean mask based on whether the 'year' column value is 1952.
    - `gapminder['continent'] == 'Americas'`: Creates another Boolean mask based on whether the 'continent' column value is 'Americas'.
    - The `&` operator combines the two Boolean masks element-wise, returning `True` only where both conditions are met, and `False` otherwise.
    - The combined mask is then used to filter the rows of the `gapminder` DataFrame, resulting in a new DataFrame `am_52` that satisfies both conditions.

### In Python, we typically use pandas methods directly which is the equivalent of tidyverse in R



```python
# select 1 column
selected_columns = gapminder[['country']]
print(selected_columns.head())
```

           country
    0  Afghanistan
    1  Afghanistan
    2  Afghanistan
    3  Afghanistan
    4  Afghanistan



```python
# select multiple columns
selected_range = gapminder[['continent', 'year', 'lifeExp', 'pop']]
print(selected_range.head())
```

      continent  year  lifeExp       pop
    0      Asia  1952   28.801   8425333
    1      Asia  1957   30.332   9240934
    2      Asia  1962   31.997  10267083
    3      Asia  1967   34.020  11537966
    4      Asia  1972   36.088  13079460



```python
# select only numeric columns
numeric_cols = gapminder.select_dtypes(include=['number'])
print(numeric_cols.head())
```

       year  lifeExp       pop   gdpPercap
    0  1952   28.801   8425333  779.445314
    1  1957   30.332   9240934  820.853030
    2  1962   31.997  10267083  853.100710
    3  1967   34.020  11537966  836.197138
    4  1972   36.088  13079460  739.981106


- **How it Works**:
    - `select_dtypes` is a method available on pandas DataFrames. It allows selection of columns based on their datatype.
    - The `include` parameter specifies which data types to select. By passing `['number']`, we are indicating that we want to select all numeric types (both integer and float columns).
    - The result is stored in the `numeric_cols` variable, which will be a DataFrame containing only the numeric columns from `gapminder`.



```python
negation_selection = gapminder.loc[:, gapminder.columns != 'country']
print(negation_selection.head())

```

      continent  year  lifeExp       pop   gdpPercap
    0      Asia  1952   28.801   8425333  779.445314
    1      Asia  1957   30.332   9240934  820.853030
    2      Asia  1962   31.997  10267083  853.100710
    3      Asia  1967   34.020  11537966  836.197138
    4      Asia  1972   36.088  13079460  739.981106



```python
negation_selection = gapminder.loc[:, ~(gapminder.columns == 'country')]
print(negation_selection.head())
```

      continent  year  lifeExp       pop   gdpPercap
    0      Asia  1952   28.801   8425333  779.445314
    1      Asia  1957   30.332   9240934  820.853030
    2      Asia  1962   31.997  10267083  853.100710
    3      Asia  1967   34.020  11537966  836.197138
    4      Asia  1972   36.088  13079460  739.981106


## References

The provided content and techniques are based on documentation and resources from official Python, Pandas, and NumPy websites:

- **Python**: [Python Official Documentation](https://docs.python.org/3/)

- **Pandas**: [Pandas Official Documentation](https://pandas.pydata.org/docs/)
    - The [indexing and selecting data](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html) section provides detailed information on how to use `.loc[]` and other selection methods.
    - The [DataFrame](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.html) section offers insights into the various attributes and methods associated with Pandas DataFrames.

- **NumPy**: [NumPy Official Documentation](https://numpy.org/doc/)
    



```python

```


```python

```


```python

```


```python

```
