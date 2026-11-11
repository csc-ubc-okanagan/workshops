# R: Subsetting & Filtering Data

<style>
  .notes { display: none; }
  hr { display: none; }
  .site-footer, .footer { display: none; }
</style>

### Roadmap 🗾

<style type="text/css">
/* Horizontal scroll for code, R output, and tables */
.reveal pre,
.reveal table {
  display: block;
  overflow-x: auto;
  max-width: 100%;
}
&#10;.reveal pre code {
  white-space: pre;  /* keep long lines intact instead of wrapping */
}
&#10;/* Vertical scroll for slides that are too tall */
.reveal .slides section {
  height: 100%;
  overflow-y: auto !important;
}
</style>

- **Why subset?** Real datasets are big, and we rarely need all of them
  at once
  - Focus on the rows and columns that answer our question
  - Cleaner, faster analysis and easier-to-read output
- Topics:
  - **Base R**
  - **Tidyverse (`dplyr`)**
  - **Regular expressions**
  - **`data.table`**
  - **Additional packages**

### Base R

``` r
data_gapminder <- read.csv("../../data/gapminder.csv")
lifeExp <- data_gapminder$lifeExp
head(lifeExp)
```

    ## [1] 28.801 30.332 31.997 34.020 36.088 38.438

### Lists

``` r
basic_list <- list(item_1 = letters,
     item_2 = 1:10,
     item_3 = c(TRUE, FALSE))

item_1 <- basic_list$item_1

item_1
```

    ##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
    ## [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"

``` r
# again, it defaults to creating a vector
class(item_1)
```

    ## [1] "character"

### Bracket notation: `[` and `[[`

``` r
pop_preserved <- data_gapminder["pop"]
pop_simple <- data_gapminder[["pop"]]

head(pop_preserved, 3)
```

    ##        pop
    ## 1  8425333
    ## 2  9240934
    ## 3 10267083

``` r
head(pop_simple, 3)
```

    ## [1]  8425333  9240934 10267083

``` r
class(pop_preserved)
```

    ## [1] "data.frame"

``` r
class(pop_simple)
```

    ## [1] "integer"

### Accessing rows and columns in data frames

``` r
# value in the first row and first column
data_gapminder[1,1]
```

    ## [1] "Afghanistan"

``` r
# values in the second row
data_gapminder[2,]
```

    ##       country continent year lifeExp     pop gdpPercap
    ## 2 Afghanistan      Asia 1957  30.332 9240934   820.853

### Accessing multiple rows and columns at once

``` r
# values in the first 5 rows and first 3 columns
data_gapminder[1:5, 1:3]
```

    ##       country continent year
    ## 1 Afghanistan      Asia 1952
    ## 2 Afghanistan      Asia 1957
    ## 3 Afghanistan      Asia 1962
    ## 4 Afghanistan      Asia 1967
    ## 5 Afghanistan      Asia 1972

### Working with lists

``` r
# return the first element of a list
basic_list[1]
```

    ## $item_1
    ##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
    ## [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"

``` r
# extract the first value from the first list item
basic_list[[1]][1]
```

    ## [1] "a"

### Comparison & Logical Operators

You can also filter your data to specific cases based on conditions.
This is done by placing the condition within the subsetting operators.

Conditions include:

| Operator | Meaning                  |
|---------:|--------------------------|
|     `!=` | not equal to?            |
|     `==` | equal to?                |
|      `<` | less than                |
|      `>` | greater than             |
|     `<=` | less than or equal to    |
|     `>=` | equal to or greater than |
|      `!` | not                      |
|     `\|` | or                       |
|      `&` | and                      |
|   `%in%` | in set (membership)      |

### Vectors

``` r
# using the lifeExp vector created earlier
lifeExp_gt_70 <- lifeExp[lifeExp > 70]
head(lifeExp_gt_70, n = 20)
```

    ##  [1] 70.420 72.000 71.581 72.950 75.651 76.423 70.994 72.301 70.774
    ## [10] 71.868 73.275 74.340 75.320 70.330 70.930 71.100 71.930 73.490
    ## [19] 74.740 76.320

``` r
length(lifeExp_gt_70)
```

    ## [1] 493

### Data Frames

For data frames, you identify the column and the condition for the
values in that column, which will give you all rows that match that
condition, followed by the columns of interest.

``` r
# all columns for 1952
gapminder_1952 <- data_gapminder[data_gapminder$year == 1952, ]

head(gapminder_1952)
```

    ##        country continent year lifeExp      pop  gdpPercap
    ## 1  Afghanistan      Asia 1952  28.801  8425333   779.4453
    ## 13     Albania    Europe 1952  55.230  1282697  1601.0561
    ## 25     Algeria    Africa 1952  43.077  9279525  2449.0082
    ## 37      Angola    Africa 1952  30.015  4232095  3520.6103
    ## 49   Argentina  Americas 1952  62.485 17876956  5911.3151
    ## 61   Australia   Oceania 1952  69.120  8691212 10039.5956

