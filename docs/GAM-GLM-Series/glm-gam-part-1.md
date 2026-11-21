---
title: "GLMs and GAMs in R (Part 1): Intro to Generalized Linear Models"
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

<style>
  .site-footer,
  .footer { display: none; }

  html { scroll-behavior: smooth; }

  .ws-page {
    display: flex;
    gap: 34px;
    align-items: flex-start;
    max-width: 1150px;
    margin: 0 auto;
  }

  .ws-toc {
    position: sticky;
    top: 20px;
    flex: 0 0 225px;
    max-height: calc(100vh - 40px);
    overflow-y: auto;
    font-size: 0.88rem;
  }
  .ws-toc-title {
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    font-size: 0.74rem;
    color: #888;
    padding: 0 10px 8px;
  }
  .ws-toc nav ul { list-style: none; margin: 0; padding: 0; }
  .ws-toc nav a {
    display: block;
    padding: 5px 10px;
    color: #333;
    text-decoration: none;
    border-left: 2px solid transparent;
    line-height: 1.3;
  }
  .ws-toc nav a:hover {
    border-left-color: #666;
    background: rgba(0, 0, 0, 0.04);
    color: #000;
  }
  .ws-toc nav a.active {
    border-left-color: #EE6677;
    color: #000;
    font-weight: 600;
  }
  .ws-toc nav li.sub a {
    padding-left: 24px;
    font-size: 0.83rem;
    color: #666;
  }

  .ws-body { flex: 1 1 auto; min-width: 0; }
  .ws-body h1, .ws-body h2 { scroll-margin-top: 16px; }

  @media (max-width: 900px) {
    .ws-page { flex-direction: column; gap: 12px; }
    .ws-toc {
      position: static;
      flex-basis: auto;
      width: 100%;
      max-height: none;
      border-bottom: 1px solid #ddd;
      padding-bottom: 10px;
      margin-bottom: 6px;
    }
  }
</style>

<div class="ws-page">

  <aside class="ws-toc">
    <div class="ws-toc-title">On this page</div>
    <nav>
      <ul>
        <li><a href="#what-you-will-learn">What You Will Learn</a></li>
        <li><a href="#setup">Setup</a></li>
        <li><a href="#part-a">A. Where the Line Runs Out</a></li>
        <li class="sub"><a href="#binary-outcome">A binary outcome</a></li>
        <li class="sub"><a href="#count-outcome">A count outcome</a></li>
        <li class="sub"><a href="#anatomy">The three parts of a GLM</a></li>
        <li class="sub"><a href="#link-functions">Why the logit and the log</a></li>
        <li><a href="#part-b">B. Logistic Regression</a></li>
        <li class="sub"><a href="#fitting-logistic">Fitting</a></li>
        <li class="sub"><a href="#three-scales">Three scales</a></li>
        <li class="sub"><a href="#indicators">Where is racewhite?</a></li>
        <li class="sub"><a href="#intervals">Intervals and the link scale</a></li>
        <li class="sub"><a href="#logistic-diagnostics">Diagnostics</a></li>
        <li><a href="#part-c">C. Poisson Regression</a></li>
        <li class="sub"><a href="#fitting-poisson">Fitting</a></li>
        <li class="sub"><a href="#poisson-diagnostics">Diagnostics</a></li>
        <li class="sub"><a href="#overdispersion">When the check fails</a></li>
        <li class="sub"><a href="#offsets">A note on exposure</a></li>
        <li><a href="#you-try">YOU TRY!</a></li>
        <li><a href="#summary">So... what did we learn?</a></li>
        <li><a href="#references">References</a></li>
      </ul>
    </nav>
  </aside>

  <div class="ws-body" markdown="1">

# GLMs and GAMs in R (Part 1): Intro to Generalized Linear Models

> This is the first workshop in a six-part series. Linear regression assumes a continuous response, errors that are normally distributed, and a variance that stays the same everywhere. Plenty of outcomes break all three at once. A yes or no answer cannot be normal. A count cannot be negative. The spread of a count grows as the count grows. Today we keep the linear predictor and change two things around it, the distribution assumed for the response and the function connecting that distribution to the predictors. Those two choices turn one model into a family of models.

## What You Will Learn {#what-you-will-learn}

By the end of this session you will be able to:

1. Show, with evidence rather than assertion, why a linear model is the wrong tool for a binary or a count outcome.
2. Name the three parts of a GLM and point to each one in a fitted model.
3. Say what a link function does, and why the logit and the log are the usual choices.
4. Fit logistic and Poisson regressions with `glm()`, and read the coefficient table.
5. Move one coefficient between three scales, the log-odds, the odds ratio, and a predicted probability.
6. Build an interval on the link scale and transform it, and say what goes wrong in the other order.
7. Check a fitted GLM with binned residuals, a calibration plot, a rootogram, and a dispersion statistic.
8. Recognise overdispersion and say what it does to your standard errors.

## Setup {#setup}

We use `ggplot2` for plots and `MASS` for the `birthwt` data. `MASS` ships with R, so there is nothing to install for it.

```r
packages <- c("ggplot2")
toInstall <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(toInstall)) install.packages(toInstall)

library(ggplot2)
library(MASS)
theme_set(theme_classic(base_size = 14))

## Pearson chi-square over residual degrees of freedom. A Poisson or a
## binomial model claims this number is 1.
dispersion <- function(model) {
  sum(residuals(model, type = "pearson")^2) / df.residual(model)
}
```

# Part A: Where the Linear Model Runs Out {#part-a}

## A Binary Outcome {#binary-outcome}

`birthwt` records 189 births at Baystate Medical Center in 1986. The response `low` is 1 when the baby weighed under 2500 grams and 0 otherwise. The predictors are the mother's age and weight, her race, whether she smoked during pregnancy, whether she had a history of premature labour, and two clinical indicators.

