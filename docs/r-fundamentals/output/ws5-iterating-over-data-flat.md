<style>
  .notes { display: none; }
  hr { display: none; }
  .site-footer, .footer { display: none; }
</style>

## Roadmap 🗾

<style type="text/css">
/* Horizontal scroll for code, R output, and tables */
.reveal pre,
.reveal table {
  display: block;
  overflow-x: auto;
  max-width: 100%;
}

.reveal pre code {
  white-space: pre;  /* keep long lines intact instead of wrapping */
}

/* Vertical scroll for slides that are too tall */
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

The power of computers comes from their ability to compute a lot of
values fast. This task regularly involves *iterating* through a series
of data (whether those data are vectors, data frames, or others). Given
the fundamnetal nature of iteration to computing, it’s essential that we
grasp the various ways available to us as researchers to iterate over
data. We’ll look at where that way of thinking breaks down, and at the
cases where you genuinely need a loop. Then we’ll cover the apply family
and purrr’s map(), which are tidier ways to write loops, and finish with
how to write a for-loop properly when you need one.

## Vectorization

    # look inside the sum() and sqrt() functions
    sum

    ## function (..., na.rm = FALSE)  .Primitive("sum")

    sqrt

    ## function (x)  .Primitive("sqrt")

    # look inside the colSums() function that does some tests in R first before passing along
    colSums

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

In general, R takes care of a lot of iteration for you; this is perhaps
why R is based around atomic vectors as a fundamental data structure.
When processing your data, R looks at the data type of the vector – not
every value in it – and frequently passes the task off to code written
in a much faster language, like `C` or `Fortran.` This helps to keep R
code as fast as possible. You can see this by looking at a function’s
internals - these ‘vectorized’ functions are often denoted by something
like `Primitive` or `Internal`.

## Why work with vectors 🤔

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

    ## # A tibble: 2 × 2
    ##   expression   median
    ##   <bch:expr> <bch:tm>
    ## 1 loop        64.68ms
    ## 2 vectorized   9.63ms

    timings <- bench::mark(
      loop           = loop_sqrt(x),
      vectorized     = sqrt(x + 2),
      iterations     = 5,
      check          = FALSE 
    ) %>% 
    mutate(expression = c("Base R", "data.table")) %>%
      dplyr::select(c(expression, min, median))

The reason why we might want to learn about vectorization is that
vectorizing code is fast–much faster that processing data sequentially.

## Working with vectors

    some_numbers <- c(1:10)
    sqrt(some_numbers + 2)

    ##  [1] 1.732051 2.000000 2.236068 2.449490 2.645751 2.828427 3.000000 3.162278 3.316625 3.464102

What this means in practice, is that we can pass a vector to one of
these functions, and the function operates on the entire vector.

## Vectorize your code

    data_gapminder_num <- select(gap_dat, is.numeric) # grab any column where is.numeric() is true
    colSums(data_gapminder_num) 

    ##         year      lifeExp          pop    gdpPercap 
    ## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07

    colMeans(data_gapminder_num)

    ##         year      lifeExp          pop    gdpPercap 
    ## 1.979500e+03 5.947444e+01 2.960121e+07 7.215327e+03

Similarly, we can pass an object made of vectors and the whole ‘package’
is passed along. If you hear people talking about ‘vectorizing your
code’, generally they mean taking advantage of this construct.

## Functions That Loop For You

R also has several several built in functions that hide the need to
build a loop for you; these are generally simpler and faster than
writing your own loops. Perhaps the most common are the `apply()` family
of functions. Generally, these functions work such that you provide a
data set and function to apply across that data set, but each is a
little unique in terms of what it expects, how it expects it, and what
it returns. Each will cater to slightly different use cases.

## `apply()`

    apply(data_gapminder_num, 2, sum)

    ##         year      lifeExp          pop    gdpPercap 
    ## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07

    head(apply(data_gapminder_num[data_gapminder_num$year == 1952, ], 2, sort))

    ##      year lifeExp    pop gdpPercap
    ## [1,] 1952  28.801  60011  298.8462
    ## [2,] 1952  30.000  63149  299.8503
    ## [3,] 1952  30.015 120447  328.9406
    ## [4,] 1952  30.331 147962  331.0000
    ## [5,] 1952  31.286 153936  339.2965
    ## [6,] 1952  31.975 160000  362.1463

    apply(data_gapminder_num, 2, max)

    ##         year      lifeExp          pop    gdpPercap 
    ## 2.007000e+03 8.260300e+01 1.318683e+09 1.135231e+05

`apply()` operates on a matrix or array (it will convert an eligible
data frame to a matrix) and takes three arguments, the data set, a
dimension (1 = row, 2 = column) on which to apply a function, and a
function.

## `lapply()` and `sapply()`

- `lapply()` always returns a list

