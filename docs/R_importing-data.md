---
title: "R: Importing & Exporting Data"
pagetitle: "R: Importing Data"
---

# R: Importing & Exporting Data

## Importing Data

### Comma Separated Values

#### Base R

`read.table()` is R's primary means of importing data, allowing the user to specify a variety of options. `read.csv()` and `read.delim()` are two wrappers on `read.table()` to simplify the import of comma separated and tab delimited files; the only difference between the two is the delimiter that they expect.

**read.csv()**

Using `read.csv()` is as simple as specifying a directory or url from which to import data...

```r
# import from directory
data_local <- read.csv("../data/gapminder.csv")

# import from url
url = 'https://raw.githubusercontent.com/jstaf/gapminder/master/gapminder/gapminder.csv'
data_url <- read.csv(url)
```

By default, `read.csv()` assumes your file has a header and that any missing values contain the characters "NA". Depending on your data source, however, you may need to adjust these parameters, as it's not uncommon for missing values to be blank (empty), coded in a variety of ways -- such as "99" -- or accidently containing a space. 

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

**read_csv()**

`read.csv()` and `read_csv()` are very similar. `read_csv()` is ostensibly faster, it also loads data into a tibble as opposed to a data frame, and has more user friendly defaults. It does, however, require loading additional packages.

As with `read.csv()` and `read.delim`, `read_csv()` and `read_tsv()` -- for tab separated values -- are wrappers on `read_delim()`, which is more flexible.

`read_csv()` assumes the file has a header, that missing values are either blank cells or contain the character "NA", and it trims white space by default. To adjust these, use the arguments `col_names = FALSE`, `na = na_values`, `trim_ws = FALSE`.

```r
# install readr if necessary...
# install.packages("readr")

library(readr)
data_readr <- read_csv("../data/gapminder.csv")
```

#### Excel

Base R does not include a package for loading in Excel files. For this we'll use the TidyVerse package `readxl`, which can read both legacy `xls` as well as more recent `xlsx` files.

```r
# install readr if necessary...
# install.packages("readxl")

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

## Exporting Data

### Comma Seperated Values

The equivalent to `read.csv()` and the TidyVerse `read_csv()` for writing to comma seperated values are `write.csv()` and `write_csv()`.

`write.csv()` is a wrapper on `write.table()`, simplifying writing to csv files. At it's simplest, you provide it with a data frame and a name to save the file to.

```r
write.csv(data_custom_na, "gapminder.csv")
```

> Your file name must contain an extension, in this case `.csv`, for it to be recognized by your operating system.

`write.csv()` by default fills missing values with the characters "NA", and includes both column (header) and row names. These defaults can all be adjusted with the arguments `col.names = FALSE`, `row.names = FALSE`, `na = "99"` -- or however you want to code for missing values.

```r
# export without row names
write.csv(data_custom_na, "gapminder.csv", row.names = FALSE)
```

Additional options and their defaults can be found with `?write.table` 

`write_csv()` is not much different. Again, it's a simplified wrapper on `write_delim()`, and it's defaults similar to `write.csv()`, which includes column names and missing values coded as "NA". In contrast to `write.csv()`, row names are not included in the output file.

```r
write_csv(data_readr, "gapminder.csv")
```

### R data file

The advantage to writing to an R data file is that all of your hard work assigning data types, ordering factors, etc., are saved as well.

R has two formats that you can save to `RDS`, with `saveRDS()`, and `RData`, with `save()` -- the former for single objects, like one data frame, the latter for multiple objects.

They are both fairly simple, taking the object as the first argument, and the file name -- with extension -- as the second.

```r
# save to RDS
saveRDS(data_readr, file = "gapminder.RDS")
```

```r
# save to to RData
save(data_readr, data_custom_na, file = "gapminder.RData)
```

Reading these back in is also fairly straight forward...

```r
# read in RDS
data_readr <- readRDS("gapminder.RDS")
```

```r
# read in RData
load("gapminder.RData")
```

