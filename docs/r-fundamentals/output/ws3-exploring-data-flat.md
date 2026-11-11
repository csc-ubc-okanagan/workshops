# R: Exploring Data

<style>
  .notes { display: none; }
  hr { display: none; }
  .site-footer, .footer { display: none; }
</style>

## Getting oriented

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

- Let’s load the gapminder dataset.

``` r
suppressMessages(library(dplyr)); suppressMessages(library(purrr)) # now go ahead and load them

data_gapminder <- read.csv(file.path("..", "..", "data", "gapminder_nas.csv"))
```

## What are missing values

- Run `data_gapminder` in your console

- `NA` stands for “not available”, a special `boolean` for missing data
  within an object

- `NA_integer_`, `NA_real_`, `NA_complex_` and `NA_character_`

- `NULL` used for empty objects (points to the same singleton place in
  memory), think of it like an object purgatory. It exists and…it
  doesn’t.

- Analogous (but perhaps not equivalent to) `SASS` `SYSMIS`

## Missingness in `R`

|  | `NA` | `NULL` |
|----|----|----|
| **Meaning** | A value exists but is unknown | No value at all |
| **Length** | 1 | 0 |
| **Type** | `logical` by default (also `NA_integer_`, `NA_real_`, `NA_character_`) | `"NULL"` |
| **In a vector** | Keeps its slot: `c(1, NA, 3)` → `1 NA 3` | Disappears: `c(1, NULL, 3)` → `1 3` |
| **In calculations** | Spreads: `NA + 1` → `NA` | Returns empty: `NULL + 1` → `numeric(0)` |
| **How many exist** | Many (each is its own value in memory) | One shared object per session |
| **`tracemem()`** | Works | Error: cannot trace NULL |
| **Test with** | `is.na()` | `is.null()` |
| **Typical source** | Skipped survey answer, failed conversion | Missing list element, function returning nothing |

## How `R` handles ‘missingness’

``` r
# NULL = "nothing here"; NA = "something here, but we don't know what"
x_null <- NULL
x_na   <- NA

length(x_null)   # 0  -- no object, no slot
```

    ## [1] 0

``` r
length(x_na)     # 1  -- one slot, value unknown
```

    ## [1] 1

``` r
typeof(x_null)   # "NULL"
```

    ## [1] "NULL"

``` r
typeof(x_na)     # "logical" -- NA has a type!
```

    ## [1] "logical"

``` r
# The difference shows up inside vectors
c(1, NULL, 3)    # 1 3     -- NULL just vanishes
```

    ## [1] 1 3

``` r
c(1, NA, 3)      # 1 NA 3  -- NA keeps its place
```

    ## [1]  1 NA  3

``` r
# Testing for each
is.null(x_null)  # TRUE
```

    ## [1] TRUE

``` r
is.na(x_na)      # TRUE
```

    ## [1] TRUE

``` r
is.na(x_null)    # logical(0) + a warning -- the wrong test for NULL
```

    ## logical(0)

``` r
# NA is "contagious": unknown in, unknown out
NA + 1           # NA
```

    ## [1] NA

``` r
NA == NA         # NA, not TRUE! Use is.na() instead
```

    ## [1] NA

``` r
mean(c(1, NA, 3))               # NA
```

    ## [1] NA

``` r
mean(c(1, NA, 3), na.rm = TRUE) # 2
```

    ## [1] 2

``` r
# tracemem() needs an actual object to trace
# tracemem(x_null) # Error: cannot trace NULL
```

## Working with missing values

``` r
na_values <- c("NA", "NULL", "", " ")
data_gapminder <- read.csv(file.path("..", "..", "data", "gapminder_nas.csv"), na.strings = na_values)
# is.na()
```

## Complete cases

``` r
complete_gapminder <- complete.cases(data_gapminder)
complete_gapminder <- data_gapminder[which(complete_gapminder),]
#typeof(complete_gapminder)
```

## Small rant

``` r
mean(data_gapminder[which(data_gapminder$continent == "Americas"),]$lifeExp, na.rm = TRUE)
```

    ## [1] 64.32363

``` r
mean(complete_gapminder[which(complete_gapminder$continent == "Americas"),]$lifeExp)
```

    ## [1] 61.70087

## Imputation to the rescue?

