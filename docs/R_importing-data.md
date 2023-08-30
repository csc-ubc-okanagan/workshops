---
title: "R: Importing Data"
pagetitle: "R: Importing Data"
---

# R: Importing Data

## Comma Separated Values

### Base R

`read.table()` is R's primary means of importing data, allowing the user to specify a variety of options. `read.csv()` and `read.delim()` are two wrappers on `read.table()` to simplify the import of comma separated and tab delimited files; the only difference between the two is the delimiter that they expect.

#### read.csv()

using `read.csv()` is as simple as specifying a directory or url from which to import data...


```r
# import from directory
data_local <- read.csv("../data/gapminder.csv")

# import from url
url = 'https://raw.githubusercontent.com/jstaf/gapminder/master/gapminder/gapminder.csv'
data_url <- read.csv(url)
```

By default, it assumes your file has a header and that any blank values contain the characters `NA`. Depending on our data source, however, we may need to adjust these parameters...


```r
# a set of possible NA values
na_values <- c("NULL", "NA", "N/A", "99", "", " ")
data_custom_na <- read.csv("../data/gapminder.csv", na.strings = na_values)

# a file with no header
data_no_header <- read.csv("../data/gapminder.csv", header = FALSE)
```

It may also be a good idea to trim excess white space, which is not done by default...


```r
data_nows <- read.csv("../data/gapminder.csv", strip.white = TRUE)
```

> TRUE and FALSE can be denoted with either `T` and `F` or `TRUE` and `FALSE`. However, `T` and `F` as variable names can be overwritten to point to other objects, whereas `TRUE` and `FALSE` cannot. It is advisable to always use `TRUE` and `FALSE`.

Additional options and their defaults can be found with `?read.table()`.

### TidyVerse

#### read_csv()

`read.csv()` and `read_csv()` are very similar. `read_csv()` is ostensibly faster, it also loads data into a tibble as opposed to a data frame, and has more user friendly defaults. It does, however, require loading additional packages.

As with `read.csv()` and `read.delim`, `read_csv()` and `read_tsv()` -- for tab separated values -- are wrappers on `read_delim()` that is more flexible.

`read_csv()` assumes the file has a header, it trims white space by default, and that missing data are either blank cells or contain the character `NA`. To adjust these, use the arguments `col_names = FALSE`, `na = na_values`, `trim_ws = FALSE`.


```r
library(readr)
data_readr <- read_csv("../data/gapminder.csv")
```

### Excel

Base R does not include a package for loading in Excel files. For this we'll use the TidyVerse package `readxl`, which can read both legacy `xls` as well as more recent `xlsx` files.


```r
library(readxl)
data_xls <- read_excel("../data/gapminder.xlsx")
```

This is TidyVerse, and so loads a tibble object. If you need or want a data frame, you'll need to adjust for that...


```r
data_xls_df <- as.data.frame(read_excel("../data/gapminder.xlsx"))
```

You can specify specific sheets and ranges with the `sheet` and `range` arguments...


```r
data_xls <- read_excel("../data/gapminder.xlsx", sheet = '1952', range = "A1:D5")
```

Additional options and their defaults can be found with `?readxl` or by visiting [https://readxl.tidyverse.org/](https://readxl.tidyverse.org/).
