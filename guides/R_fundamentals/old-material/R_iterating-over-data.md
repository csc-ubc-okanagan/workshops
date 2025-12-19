---
title: "R: Iterating Over Data"
output:
  html_document:
    keep_md: yes
---



Last Updates: 2023-10-17

## Vectorization

In general, R takes care of a lot of iteration for you; this is perhaps why R is based around atomic vectors as a fundamental data structure. When processing your data, R looks at the data type of the vector -- not every value in it -- and frequently passes the task off to code written in a much faster language, like C or Fortran. This helps to keep R code as fast as possible. You can see this by looking at a function's internals - these 'vectorized' functions are often denoted by something like `Primitive` or `Internal`.


```r
# look inside the sum() and sqrt() functions
sum
```

```
## function (..., na.rm = FALSE)  .Primitive("sum")
```

```r
sqrt
```

```
## function (x)  .Primitive("sqrt")
```

```r
# look inside the colSums() function that does some tests in R first before passing along
colSums
```

```
## function (x, na.rm = FALSE, dims = 1L) 
## {
##     if (is.data.frame(x)) 
##         x <- as.matrix(x)
##     if (!is.array(x) || length(dn <- dim(x)) < 2L) 
##         stop("'x' must be an array of at least two dimensions")
##     if (dims < 1L || dims > length(dn) - 1L) 
##         stop("invalid 'dims'")
##     n <- prod(dn[id <- seq_len(dims)])
##     dn <- dn[-id]
##     z <- if (is.complex(x)) 
##         .Internal(colSums(Re(x), n, prod(dn), na.rm)) + (0+1i) * 
##             .Internal(colSums(Im(x), n, prod(dn), na.rm))
##     else .Internal(colSums(x, n, prod(dn), na.rm))
##     if (length(dn) > 1L) {
##         dim(z) <- dn
##         dimnames(z) <- dimnames(x)[-id]
##     }
##     else names(z) <- dimnames(x)[[dims + 1L]]
##     z
## }
## <bytecode: 0x00000239cebae130>
## <environment: namespace:base>
```

What this means in practice, is that we can pass a vector to one of these functions, and the function operates on the entire vector.


```r
some_numbers <- c(1:10)
sqrt(some_numbers + 2)
```

```
##  [1] 1.732051 2.000000 2.236068 2.449490 2.645751 2.828427 3.000000 3.162278
##  [9] 3.316625 3.464102
```

Similarly, we can pass an object made of vectors and the whole 'package' is passed along.


```r
library(gapminder)
library(dplyr)
data_gapminder_num <- select(gapminder, is.numeric)
colSums(data_gapminder_num)
```

```
##         year      lifeExp          pop    gdpPercap 
## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07
```

```r
colMeans(data_gapminder_num)
```

```
##         year      lifeExp          pop    gdpPercap 
## 1.979500e+03 5.947444e+01 2.960121e+07 7.215327e+03
```

If you hear people talking about 'vectorizing your code', generally they mean taking advantage of this construct.

## Functions That Loop For You

R also has several several built in functions that hide the need to build a loop for you; these are generally simpler and faster than writing your own loops. Perhaps the most common are the `apply()` family of functions. Generally, these functions work such that you provide a data set and function to apply across that data set, but each is a little unique in terms of what it expects, how it expects it, and what it returns. Each will cater to slightly different use cases.

### apply()

`apply()` operates on a matrix or array (it will convert an eligible data frame to a matrix) and takes three arguments, the data set, a dimension (1 = row, 2 = column) on which to apply a function, and a function.


```r
apply(data_gapminder_num, 2, sum)
```

```
##         year      lifeExp          pop    gdpPercap 
## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07
```

```r
head(apply(data_gapminder_num[data_gapminder_num$year == 1952, ], 2, sort))
```

```
##      year lifeExp    pop gdpPercap
## [1,] 1952  28.801  60011  298.8462
## [2,] 1952  30.000  63149  299.8503
## [3,] 1952  30.015 120447  328.9406
## [4,] 1952  30.331 147962  331.0000
## [5,] 1952  31.286 153936  339.2965
## [6,] 1952  31.975 160000  362.1463
```

