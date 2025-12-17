---
title: 'Python: Fundamental Concepts with Jupyter Notebook'
output:
  html_document:
    keep_md: yes
---



Last Updated: 2023-12-11

Python excels at interactive computational analysis, enabling extensive data exploration and manipulation. Jupyter Notebook seamlessly complements this capability, offering an interactive environment where users can write code, visualize results, and document their workflow. Through its integrated interface, Jupyter provides versatile cells for code execution, rendering outputs, and adding explanatory markdown annotations, making it a powerful tool for data analysis and scientific computing.

## Simple Math

At its most fundamental level, Python functions as a versatile computational tool, equipped to handle a wide array of mathematical operations and calculations with ease.

Addition


```python
2+2
```

```
## 4
```
Subtraction


```python
3-2
```

```
## 1
```

Multiplication


```python
3*3
```

```
## 9
```

Division


```python
4/2
```

```
## 2.0
```

Square root

To take the square root, we need to import the Math module first.


```python
import math
math.sqrt(9)
```

```
## 3.0
```

Log10


```python
math.log10(100)
```

```
## 2.0
```

## Functions

In Python, especially at the outset, much of your work revolves around applying functions to data. In the preceding section, we encountered various functions, including mathematical operators like `sqrt()` and `log10()`. Functions are designed to take data (or values) as input, process them, and yield an output, which is typically displayed in your console by default.

NumPy, a foundational Python library for numerical computations, introduces a crucial data type called NumPyArray. Creating these NumPy arrays becomes indispensable when collaborating with other Python libraries that heavily rely on them, such as SciPy, Pandas, Matplotlib, scikit-learn, among others. NumPy stands out for array manipulation, thanks to its wealth of built-in functions, performance optimizations, and the ability to write concise code.

To harness NumPy's capabilities, you'll first need to import the NumPy library.


```python
import numpy as np
```

In Python, "np" serves as a concise alias for the NumPy library. With this in place, we can proceed to generate sequential data. NumPy equips us with the "arange()" function for making arrays that encompass sequences of numbers.


```python
np.arange(1,11)
```

```
## array([ 1,  2,  3,  4,  5,  6,  7,  8,  9, 10])
```

In the arragne function above, pay special attention to the range we entered. The end number we entered is not included in the output. 

## Variables

While it's convenient to view outputs in the console during interactive analysis, there are scenarios where we must retain data and outputs for future reference. This is accomplished through variable assignment, where we use the equal sign to link the values (objects) on the right with the names (variables) on the left.


```python
my_variable = np.arange(1,11)
```

And plug it into functions, ie, do computations on it.


```python
my_variable * 2
```

```
## array([ 2,  4,  6,  8, 10, 12, 14, 16, 18, 20])
```

> When naming variables in Python, keep in mind the following:
>
> * Names should be descriptive and indicate the variable's purpose or the kind of value it holds.
> * Use lowercase letters. 
> * If a variable name consists of multiple words, separate them with underscores (e.g., `variable_name`).
> * Do not use Python keywords or functions as variable names to prevent confusion and errors.
> * Names must start with a letter or an underscore.
> * Aside from underscores, avoid using special characters in variablethe code in the long term.res.

## Data Types & Structures

Data types are fundamental constructs in Python, each with distinct characteristics. The three primary data types include numeric, character, and boolean. Numeric data allows for mathematical operations such as addition and division. Character data, often assembled into strings, consists of individual characters or groups of characters. Boolean data is crucial for handling dichotomous (true/false) values. Each data type comes with inherent properties that facilitate specific operations and manipulations.

Main Data Types:

* Numeric (int, float)
* String (str)
* Boolean (bool)

The function `type()`, will tell you what data type you have…


```python
type(2)
```

```
## <class 'int'>
```


```python
type(2.2)
```

```
## <class 'float'>
```


```python
type("a")
```

```
## <class 'str'>
```


```python
type(True)
```

```
## <class 'bool'>
```

## Data Structures

Python offers various data structures to aggregate and organize multiple data elements effectively, especially in data analysis tasks. Below are some of the most frequently used data structures:

**Numpy Arrays:** These structures, provided by the NumPy library, are efficient containers that hold homogenous data (usually numbers), allowing for vectorized operations and efficient data manipulation.
  
**Pandas Series:** The Pandas library offers the Series data structure, which can hold any data type. A Series is a one-dimensional labeled array that can accommodate various data types, making it versatile for data analysis tasks.
  
**Pandas DataFrame:** Also within the Pandas library is the DataFrame, a two-dimensional, size-mutable, and potentially heterogeneous tabular data structure with labeled axes (rows and columns). It's especially suitable for handling and analyzing structured data.

Each of these structures comes with a suite of methods and attributes designed to facilitate data manipulation and analysis effectively.