- `sapply()` simplifies the output, returning a vector or matrix

`lapply()` and `sapply()` are similar to `apply()`, but a little simpler
in their construction; both require only a data set (vector, data frame,
or list) and a function as an argument.

`lapply()` always returns a list and `sapply()` ‘simplifies’ the output,
returning a vector or matrix.

## Working with `lapply()` and `sapply()`

    lapply(data_gapminder_num, sum)

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

    sapply(data_gapminder_num, sum)

    ##         year      lifeExp          pop    gdpPercap 
    ## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07

## `unlist()`

    unlist(lapply(data_gapminder_num, sum))

    ##         year      lifeExp          pop    gdpPercap 
    ## 3.373068e+06 1.013444e+05 5.044047e+10 1.229492e+07

When using `lapply()` it can be handy to be familiar with `unlist()`,
which simplifies a list to a vector:

## `mapply()`

- `mapply()` applies function *across* more than one object

`apply()`, `sapply()`, etc all take a single object (vector, data frame,
etc), as an argument and perform a function on that object. `mapply()`
applies a function *across* more than one object. To do this, you start
with the function and then a list of data objects:

## Using `mapply()`

    # three vectors
    a <- c(1:10)
    b <- c(11:20)
    c <- c(21:30)

    # sum each element together in order (first value of each object, second value, etc)
    mapply(sum, a, b, c)

    ##  [1] 33 36 39 42 45 48 51 54 57 60

## `mapply()` is just `apply()`

    d <- cbind(a, b, c)
    d

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

    apply(d, 1, sum)

    ##  [1] 33 36 39 42 45 48 51 54 57 60

This is functionally equivalent to first merging the objects into one
object and then using one of the other members of the `apply()` family

## Iterating with **Tidyverse**

    # install purr if not already installed
    # install.packages("purrr")
    map(data_gapminder_num, sum)

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

    map2(a, b, sum)

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

The purrr package from Tidyverse provides an equivalent to the `apply()`
family of functions, called `map()` and `map2()`. These are constructed
to be consistent in how they take their inputs and specific in what they
return. `map()` expects one data object, `map2()` expects two data
objects.

## Note

- `map()`: <https://purrr.tidyverse.org/reference/map.html>
- `map2()`: <https://purrr.tidyverse.org/reference/map2.html>

There are several variations on `map()` and `map2()` - it’s worth
consulting the documentation if you plan to use the Tidyverse approach:

## For-loops

    for (int in c(1:10)) { # for each int in the range 1 through 10
      print(int) # print that int
    }

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

Vectorization and pre-existing looping functions will be the fastest and
likely simplest way to iterate over your data. When your task is unique,
however, you may need to write your own loop. Two common loop constructs
are ‘for loops’ and ‘while loops’. Here we cover the former.

For loops iterate for a pre-determined number of iterations and take the
following basic approach

## Sampling

    # sample our data to keep things small
    data_gapminder_sample <- data_gapminder_num[sample(nrow(data_gapminder_num), 20), ]

    data_gapminder_sample

    ##      year lifeExp      pop  gdpPercap
    ## 779  2002  80.240 57926999 27968.0982
    ## 82   1997  77.510  8069876 29095.9207
    ## 372  2007  48.328 18013409  1544.7501
    ## 52   1967  65.634 22934225  8052.9530
    ## 338  1957  45.053   940458  2315.0566
    ## 1265 1972  64.274   461633  5047.6586
    ## 1049 1972  53.070 28466390   357.0000
    ## 783  1962  65.610  1665128  5246.1075
    ## 1128 2007  56.867 12894865   619.6769
    ## 363  1962  44.930  3832408  1728.8694
    ## 67   1982  74.740 15184200 19477.0093
    ## 384  2007  75.748  4493312 14619.2227
    ## 1079 2002  61.340 25873917  1057.2063
    ## 202  1997  50.324 10352843   946.2950
    ## 1502 1957  62.400 10164215  1507.8613
    ## 284  1987  72.492 12463354  5547.0638
    ## 268  1967  43.601  3495967  1196.8106
    ## 49   1952  62.485 17876956  5911.3151
    ## 567  1962  70.300 73739117 12902.4629
    ## 42   1977  39.483  6162675  3008.6474

    #example of what we want to print, the log base 10 of the first value in the column gdpPercap
    print(log10(data_gapminder_sample$gdpPercap[1]))

    ## [1] 4.446663

    # for demonstration purposes
    # for each indexed position in our sampled data
    # print the index position and
    # the log base 10 of the per capita gdp for that index point
    for (index in seq_along(data_gapminder_sample$gdpPercap)) {
      print(index)
      print(log10(data_gapminder_sample$gdpPercap[index]))
    }

    ## [1] 1
    ## [1] 4.446663
    ## [1] 2
    ## [1] 4.463832
    ## [1] 3
    ## [1] 3.188858
    ## [1] 4
    ## [1] 3.905955
    ## [1] 5
    ## [1] 3.364562
    ## [1] 6
    ## [1] 3.70309
    ## [1] 7
    ## [1] 2.552668
    ## [1] 8
    ## [1] 3.719837
    ## [1] 9
    ## [1] 2.792165
    ## [1] 10
    ## [1] 3.237762
    ## [1] 11
    ## [1] 4.289522
    ## [1] 12
    ## [1] 4.164924
    ## [1] 13
    ## [1] 3.02416
    ## [1] 14
    ## [1] 2.976027
    ## [1] 15
    ## [1] 3.178361
    ## [1] 16
    ## [1] 3.744063
    ## [1] 17
    ## [1] 3.078025
    ## [1] 18
    ## [1] 3.771684
    ## [1] 19
    ## [1] 4.110673
    ## [1] 20
    ## [1] 3.478371

