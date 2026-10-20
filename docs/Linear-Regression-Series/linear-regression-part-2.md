---
title: "Linear Regression in R (Part 2): Multiple Linear Regression"
output:
  html_document:
    keep_md: yes
---

<script>
  MathJax = {
    tex: { inlineMath: [['$','$'], ['\\(','\\)']],
           displayMath: [['$$','$$'], ['\\[','\\]']] },
    svg: { fontCache: 'global' }
  };
</script>
<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-svg.js" id="MathJax-script" async></script>

# Linear Regression in R (Part 2): Multiple Linear Regression

> This is the second workshop in a six-part series on linear regression. Last time we used a single predictor. Today we use several at once, and we see how the meaning of a coefficient changes when other predictors sit beside it.

## What You Will Learn

By the end of this session you will be able to:

1. Fit a multiple linear regression model in R with `lm()`.
2. Interpret a coefficient as a partial effect, holding the other predictors fixed.
3. Add a categorical predictor and read its coefficients.
4. Diagnose collinearity with the variance inflation factor.
5. Reason about confounding with a directed acyclic graph before trusting a coefficient.
6. Compare models with adjusted `R`-squared and understand why more predictors is not always better.

## Setup

We use base R for modeling, `ggplot2` for plots, `car` for the variance inflation factor, and `ggdag` with `dagitty` for drawing causal diagrams. Install once, then load each session.


```r
packages <- c("ggplot2", "car", "dagitty", "ggdag")
toInstall <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(toInstall)) install.packages(toInstall)

library(ggplot2)
library(car)
library(dagitty)
library(ggdag)
theme_set(theme_classic(base_size = 14))
```

## The Data

We use `state.x77`, built into R. It holds eight measurements on each of the 50 US states, recorded in the 1970s. We predict life expectancy from the other variables.

`state.x77` is a matrix with state names as row names, and several column names contain spaces. We clean it into a tidy data frame with workable names. We also attach each state's region from `state.region`, which gives us a categorical predictor.


```r
states <- as.data.frame(state.x77)

# give the awkward column names clean versions
names(states)[names(states) == "Life Exp"] <- "LifeExp"
names(states)[names(states) == "HS Grad"] <- "HSGrad"
names(states)[names(states) == "Murder"]  <- "MurderRate"   # murders per 100,000

# state.region lines up with the rows of state.x77, so we can attach it directly
states$Region <- state.region

head(states)
```

```
   Population Income Illiteracy LifeExp MurderRate HSGrad Frost   Area Region
Alabama          3615   3624        2.1   69.05       15.1   41.3    20  50708  South
Alaska            365   6315        1.5   69.31       11.3   66.7   152 566432   West
Arizona          2212   4530        1.8   70.55        7.8   58.1    15 113417   West
Arkansas         2110   3378        1.9   70.66       10.1   39.9    65  51945  South
California      21198   5114        1.1   71.71       10.3   62.6    20 156361   West
Colorado         2541   4884        0.7   72.06        6.8   63.9   166 103766   West
```

The variables we use today:

- `LifeExp`: life expectancy in years. This is the response.
- `Income`: per capita income in dollars.
- `MurderRate`: murders per 100,000 people.
- `HSGrad`: percent of adults who are high school graduates.
- `Region`: a categorical variable with four levels (Northeast, South, North Central, West).

## From One Predictor to Several

Simple linear regression used one predictor:

$$Y_i = \beta_0 + \beta_1 x_i + \epsilon_i.$$

Multiple linear regression uses $p$ predictors at once:

$$Y_i = \beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + \cdots + \beta_p x_{ip} + \epsilon_i,$$

where

- $Y_i$ is the response for observation $i$,
- $x_{ij}$ is the value of predictor $j$ for observation $i$,
- $\beta_j$ is the coefficient for predictor $j$,
- $\epsilon_i$ is the error, assumed $N(0, \sigma^2)$ as before.

The assumptions from Part 1 carry over unchanged: certainty in the predictors, linearity, constant error variance, independence, and normal errors.