``` r
# Compare sample size before and after complete.cases
nrow(data_gapminder)
```

    ## [1] 1704

``` r
sum(complete.cases(data_gapminder))
```

    ## [1] 853

``` r
# Simple example of mean imputation
data_imputed <- data_gapminder
data_imputed$lifeExp[is.na(data_imputed$lifeExp)] <- 
  mean(data_imputed$lifeExp, na.rm = TRUE)
```

## Inspecting data

``` r
complete_gapminder <- complete.cases(data_gapminder) # for later use
# first few index numbers of complete cases
head(which(complete_gapminder))
```

    ## [1]  2  3  4  5  8 12

## Unique values

``` r
unique(data_gapminder$continent)
```

    ## [1] "Asia"     "Europe"   "Africa"   "Americas" "Oceania"

## Duplicated values

``` r
# on a vector
head(duplicated(data_gapminder$continent))
```

    ## [1] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE

``` r
# there are 5 unique continents and 1699 duplicates
sum(duplicated(data_gapminder$continent))
```

    ## [1] 1699

``` r
# on a data frame
head(duplicated(data_gapminder))
```

    ## [1] FALSE FALSE FALSE FALSE FALSE FALSE

``` r
# there are no duplicate values
sum(duplicated(data_gapminder))
```

    ## [1] 0

## Descriptive Statistics

## Number of Observations

``` r
length(data_gapminder$country)
```

    ## [1] 1704

``` r
length(data_gapminder) # will return ncol, but that's confusing
```

    ## [1] 6

``` r
ncol(data_gapminder)
```

    ## [1] 6

``` r
nrow(data_gapminder)
```

    ## [1] 1704

## The usual suspects: range, min, max, mean, median, sd, variance, quantiles

``` r
range(data_gapminder$year, na.rm = TRUE)
mean(data_gapminder$lifeExp, na.rm = TRUE)
median(data_gapminder$gdpPercap, na.rm = TRUE)
min(data_gapminder$year, na.rm = TRUE)
max(data_gapminder$year, na.rm = TRUE)
quantile(data_gapminder$gdpPercap, na.rm = TRUE)
var(data_gapminder$lifeExp, na.rm = TRUE)
sd(data_gapminder$lifeExp, na.rm = TRUE)
```

## Summaries

``` r
# kable(summary(data_gapminder$gdpPercap)) # could also summarise just one column
summary(data_gapminder)
```

    ##       country         continent         year         lifeExp           pop              gdpPercap       
    ##  Length   :1704   Length   :1704   Min.   :1952   Min.   :23.60   Min.   :6.001e+04   Min.   :   241.2  
    ##  N.unique : 142   N.unique :   5   1st Qu.:1962   1st Qu.:47.83   1st Qu.:2.736e+06   1st Qu.:  1147.4  
    ##  N.blank  :   0   N.blank  :   0   Median :1977   Median :59.63   Median :6.703e+06   Median :  3242.5  
    ##  Min.nchar:   4   Min.nchar:   4   Mean   :1979   Mean   :58.90   Mean   :2.835e+07   Mean   :  6839.5  
    ##  Max.nchar:  24   Max.nchar:   8   3rd Qu.:1992   3rd Qu.:70.60   3rd Qu.:1.836e+07   3rd Qu.:  8533.1  
    ##                                    Max.   :2007   Max.   :82.60   Max.   :1.319e+09   Max.   :113523.1  
    ##                                    NAs    :217    NAs    :192     NAs    :223         NAs    :219

## Proper summary

    ##         country        continent        year         lifeExp           pop              gdpPercap       
    ##  Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60   Min.   :6.001e+04   Min.   :   241.2  
    ##  Albania    :  12   Americas:300   1st Qu.:1962   1st Qu.:47.83   1st Qu.:2.736e+06   1st Qu.:  1147.4  
    ##  Algeria    :  12   Asia    :396   Median :1977   Median :59.63   Median :6.703e+06   Median :  3242.5  
    ##  Angola     :  12   Europe  :360   Mean   :1979   Mean   :58.90   Mean   :2.835e+07   Mean   :  6839.5  
    ##  Argentina  :  12   Oceania : 24   3rd Qu.:1992   3rd Qu.:70.60   3rd Qu.:1.836e+07   3rd Qu.:  8533.1  
    ##  Australia  :  12                  Max.   :2007   Max.   :82.60   Max.   :1.319e+09   Max.   :113523.1  
    ##  (Other)    :1632                  NAs    :217    NAs    :192     NAs    :223         NAs    :219