```r
apply(data_gapminder_num, 2, max)
```

```
##         year      lifeExp          pop    gdpPercap 
## 2.007000e+03 8.260300e+01 1.318683e+09 1.135231e+05
```

### lapply() and sapply()

`lapply()` and `sapply()` are similar to `apply()`, but a little simpler in their construction; both require only a data set (vector, data frame, or list) and a function as an argument.

`lapply()` always returns a list and `sapply()` 'simplifies' the output, returning a vector or matrix.


```r
lapply(data_gapminder_num, sum)
```

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
```

```r
sapply(data_gapminder_num, sum)
```

```
##         year      lifeExp          pop    gdpPercap 
## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07
```

When using `lapply()` it can be handy to be familiar with `unlist()`, which simplifies a list to a vector:


```r
unlist(lapply(data_gapminder_num, sum))
```

```
##         year      lifeExp          pop    gdpPercap 
## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07
```

### mapply()

`apply()`, `sapply()`, etc all take a single object (vector, data frame, etc), as an argument and perform a function on that object. `mapply()` applies a function *across* more than one object. To do this, you start with the function and then a list of data objects:


```r
# three vectors
a <- c(1:10)
b <- c(11:20)
c <- c(21:30)

# sum each element together in order (first value of each object, second value, etc)
mapply(sum, a, b, c)
```

```
##  [1] 33 36 39 42 45 48 51 54 57 60
```

This is functionally equivalent to first merging the objects into one object and then using one of the other members of the `apply()` family


```r
d <- cbind(a, b, c)
d
```

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
```

```r
apply(d, 1, sum)
```

```
##  [1] 33 36 39 42 45 48 51 54 57 60
```

## Tidyverse

The purrr package from Tidyverse provides an equivalent to the `apply()` family of functions, called `map()` and `map2()`. These are constructed to be consistent in how they take their inputs and specific in what they return. `map()` expects one data object, `map2()` expects two data objects. 


```r
# install purr if not already installed
# install.packages("purrr")
library(purrr)
map(data_gapminder_num, sum)
```

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
```

```r
map2(a, b, sum)
```

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
```

There are several variations on `map()` and `map2()` - it's worth consulting the documentation if you plan to use the Tidyverse approach:

* `map()`: https://purrr.tidyverse.org/reference/map.html
* `map2()`: https://purrr.tidyverse.org/reference/map2.html

## For Loops

Vecotrization and pre-existing looping functions will be the fastest and likely simplest way to iterate over your data. When your task is unique, however, you may need to write your own loop. Two common loop constructs are 'for loops' and 'while loops'. Here we cover the former.

For loops iterate for a pre-determined number of iterations and take the following basic approach:

```
for (each value in a list of values using an indexed location) {
do something;
} 
```

for example


```r
for (int in c(1:10)) { # for each int in the range 1 through 10
  print(int) # print that int
}
```

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
```

We can similarly walk over a data frame


```r
# sample our data to keep things small
data_gapminder_sample <- data_gapminder_num[sample(nrow(data_gapminder_num), 20), ]

