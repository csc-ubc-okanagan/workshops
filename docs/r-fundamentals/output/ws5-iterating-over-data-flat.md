# Learning R: Iterating Over Data

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

- **iteration** the process of repeating a set of instructions until a
  specific condition is met
- **iterate** sequentially or in **vectorized** fashion
- topics:
  - **vectorization:** what it is and why it’s fast
  - **thinking in vectors:** element-wise operations, recycling, logical
    vectors
  - **loops in disguise:** the `apply()` family and `purrr::map()`
  - **for-loops done right:** preallocating your output

### Vectorization

``` r
# look inside the sum() and sqrt() functions
sum
```

    ## function (..., na.rm = FALSE)  .Primitive("sum")

``` r
sqrt
```

    ## function (x)  .Primitive("sqrt")

``` r
# look inside the colSums() function that does some tests in R first before passing along
colSums
```

    ## function (x, na.rm = FALSE, dims = 1L) 
    ## {
    ##     if (is.data.frame(x)) 
    ##         x <- as.matrix(x)
    ##     if (!is.array(x) || length(dn <- dim(x)) < 2L) 
    ##         stop("'x' must be an array of at least two dimensions")
    ##     if (length(dims) != 1L || dims < 1L || dims > length(dn) - 
    ##         1L) 
    ##         stop("invalid 'dims'")
    ##     n <- prod(dn[id <- seq_len(dims)])
    ##     dn <- dn[-id]
    ##     z <- .Internal(colSums(x, n, prod(dn), na.rm))
    ##     if (length(dn) > 1L) {
    ##         dim(z) <- dn
    ##         dimnames(z) <- dimnames(x)[-id]
    ##     }
    ##     else names(z) <- dimnames(x)[[dims + 1L]]
    ##     z
    ## }
    ## <bytecode: 0x000001faa2e75210>
    ## <environment: namespace:base>

### Why work with vectors 🤔

``` r
x <- runif(1e6)

loop_sqrt <- function(x) {
  out <- numeric(length(x))
  for (i in seq_along(x)) out[i] <- sqrt(x[i] + 2)
  out
}

bench::mark(
  loop       = loop_sqrt(x),
  vectorized = sqrt(x + 2)
)[, c("expression", "median")]
```

    ## # A tibble: 2 × 2
    ##   expression   median
    ##   <bch:expr> <bch:tm>
    ## 1 loop        64.34ms
    ## 2 vectorized   8.41ms

``` r
timings <- bench::mark(
  loop           = loop_sqrt(x),
  vectorized     = sqrt(x + 2),
  iterations     = 5,
  check          = FALSE 
) %>% 
mutate(expression = c("Base R", "data.table")) %>%
  dplyr::select(c(expression, min, median))
```

### Working with vectors

``` r
some_numbers <- c(1:10)
sqrt(some_numbers + 2)
```

    ##  [1] 1.732051 2.000000 2.236068 2.449490 2.645751 2.828427
    ##  [7] 3.000000 3.162278 3.316625 3.464102

### Vectorize your code

``` r
data_gapminder_num <- select(gap_dat, is.numeric) # grab any column where is.numeric() is true
colSums(data_gapminder_num) 
```

    ##         year      lifeExp          pop    gdpPercap 
    ## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07

``` r
colMeans(data_gapminder_num)
```

    ##         year      lifeExp          pop    gdpPercap 
    ## 1.979500e+03 5.947444e+01 2.960121e+07 7.215327e+03

### Functions That Loop For You

### `apply()`

``` r
apply(data_gapminder_num, 2, sum)
```

    ##         year      lifeExp          pop    gdpPercap 
    ## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07

``` r
head(apply(data_gapminder_num[data_gapminder_num$year == 1952, ], 2, sort))
```

    ##      year lifeExp    pop gdpPercap
    ## [1,] 1952  28.801  60011  298.8462
    ## [2,] 1952  30.000  63149  299.8503
    ## [3,] 1952  30.015 120447  328.9406
    ## [4,] 1952  30.331 147962  331.0000
    ## [5,] 1952  31.286 153936  339.2965
    ## [6,] 1952  31.975 160000  362.1463

``` r
apply(data_gapminder_num, 2, max)
```

    ##         year      lifeExp          pop    gdpPercap 
    ## 2.007000e+03 8.260300e+01 1.318683e+09 1.135231e+05

### `lapply()` and `sapply()`

- `lapply()` always returns a list

- `sapply()` simplifies the output, returning a vector or matrix

### Working with `lapply()` and `sapply()`