The one idea that changes is interpretation. In simple regression, $\beta_1$ is the total effect of `x` on `Y`. In multiple regression, $\beta_j$ is the effect of $x_j$ **holding every other predictor fixed**. This is called a partial effect.

## Fitting a First Model

Start with one predictor, income, so we have a baseline to compare against.


```r
incomeModel <- lm(LifeExp ~ Income, data = states)
summary(incomeModel)
```

```
Residuals:
     Min       1Q   Median       3Q      Max 
-2.96547 -0.76381 -0.03428  0.92876  2.32951 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 6.758e+01  1.328e+00  50.906   <2e-16 ***
Income      7.433e-04  2.965e-04   2.507   0.0156 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.275 on 48 degrees of freedom
Multiple R-squared:  0.1158,	Adjusted R-squared:  0.09735 
F-statistic: 6.285 on 1 and 48 DF,  p-value: 0.01562
```

Income has a positive, statistically detectable association with life expectancy, but the adjusted `R`-squared is low. The model leaves most of the variation in life expectancy unexplained, which suggests we are missing predictors that matter.

## Adding a Second Predictor

Add the murder rate. Predictors are joined with `+` in the formula.


```r
twoModel <- lm(LifeExp ~ Income + MurderRate, data = states)
summary(twoModel)
```

```
Residuals:
     Min       1Q   Median       3Q      Max 
-1.48301 -0.62099 -0.01714  0.47768  2.20831 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) 71.2255815  0.9673952  73.626  < 2e-16 ***
Income       0.0003705  0.0001973   1.878   0.0666 .  
MurderRate  -0.2697594  0.0328408  -8.214 1.22e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.8259 on 47 degrees of freedom
Multiple R-squared:  0.637,	Adjusted R-squared:  0.6215 
F-statistic: 41.23 on 2 and 47 DF,  p-value: 4.561e-11
```

Two things happen worth pausing on.

First, the adjusted `R`-squared jumps substantially. Murder rate explains a large share of the variation that income alone missed.

Second, the coefficient and p-value for income **change**. Income looked clearly useful on its own, and now it looks weaker. Nothing is wrong. The reason is that income and murder rate are related, so some of what income appeared to explain was really the murder rate working through it. Once murder rate is in the model, income is credited only with what it adds *beyond* murder rate.

You can see the relationship between the two predictors directly:


```r
ggplot(states, aes(x = Income, y = MurderRate)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x) +
  labs(x = "Per capita income (dollars)",
       y = "Murders per 100,000",
       title = "Income and murder rate are related")
```

![](../assets/images/intro-to-linear-regression/2-income-vs-murder.png)

A coefficient is not a fixed property of a predictor. It depends on which other predictors share the model.

## Thinking About Confounding with a DAG

Before adding more predictors, it helps to draw what we believe about how the variables influence one another. A directed acyclic graph (DAG) is a picture of assumed causal relationships. Arrows point from cause to effect. DAGs make confounding visible: a confounder is a variable that influences both a predictor and the response, and ignoring it distorts the coefficient you care about.

We sketch a DAG where income affects life expectancy both directly and indirectly through the murder rate.


```r
lifeDag <- dagify(
  LifeExp ~ Income + MurderRate,
  MurderRate ~ Income,
  labels = c(LifeExp = "Life expectancy",
             Income = "Income",
             MurderRate = "Murder rate")
)

ggdag(lifeDag, text = TRUE) + theme_dag()
```

![](../assets/images/intro-to-linear-regression/2-dag.png)

The arrow from income into murder rate, and from murder rate into life expectancy, is exactly the indirect path that explains why income's coefficient shifted when we added murder rate. The DAG is a reasoning tool, not an output of the data. You bring the arrows; the data cannot tell you their direction.

## Adding a Categorical Predictor

So far every predictor is numeric. Region is categorical. R handles this automatically: a factor with $k$ levels enters the model as $k - 1$ indicator variables, each comparing one level against a baseline level.


```r
regionModel <- lm(LifeExp ~ Income + MurderRate + Region + HSGrad, data = states)
summary(regionModel)
```