We can similarly walk over a data frame.

## Anatomy of a ‘For-loop’

    out <- numeric(length(x))   # output: somewhere to store results

    for (i in seq_along(x)) {   # for (loop variable in sequence)
      out[i] <- sqrt(x[i])      # body: runs once per iteration
    } 

Read a for-loop out loud as “for each i in this sequence, do the body.”
The loop variable i takes the first value of the sequence, the body
runs, then i takes the next value, and so on until the sequence runs
out. Each pass through the body is called an iteration.

## Writing a for-loop

    for (index in seq_along(data_gapminder_sample$gdpPercap)) {
      index_number <- index
      log <- log10(data_gapminder_sample$gdpPercap[index])
      cat(paste0("The log base 10 of the index point ", index, " is: ", log, "\n"))
    }

    ## The log base 10 of the index point 1 is: 4.44666293536129
    ## The log base 10 of the index point 2 is: 4.46383210379552
    ## The log base 10 of the index point 3 is: 3.18885823537455
    ## The log base 10 of the index point 4 is: 3.90595516552978
    ## The log base 10 of the index point 5 is: 3.36456160814328
    ## The log base 10 of the index point 6 is: 3.70308997040009
    ## The log base 10 of the index point 7 is: 2.55266821611219
    ## The log base 10 of the index point 8 is: 3.71983718762706
    ## The log base 10 of the index point 9 is: 2.79216530171644
    ## The log base 10 of the index point 10 is: 3.23776219463864
    ## The log base 10 of the index point 11 is: 4.28952227118181
    ## The log base 10 of the index point 12 is: 4.16492428251317
    ## The log base 10 of the index point 13 is: 3.02415974699117
    ## The log base 10 of the index point 14 is: 2.97602652785581
    ## The log base 10 of the index point 15 is: 3.1783613920919
    ## The log base 10 of the index point 16 is: 3.74406315737898
    ## The log base 10 of the index point 17 is: 3.078025414328
    ## The log base 10 of the index point 18 is: 3.77168410638546
    ## The log base 10 of the index point 19 is: 4.11067261930134
    ## The log base 10 of the index point 20 is: 3.47837128685849

We can store values within a for loop, but they are confined to that for
loop and are not accessible outside of it.

## Storing output with for-loops

    # create an empty vector of a known length and data type
    gdp_percapita_log <- vector(mode = "double",
                                length = nrow(data_gapminder_sample))

    # update the values of the vector as we iterate over gdpPercap
    for (i in seq_along(data_gapminder_sample$gdpPercap)){
      gdp_percapita_log[i] <- log10(data_gapminder_sample$gdpPercap[i])
    }

    # print the vector
    gdp_percapita_log

    ##  [1] 4.446663 4.463832 3.188858 3.905955 3.364562 3.703090 2.552668 3.719837 2.792165 3.237762 4.289522 4.164924 3.024160
    ## [14] 2.976027 3.178361 3.744063 3.078025 3.771684 4.110673 3.478371

In order to store the output of a for loop, we first need to create an
object to hold the data.

## Takeaway

- R is built on vectors, so let functions work on a **whole vector at
  once**
- Vectorized functions are *fast*
- Think in element-wise operations (e.g., `sum(x > 70)`, `mean(x > 70)`)
- The `apply()` family and `purrr::map()` **are loops**
  - `lapply()` / `map()` return a list; `sapply()` simplifies
  - `mapply()` / `map2()` iterate over more than one object
- Write a `for` loop when each step depends on the last
  - **preallocate** your output first

The big idea from today: before you write a loop, ask whether a
vectorized function already does the job. If it does, it will almost
always be shorter, clearer, and faster. If you need to apply a function
over many columns or list elements, the apply family or purrr’s map()
keep your code tidy. And when each step genuinely depends on the
previous one, a for loop is the right tool, just create the output
object before the loop rather than growing it inside.
