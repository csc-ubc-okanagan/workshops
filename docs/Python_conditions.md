---
title: 'conditions'
output:
  html_document:
    keep_md: yes
---


```python
import pandas as pd
import numpy as np
import math
```


```python
# Reading CSV files from GitHub
gapminder = pd.read_csv('https://raw.githubusercontent.com/csc-ubc-okanagan/workshops/a091bc6eae8b9045866c28dbd1848c7e072db5b1/data/gapminder.csv')
gapminder.to_csv('gapminder.csv', index=False)
```

### 1. If Statement
- **Purpose**: Used to execute a block of code only if a specified condition is true.
- **Syntax**:
  ```python
  if condition:
      # code to execute if condition is true



```python
x = 5

if x < 6:
    print("x is less than 6")
if x == 5:
    print("x is equal to 5")
if x != 2:
    print("x is some other number than 2")
```

    x is less than 6
    x is equal to 5
    x is some other number than 2


- The code is checking the value of `x` against different conditions.
- `x` is assigned a value of `5`.
- First `if` statement:
  - Checks if `x` is less than `6`.
  - If `true`, prints "x is less than 6".
  - Since `x` is `5`, this condition is `true`, so "x is less than 6" will be printed.
- Second `if` statement:
  - Checks if `x` is exactly equal to `5`.
  - If `true`, prints "x is equal to 5".
  - Since `x` is indeed `5`, this condition is `true`, so "x is equal to 5" will be printed.
- Third `if` statement:
  - Checks if `x` is not equal to `2`.
  - If `true`, prints "x is some other number than 2".
  - Since `x` is `5`, not `2`, this condition is `true`, so "x is some other number than 2" will be printed.


### 2. If-Else Statement

- **Purpose**: Chooses between two alternatives - one block if the condition is True, another if it's False.
- **Syntax**:
  ```python
  if condition:
    # Code if condition is true
  else:
    # Code if condition is false




```python
if x == 2:
    print("x is equal to 2")
else:
    print("x is not equal to 2")
```

    x is not equal to 2


- **Code Block Purpose**: To check the value of variable `x` and execute code based on its value.
- **Condition Check**:
  - The code uses an `if` statement to check if `x` is equal to the number `2`.
- **Equality Operator (`==`)**:
  - `==` is the comparison operator for equality in Python.
- **True Condition**:
  - If the condition (`x == 2`) evaluates to `True`:
    - The `print` function within the `if` block is called.
    - Outputs: `"x is equal to 2"` to the console.
- **False Condition**:
  - If `x` is anything other than `2`, the condition evaluates to `False`.
    - The `print` function within the `else` block is executed.
    - Outputs: `"x is not equal to 2"` to the console.
- **Code Execution**:
  - Exactly one of the `print` statements will execute based on the value of `x`.
- **Indentation**:
  - Indentation indicates the scope of the `if` and `else` blocks, which is critical in Python syntax.

This conditional structure ensures that the program can appropriately respond to the specific condition of `x` being equal to `2` or not.



### 3. If-Elif-Else Statement

- **Purpose**: Checks multiple conditions sequentially and executes the block of code corresponding to the first True condition.
- - **Syntax**:
  ```python
  if condition1:
    # Code if condition1 is true
  elif condition2:
    # Code if condition2 is true
  else:
    # Code if all above conditions are false



```python
if x < 5:
    print("x is less than 5")
elif x > 5:
    print("x is greater than 5")
else:
    print("x is equal to 5")
```

    x is equal to 5


- **Purpose of Code**: The code snippet checks the value of the variable `x` and compares it against the number `5`.
- **First Condition (`if`)**:
  - The `if` statement checks if `x` is less than `5`.
  - If `x` is indeed less than `5`, the condition evaluates to `True`.
  - The corresponding message `"x is less than 5"` will be printed to the console.
- **Second Condition (`elif`)**:
  - The `elif` (short for 'else if') statement checks if `x` is greater than `5`.
  - This condition is only evaluated if the first `if` condition was `False`.
  - If `x` is greater than `5`, it prints `"x is greater than 5"`.
- **Alternate Condition (`else`)**:
  - The `else` statement covers the scenario where `x` is neither less than nor greater than `5`.
  - In other words, it implies `x` is equal to `5`.
  - It will print `"x is equal to 5"` in this case.
- **Execution Flow**:
  - Only one block of code will execute - corresponding to the first condition that is `True`.
  - If `x` is less than `5`, the first block runs.
  - If `x` is greater than `5`, the second block runs.
  - If `x` is neither (which means it must be equal to `5`), the `else` block runs.
- **Indentation**:
  - As with all Python blocks, the indentation is essential to define the scope of the conditional blocks.

This structure is an efficient way to handle multiple related conditions by checking them in a sequence until one of the conditions is met.



```python
gapminder_cond = gapminder
```

## Creating Categorical Data in Pandas


```python