## Exploring data in `DPLYR`: A better way to do data

## Code for prior slide’s table

``` r
data_gapminder %>%
  summarise(
    mean_life = mean(lifeExp, na.rm = TRUE),
    sd_life   = sd(lifeExp, na.rm = TRUE),
    min_life  = min(lifeExp, na.rm = TRUE),
    max_life  = max(lifeExp, na.rm = TRUE)
  ) %>% flextable() %>% flextable::theme_vanilla() %>%
  flextable::autofit() %>%                # adjusts columns to content
  flextable::set_table_properties(        # ensures full-width fit
    width = 1,
    layout = "autofit"
  )
```

## Exploring data in `DPLYR`: groups

``` r
data_gapminder %>%
  # `group_by` this automatically groups things by class for you very powerful
  group_by(continent) %>% 
  summarise(
    mean_life = mean(lifeExp, na.rm = TRUE),
    n = n()
  )
```

    ## # A tibble: 5 × 3
    ##   continent mean_life     n
    ##   <fct>         <dbl> <int>
    ## 1 Africa         48.6   624
    ## 2 Americas       64.3   300
    ## 3 Asia           59.6   396
    ## 4 Europe         71.7   360
    ## 5 Oceania        74.5    24

## Exploring data `PURRRfectly`: functional programming

``` r
data_gapminder %>%
  split(.$continent) %>%
  map(~ mean(.x$lifeExp, na.rm = TRUE))
```

    ## $Africa
    ## [1] 48.62973
    ## 
    ## $Americas
    ## [1] 64.32363
    ## 
    ## $Asia
    ## [1] 59.62585
    ## 
    ## $Europe
    ## [1] 71.74504
    ## 
    ## $Oceania
    ## [1] 74.47852

## Visualizing Distributions

![](output/ws3-exploring-data-flat_files/figure-gfm/unnamed-chunk-19-1.png)

## Histograms

``` r
hist(data_gapminder$gdpPercap)
```

![](output/ws3-exploring-data-flat_files/figure-gfm/unnamed-chunk-20-1.png)
:::notes You can plot a basic histogram with `hist()` Plotting for
presentation will be covered in greater detail in a future session.
Basic plotting for distribution analysis is relatively straight forward
in base R. :::

## Histograms cont’d

``` r
hist(data_gapminder$gdpPercap, breaks = 30)
```

![](output/ws3-exploring-data-flat_files/figure-gfm/unnamed-chunk-21-1.png)
:::notes And you can increase the ‘buckets’ with the `breaks` argument
:::

## Density Plots

``` r
dens <- density(data_gapminder$lifeExp, na.rm = TRUE)
plot(dens)
```

![](output/ws3-exploring-data-flat_files/figure-gfm/unnamed-chunk-22-1.png)
:::notes A density plot can be generated with `plot()`, but requires the
extra step of computing the density of the data with the `density()`
function first ::: \# Distribution of Two Variables

![](output/ws3-exploring-data-flat_files/figure-gfm/unnamed-chunk-23-1.png)

## Box Plots

``` r
boxplot(data_gapminder$lifeExp ~ data_gapminder$continent)
```

![](output/ws3-exploring-data-flat_files/figure-gfm/unnamed-chunk-24-1.png)
:::notes `boxplot()` allows you to facet one variable by another using a
tilde `~` to define the relationship :::

## Scatter Plots

``` r
plot(x = data_gapminder$gdpPercap, y = data_gapminder$lifeExp)
```

![](output/ws3-exploring-data-flat_files/figure-gfm/unnamed-chunk-25-1.png)

## Data transformations for better visualisation

``` r
# log transform gdp per capita
plot(x = log(data_gapminder$gdpPercap), y = data_gapminder$lifeExp)
```

![](output/ws3-exploring-data-flat_files/figure-gfm/unnamed-chunk-26-1.png)

## References

- Data Camp - [Data Camp](https://www.datacamp.com/doc/r/missingdata)
- Cran R Project Symbols - [R Internal
  Documentation](https://cran.r-project.org/doc/manuals/r-release/R-ints.html#Symbols)
