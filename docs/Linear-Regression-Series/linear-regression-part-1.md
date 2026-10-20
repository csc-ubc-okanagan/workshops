---
title: "Linear Regression in R (Part 1): Intro to Linear Regression"
output:
  html_document:
    keep_md: yes
---



# Linear Regression in R (Part 1): Intro to Linear Regression

> This is the first workshop in a six-part series on linear regression. Today we work with a single explanatory variable. Next time we extend to several predictors at once (multiple linear regression).

## What You Will Learn

By the end of this session you will be able to:

1. Fit a simple linear regression model in R with `lm()`.
2. Interpret the slope and the intercept.
3. Visualize the fitted relationship and its uncertainty.
4. State the assumptions that decide whether the model can be trusted.
5. Read the standard model output, including the coefficient table and `R`-squared.

The approach is visual. We plot the data first, fit a model, then plot what the model claims.

## Setup

We use base R for the modeling and `ggplot2` for plots. Install `ggplot2` once, then load it at the start of every session.


```r
# install once (skip if already installed)
packages <- c("ggplot2")
toInstall <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(toInstall)) install.packages(toInstall)

library(ggplot2)
theme_set(theme_classic(base_size = 14))
```

## The Data

We use `trees`, a dataset built into R. It records measurements on 31 black cherry trees. We predict the volume of usable timber in a tree from its girth (the distance around the trunk).


```r
data(trees)
head(trees)
```

```
  Girth Height Volume
1   8.3     70   10.3
2   8.6     65   10.3
3   8.8     63   10.2
4  10.5     72   16.4
5  10.7     81   18.8
6  10.8     83   19.7
```

Each row is one tree. `Girth` is the trunk diameter in inches, `Height` is in feet, and `Volume` is in cubic feet. We will use `Girth` to explain `Volume` and leave `Height` for the multiple regression workshop.

A wider trunk should hold more wood. Linear regression lets us say how much more, and lets us quantify how confident we are in that statement.

## Visualizing the Relationship First

Always look at the data before fitting anything. A scatter plot shows the shape of the relationship and warns you early if a straight line is the wrong tool.


```r
ggplot(trees, aes(x = Girth, y = Volume)) +
  geom_point() +
  labs(x = "Trunk girth (inches)",
       y = "Timber volume (cubic feet)",
       title = "Tree volume increases with girth")
```

![](assets/images/intro-to-linear-regression/1-tree-scatter.png)

The points rise from the lower left to the upper right. The trend looks close to a straight line, so simple linear regression is a reasonable starting model.

## What Is Simple Linear Regression?

A simple linear regression model assumes the mean of a response variable changes linearly with one predictor variable.

- Response (dependent variable): the quantity we want to explain. Here, `Volume`. We call it `Y`.
- Predictor (independent variable): the quantity we use to explain it. Here, `Girth`. We call it `x`.

The model is

$$Y_i = \beta_0 + \beta_1 x_i + \epsilon_i,$$

where

- $\beta_0$ is the intercept, the mean of `Y` when `x` is zero,
- $\beta_1$ is the slope, the change in the mean of `Y` for a one-unit increase in `x`,
- $\epsilon_i$ is random error, the part of `Y` the line does not explain.

The line $\beta_0 + \beta_1 x$ is the mean of `Y` at a given `x`. Individual observations scatter around that line. Fitting the model means estimating $\beta_0$ and $\beta_1$ from the data. We write the estimates as $\hat\beta_0$ and $\hat\beta_1$.

## How Are the Coefficients Estimated?

We choose the line that sits as close to the points as possible. "Close" is measured by the vertical distance from each point to the line, called a residual. The least squares method picks the estimates that minimize the sum of squared residuals (SSE):

$$\text{SSE} = \sum_{i=1}^{n} (Y_i - \hat{Y}_i)^2 = \sum_{i=1}^{n} (Y_i - \hat\beta_0 - \hat\beta_1 x_i)^2.$$

Squaring keeps positive and negative misses from cancelling and penalizes large misses more than small ones. For one predictor the minimizing values have a closed form:

