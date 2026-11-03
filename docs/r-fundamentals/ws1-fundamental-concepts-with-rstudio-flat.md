# R: Fundamental Concepts with RStudio

## What is this series about?

<style>
  .notes { display: none; }
  hr { display: none; }
  .site-footer, .footer { display: none; }
</style>

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

- Modern research consists of computing, lots and lots of *computing*
- This series is designed to introduce researchers to the basics of
  research computing through R
- *Warning*: assumes you’ve already installed Rstudio and R
  - If you have not done so please make an appointment with me through
    the CSC and I would happily assist you :)

## A high-level data analysis workflow

Import (data) ➡️ Tidy (data) ➡️ Visualize (data) ➡️ Communicate
(findings)

## Where we are in the series

1.  **R: Fundamental Concepts with RStudio**

## Why R: supported and open source

- free and open source
- built for data analysis and statistics
- huge community and package ecosystem (20,000+ packages on CRAN)

## Why R: reproducibility and replicability

| Term            | Meaning                   |
|:----------------|:--------------------------|
| Reproducibility | *Same* data, same methods |
| Replicability   | *New* data, same methods  |

- A script records every step, which makes your work reproducible

<p class="caption">

Most scientists report failing to reproduce others’ results, and many
their own. Survey of 1,576 researchers (Baker, 2016, *Nature*).
</p>

## Motivation 🤔

- **Stand on the shoulders of giants:** others can only build on your
  work if they can see what you did
- **Efficiency:** automate repetitive tasks, get to the important task
  of *thinking*
- **Scale:** work with datasets far too large for a spreadsheet
- **Your future self:** six months from now, you’ll need to know what
  you did, too

## R vs. RStudio

- **R** is the engine: the language that does the computing
- **RStudio** is the dashboard: an interface that makes R easier to
  drive (an integrated development environment or *IDE*)

## Today’s Goals

By the end of this session, you should be able to:

- Find your way around RStudio
- Install and load packages
- Run code and use functions
- Create and name variables
- Recognize R’s main data types and data structures
- Know where to look for help

## RStudio

## Installing packages

``` r
# install.packages("dplyr") # This call installs a package 
# library(dplyr) # This loads a package
# devtools packages
# install.packages("devtools")
# install_github("username/repositoryname")
```

## Simple Math

``` r
2 + 2 # add
```

    ## [1] 4

``` r
3 - 2 # subtract
```

    ## [1] 1

``` r
3 * 3 # multiply
```

    ## [1] 9

``` r
4 / 2 # division
```

    ## [1] 2

``` r
sqrt(9) # square root
```

    ## [1] 3

## Functions

``` r
# c() is a common function for concatenating things together
c(1:10)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

<!--
S1 Variables
-->

## Variables

## Creating variables

``` r
# You can then recall the values (object) associated with your variable...
my_variable <- c(1:10)
myAlphabet <- letters[1:5]
myNumbers <- c(1:5)
#And plug it into functions, ie, do computations on it...

my_variable
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
my_variable * 2
```

    ##  [1]  2  4  6  8 10 12 14 16 18 20

## Naming variables

``` r
# camel case
myNumber <- "Hello" # bad naming
myNumber <- 10 # good naming
# skeleton case
my_number <- 10
```

## Data types

- data (and the variables that we use to store them) come in different
  shapes and sizes
- think of a variable as a *box* and the data are the things you want to
  put in, not all boxes fit all types of stuff (data)
- **note**: the function `typeof()`, will tell you what data type you
  have…

## Boolean (Logical Data)

- `boolean` data are generally referred to as `logical`

``` r
myBool <- TRUE # this is camel case
typeof(myBool)
```

    ## [1] "logical"

## Numeric (Double)

- in `R` `numeric` data are subdivided into `double` and `integer`

``` r
myDouble <- 10.5
typeof(myDouble)
```

    ## [1] "double"

## Numeric (Integer)

``` r
myInteger <- 10L
typeof(myInteger)
```

    ## [1] "integer"

## Characters

- `character` data always needs to be wrapped in single or double
  quotations.

``` r
myChar <- "a" # Note that R does not distinguish between '' and "" but the use has to match
typeof(myChar)
```

    ## [1] "character"

## Complex

``` r
myComplexNum <- 9 + 3i # remember sqrt(-1) :)
typeof(myComplexNum)
```

    ## [1] "complex"

<!--
S2 Data Structures
-->

## Data Structures 🗂️

## Vectors

``` r
# numeric vector
c(1:10)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
# character vector
c("a", "b", "c")
```

    ## [1] "a" "b" "c"

``` r
# logical vector
c(TRUE, TRUE, FALSE)
```

    ## [1]  TRUE  TRUE FALSE

``` r
# note that vectors do not allow you to mix types
# c(TRUE, 10) # this will convert TRUE to 1
# c(TRUE, "10") # this will convert TRUE to "TRUE"
```

## Matrices

``` r
matrix(1:10, nrow = 2)
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    3    5    7    9
    ## [2,]    2    4    6    8   10