```r
data(birthwt)
bw <- birthwt
bw$race    <- factor(bw$race,  labels = c("white", "black", "other"))
bw$smoke   <- factor(bw$smoke, labels = c("no", "yes"))
bw$ht      <- factor(bw$ht,    labels = c("no", "yes"))
bw$ui      <- factor(bw$ui,    labels = c("no", "yes"))
bw$preterm <- factor(ifelse(bw$ptl > 0, "yes", "no"), levels = c("no", "yes"))

c(births = nrow(bw), lowBirthWeight = sum(bw$low), rate = round(mean(bw$low), 3))
table(bw$smoke, bw$low)
```

```
        births lowBirthWeight           rate 
       189.000         59.000          0.312 
     
       0  1
  no  86 29
  yes 44 30
```

In the table about, the 1-column indicates babies whose birthrate was low. The 0-column is the 'otherwise'. Fifty-nine of the 189 babies were small, so the rate is 0.312. Now fit a linear model to that 0 and 1 column.

```r
modelFormula <- low ~ age + lwt + race + smoke + preterm + ht + ui

lmBinary <- lm(modelFormula, data = bw)
round(c(minimumFit = min(fitted(lmBinary)),
        maximumFit = max(fitted(lmBinary)),
        outsideZeroOne = sum(fitted(lmBinary) < 0 | fitted(lmBinary) > 1)), 4)
```

```
    minimumFit     maximumFit outsideZeroOne 
       -0.1396         0.8898         8.0000 
```

Eight of the 189 mothers are given a negative probability of a small baby. The smallest is -0.1396.

![](../assets/images/glms-and-gams/1-binary-lm-fail.png)

The left panel sorts the fitted values and marks the eight that cannot exist. The right panel is the reason the usual residual plots are no help here. A residual is $y_i - \hat{y}_i$, and $y_i$ is 0 or 1, so every residual sits on one of two parallel lines. Nothing about that pattern tells you whether the model is any good. It is what a binary outcome looks like no matter what you fit.

Three things are worth noting about the above model.

**The predictions leave the range.** A probability must be between 0 and 1. A straight line is unbounded, so far enough along any slope it will leave that interval.

**The variance is not constant.** For a 0 or 1 outcome the variance is $p(1-p)$, which is largest at $p = 0.5$ and shrinks to nothing at either end. Least squares assumes constant variance, so it weights every observation the same when it should not.

**The response is not normal.** It has two values, so it cannot possibly follow a normal distribution.

Here is the same comparison with one predictor, so the shapes can be told apart.

```r
lmOne  <- lm(low ~ lwt, data = bw)
glmOne <- glm(low ~ lwt, family = binomial(link = "logit"), data = bw)

newWeight <- data.frame(lwt = c(80, 150, 250))
round(cbind(lwt = newWeight$lwt,
            linearModel = predict(lmOne, newWeight),
            logistic = predict(glmOne, newWeight, type = "response")), 4)

round(c(crossesZeroAtLwt = unname(-coef(lmOne)[1] / coef(lmOne)[2]),
        largestObservedLwt = max(bw$lwt)), 1)
```

```
  lwt linearModel logistic
1  80      0.4406   0.4685
2 150      0.2601   0.2478
3 250      0.0024   0.0747

  crossesZeroAtLwt largestObservedLwt 
             250.9              250.0 
```

The straight line hits zero at 250.9 pounds. The heaviest mother in the data weighs 250. The linear model runs out of valid probabilities at the edge of its own data. Although we should not extrapolate, a 0.9 pounds extrapolation would be reasonable in many cases.

![](../assets/images/glms-and-gams/1-binary-curves.png)

The grey strip marks the observed weights. Inside it the two fits agree well enough. Outside it one of them keeps going and the other flattens, because it was built to.

## A Count Outcome {#count-outcome}

`InsectSprays` counts insects found on 72 agricultural units, twelve for each of six insecticides.

```r
sprayStats <- aggregate(count ~ spray, data = InsectSprays,
                        FUN = function(x) c(mean = mean(x), variance = var(x)))
sprayStats <- data.frame(spray = sprayStats$spray, round(sprayStats$count, 2))
sprayStats$ratio <- round(sprayStats$variance / sprayStats$mean, 2)
sprayStats
range(InsectSprays$count)
```

```
  spray  mean variance ratio
1     A 14.50    22.27  1.54
2     B 15.33    18.24  1.19
3     C  2.08     3.90  1.88
4     D  4.92     6.27  1.27
5     E  3.50     3.00  0.86
6     F 16.67    38.61  2.32

[1]  0 26
```

Read the first two columns against each other. The group with a mean of 2.08 has a variance of 3.90. The group with a mean of 16.67 has a variance of 38.61. The spread travels with the level, which least squares (linear regression) is not equipped for.

A linear model with `spray` as the only predictor fits each group its own mean, so the fitted values themselves are fine. The intervals are not.

```r
lmCount <- lm(count ~ spray, data = InsectSprays)
countPred <- predict(lmCount, data.frame(spray = levels(InsectSprays$spray)),
                     interval = "prediction")
data.frame(spray = levels(InsectSprays$spray), round(countPred, 2))
```

```
  spray   fit   lwr   upr
1     A 14.50  6.35 22.65
2     B 15.33  7.18 23.48
3     C  2.08 -6.07 10.23
4     D  4.92 -3.23 13.07
5     E  3.50 -4.65 11.65
6     F 16.67  8.52 24.82
```

Three of the six prediction intervals start below zero. Spray C is expected to leave about two insects, give or take six in the negative direction. The model is being asked for one variance and it returns the average of a wide group and a narrow one, which fits neither.

![](../assets/images/glms-and-gams/1-count-lm-fail.png)

The left panel is the fan that a constant variance assumption leaves behind. The right panel plots each group's mean against its variance, with the line where the two would be equal. The points track that line rather than a flat one.

## The Three Parts of a GLM {#anatomy}

A generalized linear model keeps the linear predictor and replaces the two assumptions around it.

**1. The random component.** The response follows a distribution with mean $\mu_i$, chosen to match the kind of outcome.

$$Y_i \sim \text{some distribution with } E[Y_i] = \mu_i$$

**2. The systematic component.** The predictors enter in a straight sum, as before.

$$\eta_i = \beta_0 + \beta_1 x_{i1} + \cdots + \beta_p x_{ip}$$