$$\hat\beta_1 = \frac{\sum_{i=1}^{n} (x_i - \bar{x})(Y_i - \bar{Y})}{\sum_{i=1}^{n} (x_i - \bar{x})^2}, \qquad \hat\beta_0 = \bar{Y} - \hat\beta_1 \bar{x}.$$

The slope is the covariance of `x` and `Y` divided by the variance of `x`. The intercept forces the line through the point of averages $(\bar{x}, \bar{Y})$.

## Fitting the Model in R

The function `lm()` fits a linear model. The formula `Volume ~ Girth` reads as "Volume explained by Girth".


```r
treeModel <- lm(Volume ~ Girth, data = trees)
summary(treeModel)
```

```
Call:
lm(formula = Volume ~ Girth, data = trees)

Residuals:
   Min     1Q Median     3Q    Max 
-8.065 -3.107  0.152  3.495  9.587 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -36.9435     3.3651  -10.98 7.62e-12 ***
Girth         5.0659     0.2474   20.48  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4.252 on 29 degrees of freedom
Multiple R-squared:  0.9353,	Adjusted R-squared:  0.9331 
F-statistic: 419.4 on 1 and 29 DF,  p-value: < 2.2e-16
```

The summary prints a coefficient table. Each row is one coefficient (the intercept, then the slope on `Girth`) with four columns:

- `Estimate`: the fitted value of the coefficient.
- `Std. Error`: how much the estimate would vary across repeated samples.
- `t value`: the estimate divided by its standard error.
- `Pr(>|t|)`: the p-value for testing whether that coefficient is zero.

A small p-value on `Girth` is evidence that girth genuinely helps explain volume rather than appearing useful by chance.

## The Coefficients by Hand

`lm()` is doing arithmetic we can reproduce. Computing the estimates directly makes the formulas concrete and sets up the matrix approach we rely on in the next workshop.

### Using the Closed-Form Formulas


```r
girth  <- trees$Girth
volume <- trees$Volume

slopeHat     <- sum((girth - mean(girth)) * (volume - mean(volume))) /
                sum((girth - mean(girth))^2)
interceptHat <- mean(volume) - slopeHat * mean(girth)

c(intercept = interceptHat, slope = slopeHat)
coef(treeModel
```

```
 intercept      slope 
-36.943459   5.065856 
```

The hand calculation and `coef(treeModel)` agree!

### Using the Model Matrix

Even with a single predictor there is a model matrix. It has one column of ones for the intercept and one column for the predictor:

$$
X =
\begin{bmatrix}
1 & x_1 \\
1 & x_2 \\
\vdots & \vdots \\
1 & x_n
\end{bmatrix}.
$$

The least squares estimates solve the normal equations, which have the matrix solution

$$\hat{\beta} = (X^\top X)^{-1} X^\top Y.$$

In R:


```r
designMatrix <- cbind(intercept = 1, girth = girth)   # the matrix X
betaHat <- solve(t(designMatrix) %*% designMatrix) %*%
           t(designMatrix) %*% volume
betaHat
```

```
                [,1]
intercept -36.943459
girth       5.065856
```

This returns the same intercept and slope again. The column of ones is what lets the model fit a non-zero intercept. The same `(X'X)^{-1} X'Y` expression handles two predictors, ten predictors, or a hundred, which is why we introduce it now. Next workshop we add columns to `X` instead of changing the method.

> In practice, always fit with `lm()`. It handles the numerical work carefully and returns standard errors, p-values, and diagnostics. 

## Interpreting the Output

Pull the coefficients out on their own:


```r
coef(treeModel)
```

```
(Intercept)       Girth 
 -36.943459    5.065856 
 ```
 
Read them in the units of the data:

- Intercept: the predicted volume when girth is zero. A tree with zero girth has no trunk, so this value is not physically meaningful on its own. The intercept anchors the line; it is not always a quantity worth interpreting.
- Slope on `Girth`: the predicted increase in timber volume, in cubic feet, for each additional inch of girth. This is the number that answers our original question.

Interpreting the intercept outside the range of the observed data is a common mistake. Our trees have girths well above zero, so a prediction at girth zero is an extrapolation far from any data we actually saw.

