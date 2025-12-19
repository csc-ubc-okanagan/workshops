---
title: 'R: Subsetting & Filtering Data'
output:
  html_document:
    keep_md: yes
---



Last Updates: 2023-10-25

## Base R

### `$`

We've already seen that we can select a single variable of a data frame with `$`.


```r
data_gapminder <- read.csv("../data/gapminder.csv")
lifeExp <- data_gapminder$lifeExp
head(lifeExp)
```

```
## [1] 28.801 30.332 31.997 34.020 36.088 38.438
```

It's important to note that generally R simplifies data structures when possible, so `lifeExp` has lost most of its attributes, and is now simply a vector...


```r
class(lifeExp)
```

```
## [1] "numeric"
```

`$` can be used with both data frames and lists.


```r
basic_list <- list(item_1 = letters,
     item_2 = 1:10,
     item_3 = c(TRUE, FALSE))

item_1 <- basic_list$item_1

item_1
```

```
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
## [20] "t" "u" "v" "w" "x" "y" "z"
```

```r
# again, it defaults to creating a vector
class(item_1)
```

```
## [1] "character"
```

### `[` and `[[`

You can also subset using single or double square brackets. These provide you with more flexibility than `$`. They can also be more verbose. The primary difference between the two is that `[` preserves the original data structure, while `[[` discards it and simplifies.


```r
pop_preserved <- data_gapminder["pop"]
pop_simple <- data_gapminder[["pop"]]

class(pop_preserved)
```

```
## [1] "data.frame"
```

```r
class(pop_simple)
```

```
## [1] "integer"
```

`[` and `[[` allow you to specify specific ranges of columns and rows to extract. The arguments are passed as `[row range, column range]`. Leaving an argument blank returns all rows or columns.


```r
# value in the first row and first column
data_gapminder[1,1]
```

```
## [1] "Afghanistan"
```

```r
# values in the second row
data_gapminder[2,]
```

```
##       country continent year lifeExp     pop gdpPercap
## 2 Afghanistan      Asia 1957  30.332 9240934   820.853
```

```r
# values in the first 5 rows and first 3 columns
data_gapminder[1:5, 1:3]
```

```
##       country continent year
## 1 Afghanistan      Asia 1952
## 2 Afghanistan      Asia 1957
## 3 Afghanistan      Asia 1962
## 4 Afghanistan      Asia 1967
## 5 Afghanistan      Asia 1972
```

This works on lists as well...


```r
# return the first element of a list
basic_list[1]
```

```
## $item_1
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
## [20] "t" "u" "v" "w" "x" "y" "z"
```

However, if you want an item (value) from within a list, you need to simplify that object first with `[[` and then apply a single `[`


```r
# extract the first value from the first list item
basic_list[[1]][1]
```

```
## [1] "a"
```

> You can specify the row and column to subset either by its name, wrapped in "", or by its indexed number.

### Filtering Based on Conditions

You can also filter your data to specific cases based on conditions. This is done by placing the condition within the subsetting operators.

Conditions include:

| | |
| --- | --- |
| != | not equal to |
| == | equal to |
| < | less than |
| > | greater than |
| <= | less than or equal to |
| => | equal to or greater than |

And conditions can be strung together with the following operators:

| | |
| --- | --- |
| ! | not |
| \| | or |
| & | and |

#### Vectors


```r
# using the lifeExp vector created earlier
lifeExp_gt_70 <- lifeExp[lifeExp > 70]
head(lifeExp_gt_70, n = 20)
```

```
##  [1] 70.420 72.000 71.581 72.950 75.651 76.423 70.994 72.301 70.774 71.868
## [11] 73.275 74.340 75.320 70.330 70.930 71.100 71.930 73.490 74.740 76.320
```

```r
length(lifeExp_gt_70)
```

```
## [1] 493
```

#### Data Frames

For data frames, you identify the column and the condition for the values in that column, which will give you all rows that match that condition, followed by the columns of interest.


```r
# all columns for 1952
gapminder_1952 <- data_gapminder[data_gapminder$year == 1952, ]

head(gapminder_1952)
```

```
##        country continent year lifeExp      pop  gdpPercap
## 1  Afghanistan      Asia 1952  28.801  8425333   779.4453
## 13     Albania    Europe 1952  55.230  1282697  1601.0561
## 25     Algeria    Africa 1952  43.077  9279525  2449.0082
## 37      Angola    Africa 1952  30.015  4232095  3520.6103
## 49   Argentina  Americas 1952  62.485 17876956  5911.3151
## 61   Australia   Oceania 1952  69.120  8691212 10039.5956
```

```r
# country and gdp for 1952
gdp_1952 <- data_gapminder[data_gapminder$year == 1952, c(1,6)]

head(gdp_1952)
```

```
##        country  gdpPercap
## 1  Afghanistan   779.4453
## 13     Albania  1601.0561
## 25     Algeria  2449.0082
## 37      Angola  3520.6103
## 49   Argentina  5911.3151
## 61   Australia 10039.5956
```

### `subset()`

`subset()` allows you to achieve similar results to those above. At its most basic, it takes a data set and a condition on which to subset.


```r
head(subset(data_gapminder, year == 1952))
```