**3. The link function.** A function $g$ connects the mean to that sum.

$$g(\mu_i) = \eta_i \qquad \Longleftrightarrow \qquad \mu_i = g^{-1}(\eta_i)$$

The model is still linear. It is linear in $\eta_i$, on a scale where the mean has room to move. A linear model is the special case with a normal distribution and $g(\mu) = \mu$.

| Response | Family | Default link | $g(\mu)$ | In R |
|---|---|---|---|---|
| Continuous, unbounded | Gaussian | Identity | $\mu$ | `gaussian()` |
| Binary, or successes out of trials | Binomial | Logit | $\log\!\left(\frac{\mu}{1-\mu}\right)$ | `binomial()` |
| Count | Poisson | Log | $\log(\mu)$ | `poisson()` |
| Positive and right-skewed | Gamma | Inverse | $1/\mu$ | `Gamma(link = "log")` |
| Proportion strictly inside 0 and 1 | Beta | Logit | $\log\!\left(\frac{\mu}{1-\mu}\right)$ | `mgcv::betar()` |

> Two notes on that table. R's default link for `Gamma` is the inverse, which is rarely what anyone wants, so write `Gamma(link = "log")` when you mean the log. And a proportion built from a known number of trials is binomial, not beta. Beta is for a proportion with no denominator behind it, such as the share of a leaf covered in rust.

## Why the Logit and the Log {#link-functions}

For a count, $\mu > 0$. The log sends $(0, \infty)$ to the whole real line, and the inverse sends it back.

$$\log(\mu_i) = \eta_i \qquad \Longrightarrow \qquad \mu_i = e^{\eta_i} > 0 \text{ for any } \eta_i$$

For a probability, $0 < \mu < 1$. The logit sends $(0,1)$ to the whole real line.

$$\log\!\left(\frac{\mu_i}{1 - \mu_i}\right) = \eta_i \qquad \Longrightarrow \qquad \mu_i = \frac{1}{1 + e^{-\eta_i}} \in (0,1) \text{ for any } \eta_i$$

![](../assets/images/glms-and-gams/1-links.png)

Below is the 'anatomy' of the logistic regression case.

1. Random component, $Y_i \sim \text{Bernoulli}(\mu_i)$, where $P(Y_i = 1) = \mu_i$.
2. Systematic component, $\eta_i = \beta_0 + \beta_1 x_i$.
3. Link, $g(\mu_i) = \log\!\left(\frac{\mu_i}{1-\mu_i}\right) = \eta_i$.
4. Substitute, $\displaystyle \mu_i = \frac{1}{1 + e^{-(\beta_0 + \beta_1 x_i)}}$.

The quantity $\mu_i / (1 - \mu_i)$ is the odds. The model says the log-odds move in a straight line. A one-unit increase in $x$ adds $\beta_1$ to the log-odds, which multiplies the odds by $e^{\beta_1}$.

The Poisson case runs similarly.

1. Random component, $Y_i \sim \text{Poisson}(\mu_i)$, where $P(Y_i = y) = e^{-\mu_i}\mu_i^{y} / y!$.
2. Systematic component, $\eta_i = \beta_0 + \beta_1 x_i$.
3. Link, $g(\mu_i) = \log(\mu_i) = \eta_i$.
4. Substitute, $\mu_i = e^{\beta_0 + \beta_1 x_i} = e^{\beta_0} \cdot \left(e^{\beta_1}\right)^{x_i}$.

A one-unit increase in $x$ multiplies the expected count by $e^{\beta_1}$.

**Notice the pattern?** Additive on the link scale means multiplicative on the response scale. R prints coefficients on the link scale. Readers want the response scale. Most of Part B is the analysis between them.

# Part B: Logistic Regression {#part-b}

## Fitting {#fitting-logistic}

Swap `lm()` for `glm()` and name a family. The formula does not change.

```r
logitModel <- glm(modelFormula, family = binomial(link = "logit"), data = bw)
summary(logitModel)
```

```
Call:
glm(formula = modelFormula, family = binomial(link = "logit"), 
    data = bw)

Coefficients:
            Estimate Std. Error z value Pr(>|z|)   
(Intercept)  0.63691    1.23028   0.518  0.60467   
age         -0.03775    0.03781  -0.998  0.31808   
lwt         -0.01491    0.00704  -2.118  0.03419 * 
raceblack    1.21274    0.53248   2.278  0.02275 * 
raceother    0.80412    0.44843   1.793  0.07294 . 
smokeyes     0.84640    0.40806   2.074  0.03806 * 
pretermyes   1.22175    0.46301   2.639  0.00832 **
htyes        1.83869    0.70324   2.615  0.00893 **
uiyes        0.71113    0.46311   1.536  0.12465   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 234.67  on 188  degrees of freedom
Residual deviance: 196.83  on 180  degrees of freedom
AIC: 214.83

Number of Fisher Scoring iterations: 4
```

Four things in that output are new.

**The column says `z value`, not `t value`.** There is no residual variance to estimate and no $t$ distribution to refer to, so the test is a normal approximation. With 189 observations that approximation is reasonable. With 20 it would not be.

**There is no residual standard error and no $R^2$.** Deviance replaces them. Residual deviance measures how far the fitted model sits from a model that fits every observation perfectly. Null deviance does the same for a model with an intercept and nothing else. The drop from 234.67 to 196.83 is what the predictors bought.

**The dispersion parameter is fixed at 1.** The binomial distribution ties the variance to the mean, so there is no free variance to estimate. R is telling you it did not estimate one. Part C shows what happens when that claim is false.

**Fisher scoring iterations.** There is no closed-form solution. The fit is found by iteration. A number above about 25, or a warning about fitted probabilities of 0 or 1, usually means a predictor separates the outcome perfectly and the coefficient is running off to infinity.

The fitted model, with coefficients rounded to four places, is

$$\log\!\left(\frac{\hat{p}_i}{1-\hat{p}_i}\right) = 0.6369 - 0.0377\,\text{age}_i - 0.0149\,\text{lwt}_i + 1.2127\,\color{red}{\text{black}_i} + 0.8041\,\color{red}{\text{other}_i}$$

