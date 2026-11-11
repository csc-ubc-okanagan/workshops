# Learning R: Iterating Over Data

<style>
  .notes { display: none; }
  hr { display: none; }
  .site-footer, .footer { display: none; }
</style>

### Roadmap 📍

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
    ## 1 loop        64.54ms
    ## 2 vectorized   8.58ms

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

    ##      year lifeExp       pop  gdpPercap
    ## 1315 1982  63.012  11254672 33693.1753
    ## 879  1962  47.747    893143   411.8006
    ## 336  2007  46.462  64606759   277.5519
    ## 1222 1997  68.564  75012988  2536.5349
    ## 1346 1957  31.570   2295678  1004.4844
    ## 801  1992  79.360 124329269 26824.8951
    ## 1371 1962  70.330   4237384  7481.1076
    ## 1502 1957  62.400  10164215  1507.8613
    ## 495  1962  40.158   1666618   380.9958
    ## 421  1952  34.812     63149  2669.5295
    ## 1497 1992  69.249  13219062  3340.5428
    ## 159  1962  51.520    512764   983.6540
    ## 27   1962  48.303  11000948  2550.8169
    ## 860  1987  74.174   1891487 28118.4300
    ## 1369 1952  64.360   3558137  5074.6591
    ## 414  1977  74.690   5088419 20422.9015
    ## 273  1992  51.724   6429417  1058.0643
    ## 1030 1997  67.660  28529501  2982.1019
    ## 1050 1977  56.059  31528087   371.0000
    ## 460  1967  49.293  31681188  1814.8807

``` r
#example of what we want to print, the log base 10 of the first value in the column gdpPercap
print(log10(data_gapminder_sample$gdpPercap[1]))
```

    ## [1] 4.527542

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
    ## [1] 4.527542
    ## [1] 2
    ## [1] 2.614687
    ## [1] 3
    ## [1] 2.443344
    ## [1] 4
    ## [1] 3.404241
    ## [1] 5
    ## [1] 3.001943
    ## [1] 6
    ## [1] 4.428538
    ## [1] 7
    ## [1] 3.873966
    ## [1] 8
    ## [1] 3.178361
    ## [1] 9
    ## [1] 2.58092
    ## [1] 10
    ## [1] 3.426435
    ## [1] 11
    ## [1] 3.523817
    ## [1] 12
    ## [1] 2.992842
    ## [1] 13
    ## [1] 3.406679
    ## [1] 14
    ## [1] 4.448991
    ## [1] 15
    ## [1] 3.705407
    ## [1] 16
    ## [1] 4.310117
    ## [1] 17
    ## [1] 3.024512
    ## [1] 18
    ## [1] 3.474522
    ## [1] 19
    ## [1] 2.569374
    ## [1] 20
    ## [1] 3.258848

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

    ## The log base 10 of the index point 1 is: 4.52754194088831
    ## The log base 10 of the index point 2 is: 2.61468700310939
    ## The log base 10 of the index point 3 is: 2.44334414004637
    ## The log base 10 of the index point 4 is: 3.40424084640125
    ## The log base 10 of the index point 5 is: 3.00194321238603
    ## The log base 10 of the index point 6 is: 4.42853803247444
    ## The log base 10 of the index point 7 is: 3.87396590108497
    ## The log base 10 of the index point 8 is: 3.1783613920919
    ## The log base 10 of the index point 9 is: 2.58092023750837
    ## The log base 10 of the index point 10 is: 3.42643472038373
    ## The log base 10 of the index point 11 is: 3.52381703627158
    ## The log base 10 of the index point 12 is: 2.99284235191855
    ## The log base 10 of the index point 13 is: 3.40667928226323
    ## The log base 10 of the index point 14 is: 4.4489910677682
    ## The log base 10 of the index point 15 is: 3.70540687333909
    ## The log base 10 of the index point 16 is: 4.31011744274222
    ## The log base 10 of the index point 17 is: 3.0245120611648
    ## The log base 10 of the index point 18 is: 3.47452247332618
    ## The log base 10 of the index point 19 is: 2.56937390961505
    ## The log base 10 of the index point 20 is: 3.25884808894596

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

    ##  [1] 4.527542 2.614687 2.443344 3.404241 3.001943 4.428538
    ##  [7] 3.873966 3.178361 2.580920 3.426435 3.523817 2.992842
    ## [13] 3.406679 4.448991 3.705407 4.310117 3.024512 3.474522
    ## [19] 2.569374 3.258848

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