``` r
lapply(data_gapminder_num, sum)
```

    ## $year
    ## [1] 3373068
    ## 
    ## $lifeExp
    ## [1] 101344.4
    ## 
    ## $pop
    ## [1] 50440465801
    ## 
    ## $gdpPercap
    ## [1] 12294917

``` r
sapply(data_gapminder_num, sum)
```

    ##         year      lifeExp          pop    gdpPercap 
    ## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07

### `unlist()`

``` r
unlist(lapply(data_gapminder_num, sum))
```

    ##         year      lifeExp          pop    gdpPercap 
    ## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07

### `mapply()`

- `mapply()` applies function *across* more than one object

### Using `mapply()`

``` r
# three vectors
a <- c(1:10)
b <- c(11:20)
c <- c(21:30)

# sum each element together in order (first value of each object, second value, etc)
mapply(sum, a, b, c)
```

    ##  [1] 33 36 39 42 45 48 51 54 57 60

### `mapply()` is just `apply()`

``` r
d <- cbind(a, b, c)
d
```

    ##        a  b  c
    ##  [1,]  1 11 21
    ##  [2,]  2 12 22
    ##  [3,]  3 13 23
    ##  [4,]  4 14 24
    ##  [5,]  5 15 25
    ##  [6,]  6 16 26
    ##  [7,]  7 17 27
    ##  [8,]  8 18 28
    ##  [9,]  9 19 29
    ## [10,] 10 20 30

``` r
apply(d, 1, sum)
```

    ##  [1] 33 36 39 42 45 48 51 54 57 60

### Iterating with **Tidyverse**

``` r
# install purr if not already installed
# install.packages("purrr")
map(data_gapminder_num, sum)
```

    ## $year
    ## [1] 3373068
    ## 
    ## $lifeExp
    ## [1] 101344.4
    ## 
    ## $pop
    ## [1] 50440465801
    ## 
    ## $gdpPercap
    ## [1] 12294917

``` r
map2(a, b, sum)
```

    ## [[1]]
    ## [1] 12
    ## 
    ## [[2]]
    ## [1] 14
    ## 
    ## [[3]]
    ## [1] 16
    ## 
    ## [[4]]
    ## [1] 18
    ## 
    ## [[5]]
    ## [1] 20
    ## 
    ## [[6]]
    ## [1] 22
    ## 
    ## [[7]]
    ## [1] 24
    ## 
    ## [[8]]
    ## [1] 26
    ## 
    ## [[9]]
    ## [1] 28
    ## 
    ## [[10]]
    ## [1] 30

### Note

- `map()`: <https://purrr.tidyverse.org/reference/map.html>
- `map2()`: <https://purrr.tidyverse.org/reference/map2.html>

### For-loops

``` r
for (int in c(1:10)) { # for each int in the range 1 through 10
  print(int) # print that int
}
```

    ## [1] 1
    ## [1] 2
    ## [1] 3
    ## [1] 4
    ## [1] 5
    ## [1] 6
    ## [1] 7
    ## [1] 8
    ## [1] 9
    ## [1] 10

### Sampling

``` r
# sample our data to keep things small
data_gapminder_sample <- data_gapminder_num[sample(nrow(data_gapminder_num), 20), ]

data_gapminder_sample
```

    ##      year lifeExp      pop  gdpPercap
    ## 751  1982  73.100  3480000 12618.3214
    ## 1421 1972  73.060 34513161 10638.7513
    ## 137  1972  46.714  4565872  2980.3313
    ## 1457 1972  49.552   480105  3364.8366
    ## 1038 1977  42.495 11127868   502.3197
    ## 21   1992  71.581  3326498  2497.4379
    ## 1195 1982  66.874  3366439  4258.5036
    ## 213  1992  44.736  5809236   631.6999
    ## 1589 1972  51.016 10190285   950.7359
    ## 1203 1962  49.096 10516500  4957.0380
    ## 1466 1957  72.490  7363802  9911.8782
    ## 192  2007  73.005  7322858 10680.7928
    ## 467  2002  69.806 73312559  4754.6044
    ## 1277 1972  69.210 20662648  8011.4144
    ## 918  1977  46.881  8007166  1544.2286
    ## 515  2002  50.725 67946797   530.0535
    ## 1106 1957  45.432  1358828  3457.4159
    ## 78   1977  72.170  7568430 19749.4223
    ## 1585 1952  39.978  5824797   734.7535
    ## 529  1952  67.410 42459667  7029.8093

``` r
#example of what we want to print, the log base 10 of the first value in the column gdpPercap
print(log10(data_gapminder_sample$gdpPercap[1]))
```

    ## [1] 4.101002

