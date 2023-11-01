---
title: 'Iterating Over Data in Python'
output:
  html_document:
    keep_md: yes
---

Let's import the libraries we need.


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


```python
gapminder.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 1704 entries, 0 to 1703
    Data columns (total 6 columns):
     #   Column     Non-Null Count  Dtype  
    ---  ------     --------------  -----  
     0   country    1704 non-null   object
     1   continent  1704 non-null   object
     2   year       1704 non-null   int64  
     3   lifeExp    1704 non-null   float64
     4   pop        1704 non-null   int64  
     5   gdpPercap  1704 non-null   float64
    dtypes: float64(2), int64(2), object(2)
    memory usage: 80.0+ KB


# In the previous workshop:

From our last workshop, we discussed methods to retrieve data from DataFrames:

- **Single Square Brackets `[]`**
  - Returns a Series.
  - Used for selecting a single column.

- **Double Square Brackets `[[]]`**
  - Returns a DataFrame.
  - Can be used to select multiple columns or rows.

---

Remember:
- A `Series` is essentially a column in a DataFrame.
- A `DataFrame` can represent both rows and columns of data.


# Data Iteration Methods in Pandas

## 1. Vectorization
- **Definition:** Applying operations on entire arrays, Series, or DataFrames simultaneously without explicit loops.
- **Advantages:** Uses optimized low-level languages like C under the hood, providing a significant performance boost.

## 2. Apply/Map Functions
- **Definition:** Leveraging `apply` and `map` functions to iterate over and transform data.
- **Advantages:** Can be more flexible than vectorization for complex operations.
- **Methods:**
  - `apply()`: Used with both Series and DataFrames.
  - `map()`: Specifically for Series, useful for element-wise operations.
  - `applymap()`: For DataFrames, applying a function to each element.

## 3. Loops
- **Definition:** Traditional Python method to iterate over data.
- **Advantages/Disadvantages:** Offers finer control but can be slower than vectorized operations.

---

**Note:** When working with Pandas, it's generally recommended to use vectorization whenever possible because of its efficiency advantages.


## **1. Vectorization**


```python
some_numbers = pd.Series(range(1, 11)) # remember that rnage function excludes the last number
some_numbers
```




    0     1
    1     2
    2     3
    3     4
    4     5
    5     6
    6     7
    7     8
    8     9
    9    10
    dtype: int64




```python
np.sqrt(some_numbers + 2)
```




    0    1.732051
    1    2.000000
    2    2.236068
    3    2.449490
    4    2.645751
    5    2.828427
    6    3.000000
    7    3.162278
    8    3.316625
    9    3.464102
    dtype: float64



### And similarly with DataFrames:
For this, let's first select the numeric columns from the gapminder dataframe using the .select_dtypes() function.


```python
# We can select only the numeric columns from the DataFrame
gapminder_num = gapminder.select_dtypes(include=[np.number])
gapminder_num
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
      <th>year</th>
      <th>lifeExp</th>
      <th>pop</th>
      <th>gdpPercap</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1952</td>
      <td>28.801</td>
      <td>8425333</td>
      <td>779.445314</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1957</td>
      <td>30.332</td>
      <td>9240934</td>
      <td>820.853030</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1962</td>
      <td>31.997</td>
      <td>10267083</td>
      <td>853.100710</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1967</td>
      <td>34.020</td>
      <td>11537966</td>
      <td>836.197138</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1972</td>
      <td>36.088</td>
      <td>13079460</td>
      <td>739.981106</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1699</th>
      <td>1987</td>
      <td>62.351</td>
      <td>9216418</td>
      <td>706.157306</td>
    </tr>
    <tr>
      <th>1700</th>
      <td>1992</td>
      <td>60.377</td>
      <td>10704340</td>
      <td>693.420786</td>
    </tr>
    <tr>
      <th>1701</th>
      <td>1997</td>
      <td>46.809</td>
      <td>11404948</td>
      <td>792.449960</td>
    </tr>
    <tr>
      <th>1702</th>
      <td>2002</td>
      <td>39.989</td>
      <td>11926563</td>
      <td>672.038623</td>
    </tr>
    <tr>
      <th>1703</th>
      <td>2007</td>
      <td>43.487</td>
      <td>12311143</td>
      <td>469.709298</td>
    </tr>
  </tbody>