``` r
# country and gdp for 1952
gdp_1952 <- data_gapminder[data_gapminder$year == 1952, c(1,6)]

head(gdp_1952)
```

    ##        country  gdpPercap
    ## 1  Afghanistan   779.4453
    ## 13     Albania  1601.0561
    ## 25     Algeria  2449.0082
    ## 37      Angola  3520.6103
    ## 49   Argentina  5911.3151
    ## 61   Australia 10039.5956

### `subset()`

``` r
head(subset(data_gapminder, year == 1952), 1)
```

    ##       country continent year lifeExp     pop gdpPercap
    ## 1 Afghanistan      Asia 1952  28.801 8425333  779.4453

``` r
head(subset(data_gapminder, year == 1952,
            select = c("country", "gdpPercap")), 1)
```

    ##       country gdpPercap
    ## 1 Afghanistan  779.4453

### Multiple conditions

``` r
# 1952 and Americas
am_52 <- data_gapminder[data_gapminder$year == 1952 & data_gapminder$continent == "Americas", ]
head(am_52)
```

    ##       country continent year lifeExp      pop gdpPercap
    ## 49  Argentina  Americas 1952  62.485 17876956  5911.315
    ## 133   Bolivia  Americas 1952  40.414  2883315  2677.326
    ## 169    Brazil  Americas 1952  50.917 56602560  2108.944
    ## 241    Canada  Americas 1952  68.750 14785584 11367.161
    ## 277     Chile  Americas 1952  54.745  6377619  3939.979
    ## 301  Colombia  Americas 1952  50.643 12350771  2144.115

``` r
am_52_ss <- subset(data_gapminder, year == 1952 & continent == "Americas")
head(am_52_ss)
```

    ##       country continent year lifeExp      pop gdpPercap
    ## 49  Argentina  Americas 1952  62.485 17876956  5911.315
    ## 133   Bolivia  Americas 1952  40.414  2883315  2677.326
    ## 169    Brazil  Americas 1952  50.917 56602560  2108.944
    ## 241    Canada  Americas 1952  68.750 14785584 11367.161
    ## 277     Chile  Americas 1952  54.745  6377619  3939.979
    ## 301  Colombia  Americas 1952  50.643 12350771  2144.115

### Tidyverse

- The `dplyr` package
- The `filter`, `select` operations

### `select()`

``` r
# load the library
library(dplyr)

# select 1 column
head(select(data_gapminder, country))
```

    ##       country
    ## 1 Afghanistan
    ## 2 Afghanistan
    ## 3 Afghanistan
    ## 4 Afghanistan
    ## 5 Afghanistan
    ## 6 Afghanistan

``` r
# select multiple columns
head(select(data_gapminder, year, lifeExp))
```

    ##   year lifeExp
    ## 1 1952  28.801
    ## 2 1957  30.332
    ## 3 1962  31.997
    ## 4 1967  34.020
    ## 5 1972  36.088
    ## 6 1977  38.438

``` r
# select range of columns
head(select(data_gapminder, continent:pop))
```

    ##   continent year lifeExp      pop
    ## 1      Asia 1952  28.801  8425333
    ## 2      Asia 1957  30.332  9240934
    ## 3      Asia 1962  31.997 10267083
    ## 4      Asia 1967  34.020 11537966
    ## 5      Asia 1972  36.088 13079460
    ## 6      Asia 1977  38.438 14880372

``` r
# select numeric columns
head(select(data_gapminder, where(is.numeric)))
```

    ##   year lifeExp      pop gdpPercap
    ## 1 1952  28.801  8425333  779.4453
    ## 2 1957  30.332  9240934  820.8530
    ## 3 1962  31.997 10267083  853.1007
    ## 4 1967  34.020 11537966  836.1971
    ## 5 1972  36.088 13079460  739.9811
    ## 6 1977  38.438 14880372  786.1134

``` r
# select by negation
head(select(data_gapminder, !country))
```

    ##   continent year lifeExp      pop gdpPercap
    ## 1      Asia 1952  28.801  8425333  779.4453
    ## 2      Asia 1957  30.332  9240934  820.8530
    ## 3      Asia 1962  31.997 10267083  853.1007
    ## 4      Asia 1967  34.020 11537966  836.1971
    ## 5      Asia 1972  36.088 13079460  739.9811
    ## 6      Asia 1977  38.438 14880372  786.1134

### `filter()`