data_gapminder_sample
```

```
## # A tibble: 20 × 4
##     year lifeExp       pop gdpPercap
##    <int>   <dbl>     <int>     <dbl>
##  1  1972    72.9  22284500    18971.
##  2  1997    68.0  63327987     8264.
##  3  1967    46.6    420690     2613.
##  4  1972    73.5   4991596    18866.
##  5  1962    44.2   1146757     1056.
##  6  1977    46.5    228694     3082.
##  7  1962    49.1  10516500     4957.
##  8  1952    38.5    863308      576.
##  9  1967    71.1  52667100    10022.
## 10  1987    54.9    395114     1316.
## 11  1997    43.8   6633514      931.
## 12  1962    69.4   2310904     7106.
## 13  2002    50.7  67946797      530.
## 14  1992    71.6   3326498     2497.
## 15  2007    78.2 301139947    42952.
## 16  1977    73.5  56059245    14256.
## 17  1972    40.3   7450606      422.
## 18  1962    38.4   3628608      428.
## 19  1962    53.5   3453434     1662.
## 20  1997    69.5   5783439     5155.
```

```r
#example of what we want to print, the log base 10 of the first value in the column gdpPercap
print(log10(data_gapminder_sample$gdpPercap[1]))
```

```
## [1] 4.27808
```

```r
# for demonstration purposes
# for each indexed position in our sampled data
# print the index position and
# the log base 10 of the per capita gdp for that index point
for (index in seq_along(data_gapminder_sample$gdpPercap)) {
  print(index)
  print(log10(data_gapminder_sample$gdpPercap[index]))
}
```

```
## [1] 1
## [1] 4.27808
## [1] 2
## [1] 3.917169
## [1] 3
## [1] 3.417156
## [1] 4
## [1] 4.275685
## [1] 5
## [1] 3.023621
## [1] 6
## [1] 3.488799
## [1] 7
## [1] 3.695222
## [1] 8
## [1] 2.7601
## [1] 9
## [1] 4.000972
## [1] 10
## [1] 3.11925
## [1] 11
## [1] 2.968761
## [1] 12
## [1] 3.851603
## [1] 13
## [1] 2.72432
## [1] 14
## [1] 3.397495
## [1] 15
## [1] 4.63298
## [1] 16
## [1] 4.153997
## [1] 17
## [1] 2.624925
## [1] 18
## [1] 2.631343
## [1] 19
## [1] 3.220667
## [1] 20
## [1] 3.712214
```

We can store values within a for loop, but they are confined to that for loop and are not accessible outside of it


```r
for (index in seq_along(data_gapminder_sample$gdpPercap)) {
  index_number <- index
  log <- log10(data_gapminder_sample$gdpPercap[index])
  cat(paste0("The log base 10 of the index point ", index, " is: ", log, "\n"))
}
```

```
## The log base 10 of the index point 1 is: 4.27808039981948
## The log base 10 of the index point 2 is: 3.91716877724031
## The log base 10 of the index point 3 is: 3.41715630666173
## The log base 10 of the index point 4 is: 4.2756846000415
## The log base 10 of the index point 5 is: 3.02362115947219
## The log base 10 of the index point 6 is: 3.48879895792208
## The log base 10 of the index point 7 is: 3.69522224658516
## The log base 10 of the index point 8 is: 2.76010041014319
## The log base 10 of the index point 9 is: 4.00097178847123
## The log base 10 of the index point 10 is: 3.11924955698062
## The log base 10 of the index point 11 is: 2.9687613813918
## The log base 10 of the index point 12 is: 3.85160263257717
## The log base 10 of the index point 13 is: 2.72431973268524
## The log base 10 of the index point 14 is: 3.39749469826406
## The log base 10 of the index point 15 is: 4.632979883279
## The log base 10 of the index point 16 is: 4.15399722211687
## The log base 10 of the index point 17 is: 2.62492535061919
## The log base 10 of the index point 18 is: 2.6313433883056
## The log base 10 of the index point 19 is: 3.22066691101895
## The log base 10 of the index point 20 is: 3.71221396789169
```

In order to store the output of a for loop, we first need to create an object to hold the data.


```r
# create an empty vector of a known length and data type
gdp_percapita_log <- vector(mode = "double", length = nrow(data_gapminder_sample))

# update the values of the vector as we iterate over gdpPercap
for (i in seq_along(data_gapminder_sample$gdpPercap)){
  gdp_percapita_log[i] <- log10(data_gapminder_sample$gdpPercap[i])
}

# print the vector
gdp_percapita_log
```

```
##  [1] 4.278080 3.917169 3.417156 4.275685 3.023621 3.488799 3.695222 2.760100
##  [9] 4.000972 3.119250 2.968761 3.851603 2.724320 3.397495 4.632980 4.153997
## [17] 2.624925 2.631343 3.220667 3.712214
```