## Visualizing the Fitted Line

Overlay the fitted line on the data. `geom_smooth()` with `method = "lm"` fits the same model and draws it, with a shaded band for the uncertainty in the mean.


```r
ggplot(trees, aes(x = Girth, y = Volume)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE,
              color = "darkorange", fill = "darkorange") +
  labs(x = "Trunk girth (inches)",
       y = "Timber volume (cubic feet)",
       title = "Fitted regression line with 95% confidence band")
```

![](assets/images/intro-to-linear-regression/1-tree-fitted.png)

The orange line is the estimated mean volume at each girth. The band is a 95% confidence interval for that mean. The band is narrow in the middle of the data and widens toward the edges, because we have less information about the relationship far from the bulk of the observations.

## Making Predictions

Use the model to predict volume at girth values of interest. `predict()` returns the fitted mean and, with `interval = "confidence"`, an interval for it.

```r
newTrees <- data.frame(Girth = c(10, 14, 18))
predict(treeModel, newdata = newTrees, interval = "confidence")
```

```
       fit      lwr      upr
1 13.71511 11.44781 15.98240
2 33.97853 32.37101 35.58606
3 54.24196 51.37508 57.10883
```

Each row gives the predicted mean volume at that girth (`fit`) and the lower and upper bounds of the 95% confidence interval. Predict only within the range of girths you observed. Pushing the line far beyond the data assumes the straight-line relationship continues where you have no evidence that it does.

## How Well Does the Model Fit?

Regression splits the total variation in `Y` into a part the model explains and a part it does not.

- SST (total): how much `Y` varies around its own mean, ignoring `x`.
- SSR (regression): how much of that variation the fitted line explains.
- SSE (error): what is left over in the residuals.

These add up: $\text{SST} = \text{SSR} + \text{SSE}$.


```r
fittedVolume <- predict(treeModel)

SST <- sum((volume - mean(volume))^2)
SSR <- sum((fittedVolume - mean(volume))^2)
SSE <- sum((volume - fittedVolume)^2)

SST
SSR + SSE        
```

```
> SST
[1] 8106.084
> SSR + SSE        
[1] 8106.084
```

The coefficient of determination, `R`-squared, is the share of total variation the model explains:

$$R^2 = \frac{\text{SSR}}{\text{SST}}.$$


```r
SSR / SST                      # by hand
summary(treeModel)$r.squared   # from the model
```

```
> SSR / SST                      
[1] 0.9353199
> summary(treeModel)$r.squared   
[1] 0.9353199
```

An `R`-squared near one means girth accounts for most of the variation in volume. An `R`-squared near zero means it accounts for very little. For these trees, girth alone explains the large majority of the variation, which matches how tightly the points hug the line.

## The Assumptions Behind the Model

The coefficient estimates come out of any dataset you give `lm()`. Whether the p-values and intervals can be trusted depends on five assumptions.

1. Certainty in `x`. The predictor is measured without error. All uncertainty lives in `Y`.
2. Linearity. The mean of `Y` is a straight-line function of `x`.
3. Homoscedasticity. The residuals have constant spread across all values of `x`.
4. Independence. One observation's error tells you nothing about another's.
5. Normality. The errors follow a normal distribution.

Violations do not stop R from returning a number. They make the inference around that number unreliable: p-values, confidence intervals, and predictions can all be off.

## Checking the Assumptions with Diagnostic Plots

Base R gives four diagnostic plots for any `lm` object. Set up a two-by-two grid and plot the model.


```r
par(mfrow = c(2, 2))
plot(treeModel)
par(mfrow = c(1, 1))   
```

![](assets/images/intro-to-linear-regression/1-tree-diagnostics.png)

What to look for:

- Residuals vs Fitted: points scattered flat around zero with no curve. A curve signals a broken linearity assumption. A funnel shape signals non-constant variance.
- Q-Q Residuals: points close to the diagonal line. Departures at the ends signal non-normal errors.
- Scale-Location: a roughly flat trend. A rising or falling trend signals changing variance.
- Residuals vs Leverage: flags individual points with outsized influence on the fit.