$$+\; 0.8464\,\color{red}{\text{smoke}_i} + 1.2218\,\color{red}{\text{preterm}_i} + 1.8387\,\color{red}{\text{ht}_i} + 0.7111\,\color{red}{\text{ui}_i}$$

Note that the $\color{red}{red}$ variables above are indicator functions, as seen in the output above.

## Three Scales for One Coefficient {#three-scales}

The smoking coefficient is 0.8464. On its own that number means nothing to a reader. It has three readings.

```r
oddsInterval <- exp(confint(logitModel))
oddsTable <- data.frame(
  logOdds = round(coef(logitModel), 4),
  oddsRatio = round(exp(coef(logitModel)), 3),
  lower = round(oddsInterval[, 1], 3),
  upper = round(oddsInterval[, 2], 3))
oddsTable
```

```
            logOdds oddsRatio lower  upper
(Intercept)  0.6369     1.891 0.175 22.277
age         -0.0377     0.963 0.892  1.036
lwt         -0.0149     0.985 0.971  0.998
raceblack    1.2127     3.363 1.186  9.734
raceother    0.8041     2.235 0.938  5.501
smokeyes     0.8464     2.331 1.058  5.293
pretermyes   1.2218     3.393 1.382  8.602
htyes        1.8387     6.288 1.640 27.258
uiyes        0.7111     2.036 0.812  5.058
```

**Log-odds.** Smoking adds 0.8464 to the log-odds of a small baby, holding the rest fixed. Correct, and useless in a sentence anyone will read.

**Odds ratio.** $e^{0.8464} = 2.331$. Smoking multiplies the odds by about 2.3, with a 95 percent interval from 1.06 to 5.29. The interval was built on the log-odds scale and then exponentiated, which is why it is not symmetric around 2.331. An odds ratio of 1 is the no-effect value, so an interval that excludes 1 matches a p-value below 0.05.

`confint()` on a `glm` object inverts the likelihood ratio test rather than adding and subtracting standard errors, which is why it pauses to profile. It is the better interval for small samples. `confint.default()` gives the quicker Wald version.

**Probability.** This one needs a starting point, because the model is not a straight line on the probability scale. The same odds ratio moves the probability by different amounts depending on where you start.

```r
profiles <- data.frame(
  lwt = c(120, 120, 180, 180),
  smoke = factor(c("no", "yes", "no", "yes"), levels = c("no", "yes")),
  age = 23, race = factor("white", levels = levels(bw$race)),
  preterm = factor("no", levels = c("no", "yes")),
  ht = factor("no", levels = c("no", "yes")),
  ui = factor("no", levels = c("no", "yes")))
profiles$probability <- round(predict(logitModel, profiles, type = "response"), 4)
profiles[, c("lwt", "smoke", "probability")]
```

```
  lwt smoke probability
1 120    no      0.1171
2 120   yes      0.2361
3 180    no      0.0514
4 180   yes      0.1122
```

One odds ratio, two different stories. For a 120-pound mother, smoking moves the risk from 0.117 to 0.236, a rise of about 12 percentage points. For a 180-pound mother, it moves from 0.051 to 0.112, a rise of about 6 percentage points. The odds ratio is 2.33 in both rows, and so is constant by construction. The risk difference is not. **Report the odds ratio for the model and a predicted probability for the reader**, and say which profile the probability belongs to.

![](../assets/images/glms-and-gams/1-logistic-prob.png)

## Sidenote: Where Is racewhite? {#indicators}

`race` has three levels and the model has two coefficients for it. The missing one is the baseline. R takes the first level, `white`, and folds it into the intercept. The red terms in the fitted equation above are indicators, equal to 1 when the condition holds and 0 when it does not.

For a white mother, `black` and `other` are both 0, and the equation collapses to

$$\log\!\left(\frac{\hat{p}_i}{1-\hat{p}_i}\right) = 0.6369 - 0.0377\,\text{age}_i - 0.0149\,\text{lwt}_i + \cdots$$

So `raceblack` of 1.2127 is not a statement about Black mothers on their own. It is the gap between Black and white mothers, with everything else held fixed. Every indicator coefficient in a GLM is a comparison against the level R left out. Use `relevel()` to change which one that is.

## Intervals Belong on the Link Scale {#intervals}

`predict()` offers both scales and they are not interchangeable.

```r
riskProfile <- data.frame(
  age = 23, lwt = 95,
  race = factor("black", levels = levels(bw$race)),
  smoke = factor("yes", levels = c("no", "yes")),
  preterm = factor("yes", levels = c("no", "yes")),
  ht = factor("yes", levels = c("no", "yes")),
  ui = factor("no", levels = c("no", "yes")))

onLink <- predict(logitModel, riskProfile, type = "link", se.fit = TRUE)
onResponse <- predict(logitModel, riskProfile, type = "response", se.fit = TRUE)

round(c(estimate = plogis(onLink$fit),
        linkLower = plogis(onLink$fit - 1.96 * onLink$se.fit),
        linkUpper = plogis(onLink$fit + 1.96 * onLink$se.fit),
        responseLower = onResponse$fit - 1.96 * onResponse$se.fit,
        responseUpper = onResponse$fit + 1.96 * onResponse$se.fit), 4)
```

```
     estimate.1     linkLower.1     linkUpper.1 responseLower.1 responseUpper.1 
         0.9699          0.8192          0.9956          0.9126          1.0272 
```

The second interval ends at 1.0272. The model has reported a probability above one.

The reason is the same one the link was introduced for. Adding and subtracting standard errors is a straight-line operation, and it belongs on the scale where the quantity is free to move. On the link scale the estimate is -3.47 with a symmetric interval around it. Pushing that interval through `plogis()` gives 0.8192 to 0.9956, which is squeezed against the upper bound and cannot cross it.

![](../assets/images/glms-and-gams/1-ci-scales.png)

**Build the interval on the link scale, then transform both ends.** This holds for every GLM and every link. Part 5 of this series returns to it with prediction rather than confidence intervals.