gapminder_cond = gapminder.copy()

# Create an empty variable to hold our ordered categorical data
# Initially, all values are set to NaN
gapminder_cond['income_level'] = pd.NA

# Define the categories and their order
income_levels = pd.CategoricalDtype(categories=["low-income", "middle-income", "high-income"], ordered=True)

# Start the loop to add values to income_level based on GDP values
for i in gapminder_cond.index:  # Iterating over the DataFrame index
    if gapminder_cond.loc[i, 'gdpPercap'] <= 10000:
        gapminder_cond.loc[i, 'income_level'] = 'low-income'
    elif gapminder_cond.loc[i, 'gdpPercap'] <= 75000:
        gapminder_cond.loc[i, 'income_level'] = 'middle-income'
    else:
        gapminder_cond.loc[i, 'income_level'] = 'high-income'

# Convert the 'income_level' column to ordered categorical type
gapminder_cond['income_level'] = gapminder_cond['income_level'].astype(income_levels)

# Summary of the 'income_level' column
print(gapminder_cond['income_level'].describe())

```

    count           1704
    unique             3
    top       low-income
    freq            1312
    Name: income_level, dtype: object


- **Preparation for Categorical Data**:
  - An empty 'income_level' column is added to `gapminder_cond` with missing values (NaN).

- **Categorical Type Definition**:
  - A pandas CategoricalDtype is defined with three ordered categories: "low-income", "middle-income", "high-income".

- **Looping Through DataFrame**:
  - A for loop iterates over the indices of the DataFrame.
  - Using `.loc[]`, it accesses and evaluates the 'gdpPercap' value for each row.

- **Conditional Assignment**:
  - If 'gdpPercap' is less than or equal to 10,000, 'low-income' is assigned to 'income_level'.
  - If 'gdpPercap' is over 10,000 but less than or equal to 75,000, 'middle-income' is assigned.
  - If 'gdpPercap' is greater than 75,000, 'high-income' is assigned.

- **Post-loop Processing**:
  - The 'income_level' column is converted to the defined CategoricalDtype to enforce the order.

- **Output**:
  - The `describe()` function is called on the 'income_level' column, printing a summary that includes count, unique, top, and frequency of the categories.


```python
gapminder_cond['income_level'] = pd.Categorical(
    np.where(gapminder_cond['gdpPercap'] <= 10000, 'low-income',
    np.where(gapminder_cond['gdpPercap'] <= 75000, 'middle-income', 'high-income')),
    categories=['low-income', 'middle-income', 'high-income'],
    ordered=True
)

print(gapminder_cond['income_level'].describe())
```

    count           1704
    unique             3
    top       low-income
    freq            1312
    Name: income_level, dtype: object


- **Objective**: Assign a categorical variable `income_level` based on `gdpPercap` values in `gapminder_cond` DataFrame.

- **Method Used**:
  - Utilizes `pd.Categorical` from pandas to create a categorical column.
  - Employs `np.where` from numpy for conditional assignments.

- **Categorization Logic**:
  - **Low-income**: Assigned to countries with `gdpPercap` <= 10,000.
  - **Middle-income**: For countries with `gdpPercap` between 10,000 and 75,000.
  - **High-income**: Allocated to countries with `gdpPercap` > 75,000.

- **Categories Parameter**:
  - Explicitly sets the categories as `['low-income', 'middle-income', 'high-income']`.

- **Ordered Parameter**:
  - Indicates that the categories have a logical order (`True`).

- **Final Step**:
  - Adds the `income_level` column to `gapminder_cond` with the appropriate labels.

- **Output**:
  - Executes `print(gapminder_cond['income_level'].describe())` to display the descriptive statistics of the `income_level` column.



```python
# Assign values of 'below-average' if lifeExp is equal to or below 59.47
# and 'above-average' if above 59.47