</table>
<p>1704 rows × 4 columns</p>
</div>



Now let's clacualte the mean of each of these columns:


```python
gapminder_num.mean()
```




    year         1.979500e+03
    lifeExp      5.947444e+01
    pop          2.960121e+07
    gdpPercap    7.215327e+03
    dtype: float64



### Task: Calculate the GDP (Gross Domestic Product) for each country-year combination:
GDP is often calculated as gdpPercap (GDP per capita) multiplied by pop (population).


```python
gapminder['gdp'] = gapminder['gdpPercap'] * gapminder['pop']
gapminder[['country', 'year', 'gdp']]
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
      <th>year</th>
      <th>gdp</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Afghanistan</td>
      <td>1952</td>
      <td>6.567086e+09</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Afghanistan</td>
      <td>1957</td>
      <td>7.585449e+09</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Afghanistan</td>
      <td>1962</td>
      <td>8.758856e+09</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Afghanistan</td>
      <td>1967</td>
      <td>9.648014e+09</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Afghanistan</td>
      <td>1972</td>
      <td>9.678553e+09</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1699</th>
      <td>Zimbabwe</td>
      <td>1987</td>
      <td>6.508241e+09</td>
    </tr>
    <tr>
      <th>1700</th>
      <td>Zimbabwe</td>
      <td>1992</td>
      <td>7.422612e+09</td>
    </tr>
    <tr>
      <th>1701</th>
      <td>Zimbabwe</td>
      <td>1997</td>
      <td>9.037851e+09</td>
    </tr>
    <tr>
      <th>1702</th>
      <td>Zimbabwe</td>
      <td>2002</td>
      <td>8.015111e+09</td>
    </tr>
    <tr>
      <th>1703</th>
      <td>Zimbabwe</td>
      <td>2007</td>
      <td>5.782658e+09</td>
    </tr>
  </tbody>
</table>
<p>1704 rows × 3 columns</p>
</div>



## **2. Using `apply`,  `map` and `applymap` in Pandas**s.

### 1) apply()

- **In Pandas**:
  - Used with both Series and DataFrames.
  - Operates on a matrix or array.
  - Can specify an axis to apply a funcmax)
    ```


```python
# 1.Sum across columns
gapminder_num.apply(sum, axis=0) # the apply() function takes a function and axis. axis=0 means rows.
```




    year         3.373068e+06
    lifeExp      1.013444e+05
    pop          5.044047e+10
    gdpPercap    1.229492e+07
    dtype: float64



It might seem a bit counter-intuitive initially, but a helpful way to remember this is:

* axis=0: The function gets applied vertically (down the rows, so column-wise).
* axis=1: The function gets applied horizontally (across the columns, so row-wise).


```python
# 2.Sort values of columns for rows where 'year' is 1952 and display top values
gapminder_num[gapminder_num['year'] == 1952].apply(sorted, axis=0).head()
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
      <th>year</th>
      <th>lifeExp</th>
      <th>pop</th>
      <th>gdpPercap</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1952</td>
      <td>28.801</td>
      <td>60011</td>
      <td>298.846212</td>
    </tr>
    <tr>
      <th>12</th>
      <td>1952</td>
      <td>30.000</td>
      <td>63149</td>
      <td>299.850319</td>
    </tr>
    <tr>
      <th>24</th>
      <td>1952</td>
      <td>30.015</td>
      <td>120447</td>
      <td>328.940557</td>
    </tr>
    <tr>
      <th>36</th>
      <td>1952</td>
      <td>30.331</td>
      <td>147962</td>
      <td>331.000000</td>
    </tr>
    <tr>
      <th>48</th>
      <td>1952</td>
      <td>31.286</td>
      <td>153936</td>
      <td>339.296459</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 3.Get maximum values across columns
gapminder_num.apply(max, axis=0)
```




    year         2.007000e+03
    lifeExp      8.260300e+01
    pop          1.318683e+09
    gdpPercap    1.135231e+05
    dtype: float64