## Does the Model Hold Up? {#logistic-diagnostics}

The residual plots from the linear regression series do not transfer. We saw why at the start of Part A, where every residual landed on one of two lines. For a binary outcome we need diagnostics that average over groups of observations before looking at anything.

**Binned residuals.** Sort by predicted probability, cut into bins, and average the raw residuals inside each one. Individual residuals are useless. Their averages are not. If the model is right, each average should sit near zero, inside a band of roughly $\pm 2\sqrt{\overline{p(1-p)}/n_j}$.

```r
probability <- fitted(logitModel)
outcome <- bw$low

binnedResiduals <- function(p, y, bins = 12) {
  cuts <- cut(p, quantile(p, probs = seq(0, 1, length.out = bins + 1)),
              include.lowest = TRUE)
  out <- data.frame(
    meanProbability = tapply(p, cuts, mean),
    meanResidual = tapply(y - p, cuts, mean),
    n = tapply(y, cuts, length),
    se = sqrt(tapply(p * (1 - p), cuts, mean) / tapply(y, cuts, length)))
  out$inside <- abs(out$meanResidual) <= 2 * out$se
  out
}
binned <- binnedResiduals(probability, outcome)
round(binned[, c("meanProbability", "meanResidual", "n", "se")], 4)
c(binsInsideBand = sum(binned$inside), bins = nrow(binned))
```

```
                meanProbability meanResidual  n     se
[0.0233,0.0746]          0.0538      -0.0538 16 0.0563
(0.0746,0.108]           0.0918       0.0332 16 0.0721
(0.108,0.156]            0.1296      -0.0046 16 0.0839
(0.156,0.2]              0.1812       0.0855 15 0.0994
(0.2,0.229]              0.2156       0.0344 16 0.1028
(0.229,0.271]            0.2454      -0.1204 16 0.1075
(0.271,0.297]            0.2800       0.1867 15 0.1159
(0.297,0.359]            0.3212      -0.1337 16 0.1166
(0.359,0.459]            0.4063       0.0312 16 0.1225
(0.459,0.537]            0.4958      -0.0291 15 0.1289
(0.537,0.64]             0.5760      -0.0135 16 0.1232
(0.64,0.88]              0.7507      -0.0007 16 0.1068

binsInsideBand           bins 
            12             12 
```

All twelve bins fall inside the band. With sixteen births per bin the band is wide, so this check rules out a badly wrong model rather than confirming a right one.

**Calibration.** Split the predictions into tenths and compare the average prediction with the observed rate in each tenth. A model is calibrated when a predicted 30 percent happens about 30 percent of the time.

```r
calibrationTable <- function(p, y, groups = 10) {
  cuts <- cut(p, quantile(p, probs = seq(0, 1, length.out = groups + 1)),
              include.lowest = TRUE)
  data.frame(predicted = tapply(p, cuts, mean),
             observed = tapply(y, cuts, mean),
             n = tapply(y, cuts, length))
}
round(calibrationTable(probability, outcome), 4)
```

```
                predicted observed  n
[0.0233,0.0779]    0.0574   0.0000 19
(0.0779,0.123]     0.1024   0.1053 19
(0.123,0.185]      0.1537   0.2632 19
(0.185,0.225]      0.2068   0.1579 19
(0.225,0.271]      0.2427   0.2105 19
(0.271,0.301]      0.2832   0.3889 18
(0.301,0.384]      0.3413   0.3158 19
(0.384,0.504]      0.4501   0.4211 19
(0.504,0.613]      0.5512   0.5789 19
(0.613,0.88]       0.7313   0.6842 19
```

The two columns track each other, with the third group the worst at 0.154 predicted against 0.263 observed. With nineteen births per group, a gap of that size is around two babies.

The Hosmer-Lemeshow test turns the same table into one number.

```r
hosmerLemeshow <- function(p, y, groups = 10) {
  cuts <- cut(p, quantile(p, probs = seq(0, 1, length.out = groups + 1)),
              include.lowest = TRUE)
  observed <- tapply(y, cuts, sum)
  expected <- tapply(p, cuts, sum)
  n <- tapply(y, cuts, length)
  statistic <- sum((observed - expected)^2 / (expected * (1 - expected / n)))
  c(statistic = statistic, df = groups - 2,
    pValue = pchisq(statistic, groups - 2, lower.tail = FALSE))
}
round(hosmerLemeshow(probability, outcome), 4)
```

```
statistic        df    pValue 
   4.6762    8.0000    0.7916 
```

A large p-value here is the reassuring direction, which is backwards from most tests you have seen. It says the observed counts are close to the expected ones. Treat it as weak evidence. The answer moves when you change the number of groups, and the test has little power to detect a wrong model in a sample this size.

**Discrimination.** Calibration asks whether the numbers are honest. Discrimination asks whether they separate the two outcomes. The area under the ROC curve is the probability that a randomly chosen small baby was given a higher predicted risk than a randomly chosen normal one.

```r
areaUnderCurve <- function(p, y) {
  cases <- p[y == 1]
  controls <- p[y == 0]
  mean(outer(cases, controls, ">") + 0.5 * outer(cases, controls, "=="))
}
round(c(auc = areaUnderCurve(probability, outcome)), 4)
table(predicted = ifelse(probability > 0.5, 1, 0), observed = outcome)
```

```
   auc 
0.7578 

         observed
predicted   0   1
        0 116  34
        1  14  25
```

An AUC of 0.758 beats the 0.5 of a coin and falls well short of a model you would act on for an individual patient.

The table underneath shows why a 0.5 cutoff is a poor habit. Only 59 of 189 babies were small, so the model rarely predicts above 0.5, and it catches 25 of the 59. Sensitivity is 0.42 while specificity is 0.89. The cutoff is a decision about the relative cost of the two mistakes, and it is yours to make rather than R's.

**Likelihood ratio tests.** The F tests from linear regression are gone. Deviance differences replace them.

```r
anova(glm(low ~ 1, family = binomial, data = bw), logitModel, test = "Chisq")
drop1(logitModel, test = "LRT")
```

