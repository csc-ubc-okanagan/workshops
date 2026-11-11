# R: Conditions

<style>
  .notes { display: none; }
  hr { display: none; }
  .site-footer, .footer { display: none; }
</style>

### Motivation

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

- Conditional statements are good for many purposes in coding:
  - conditional iteration
  - binning data
  - catching errors

### `if ... else` construct

``` r
if("Afghanistan" %in% gap_dat$country){
  print("Afghanistan in dataset")
}else{
  print("Afghanistan not in dataset")
}
```

    ## [1] "Afghanistan in dataset"

### *problem*: `if` needs exactly one `TRUE` or `FALSE`

``` r
# a whole column is many values, so if() doesn't know which to use
if (gap_dat$lifeExp > 60) "long" else "short"
```

    ## Error in `if (gap_dat$lifeExp > 60) ...`:
    ## ! the condition has length > 1

``` r
# NA is neither TRUE nor FALSE
x <- NA
if (x > 5) print("big")
```

    ## Error in `if (x > 5) ...`:
    ## ! missing value where TRUE/FALSE needed

### A possible solution: chaining multiple `if` statements

``` r
x <- 7

if (x < 6) {
  print("x is less than 6")
}
if (x == 5) {
  print("x is equal to 5")
}else{
  print("x is greater than not less than 6 and is not equal to 5")
}
```

    ## [1] "x is greater than not less than 6 and is not equal to 5"

### Iterating over vectors

``` r
# create an empty variable to hold our ordered categorical data
gap_dat$income_level <- ordered(NA, levels = c("low-income",
                                                      "middle-income",
                                                      "high-income"))
# start the for loop to add values to income-level based on GDP values
for (i in seq_along(gap_dat$income_level)) { # for each item along the dataframe
  if (gap_dat$gdpPercap[i] <= 10000) { # if gdpPercap is LT = to 10000
    gap_dat$income_level[i] <- 'low-income' # add 'low-income' to that observation's income level variable
  }else if (gap_dat$gdpPercap[i] <= 75000) { # else, if gdpPercap is LT = 75000
    gap_dat$income_level[i] <- "middle-income" #  add 'middle-income' to that observation's income level variable
  }else { # otherwise
    gap_dat$income_level[i] <- "high-income"  #  add 'high-income' to that observation's income level variable
  }
}
summary(gap_dat$income_level)
```

    ##    low-income middle-income   high-income 
    ##          1312           387             5

### `ifelse()`

``` r
# Assign values
# of 'below-average' if lifeExp is equal to or below 59.47 
# and 'above-average' if above 59.47
gap_dat$lifeExp_cat <- ifelse(gap_dat$lifeExp <= 59.47,
                              "below-average",
                              "above-average")

# assign appropriate data type
gap_dat$lifeExp_cat <- ordered(gap_dat$lifeExp_cat,
                               levels = c("below-average", "above-average"))

summary(gap_dat$lifeExp_cat)
```

    ## below-average above-average 
    ##           809           895

### `ifelse()` construct

``` r
# create a numeric vector
some_numbers <- c(6:-4)

# take the square root of each value, which creates a bit of an issue
sqrt(some_numbers)
```

    ##  [1] 2.449490 2.236068 2.000000 1.732051 1.414214 1.000000 0.000000      NaN      NaN      NaN      NaN

## Solution: use `if_else()`

``` r
# using if else to test for numbers greater than or equal to 0
# if true, calculate the square root
# if false, produce NA
sqrt(ifelse(some_numbers >= 0, some_numbers, NA))
```

    ##  [1] 2.449490 2.236068 2.000000 1.732051 1.414214 1.000000 0.000000       NA       NA       NA       NA

## Same result, less code: `case_when()` and `cut()`

``` r
income_cw <- dplyr::case_when(
  gap_dat$gdpPercap <= 10000 ~ "low-income",
  gap_dat$gdpPercap <= 75000 ~ "middle-income",
  .default = "high-income"
)

income_cw <- ordered(income_cw,
                     levels = c("low-income", "middle-income", "high-income"))

# cut() takes in a numeric value (gdpperCap)
# sets the bins (breaks)
# and assigns new levels
income_cut <- cut(gap_dat$gdpPercap,
                  breaks = c(-Inf, 10000, 75000, Inf),
                  labels = c("low-income", "middle-income", "high-income"),
                  ordered_result = TRUE)


identical(income_cw, gap_dat$income_level)  # same as the for loop?
```

    ## [1] TRUE

``` r
identical(income_cut, gap_dat$income_level)
```

    ## [1] TRUE

``` r
summary(income_cut)
```

    ##    low-income middle-income   high-income 
    ##          1312           387             5

## `case_when()`

``` r
gap_dat$pop_size <- dplyr::case_when(
  gap_dat$pop <= 1000000 ~ "small",
  gap_dat$pop <= 100000000 ~ "medium",
  gap_dat$pop > 100000000 ~ "large"
)

gap_dat$pop_size <- ordered(gap_dat$pop_size, levels = c("small", "medium", "large"))

summary(gap_dat$pop_size)
```

    ##  small medium  large 
    ##    180   1447     77

## `switch()`: choosing by name

``` r
# switch assigns values based on character string
summarise_col <- function(x, stat = "mean") {
  switch(stat,
         mean   = mean(x),     # if stat = 'mean'
         median = median(x),   # if stat = 'median'
         sd     = sd(x),
         # stop defines an error message if input is not accepted
         # can be captured by a log file
         stop("stat must be mean, median or sd, not ", stat))
}

summarise_col(gap_dat$lifeExp, "median")
```

    ## [1] 60.7125

``` r
summarise_col(gap_dat$lifeExp, "mod")
```

    ## Error in `summarise_col()`:
    ## ! stat must be mean, median or sd, not mod

## Catching problems: `stop()`, `stopifnot()` and `warning()`

``` r
safe_log <- function(x) {
  # idicates output is not numeric
  stopifnot(is.numeric(x))                    # stop: can't continue
  if (any(x <= 0, na.rm = TRUE)) {            # warn: can continue
    # return descriptive custom warning
    warning("x has values <= 0; log() returns NaN or -Inf for those") 
  }
  # if x is numeric and > 0 return the log of x
  log(x)
}

safe_log(c(1, 10, 100))
```

    ## [1] 0.000000 2.302585 4.605170

``` r
safe_log("10")
```

    ## Error in `safe_log()`:
    ## ! is.numeric(x) is not TRUE

``` r
safe_log(c(-1, 10))
```

    ## [1]      NaN 2.302585

## Takeaway

- `if` / `else if` / `else` choose what to do for **one** value
  - the condition must be a single `TRUE` or `FALSE`: no vectors, no
    `NA`
  - use `&&` / `||` inside `if`, `&` / `|` for whole vectors
- For whole columns, use vectorized conditions:
  - `ifelse()` / `if_else()` for two outcomes
  - `case_when()` for many outcomes; order matters, first `TRUE` wins
  - `cut()` to bin numbers into ordered categories
- `switch()` chooses between options by name
- `stop()`, `stopifnot()` and `warning()` catch problems early with
  clear messages
- When you rewrite code, check that the old and new versions agree with
  `identical()`