``` r
# for demonstration purposes
# for each indexed position in our sampled data
# print the index position and
# the log base 10 of the per capita gdp for that index point
for (index in seq_along(data_gapminder_sample$gdpPercap)) {
  print(index)
  print(log10(data_gapminder_sample$gdpPercap[index]))
}
```

    ## [1] 1
    ## [1] 4.101002
    ## [1] 2
    ## [1] 4.026891
    ## [1] 3
    ## [1] 3.474265
    ## [1] 4
    ## [1] 3.526964
    ## [1] 5
    ## [1] 2.70098
    ## [1] 6
    ## [1] 3.397495
    ## [1] 7
    ## [1] 3.629257
    ## [1] 8
    ## [1] 2.800511
    ## [1] 9
    ## [1] 2.97806
    ## [1] 10
    ## [1] 3.695222
    ## [1] 11
    ## [1] 3.996156
    ## [1] 12
    ## [1] 4.028603
    ## [1] 13
    ## [1] 3.677114
    ## [1] 14
    ## [1] 3.903709
    ## [1] 15
    ## [1] 3.188712
    ## [1] 16
    ## [1] 2.72432
    ## [1] 17
    ## [1] 3.538752
    ## [1] 18
    ## [1] 4.295554
    ## [1] 19
    ## [1] 2.866142
    ## [1] 20
    ## [1] 3.846944

### Anatomy of a ‘For-loop’

``` r
out <- numeric(length(x))   # output: somewhere to store results

for (i in seq_along(x)) {   # for (loop variable in sequence)
  out[i] <- sqrt(x[i])      # body: runs once per iteration
} 
```

### Writing a for-loop

``` r
for (index in seq_along(data_gapminder_sample$gdpPercap)) {
  index_number <- index
  log <- log10(data_gapminder_sample$gdpPercap[index])
  cat(paste0("The log base 10 of the index point ", index, " is: ", log, "\n"))
}
```

    ## The log base 10 of the index point 1 is: 4.10100158542625
    ## The log base 10 of the index point 2 is: 4.02689065700032
    ## The log base 10 of the index point 3 is: 3.47426454954607
    ## The log base 10 of the index point 4 is: 3.5269639825025
    ## The log base 10 of the index point 5 is: 2.70098023955392
    ## The log base 10 of the index point 6 is: 3.39749469826406
    ## The log base 10 of the index point 7 is: 3.62925701912801
    ## The log base 10 of the index point 8 is: 2.80051079288172
    ## The log base 10 of the index point 9 is: 2.97805987911551
    ## The log base 10 of the index point 10 is: 3.69522224658516
    ## The log base 10 of the index point 11 is: 3.99615595780494
    ## The log base 10 of the index point 12 is: 4.02860349094832
    ## The log base 10 of the index point 13 is: 3.67711438920957
    ## The log base 10 of the index point 14 is: 3.90370919682789
    ## The log base 10 of the index point 15 is: 3.18871158763867
    ## The log base 10 of the index point 16 is: 2.72431973268524
    ## The log base 10 of the index point 17 is: 3.53875163080657
    ## The log base 10 of the index point 18 is: 4.29555439638822
    ## The log base 10 of the index point 19 is: 2.86614165405515
    ## The log base 10 of the index point 20 is: 3.84694354559525

### Storing output with for-loops

``` r
# create an empty vector of a known length and data type
gdp_percapita_log <- vector(mode = "double",
                            length = nrow(data_gapminder_sample))

# update the values of the vector as we iterate over gdpPercap
for (i in seq_along(data_gapminder_sample$gdpPercap)){
  gdp_percapita_log[i] <- log10(data_gapminder_sample$gdpPercap[i])
}

# print the vector
gdp_percapita_log
```

    ##  [1] 4.101002 4.026891 3.474265 3.526964 2.700980 3.397495
    ##  [7] 3.629257 2.800511 2.978060 3.695222 3.996156 4.028603
    ## [13] 3.677114 3.903709 3.188712 2.724320 3.538752 4.295554
    ## [19] 2.866142 3.846944

### Takeaway

- R is built on vectors, so let functions work on a **whole vector at
  once**
- Vectorized functions are *fast*
- Think in element-wise operations (e.g., `sum(x > 70)`, `mean(x > 70)`)
- The `apply()` family and `purrr::map()` **are loops**
  - `lapply()` / `map()` return a list; `sapply()` simplifies
  - `mapply()` / `map2()` iterate over more than one object
- Write a `for` loop when each step depends on the last
  - **preallocate** your output first