``` r
head(filter(data_gapminder, continent == "Americas"))
```

    ##     country continent year lifeExp      pop gdpPercap
    ## 1 Argentina  Americas 1952  62.485 17876956  5911.315
    ## 2 Argentina  Americas 1957  64.399 19610538  6856.856
    ## 3 Argentina  Americas 1962  65.142 21283783  7133.166
    ## 4 Argentina  Americas 1967  65.634 22934225  8052.953
    ## 5 Argentina  Americas 1972  67.065 24779799  9443.039
    ## 6 Argentina  Americas 1977  68.481 26983828 10079.027

### Regular Expressions: `grep()` and `grepl()` 🤔

- Sometimes we don’t know the **exact** value we want to search or
  filter for, but we know what it **looks like**
- **Regular expressions** (regex) let us describe that pattern (without
  knowing exactly what we’re looking for)
- `grep()` returns the **positions** (or values) of matches; `grepl()`
  returns `TRUE`/`FALSE` for each element

``` r
fruits <- c("apple", "banana", "blueberry", "cherry")
grep("^b", fruits)                 # 2 3
```

    ## [1] 2 3

``` r
grep("^b", fruits, value = TRUE)   # "banana" "blueberry"
```

    ## [1] "banana"    "blueberry"

``` r
grepl("^b", fruits)                # FALSE TRUE TRUE FALSE
```

    ## [1] FALSE  TRUE  TRUE FALSE

### Filtering and mutating with `data.table`

``` r
health_dt <- fread("../../data/health_data.csv") # load quickly with fread
health_dt[age >= 20, .(
  n = .N, # denotes
  mean_bmi_pre = mean(bmi_pre, na.rm = TRUE),
  mean_bmi_post = mean(bmi_post, na.rm = TRUE)
), by = group]
```

    ##           group     n mean_bmi_pre mean_bmi_post
    ##          <char> <int>        <num>         <num>
    ## 1:      Control    19     25.64737      25.74737
    ## 2: Intervention    19     25.87368      24.56842

### `data.table` logic

- `DT[i, j, by]`

- `i` operator is row-wise, like a filter statement (used above)

- `j` operator tells what to do and what to return

- `by` operator tells what to group by

``` r
health_dt[age >= 20, # `i` operator
          # `j` operator for what to do
          .(n = .N,
            mean_bmi_pre = mean(bmi_pre, na.rm = TRUE),
            mean_bmi_post = mean(bmi_post, na.rm = TRUE)
            ), by = group] # by operator tells what columns to group our j, i operation over
```

    ##           group     n mean_bmi_pre mean_bmi_post
    ##          <char> <int>        <num>         <num>
    ## 1:      Control    19     25.64737      25.74737
    ## 2: Intervention    19     25.87368      24.56842

### Column operators with `data.table`

- `.SD` stands for subset data and is `data.table` shorthand for get all
  columns

``` r
health_dt[, lapply(.SD, mean, na.rm = TRUE),
          by = smoker,
          .SDcols = !is.character] # notice ! operator
```

    ##    smoker      id      age weight_pre weight_post  bmi_pre bmi_post
    ##    <char>   <num>    <num>      <num>       <num>    <num>    <num>
    ## 1:     No 19.1250 33.83333   77.99167    76.64583 26.01250 25.62083
    ## 2:    Yes 22.5625 38.50000   81.01875    79.33750 25.29375 24.29375
    ##    vo2max_pre vo2max_post  improved
    ##         <num>       <num>     <num>
    ## 1:   40.59583    42.51667 0.6666667
    ## 2:   40.15625    42.96875 0.8750000

### Subsetting column operations in `data.table` with \`.SDcols

``` r
health_dt[, lapply(.SD, mean, na.rm = TRUE),
          by = smoker,
          .SDcols = c('weight_pre', 'weight_post')]
```

    ##    smoker weight_pre weight_post
    ##    <char>      <num>       <num>
    ## 1:     No   77.99167    76.64583
    ## 2:    Yes   81.01875    79.33750

### Additional packages: `skimr`

``` r
data_gapminder %>% select(country, lifeExp) %>% skim()
```

|                                                  |            |
|:-------------------------------------------------|:-----------|
| Name                                             | Piped data |
| Number of rows                                   | 1704       |
| Number of columns                                | 2          |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |            |
| Column type frequency:                           |            |
| character                                        | 1          |
| numeric                                          | 1          |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |            |
| Group variables                                  | None       |

Data summary

**Variable type: character**

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| country       |         0 |             1 |   4 |  24 |     0 |      142 |          0 |

**Variable type: numeric**

| skim_variable | n_missing | complete_rate |  mean |    sd |   p0 |  p25 |   p50 |   p75 | p100 | hist  |
|:--------------|----------:|--------------:|------:|------:|-----:|-----:|------:|------:|-----:|:------|
| lifeExp       |         0 |             1 | 59.47 | 12.92 | 23.6 | 48.2 | 60.71 | 70.85 | 82.6 | ▁▆▇▇▇ |