### 2) map()

- **In Pandas**:
  - Specifically for Series.
  - Useful for element-wise operations on a series.


```python
# Extract the `pop` column as Series and then use map() to take the log of all values in the column.
year_series = gapminder_num['pop']
year_series.head()
```




    0     8425333
    1     9240934
    2    10267083
    3    11537966
    4    13079460
    Name: pop, dtype: int64




```python
year_series.map(np.log).head()
```




    0    15.946754
    1    16.039154
    2    16.144454
    3    16.261154
    4    16.386554
    Name: pop, dtype: float64



## 3) applymap()

- **In Pandas**:
  - Used for DataFrames.
  - Applies a function to each element of the DataFrame.


```python
# If we want to take the log value of all values in our gamp minder numeric columns, the we can use applymap()
gapminder_num.applymap(np.log).head()
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
      <th>year</th>
      <th>lifeExp</th>
      <th>pop</th>
      <th>gdpPercap</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>7.576610</td>
      <td>3.360410</td>
      <td>15.946754</td>
      <td>6.658583</td>
    </tr>
    <tr>
      <th>1</th>
      <td>7.579168</td>
      <td>3.412203</td>
      <td>16.039154</td>
      <td>6.710344</td>
    </tr>
    <tr>
      <th>2</th>
      <td>7.581720</td>
      <td>3.465642</td>
      <td>16.144454</td>
      <td>6.748878</td>
    </tr>
    <tr>
      <th>3</th>
      <td>7.584265</td>
      <td>3.526949</td>
      <td>16.261154</td>
      <td>6.728864</td>
    </tr>
    <tr>
      <th>4</th>
      <td>7.586804</td>
      <td>3.585960</td>
      <td>16.386554</td>
      <td>6.606625</td>
    </tr>
  </tbody>
</table>
</div>



## **3. Loops**

In Python, just like R, vectorization often provides the fastest way to perform operations on data. When specific, custom operations are required, loops might be needed.gs:

To iterate over any iterable in Python, you can use the following syntax:

```python
for variable in iterable:
    # do something


For example:


```python
for int in range(1, 11):  # for each int in the range 1 through 10
    print(int)  # print that int
```

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10


To demonstrate simple usage of the for loops, let's sample 20 rows of data from our gapminder dataset