```
Residuals:
     Min       1Q   Median       3Q      Max 
-1.37772 -0.39428  0.02323  0.45469  2.12002 

Coefficients:
                      Estimate Std. Error t value Pr(>|t|)    
(Intercept)          6.978e+01  1.617e+00  43.167  < 2e-16 ***
Income               5.807e-05  2.545e-04   0.228    0.821    
MurderRate          -2.310e-01  4.459e-02  -5.180  5.6e-06 ***
RegionSouth          2.389e-01  4.536e-01   0.527    0.601    
RegionNorth Central  6.040e-01  3.550e-01   1.702    0.096 .  
RegionWest           1.949e-01  4.676e-01   0.417    0.679    
HSGrad               4.275e-02  3.346e-02   1.278    0.208    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.8015 on 43 degrees of freedom
Multiple R-squared:  0.6871,	Adjusted R-squared:  0.6435 
F-statistic: 15.74 on 6 and 43 DF,  p-value: 1.837e-09
```

The coefficient table now has rows like `RegionSouth`, `RegionNorth Central`, and `RegionWest`. There is no row for the Northeast, because R uses it as the baseline (the first factor level). Each region coefficient is the difference in mean life expectancy between that region and the Northeast, holding income and murder rate fixed.

To see which level is the baseline, and to change it if you prefer a different reference:


```r
levels(states$Region)                             
states$Region <- relevel(states$Region, ref = "South")   # make South the baseline instead
```

Interpreting a categorical coefficient is the same partial-effect idea: it is a comparison against the baseline level, with the other predictors held constant.

## The Model Matrix Still Does the Work

In Part 1 we solved the single-predictor model by hand with the model matrix. The same estimator handles any number of predictors. Nothing about the method changes. We only add columns to $X$.

The model matrix $X$ is $n \times (p + 1)$: one row per observation, one column per predictor, plus a leading column of ones for the intercept. The least squares estimates are

$$\hat{\beta} = (X^\top X)^{-1} X^\top Y.$$


```r
designMatrix <- cbind(intercept = 1,
                      Income     = states$Income,
                      MurderRate = states$MurderRate,
                      HSGrad     = states$HSGrad)

betaHat <- solve(t(designMatrix) %*% designMatrix) %*%
           t(designMatrix) %*% states$LifeExp
betaHat

coef(lm(LifeExp ~ Income + MurderRate + HSGrad, data = states))   # compare
```

```
> betaHat
                    [,1]
intercept   7.014211e+01
Income      9.525615e-05
MurderRate -2.385975e-01
HSGrad      3.905862e-02
> coef(lm(LifeExp ~ Income + MurderRate + HSGrad, data = states))
  (Intercept)        Income    MurderRate        HSGrad 
 7.014211e+01  9.525615e-05 -2.385975e-01  3.905862e-02 
 ```

## More Predictors Is Not Always Better

Adjusted `R`-squared is the version of `R`-squared to trust when comparing models of different sizes. Plain `R`-squared can only rise when you add a predictor, even a useless one. Adjusted `R`-squared penalizes extra predictors:

$$R^2_{\text{adj}} = 1 - \frac{(1 - R^2)(n - 1)}{n - p - 1}.$$

It rises only when a new predictor earns its place. Compare the models we built:


```r
summary(incomeModel)$adj.r.squared
summary(twoModel)$adj.r.squared
summary(regionModel)$adj.r.squared
```

Watch whether adjusted `R`-squared keeps climbing as predictors are added, or whether it stalls. A stall means the new predictors are not adding real explanatory power, only complexity.

## Letting the Data Suggest a Model

Best subset selection fits every combination of predictors and reports the strongest at each size. It is a useful check, not a replacement for judgment. The `regsubsets()` function in the `leaps` package does this.


```r
library(leaps)

allNumeric <- states[, c("LifeExp", "Income", "MurderRate", "HSGrad")]
subsetSearch <- regsubsets(LifeExp ~ ., data = allNumeric, nvmax = 3)
summary(subsetSearch)
```