We have previously provided a brief introduction to NumPy arrays. In this section, we will delve deeper into three prominent data structures, offering a more detailed exploration and understanding of each.

### NumPy Arrays

* Comes from the `numpy` library
* Homogeneous (all elements must be of the same type)
* Can be multi-dimensional (1D, 2D, 3D, ...)
* Efficient operations on numerical data.
* Indexing based on integer position.
* Supports a wide array of mathematical operations.


```python
import numpy as np
my_array = np.array([1, 2, 3, 4, 5])
my_array
```

```
## array([1, 2, 3, 4, 5])
```


```python
my_array*2
```

```
## array([ 2,  4,  6,  8, 10])
```

### Pandas Series

* Comes from the `pandas` library
* 1D labeled array
* Can hold any data type.
* Index can be integer-based, string-based, or even datetime-based
* Built on top of NumPy arrays 


```python
import pandas as pd
my_series = pd.Series([1, 2, 3, 4, 5], index=['a', 'b', 'c', 'd', 'e']) 
my_series
```

```
## a    1
## b    2
## c    3
## d    4
## e    5
## dtype: int64
```

### Pandas DataFrame

* Also from the `pandas` library
* 2D labeled data structure (like a table in a database, an Excel spreadsheet, or a data frame in R)
* Can hold columns of different data types
* Built on top of NumPy arrays
* Has both row and column indices
* Most commonly used pandas object for data manipulation tasks. 


```python
# Define data in a dictionary
data = {
    'Name': ['John', 'Anna', 'Peter', 'Linda'],
    'Age': [28, 22, 35, 32],
    'City': ['New York', 'Paris', 'Berlin', 'Tokyo']
}

# Create DataFrame
df = pd.DataFrame(data)

# Print DataFrame
print(df)
```

```
##     Name  Age      City
## 0   John   28  New York
## 1   Anna   22     Paris
## 2  Peter   35    Berlin
## 3  Linda   32     Tokyo
```

* Use **NumPy arrays** when you need efficient mathematical operations on homogeneous numerical data
* Use **Pandas Series** when you need 1D labeled data
* Use **Pandas DataFrame** for most data analysis tasks, especially when working with heterogeneous tabular data.

## Getting Help within Jupyter Notebook

### Using Python's Built-in Help System

Invoke the `help()` function for information on objects, classes, functions, etc.


```python
help(object_name)
```

### Using Question Mark `?`

Append or prepend a `?` to an object's name for quick reference.


```python
object_name?
?object_name
```

For more extensive help, use double question marks `??`


```python
object_name??
??object_name
```


```python
?print
```

### Accessing Documentation Strings (docstrings)

For quick access to a function's docstring, place the cursor inside the function’s parentheses and press `Shift + Tab`.


```python
list()
```

### Help Menu in Toolbar

Use the "Help" menu in Jupyter Notebook's toolbar. It provides links to documentation for Jupyter, IPython, NumPy, Pandas, Matplotlib, and other libraries.

### Online Help and Searching

Search for help and documentation online by opening a new browser tab.

To get information on the Pandas `DataFrame` function, use:


```python
help(pd.DataFrame)
```
    


## References

**General Python Programming:**

- [Official Python Website](https://www.python.org/)
- [Python Documentation](https://docs.python.org/3/)

**Data Types in Python:**

- [Python Built-in Types](https://docs.python.org/3/library/stdtypes.html) — Official documentation on Python's built-in data types, including numeric, character (string), and boolean.

**Data Structures in Python:**

- [Python Data Structures](https://docs.python.org/3/tutorial/datastructures.html) — Overview of Python’s core data structures, with examples and usage instructions.
   
**NumPy Library and Arrays:**

- [NumPy Official Website](https://numpy.org/)
- [NumPy Documentation](https://numpy.org/doc/stable/) — Comprehensive documentation, including details on NumPy arrays and their operations.

**Pandas Library, Series, and DataFrame:**

- [Pandas Official Website](https://pandas.pydata.org/)
- [Pandas Documentation](https://pandas.pydata.org/pandas-docs/stable/) — Detailed documentation covering various functionalities, including Series and DataFrame creation and manipulation.

## Examples & Tutorials:

- [Python Basics: Data Types](https://docs.python.org/3/tutorial/introduction.html#using-python-as-a-calculator) — A basic tutorial on using various data types in Python.
- [NumPy Quickstart Tutorial](https://numpy.org/doc/stable/user/quickstart.html) — A beginner-friendly introduction to NumPy arrays and operations.
- [10 Minutes to Pandas](https://pandas.pydata.org/pandas-docs/stable/user_guide/10min.html) — A quick, 10-minute guide to getting started with Pandas, including examples of creating and working with Series and DataFrames.

> Before using any package or library, it is advisable to consult the official documentation to understand its functionalities, capabilities, and usage conventions. The official documentation is the most reliable and up-to-date source of information for Python and its libraries.