```
Analysis of Deviance Table

Model 1: low ~ 1
Model 2: low ~ age + lwt + race + smoke + preterm + ht + ui
  Resid. Df Resid. Dev Df Deviance  Pr(>Chi)    
1       188     234.67                          
2       180     196.83  8   37.838 8.064e-06 ***

Single term deletions

Model:
low ~ age + lwt + race + smoke + preterm + ht + ui
        Df Deviance    AIC    LRT Pr(>Chi)   
<none>       196.83 214.83                   
age      1   197.85 213.85 1.0179 0.313026   
lwt      1   201.83 217.83 4.9996 0.025353 * 
race     2   203.24 217.24 6.4066 0.040628 * 
smoke    1   201.25 217.25 4.4133 0.035659 * 
preterm  1   203.95 219.95 7.1144 0.007647 **
ht       1   204.01 220.01 7.1793 0.007375 **
ui       1   199.15 215.15 2.3177 0.127909   
```

The model as a whole beats an intercept, with a deviance drop of 37.8 on 8 degrees of freedom. `drop1()` tests one term at a time against the full model, and it is the right tool for a factor with more than two levels. `race` costs two degrees of freedom, so no single row of `summary()` tests it. Here it matters at 0.041 while neither of its two coefficients clears 0.05 on its own.

![](../assets/images/glms-and-gams/1-logistic-diagnostics.png)

# Part C: Poisson Regression {#part-c}

## Fitting {#fitting-poisson}

Same function, different family.

```r
poissonModel <- glm(count ~ spray, family = poisson(link = "log"),
                    data = InsectSprays)
summary(poissonModel)
```

```
Call:
glm(formula = count ~ spray, family = poisson(link = "log"), 
    data = InsectSprays)

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)  2.67415    0.07581  35.274  < 2e-16 ***
sprayB       0.05588    0.10574   0.528    0.597    
sprayC      -1.94018    0.21389  -9.071  < 2e-16 ***
sprayD      -1.08152    0.15065  -7.179 7.03e-13 ***
sprayE      -1.42139    0.17192  -8.268  < 2e-16 ***
sprayF       0.13926    0.10367   1.343    0.179    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 409.041  on 71  degrees of freedom
Residual deviance:  98.329  on 66  degrees of freedom
AIC: 376.59
```

The intercept is 2.67415 and $e^{2.67415} = 14.5$, which is the mean count for spray A. On the log scale the intercept is the baseline group's log mean, and every other coefficient is a difference of logs, which is a ratio once exponentiated.

```r
rateInterval <- exp(confint(poissonModel))
round(data.frame(logRate = coef(poissonModel),
                 rateRatio = exp(coef(poissonModel)),
                 lower = rateInterval[, 1],
                 upper = rateInterval[, 2]), 3)
```

```
Waiting for profiling to be done...
            logRate rateRatio  lower  upper
(Intercept)   2.674    14.500 12.451 16.762
sprayB        0.056     1.057  0.860  1.302
sprayC       -1.940     0.144  0.092  0.214
sprayD       -1.082     0.339  0.250  0.453
sprayE       -1.421     0.241  0.170  0.334
sprayF        0.139     1.149  0.938  1.409
```

Spray C leaves 14.4 percent of the insects that spray A leaves, with an interval from 9 to 21 percent. Sprays B and F have intervals covering 1, so neither differs from A. The fitted model is

$$\log(\hat{\mu}_i) = 2.6741 + 0.0559\,B_i - 1.9402\,C_i - 1.0815\,D_i - 1.4214\,E_i + 0.1393\,F_i$$

Predictions follow the same rule as Part B. Build the interval on the link scale and transform it.

```r
sprayGrid <- data.frame(spray = factor(levels(InsectSprays$spray)))
sprayLink <- predict(poissonModel, sprayGrid, type = "link", se.fit = TRUE)
data.frame(
  spray = sprayGrid$spray,
  observedMean = round(tapply(InsectSprays$count, InsectSprays$spray, mean), 2),
  fitted = round(exp(sprayLink$fit), 2),
  lower = round(exp(sprayLink$fit - 1.96 * sprayLink$se.fit), 2),
  upper = round(exp(sprayLink$fit + 1.96 * sprayLink$se.fit), 2))
```

```
  spray observedMean fitted lower upper
A     A        14.50  14.50 12.50 16.82
B     B        15.33  15.33 13.27 17.72
C     C         2.08   2.08  1.41  3.08
D     D         4.92   4.92  3.81  6.35
E     E         3.50   3.50  2.59  4.74
F     F        16.67  16.67 14.51 19.14
```

The fitted values equal the group means, the same as the linear model gave. With one factor and nothing else, both models have a parameter for each group, so neither can do anything but reproduce the means. What differs is everything around them. The intervals here are asymmetric, they are narrow where the count is small, and no lower bound goes below zero.

![](../assets/images/glms-and-gams/1-poisson-fit.png)

## Does the Model Hold Up? {#poisson-diagnostics}

The Poisson makes a claim that no other common model makes. It says the variance equals the mean. That claim is checkable.

```r
round(c(pearsonDispersion = dispersion(poissonModel),
        devianceOverDf = deviance(poissonModel) / df.residual(poissonModel)), 3)
```

```
pearsonDispersion    devianceOverDf 
            1.508             1.490 
```

Both statistics should sit near 1 if the claim holds. At 1.51 the counts are about half again as variable as the Poisson expects. That is mild, and worth knowing about, because the standard errors are built on that claim.

```r
quasiModel <- glm(count ~ spray, family = quasipoisson(link = "log"),
                  data = InsectSprays)
round(data.frame(
  estimate = coef(poissonModel),
  poissonSE = summary(poissonModel)$coefficients[, 2],
  quasiSE = summary(quasiModel)$coefficients[, 2],
  inflation = summary(quasiModel)$coefficients[, 2] /
    summary(poissonModel)$coefficients[, 2]), 4)
```