```
Subset selection object
Call: regsubsets.formula(LifeExp ~ ., data = allNumeric, nvmax = 3)
3 Variables  (and intercept)
           Forced in Forced out
Income         FALSE      FALSE
MurderRate     FALSE      FALSE
HSGrad         FALSE      FALSE
1 subsets of each size up to 3
Selection Algorithm: exhaustive
         Income MurderRate HSGrad
1  ( 1 ) " "    "*"        " "   
2  ( 1 ) " "    "*"        "*"   
3  ( 1 ) "*"    "*"        "*"   
```

The output marks which predictors are chosen at each model size. Do not take the "best" subset as a final answer. Variable selection driven only by fit can select predictors that happen to correlate with the response in this sample. Pair it with what you know about the problem, which is where a DAG earns its keep.

## Statistical Significance Is Not Causal Effect

A small p-value says a coefficient is unlikely to be zero in this sample. It does not say the predictor causes the response. Collinearity can make a real effect look insignificant, and a confounder can make a spurious association look strong. This is why we draw DAGs. They force us to state our causal assumptions in the open, separate from whatever the regression output happens to show.

## YOU TRY!

Work through these for the next 15 minutes. Pick one of R's built-in datasets below and build a multiple regression model. Each has a clear response and several candidate predictors.


```r
# Option 1: mtcars   - predict mpg (fuel economy)
#   ?mtcars
# Option 2: swiss    - predict Fertility
#   ?swiss
# Option 3: airquality - predict Ozone (drop missing rows first)
#   ?airquality
```

**Part 1. Explore.**
Load your dataset and look at it with `head()` and `summary()`. Pick a response variable and three or four predictors that you think explain it.

**Part 2. Fit a simple model first.**
Fit a one-predictor model with `lm()` and read the adjusted `R`-squared. This is your baseline.

**Part 3. Add predictors.**
Fit a model with all your chosen predictors. Did the adjusted `R`-squared improve over the baseline?

**Part 4. Watch a coefficient move.**
Compare the coefficient of your first predictor between the one-predictor model and the full model. Did it change? Write one sentence explaining why adding other predictors can shift it.

**Part 5. Interpret a partial effect.**
Pick one predictor from your full model and write its interpretation in plain language, including the phrase "holding the other predictors constant".

**Part 6. Check collinearity.**
Run `vif()` on your full model. Are any values above 5? Above 10? What would you consider dropping?

**Part 7. Try a categorical predictor.**
If your dataset has one, add it. If not, create one by cutting a numeric variable into groups, for example `cut(mtcars$hp, breaks = 3)`, and add that. Read the coefficients against the baseline level.

**Part 8. Decide.**
Based on adjusted `R`-squared and the VIFs, which predictors would you keep? Justify your choice in one or two sentences.

If you finish early, draw a DAG for your variables with `dagify()` and `ggdag()`. State which variable you think is a confounder and why.

## So... what did we learn?

1. Multiple regression extends the linear model to several predictors: $Y = \beta_0 + \beta_1 x_1 + \cdots + \beta_p x_p + \epsilon$.
2. Each coefficient is a partial effect, the change in the response per unit change in that predictor, holding the others constant.
3. A coefficient depends on the company it keeps. Adding or removing predictors can move it.
4. Categorical predictors enter as indicator variables, each compared to a baseline level.
5. Adjusted `R`-squared penalizes complexity, so more predictors is not always better.
6. The model matrix estimator $(X^\top X)^{-1} X^\top Y$ from Part 1 handles any number of predictors unchanged.
7. Statistical significance is not causal effect. Use a DAG to reason about causality.

## What Is Next

Every model today assumed each predictor acts on the response independently of the others. The effect of income did not depend on the region; the effect of the murder rate was the same everywhere.

That is often too simple. Sometimes the effect of one predictor depends on the value of another. The benefit of education might differ by region. The next workshop is Interaction Terms and Hierarchical Linear Models, where we let predictors modify each other's effects, and where we handle data that comes in natural groups.