```
##        country continent year lifeExp      pop  gdpPercap
## 1  Afghanistan      Asia 1952  28.801  8425333   779.4453
## 13     Albania    Europe 1952  55.230  1282697  1601.0561
## 25     Algeria    Africa 1952  43.077  9279525  2449.0082
## 37      Angola    Africa 1952  30.015  4232095  3520.6103
## 49   Argentina  Americas 1952  62.485 17876956  5911.3151
## 61   Australia   Oceania 1952  69.120  8691212 10039.5956
```

You can also list the columns you'd like to keep with the `select` argument.


```r
head(subset(data_gapminder, year == 1952,
            select = c("country", "gdpPercap")))
```

```
##        country  gdpPercap
## 1  Afghanistan   779.4453
## 13     Albania  1601.0561
## 25     Algeria  2449.0082
## 37      Angola  3520.6103
## 49   Argentina  5911.3151
## 61   Australia 10039.5956
```

### Multiple conditions

Multiple conditions can be passed when subsetting, whether using `[` or `subset()`


```r
# 1952 and Americas
am_52 <- data_gapminder[data_gapminder$year == 1952 & data_gapminder$continent == "Americas", ]
head(am_52)
```

```
##       country continent year lifeExp      pop gdpPercap
## 49  Argentina  Americas 1952  62.485 17876956  5911.315
## 133   Bolivia  Americas 1952  40.414  2883315  2677.326
## 169    Brazil  Americas 1952  50.917 56602560  2108.944
## 241    Canada  Americas 1952  68.750 14785584 11367.161
## 277     Chile  Americas 1952  54.745  6377619  3939.979
## 301  Colombia  Americas 1952  50.643 12350771  2144.115
```

```r
am_52_ss <- subset(data_gapminder, year == 1952 & continent == "Americas")
head(am_52_ss)
```

```
##       country continent year lifeExp      pop gdpPercap
## 49  Argentina  Americas 1952  62.485 17876956  5911.315
## 133   Bolivia  Americas 1952  40.414  2883315  2677.326
## 169    Brazil  Americas 1952  50.917 56602560  2108.944
## 241    Canada  Americas 1952  68.750 14785584 11367.161
## 277     Chile  Americas 1952  54.745  6377619  3939.979
## 301  Colombia  Americas 1952  50.643 12350771  2144.115
```

## Tidyverse

The `dplyr` package from Tidyverse draws a good conceptual break between selecting variables and filtering for cases based on values with its `select()` and `filter()` functions.

### `select()`

`select()` allows you pick columns based on their names. It takes two arguments, a data set, and a set of parameters by which to select columns; that parameter could be a single name, a span of names separated with a `:`, or some other condition, like names starting with, ending with, or containing specific characters, or even by the data type held in the column.


```r
# load the library
library(dplyr)

# select 1 column
head(select(data_gapminder, country))
```

```
##       country
## 1 Afghanistan
## 2 Afghanistan
## 3 Afghanistan
## 4 Afghanistan
## 5 Afghanistan
## 6 Afghanistan
```

```r
# select multiple columns
head(select(data_gapminder, year, lifeExp))
```

```
##   year lifeExp
## 1 1952  28.801
## 2 1957  30.332
## 3 1962  31.997
## 4 1967  34.020
## 5 1972  36.088
## 6 1977  38.438
```

```r
# select range of columns
head(select(data_gapminder, continent:pop))
```

```
##   continent year lifeExp      pop
## 1      Asia 1952  28.801  8425333
## 2      Asia 1957  30.332  9240934
## 3      Asia 1962  31.997 10267083
## 4      Asia 1967  34.020 11537966
## 5      Asia 1972  36.088 13079460
## 6      Asia 1977  38.438 14880372
```

```r
# select numeric columns
head(select(data_gapminder, where(is.numeric)))
```

```
##   year lifeExp      pop gdpPercap
## 1 1952  28.801  8425333  779.4453
## 2 1957  30.332  9240934  820.8530
## 3 1962  31.997 10267083  853.1007
## 4 1967  34.020 11537966  836.1971
## 5 1972  36.088 13079460  739.9811
## 6 1977  38.438 14880372  786.1134
```

```r
# select by negation
head(select(data_gapminder, !country))
```

```
##   continent year lifeExp      pop gdpPercap
## 1      Asia 1952  28.801  8425333  779.4453
## 2      Asia 1957  30.332  9240934  820.8530
## 3      Asia 1962  31.997 10267083  853.1007
## 4      Asia 1967  34.020 11537966  836.1971
## 5      Asia 1972  36.088 13079460  739.9811
## 6      Asia 1977  38.438 14880372  786.1134
```

More options can be found here [https://dplyr.tidyverse.org/reference/select.html](https://dplyr.tidyverse.org/reference/select.html). 

### `filter()`

Filter is very similar to subset for working on data frames (it doesn't work on vectors), and follows the same basic approach of requiring a dataset and a condition on which to filter.


```r
head(filter(data_gapminder, continent == "Americas"))
```

```
##     country continent year lifeExp      pop gdpPercap
## 1 Argentina  Americas 1952  62.485 17876956  5911.315
## 2 Argentina  Americas 1957  64.399 19610538  6856.856
## 3 Argentina  Americas 1962  65.142 21283783  7133.166
## 4 Argentina  Americas 1967  65.634 22934225  8052.953
## 5 Argentina  Americas 1972  67.065 24779799  9443.039
## 6 Argentina  Americas 1977  68.481 26983828 10079.027
```

`filter()` works well with other offerings from Tidyverse. And more options can be found here [https://dplyr.tidyverse.org/reference/filter.html](https://dplyr.tidyverse.org/reference/filter.html).