lifeExp_cat = []
# Loop through each life expectancy value in the 'lifeExp' column
for x in gapminder_cond['lifeExp']:
    # Check if the life expectancy is below or equal to 59.47
    if x <= 59.47:
        # If it is, append 'below-average' to the list
        lifeExp_cat.append('below-average')
    else:
        # If it is not, append 'above-average' to the list
        lifeExp_cat.append('above-average')

# Assign the categorized list to the 'lifeExp_cat' column in the DataFrame
gapminder_cond['lifeExp_cat'] = lifeExp_cat
# Assign appropriate data type
# Define the categorical type with the specific order
life_exp_cat_type = pd.CategoricalDtype(categories=["below-average", "above-average"], ordered=True)

# Convert 'lifeExp_cat' to ordered categorical type
gapminder_cond['lifeExp_cat'] = gapminder_cond['lifeExp_cat'].astype(life_exp_cat_type)

# Summary of the 'lifeExp_cat' column
print(gapminder_cond['lifeExp_cat'].describe())

```

    count              1704
    unique                2
    top       above-average
    freq                895
    Name: lifeExp_cat, dtype: object


- **Value Assignment**:
  - A new column, 'lifeExp_cat', is created in the `gapminder_cond` DataFrame.
  - Uses a list comprehension to iterate over the 'lifeExp' column.
  - Assigns 'below-average' if the life expectancy ('lifeExp') is less than or equal to 59.47.
  - Assigns 'above-average' if the life expectancy is greater than 59.47.

- **Categorical Data Type**:
  - Defines an ordered categorical data type with 'below-average' and 'above-average' as the two possible categories.

- **Type Conversion**:
  - The 'lifeExp_cat' column is converted to this ordered categorical type, which allows for logical ordering of the category levels.

- **Data Summary**:
  - Applies the `describe()` function to the 'lifeExp_cat' column to get a summary.
  - The summary includes the count of non-null entries, the number of unique categories, the most frequent category, and its frequency.

- **Assumptions**:
  - Assumes that `gapminder_cond` is a pandas DataFrame that has already been defined and contains a column named 'lifeExp'.



```python
gapminder_cond['lifeExp_cat'] = pd.Categorical(
    np.where(gapminder_cond['lifeExp'] <= 59.47, 'below-average', 'above-average'),
    categories=['below-average', 'above-average'],
    ordered=True
)

print(gapminder_cond['lifeExp_cat'].describe())
```

    count              1704
    unique                2
    top       above-average
    freq                895
    Name: lifeExp_cat, dtype: object


- **Purpose**: To categorize countries into 'below-average' or 'above-average' life expectancy groups within the `gapminder_cond` DataFrame.

- **Methods**:
  - `pd.Categorical`: Constructs a categorical variable in pandas.
  - `np.where`: Applies a vectorized conditional logic from numpy.

- **Categorization Criteria**:
  - Countries with `lifeExp` less than or equal to 59.47 years are categorized as 'below-average'.
  - Countries with `lifeExp` greater than 59.47 years are labeled 'above-average'.

- **Categorical Settings**:
  - `categories`: Defines the two categories - 'below-average' and 'above-average'.
  - `ordered`: Indicates that there is a meaningful order to the categories (True).

- **Column Addition**:
  - Creates a new column `lifeExp_cat` in the `gapminder_cond` DataFrame with the assigned categories.

- **Descriptive Statistics**:
  - `describe()`: Provides a summary of the `lifeExp_cat` column, including counts and frequency of each category.

- **Output Command**:
  - `print`: Displays the result of `gapminder_cond['lifeExp_cat'].describe()` to the console, showing statistics of the new categorical column.



```python
# create a numeric list, equivalent to R's c(6:-4)
some_numbers = list(range(6, -5, -1))
some_numbers
```




    [6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4]




```python
# use numpy to take the square root, numpy will automatically generate NaN for negative numbers
sqrt_numbers = np.sqrt(some_numbers)
# print the result
print(sqrt_numbers)
```

    [2.44948974 2.23606798 2.         1.73205081 1.41421356 1.
     0.                nan        nan        nan        nan]


    /tmp/ipykernel_141/2103455644.py:2: RuntimeWarning: invalid value encountered in sqrt
      sqrt_numbers = np.sqrt(some_numbers)



```python
# using a list comprehension with conditional to emulate R's ifelse()
# this will replace negative numbers with NaN before taking the square root
sqrt_numbers_ifelse = [x**0.5 if x >= 0 else np.nan for x in some_numbers]
# print the result
print(sqrt_numbers_ifelse)