For the tree data the residuals show a mild curve, which hints that volume grows slightly faster than a straight line in girth. 

## When the Straight Line Is Wrong

Non-constant variance (heteroscedasticity). The spread of residuals grows as the fitted value grows, producing a funnel shape.


```r
set.seed(2026)
nPoints <- 400
widthSpread <- runif(nPoints, min = 0, max = 10)
fanResponse <- 2 + 3 * widthSpread + rnorm(nPoints, mean = 0, sd = widthSpread)

fanModel <- lm(fanResponse ~ widthSpread)
plot(fanModel, which = 1) 
```

![](assets/images/intro-to-linear-regression/1-tree-fanning.png)

Curvature (broken linearity). The true relationship bends, so a straight line leaves a curved pattern in the residuals.


```r
set.seed(2026)
nPoints <- 150
inputValue    <- runif(nPoints, min = 0, max = 5)
curvedResponse <- 10 + 5 * inputValue - inputValue^2 + rnorm(nPoints, mean = 0, sd = 2)

curvedModel <- lm(curvedResponse ~ inputValue)
plot(curvedModel, which = 1)  
```

![](assets/images/intro-to-linear-regression/1-tree-nonlinear.png)

Each plot shows the straight-line model failing in a specific way. The fix depends on which assumption broke.

## YOU TRY!

Work through these on your own for the next 15 minutes. Use a different built-in dataset: `faithful`, which records eruptions of the Old Faithful geyser. Each row has `eruptions` (the duration of an eruption in minutes) and `waiting` (the wait until the next eruption in minutes). The question: can the length of an eruption predict how long until the next one?


```r
data(faithful)
head(faithful)
```

**Part 1. Explore the data.**
Make a scatter plot of `waiting` against `eruptions`. Does the relationship look linear? Which way does it slope?

**Part 2. Fit the model.**
Fit a simple linear regression predicting `waiting` from `eruptions` with `lm()`. Save it as `geyserModel` and call `summary()` on it.

**Part 3. Interpret the coefficients.**
Write one sentence for the slope in plain language. Fill in the blank: "Each extra minute of eruption is associated with about ___ more minutes of waiting." Is the intercept meaningful here? Why or why not?

**Part 4. Confirm the slope by hand.**
Reproduce the slope and intercept using the closed-form formulas, then again with the model matrix $\hat\beta = (X^\top X)^{-1} X^\top Y$. Check that all three approaches agree with `coef(geyserModel)`.

**Part 5. Visualize the fit.**
Add the fitted line and its confidence band to your scatter plot with `geom_smooth(method = "lm")`.

**Part 6. Predict.**
Predict the waiting time after an eruption lasting 3.5 minutes, with a 95% confidence interval. Would you trust a prediction for an eruption lasting 10 minutes? Explain.

**Part 7. Check the assumptions.**
Produce the four diagnostic plots. Do the residuals look flat and patternless, or do you see a problem?

**Part 8. Measure the fit.**
Report `R`-squared. What share of the variation in waiting time does eruption duration explain?

If you finish early, compare the eruption durations in a histogram (`hist(faithful$eruptions)`). The shape you see will come up when we discuss what the independence and normality assumptions really require.

## So... what did we learn?

1. Simple linear regression models the mean of a response as a straight-line function of one predictor.
2. Least squares finds the line by minimizing the sum of squared residuals. For one predictor the estimates have a closed form, and the same answer comes from the model matrix solution $(X^\top X)^{-1} X^\top Y$.
3. The slope is the change in the mean response per one-unit change in the predictor. The intercept is often not meaningful on its own.
4. `R`-squared reports the share of variation the model explains.
5. Five assumptions decide whether the inference can be trusted. Diagnostic plots are how you check them.

## What Is Next

We used one predictor today. Real questions usually involve several at once. A tree's volume depends on both its girth and its height. A waiting time might depend on more than eruption duration.

Next workshop is Multiple Linear Regression. We add predictors by adding columns to the model matrix `X`, and the same estimator $\hat\beta = (X^\top X)^{-1} X^\top Y$ carries over without change. We will also meet new issues that only appear with more than one predictor, such as how to handle predictors that carry overlapping information.