```
            estimate poissonSE quasiSE inflation
(Intercept)   2.6741    0.0758  0.0931    1.2279
sprayB        0.0559    0.1057  0.1298    1.2279
sprayC       -1.9402    0.2139  0.2626    1.2279
sprayD       -1.0815    0.1507  0.1850    1.2279
sprayE       -1.4214    0.1719  0.2111    1.2279
sprayF        0.1393    0.1037  0.1273    1.2279
```

`quasipoisson` keeps the same coefficients and estimates the dispersion rather than assuming it. Every standard error grows by the same factor, $\sqrt{1.508} = 1.228$. The estimates do not move at all. Overdispersion is a statement about precision, not about the fit.

Two more checks are worth running on any count model.

**A rootogram** compares the counts the model expects against the counts observed, across the whole range of the response rather than one summary number. Bars hang from the expected curve. A bar that falls short of the zero line means the model expected more of that count than it saw.

```r
rootogram <- function(model, response) {
  mu <- fitted(model)
  counts <- 0:max(response)
  expected <- sapply(counts, function(k) sum(dpois(k, mu)))
  observed <- as.numeric(table(factor(response, levels = counts)))
  data.frame(count = counts, observed = observed, expected = expected,
             top = sqrt(expected), bottom = sqrt(expected) - sqrt(observed))
}
root <- rootogram(poissonModel, InsectSprays$count)
round(head(data.frame(count = root$count, observed = root$observed,
                      expected = root$expected), 8), 2)
```

```
  count observed expected
1     0        2     1.94
2     1        6     4.81
3     2        4     6.53
4     3        8     6.59
5     4        4     5.60
6     5        7     4.24
7     6        3     2.97
8     7        3     2.04
```

**Randomized quantile residuals** are the residuals to use when the response is discrete. Ordinary residuals from a count model fall into stripes for the same reason the binary ones did. Quantile residuals take a random draw from inside each observation's predicted interval and push it through the normal quantile function, which breaks up the stripes. If the model is right, they are standard normal, and an ordinary QQ plot then works.

```r
quantileResiduals <- function(model, response) {
  mu <- fitted(model)
  qnorm(runif(length(response), ppois(response - 1, mu), ppois(response, mu)))
}
set.seed(2026)
qResid <- quantileResiduals(poissonModel, InsectSprays$count)
round(c(mean = mean(qResid), sd = sd(qResid),
        shapiroP = shapiro.test(qResid)$p.value), 4)
```

```
    mean       sd shapiroP 
 -0.0456   1.1862   0.7391 
```

The mean is near zero and the test gives no reason to doubt normality. The standard deviation is 1.186 rather than 1, which is the same overdispersion showing up a second way. These residuals carry a random component, so a different seed gives slightly different numbers. Draw them a few times before drawing a conclusion.

![](../assets/images/glms-and-gams/1-poisson-diagnostics.png)

## When the Check Fails {#overdispersion}

`InsectSprays` was mild. Here is one that is not. `quakes` holds 1000 seismic events near Fiji, and `stations` counts how many monitoring stations reported each one.

```r
data(quakes)
c(events = nrow(quakes),
  meanStations = round(mean(quakes$stations), 2),
  varianceStations = round(var(quakes$stations), 2))

quakePoisson <- glm(stations ~ mag + depth, family = poisson(link = "log"),
                    data = quakes)
round(summary(quakePoisson)$coefficients, 5)
round(c(dispersion = dispersion(quakePoisson),
        standardErrorInflation = sqrt(dispersion(quakePoisson))), 3)
```

```
          events     meanStations varianceStations 
         1000.00            33.42           479.63 

            Estimate Std. Error   z value Pr(>|z|)
(Intercept) -2.20476    0.05909 -37.31433        0
mag          1.18885    0.01171 101.54970        0
depth        0.00031    0.00003  12.18264        0

            dispersion standardErrorInflation 
                 2.874                  1.695 
```

The marginal variance is 479.63 against a mean of 33.42, and after fitting, the dispersion is still 2.87. The standard errors in that table are too small by about 70 percent.

```r
quakeQuasi <- glm(stations ~ mag + depth, family = quasipoisson(link = "log"),
                  data = quakes)
round(summary(quakeQuasi)$coefficients, 5)
```

```
            Estimate Std. Error   t value Pr(>|t|)
(Intercept) -2.20476    0.10016 -22.01196        0
mag          1.18885    0.01985  59.90482        0
depth        0.00031    0.00004   7.18662        0
```

Nothing changes here, in the sense that a $t$ of 59.9 and a $z$ of 101.5 lead to the same decision. A term sitting at $z = 2.3$ under the Poisson would arrive at $z = 1.4$ once the dispersion is accounted for, and the conclusion would reverse. Report the dispersion whenever you report a Poisson fit.

On the magnitude coefficient, $e^{1.18885} = 3.28$, so each extra point of magnitude multiplies the expected number of reporting stations by about 3.3.

![](../assets/images/glms-and-gams/1-quakes.png)

The left panel shows what the log link bought. A straight line cannot bend, so it runs above the data at low magnitudes and below it at high ones, while the exponential curve follows the shape. It also shows the cost. Above magnitude 6 there are few earthquakes, and the curve climbs steeply through that gap on the strength of very little. The right panel bins the events by magnitude and plots each bin's mean against its variance. Every bin sits well above the line where the two would be equal.

What causes overdispersion? There are several possibilities. Something is missing from the model, or the observations are grouped and not independent, or the response has more zeros than the Poisson can produce. The negative binomial, the quasi-Poisson, and mixed effects are the usual answers, which we will come back to throughout this series.

## A Note on Exposure {#offsets}

Counts usually come with something that made them possible. Ten accidents in a year mean one thing on a road carrying a hundred cars and another on a road carrying a million. The quantity in the denominator is called exposure, and you might choose to model it with an offset, which is a term whose coefficient is fixed at 1.

```r
glm(claims ~ age + region + offset(log(policyYears)),
    family = poisson(link = "log"), data = insurance)
```

Writing $\log(\mu_i) = \log(t_i) + \beta_0 + \beta_1 x_{i1}$ is the same as writing $\log(\mu_i / t_i) = \beta_0 + \beta_1 x_{i1}$, so the model is about the rate per unit of exposure while the response stays a whole count. Dividing the count by the exposure first and fitting that is not the same thing, and it throws away the information that a count of 10 out of 1000 is more precisely measured than 1 out of 100.