```

    [2.449489742783178, 2.23606797749979, 2.0, 1.7320508075688772, 1.4142135623730951, 1.0, 0.0, nan, nan, nan, nan]


- `sqrt_numbers_ifelse` is a list that is created by iterating over each element in the list `some_numbers`.
- A list comprehension is used for this iteration:
  - For each element `x` in `some_numbers`, the expression `x**0.5` is evaluated if `x` is greater than or equal to `0`.
  - If `x` is less than `0`, `np.nan` is used instead of calculating the square root. `np.nan` stands for "Not a Number" and is part of the `numpy` library, representing undefined or unrepresentable numerical results.
- As a result, `sqrt_numbers_ifelse` contains the square roots of all non-negative numbers from `some_numbers`, and `np.nan` for all negative numbers where the square root is not defined in the real number system.
- The `print(sqrt_numbers_ifelse)` statement outputs the content of `sqrt_numbers_ifelse` to the console, showing the computed square roots and `np.nan` values for negative inputs.



```python
# Iterate over the DataFrame using the iterrows() function
for i, row in gapminder_cond.iterrows():
    # Check the 'gdpPercap' column to determine the income level
    if row['gdpPercap'] <= 10000:
        gapminder_cond.at[i, 'income_level'] = 'low-income'
    elif row['gdpPercap'] <= 75000:
        gapminder_cond.at[i, 'income_level'] = 'middle-income'
    else:
        gapminder_cond.at[i, 'income_level'] = 'high-income'



```

* Note: It's more efficient to avoid iterating over a DataFrame if possible.
* This operation can be vectorized using pandas' built-in methods, which would be much faster on large datasets.
* Vectorized approach using the 'apply' method or numpy's 'select' or 'where' functions.


```python
# Using multiple conditions with numpy's select()
conditions = [
    gapminder_cond['pop'] <= 1000000,
    gapminder_cond['pop'] <= 100000000,
    gapminder_cond['pop'] > 100000000
]

choices = ['small', 'medium', 'large']

gapminder_cond['pop_size'] = pd.Categorical(
    np.select(conditions, choices, default=np.nan),
    categories=['small', 'medium', 'large'],
    ordered=True
)

print(gapminder_cond['pop_size'].describe())

```

    count       1704
    unique         3
    top       medium
    freq        1447
    Name: pop_size, dtype: object


- **Defining Conditions**:
  - A list of boolean conditions is created.
  - Checks if population ('pop') is less than or equal to 1 million for the first condition.
  - Checks if population is less than or equal to 100 million for the second condition.
  - Checks if population is greater than 100 million for the third condition.

- **Setting Choices**:
  - Corresponding choices for each condition are defined in a list: `['small', 'medium', 'large']`.

- **Applying `np.select()`**:
  - The `np.select()` function is used to apply the conditions and map each to its corresponding choice.
  - If none of the conditions are met, `np.nan` is used as the default value.

- **Categorical Column Creation**:
  - The resulting array from `np.select()` is used to create a new column 'pop_size' in the `gapminder_cond` DataFrame.
  - This column is converted to a pandas Categorical type, with an explicit order defined for the categories.

- **Data Summary**:
  - The `describe()` method is used to generate a summary of the 'pop_size' column.
  - The summary provides the count of non-null entries, the number of unique categories, the most frequent category, and its frequency.

- **Importance of Ordered Categoricals**:
  - By defining the categories as ordered, they can be logically compared and sorted based on the defined order.


## References

The provided content and techniques are based on documentation and resources from official Python, Pandas, and NumPy websites:

- **Python**: [Python Official Documentation](https://docs.python.org/3/)

- **Pandas**: [Pandas Official Documentation](https://pandas.pydata.org/docs/)
    - The [indexing and selecting data](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html) section provides detailed information on how to use `.loc[]` and other selection methods.
    - The [DataFrame](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.html) section offers insights into the various attributes and methods associated with Pandas DataFrames.

- **NumPy**: [NumPy Official Documentation](https://numpy.org/doc/)


```python

```