```python
# Sample the gapminder data (random 20 rows)
gapminder_sample = gapminder_num.sample(20)
gapminder_sample
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
      <th>year</th>
      <th>lifeExp</th>
      <th>pop</th>
      <th>gdpPercap</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1303</th>
      <td>1987</td>
      <td>61.728</td>
      <td>110812</td>
      <td>1516.525457</td>
    </tr>
    <tr>
      <th>1124</th>
      <td>1992</td>
      <td>47.391</td>
      <td>8392818</td>
      <td>581.182725</td>
    </tr>
    <tr>
      <th>632</th>
      <td>1992</td>
      <td>43.266</td>
      <td>1050938</td>
      <td>745.539871</td>
    </tr>
    <tr>
      <th>682</th>
      <td>2002</td>
      <td>72.590</td>
      <td>10083313</td>
      <td>14843.935560</td>
    </tr>
    <tr>
      <th>36</th>
      <td>1952</td>
      <td>30.015</td>
      <td>4232095</td>
      <td>3520.610273</td>
    </tr>
    <tr>
      <th>1413</th>
      <td>1997</td>
      <td>60.236</td>
      <td>42835005</td>
      <td>7479.188244</td>
    </tr>
    <tr>
      <th>428</th>
      <td>1992</td>
      <td>51.604</td>
      <td>384156</td>
      <td>2377.156192</td>
    </tr>
    <tr>
      <th>1634</th>
      <td>1962</td>
      <td>60.770</td>
      <td>8143375</td>
      <td>8422.974165</td>
    </tr>
    <tr>
      <th>1677</th>
      <td>1997</td>
      <td>58.020</td>
      <td>15826497</td>
      <td>2117.484526</td>
    </tr>
    <tr>
      <th>762</th>
      <td>1982</td>
      <td>74.450</td>
      <td>3858421</td>
      <td>15367.029200</td>
    </tr>
    <tr>
      <th>352</th>
      <td>1972</td>
      <td>67.849</td>
      <td>1834796</td>
      <td>5118.146939</td>
    </tr>
    <tr>
      <th>419</th>
      <td>2007</td>
      <td>78.332</td>
      <td>5468120</td>
      <td>35278.418740</td>
    </tr>
    <tr>
      <th>717</th>
      <td>1997</td>
      <td>66.041</td>
      <td>199278000</td>
      <td>3119.335603</td>
    </tr>
    <tr>
      <th>144</th>
      <td>1952</td>
      <td>53.820</td>
      <td>2791000</td>
      <td>973.533195</td>
    </tr>
    <tr>
      <th>1612</th>
      <td>1972</td>
      <td>71.340</td>
      <td>209896000</td>
      <td>21806.035940</td>
    </tr>
    <tr>
      <th>1007</th>
      <td>2007</td>
      <td>66.803</td>
      <td>2874127</td>
      <td>3095.772271</td>
    </tr>
    <tr>
      <th>1038</th>
      <td>1982</td>
      <td>42.795</td>
      <td>12587223</td>
      <td>462.211415</td>
    </tr>
    <tr>
      <th>999</th>
      <td>1967</td>
      <td>51.253</td>
      <td>1149500</td>
      <td>1226.041130</td>
    </tr>
    <tr>
      <th>1138</th>
      <td>2002</td>
      <td>46.608</td>
      <td>119901274</td>
      <td>1615.286395</td>
    </tr>
    <tr>
      <th>463</th>
      <td>1987</td>
      <td>59.797</td>
      <td>52799062</td>
      <td>3885.460710</td>
    </tr>
  </tbody>
</table>
</div>



### Task1: Print the log base 10 of the first value in the column 'gdpPercap'


```python
# Print the log base 10 of the first value in the column 'gdpPercap'
print(np.log10(gapminder_sample['gdpPercap'].iloc[0]))
```

    3.180849704947923


### Task2: using the for loop, loop over the gdpPercap column, printing index and log10 of the value:


```python
for index, value in enumerate(gapminder_sample['gdpPercap']):
    print(index + 1)  # +1 because Python uses 0-based indexing
    print(np.log10(value))
```

    1
    3.180849704947923
    2
    2.7643126969049336
    3
    2.872470873970842
    4
    4.1715490603360585
    5
    3.546617951893976
    6
    3.8738544641368757
    7
    3.376057718158622
    8
    3.92546546862278
    9
    3.325820245308592
    10
    4.186589916507445
    11
    3.7091127500702807
    12
    4.547509110816849
    13
    3.4940621021345812
    14
    2.988350764353931
    15
    4.338576723540454
    16
    3.490769005923762
    17
    2.6648406667312905
    18
    3.0885050397031306
    19
    3.2082495351755087
    20
    3.589442521707857


### Task3. How do we store these index and computed values in a new variable?

We first need to create an empty dictionary


```python
# Create an empty dictionary to store the log values:
gdp_percapita_log_dict = {}
```


```python
# Update the values of the dictionary with log10 values:
for index, value in enumerate(gapminder_sample['gdpPercap']):
    gdp_percapita_log_dict[index] = np.log10(value)
```


```python
gdp_percapita_log_dict
```




    {0: 3.180849704947923,
     1: 2.7643126969049336,
     2: 2.872470873970842,
     3: 4.1715490603360585,
     4: 3.546617951893976,
     5: 3.8738544641368757,
     6: 3.376057718158622,
     7: 3.92546546862278,
     8: 3.325820245308592,
     9: 4.186589916507445,
     10: 3.7091127500702807,
     11: 4.547509110816849,
     12: 3.4940621021345812,
     13: 2.988350764353931,
     14: 4.338576723540454,
     15: 3.490769005923762,
     16: 2.6648406667312905,
     17: 3.0885050397031306,
     18: 3.2082495351755087,
     19: 3.589442521707857}




```python

```