# YOU TRY! {#you-try}

Work through these for the next 15 minutes. Both datasets come with R.

```r
library(MASS)
data(Pima.tr)      # 200 women, type = Yes/No for diabetes
data(warpbreaks)   # 54 looms, breaks = a count
```

**Part 1. A binary outcome.** Fit `glm(type ~ glu + bmi + age + ped, family = binomial, data = Pima.tr)`. Before that, fit the same formula with `lm()` after converting `type` to 0 and 1, and count how many fitted values fall outside 0 and 1.

**Part 2. Read a coefficient three ways.** Take the coefficient on `glu`. Report the log-odds, the odds ratio with a confidence interval, and the predicted probability for a woman at the first and third quartiles of `glu` with everything else at its median. Which of the three would you put in an abstract?

**Part 3. The interval.** Predict for a high-risk profile on both scales, as in Part B. Does the response-scale interval stay inside 0 and 1?

**Part 4. Check it.** Produce binned residuals and a calibration table. Compute the AUC. Is this model better at separating the two groups than the birth weight model was?

**Part 5. A count outcome.** Fit `glm(breaks ~ wool + tension, family = poisson, data = warpbreaks)`. Interpret `tensionM` as a rate ratio in one sentence.

**Part 6. Check the variance claim.** Compute the dispersion. Compare the Poisson standard errors with the `quasipoisson` ones. By what factor do they grow, and does any conclusion change?

**Part 7. Does an interaction help?** Fit `breaks ~ wool * tension` and compare with `anova(additive, interaction, test = "Chisq")`. Look at the dispersion again afterwards. Did adding a term fix the problem or hide it?

**Part 8. The honest summary.** Write two sentences reporting what predicts `breaks`, for someone who will act on them. Include the dispersion and say what it does to the precision you are claiming.

# So... what did we learn? {#summary}

1. A linear model on a binary outcome gave eight mothers a negative probability, and its fitted line ran out of valid probabilities at 250.9 pounds, where the heaviest mother in the data weighs 250.
2. A linear model on counts returned prediction intervals starting at -6 insects, because it was asked for one variance when the groups ranged from 3.0 to 38.6.
3. A GLM is three choices. A distribution for the response, a linear predictor, and a link that connects them. A linear model is the case with a normal distribution and an identity link.
4. A link takes a mean that is penned in and returns a number that is free. The log handles counts, the logit handles probabilities.
5. Additive on the link scale means multiplicative on the response scale. This is why coefficients get exponentiated before anyone reads them.
6. A logistic coefficient has three readings. The log-odds is what R prints, the odds ratio is what you report, and a predicted probability is what the reader understands. The odds ratio is constant across profiles and the risk difference is not.
7. Indicator coefficients compare against the level R folded into the intercept. `raceblack` is a gap, not a group.
8. Build intervals on the link scale and transform both ends. Doing it the other way returned an upper bound of 1.0272 for a probability.
9. Residual plots from linear regression do not transfer. Use binned residuals, calibration, discrimination, and likelihood ratio tests for binary outcomes.
10. A large Hosmer-Lemeshow p-value is the reassuring direction, which is backwards from most tests, and it is weak evidence either way.
11. The Poisson claims the variance equals the mean. Check it. The insect data came in at 1.51 and the earthquake data at 2.87.
12. Overdispersion leaves the coefficients alone and inflates the standard errors, by $\sqrt{1.508} = 1.23$ in one case and $\sqrt{2.874} = 1.70$ in the other. Report the dispersion alongside the fit.
13. Counts with a denominator need an offset, not a ratio as the response.

# Next Time {#next-time}

Today we fit the models and read the coefficients one at a time. Next session is about saying what they mean. We move between the link scale and the response scale on purpose rather than by habit, and
work through odds ratios, rate ratios, fitted probabilities, and expected counts,
including the cases where two scales tell different stories about the same effect.
The second half is uncertainty and fit. Where the intervals come from, what deviance
and AIC can and cannot settle, and the diagnostics that decide whether a model is
worth interpreting at all. We also return to the dispersion statistic that Part C
left sitting at 2.87.

# References {#references}

**The framework.**

- Nelder, J. A. and Wedderburn, R. W. M. (1972). Generalized linear models. *Journal of the Royal Statistical Society Series A*, 135(3), 370-384. The paper that unified the families into one fitting algorithm.
- McCullagh, P. and Nelder, J. A. (1989). *Generalized Linear Models*, 2nd edition. Chapman and Hall. The standard reference.
- Dobson, A. J. and Barnett, A. G. (2018). *An Introduction to Generalized Linear Models*, 4th edition. CRC Press. The gentler route into the same material.

**Logistic regression.**

- Hosmer, D. W., Lemeshow, S. and Sturdivant, R. X. (2013). *Applied Logistic Regression*, 3rd edition. Wiley. The source of the `birthwt` data, and of the goodness-of-fit test used above.

**Counts and diagnostics.**

- Kleiber, C. and Zeileis, A. (2016). Visualizing count data regressions using rootograms. *The American Statistician*, 70(3), 296-303.

**Data.**

- Venables, W. N. and Ripley, B. D. (2002). *Modern Applied Statistics with S*, 4th edition. Springer. The `MASS` package.
- Run `?birthwt`, `?InsectSprays`, `?quakes`, `?Pima.tr` and `?warpbreaks` for the variable definitions and original sources.

  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
  var links = Array.prototype.slice.call(
    document.querySelectorAll('.ws-toc nav a'));
  var targets = links.map(function (a) {
    return document.getElementById(a.getAttribute('href').slice(1));
  });
  function update() {
    var best = -1;
    for (var i = 0; i < targets.length; i++) {
      if (targets[i] && targets[i].getBoundingClientRect().top <= 90) best = i;
    }
    links.forEach(function (a, i) { a.classList.toggle('active', i === best); });
  }
  window.addEventListener('scroll', update, { passive: true });
  update();
});
</script>