## Data frames

``` r
data.frame(letter = letters[1:5],
           nol = 1:5) # nol mean number of letter
```

    ##   letter nol
    ## 1      a   1
    ## 2      b   2
    ## 3      c   3
    ## 4      d   4
    ## 5      e   5

## Lists

``` r
list(item_1 = myAlphabet,
     item_2 = c(1:3))
```

    ## $item_1
    ## [1] "a" "b" "c" "d" "e"
    ## 
    ## $item_2
    ## [1] 1 2 3

## Arrays

- A matrix with more than two dimensions: rows, columns, *and* layers
- Like a stack of ice cube trays or milk carton containers

``` r
my_array <- array(1:12, dim = c(2, 3, 2)) # 2 rows, 3 columns, 2 layers
my_array
```

    ## , , 1
    ## 
    ##      [,1] [,2] [,3]
    ## [1,]    1    3    5
    ## [2,]    2    4    6
    ## 
    ## , , 2
    ## 
    ##      [,1] [,2] [,3]
    ## [1,]    7    9   11
    ## [2,]    8   10   12

## Identifying Data Structures

``` r
class(c(1:10))
```

    ## [1] "integer"

``` r
class(matrix(1:10, ncol = 2))
```

    ## [1] "matrix" "array"

``` r
class(data.frame(var_1 = letters,var_2 = 1:26))
```

    ## [1] "data.frame"

``` r
class(list(item_1 = letters,item_2 = 1:10,item_3 = c(TRUE, FALSE)))
```

    ## [1] "list"

<!--
S3 Getting Help
-->

## Resources: getting help

1.  Forums (e.g., Stack Overflow or Posit Community)
2.  Blog posts and online tutorials (search for ‘blogdowns’ on a topic)
3.  Package papers (often *Journal of Statistical Software*)
4.  Books, many free online (see References)

- Want to practice? 🤓
- Try `swirl`, which teaches R interactively in your console

## Resources: the `?` operator (and vignettes)

``` r
?sqrt                    # help page for a function
??regression             # search all help pages for a topic
browseVignettes("dplyr") # long-form guides for a package
```

## References

- aRrgh: a newcomer’s (angry) guide to R, by Tim Smith and Kevin Ushey -
  <http://arrgh.tim-smith.us/>
- YaRrr! The Pirate’s Guide to R, by Nathaniel D. Phillips -
  <https://bookdown.org/ndphillips/YaRrr/>
- R for Graduate Students, by Wendy Huynh. -
  <https://bookdown.org/yih_huynh/Guide-to-R-Book/>
- Advanced R, by Hadley Wickham -
  <http://adv-r.had.co.nz/Introduction.html>

And through the library, the [O’Reilly
platform](https://resources.library.ubc.ca/page.php?details=oreilly-for-higher-education&id=2460)
hosts a plethora of titles related to R.

- [https://www.w3schools.com/r/r_data_types.asp](W3%20Schools)
- Baker, M. (2016). 1,500 scientists lift the lid on reproducibility.
  Nature, 533(7604), 452–454. <https://doi.org/10.1038/533452a>
