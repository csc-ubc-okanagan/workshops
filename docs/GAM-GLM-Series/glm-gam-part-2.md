---
title: "GLMs and GAMs in R (Part 2): Interpreting Generalized Linear Models"
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
        <li><a href="#part-a">A. Two Scales</a></li>
        <li class="sub"><a href="#recall">Recall</a></li>
        <li class="sub"><a href="#two-scales">Link and response</a></li>
        <li class="sub"><a href="#reading-output">Odds and rate ratios</a></li>
        <li class="sub"><a href="#ratios">Coefficients as ratios</a></li>
        <li class="sub"><a href="#link-intervals">Intervals on the link scale</a></li>
        <li><a href="#part-b">B. Probabilities and Counts</a></li>
        <li class="sub"><a href="#fitted-probabilities">Fitted probabilities</a></li>
        <li class="sub"><a href="#expected-counts">Expected counts</a></li>
        <li><a href="#part-c">C. Where Uncertainty Comes From</a></li>
        <li class="sub"><a href="#two-intervals">Wald and profile intervals</a></li>
        <li class="sub"><a href="#ci-vs-pi">Means against observations</a></li>
        <li><a href="#part-d">D. Does the Model Fit</a></li>
        <li class="sub"><a href="#overdispersion-fixes">Two fixes for overdispersion</a></li>
        <li class="sub"><a href="#lrt-aic">Likelihood ratios and AIC</a></li>
        <li class="sub"><a href="#deviance">Deviance</a></li>
        <li class="sub"><a href="#calibration">Calibration</a></li>
        <li class="sub"><a href="#residual-types">Three residuals</a></li>
        <li class="sub"><a href="#rootogram">Rootograms</a></li>
        <li class="sub"><a href="#curvature">The assumption that is left</a></li>
        <li><a href="#you-try">YOU TRY!</a></li>
        <li><a href="#summary">So... what did we learn?</a></li>
        <li><a href="#next-time">Next Time</a></li>
        <li><a href="#references">References</a></li>
      </ul>
    </nav>
  </aside>

  <div class="ws-body" markdown="1">

> Part 1 fit the models. A coefficient came out, we exponentiated it, and we called that an odds ratio or a rate ratio. Today is about saying what the models mean. R reports every coefficient on the link scale, and almost nobody reading your work thinks on the link scale. So we move between the link and the response scale on purpose, and work through odds ratios, rate ratios, fitted probabilities, and expected counts, including the cases where two scales tell different stories about the same effect. The second half is uncertainty and fit. Where the standard errors come from, when the two usual intervals disagree, what deviance and AIC can and cannot settle, and the diagnostics that decide whether a model is worth interpreting at all. We finish on the one assumption a GLM still makes after all of this, because removing it is what Part 3 is for.

## What You Will Learn {#what-you-will-learn}

By the end of this session you will be able to:

1. Move a prediction between the link and response scales, and say which scale
a coefficient, an interval, or a plot is on.
2. Read odds ratios and rate ratios from the output, for a change in the
predictor that a reader cares about, with an interval.
3. Report fitted probabilities and expected counts at chosen profiles, and say
why the ratio stays fixed while the difference does not.
4. Say when Wald and profile intervals disagree, and which to report.
5. Tell a confidence interval for a mean from a prediction interval for an
observation.
6. Compare models with likelihood ratio tests and AIC, and say what deviance
does and does not tell you.
7. Check a model with calibration, residuals, and a rootogram, and choose
between a quasi-Poisson and a negative binomial.

## Setup {#setup}

Same packages as Part 1. We rebuild the two models from last session and work
on those throughout.


``` r
packages <- c("ggplot2")
toInstall <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(toInstall)) install.packages(toInstall)

library(ggplot2)
library(MASS)          # birthwt, mvrnorm, glm.nb
theme_set(theme_classic(base_size = 14))

## Pearson chi-square over residual degrees of freedom.
dispersion <- function(model) {
  sum(residuals(model, type = "pearson")^2) / df.residual(model)
}

data(birthwt)
bw <- birthwt
bw$race    <- factor(bw$race,  labels = c("white", "black", "other"))
bw$smoke   <- factor(bw$smoke, labels = c("no", "yes"))
bw$ht      <- factor(bw$ht,    labels = c("no", "yes"))
bw$ui      <- factor(bw$ui,    labels = c("no", "yes"))
bw$preterm <- factor(ifelse(bw$ptl > 0, "yes", "no"), levels = c("no", "yes"))

logitModel <- glm(low ~ age + lwt + race + smoke + preterm + ht + ui,
                  family = binomial(link = "logit"), data = bw)

data(quakes)
quakePoisson <- glm(stations ~ mag + depth, family = poisson(link = "log"),
                    data = quakes)
```

# Part A: Two Scales {#part-a}

## Recall {#recall}

Part 1 introduced a GLM as three pieces: a distribution for the response, a
linear predictor $\eta_i$, and a link function $g(\cdot)$ that connects them.
The distribution comes from the exponential dispersion model (EDM) family,
which is defined by a mean $\mu_i$ and a dispersion parameter $\phi$.

$$Y_i \sim \text{EDM}(\mu_i, \phi) \qquad g(\mu_i) = \eta_i = \beta_0 + \beta_1 x_{i1} + \cdots + \beta_p x_{ip} \qquad \Longleftrightarrow \qquad \mu_i = g^{-1}(\eta_i)$$

## The Link Scale and the Response Scale {#two-scales}

Every quantity in a fitted GLM lives on one of two scales. The **link scale** is
where $\eta_i$ lives. It is unbounded, the predictors add up in a straight line,
and it is where R reports the coefficients. The **response scale** is where
$\mu_i$ lives. It is a probability or an expected count, so it is restricted to
a range (between 0 and 1, or above 0), and it is where a reader thinks.
`predict()` gives you either one, depending on `type`. With no `type`, you get
the link scale, which catches people out more often than anything else in this
session. `fitted()` always gives the response scale.

Let's do an adjusted predictions at the means (APM) to see how varying one of
our factors (`lwt` or weight of the mother at last menstruation) affects our
response (`low`) and show how the two scales actually look different when we 
predict from our GLMS.

<img src="glm-gam-part-2_files/figure-html/two-scales-plot-1.png" alt="" style="display: block; margin: auto;" />

The left panel is a straight line because the model assumes $g(\mu_i)$ is
linear in the predictors, and predicting on the link scale shows us that
assumption directly. The right panel is the same line pushed through the
inverse logit. On the left, the effect of weight is one number. On the right,
it depends on how heavy the mother already is.

## Reading the Output: Odds and Rate Ratios {#reading-output}

Rather than focusinsg on the entire output let's start with a single
coefficient from our logistic regression of birthweight against our predictors.
Below we'll look at the the coefficient, `smokeyes`, an categorical variable of
mom's who smoked.

## Logistic regression


``` r
round(summary(logitModel)$coefficients["smokeyes", ], 4)
```

```
  Estimate Std. Error    z value   Pr(>|z|) 
    0.8464     0.4081     2.0742     0.0381 
```

The estimate, `round(summary(logitModel)$coefficients["smokeyes", ], 2)[[1]]`,
is on the link scale. Holding everything else fixed,
smoking adds , `round(summary(logitModel)$coefficients["smokeyes", ], 2)[[1]]`
to the **log-odds** of a small baby. To read that, we need the odds.

The odds of an event are its probability divided by the probability that it
does not happen, $p / (1 - p)$. A probability of 0.5 is odds of 1 
($0.5/1 - 0.5$). A probability of 0.2 is odds of 0.25, or one small baby for
every four normal ones. Probabilities are stuck between 0 and 1, while odds run
from 0 to infinity, that's the condition we imposed with our choice of link
function.

You can compute odds straight from the data.


``` r
smokeTable <- table(bw$smoke, bw$low)
oddsNo  <- smokeTable["no", "1"]  / smokeTable["no", "0"]
oddsYes <- smokeTable["yes", "1"] / smokeTable["yes", "0"]
round(c(oddsNonSmokers = oddsNo, oddsSmokers = oddsYes,
        crudeOddsRatio = oddsYes / oddsNo), 3)
```

```
oddsNonSmokers    oddsSmokers crudeOddsRatio 
         0.337          0.682          2.022 
```

Among smokers there were 30 small babies for every 44 normal ones, which is
odds of 0.682. Among non-smokers it was 29 for every 86, or 0.337. The ratio
of the two, 2.02, is an **odds ratio**. Smokers had about twice the odds.

The model gives the same kind of number once the coefficient is exponentiated.
A difference in log-odds is the log of a ratio of odds, so

$$e^{0.8464} = 2.331$$

is the odds ratio for smoking, **adjusted** for everything else in the model.
It differs from the crude 2.02 because the model compares smokers and
non-smokers of the same age, weight, race, and clinical history.


``` r
round(exp(coef(logitModel)["smokeyes"]), 3)
```

```
smokeyes 
   2.331 
```
## Poisson regression

The Poisson model works the same way, without the odds. Its link is the log of
the expected count, so a coefficient is a difference in log counts, and
exponentiating it gives a ratio of expected counts, a **rate ratio**.


``` r
round(summary(quakePoisson)$coefficients["mag", ], 4)
```

```
  Estimate Std. Error    z value   Pr(>|z|) 
    1.1889     0.0117   101.5497     0.0000 
```

``` r
round(exp(coef(quakePoisson)["mag"]), 3)
```

```
  mag 
3.283 
```

Each extra point of magnitude adds 1.189 to the log of the expected number of
reporting stations, which multiplies the expected number by 3.283. An odds
ratio and are both just exponentiating a difference on the link scale. The only
difference is what gets multiplied, the odds or the count.

What a coefficient means once it leaves the link scale depends on the link.

| Link     | Coefficient (link scale) | $e^{\beta}$ (response scale) | A one-unit rise in $x$                       |
|----------|--------------------------|------------------------------|----------------------------------------------|
| Identity | Change in the mean       | Not used                     | Adds $\beta$ to the mean                     |
| Logit    | Change in the log-odds   | Odds ratio                   | Multiplies the odds by $e^{\beta}$           |
| Log      | Change in the log mean   | Rate ratio                   | Multiplies the expected count by $e^{\beta}$ |

> Additive on the link scale means multiplicative on the response scale.

## Coefficients as Ratios {#ratios}

Exponentiate the coefficients and the interval ends together.


``` r
profileCI <- confint(logitModel)
term <- "smokeyes"

round(data.frame(logOddsRatio = coef(logitModel)[[term]],
                 oddsRatio    = exp(coef(logitModel)[[term]]),
                 lower        = exp(profileCI[term, 1]),
                 upper        = exp(profileCI[term, 2]),
                 row.names    = term), 3)
```

```
         logOddsRatio oddsRatio lower upper
smokeyes        0.846     2.331 1.058 5.293
```

The weight coefficient gives an odds ratio of 0.985 per pound. That is correct
and also not very helpful, because nobody thinks about one pound. A reader wants a
step that means something, such as ten pounds or five years.

The rule is to multiply on the link scale and then exponentiate, both for the
estimate and for each end of the interval. A change of $k$ units multiplies the
odds by $e^{k\beta}$, which is $(e^{\beta})^k$ and not $k \cdot e^{\beta}$.


``` r
rescaledRatio <- function(model, term, k, ci = confint(model)) {
  round(exp(k * c(estimate = unname(coef(model)[term]),
                  lower = ci[term, 1], upper = ci[term, 2])), 3)
}
rbind(per10Pounds = rescaledRatio(logitModel, "lwt", 10, profileCI),
      per5Years   = rescaledRatio(logitModel, "age", 5, profileCI))
```

```
            estimate lower upper
per10Pounds    0.861 0.744 0.983
per5Years      0.828 0.566 1.191
```

Every ten pounds of the mother's weight multiplies the odds of a small baby by
0.861, with an interval from 0.744 to 0.983. That is a 14 percent drop in the
odds per ten pounds. The odds is a ratio so 1 means no change. To see the
change we subract 1 from the odds ratio 0.861 and multiply by 100 giving us 
$\approx 14\%$.

## Intervals Belong on the Link Scale {#link-intervals}

Part 1 made this point with one high-risk mother, and it is worth repeating
before we build more intervals. `predict()` returns a standard error on
whichever scale you ask for, and only one of those scales have a symmetric 
interval.


``` r
riskProfile <- data.frame(
  age = 23, lwt = 95,
  race = factor("black", levels = levels(bw$race)),
  smoke = factor("yes", levels = c("no", "yes")),
  preterm = factor("yes", levels = c("no", "yes")),
  ht = factor("yes", levels = c("no", "yes")),
  ui = factor("no", levels = c("no", "yes")))

onLink <- predict(logitModel, riskProfile, type = "link", se.fit = TRUE)
onResponse <- predict(logitModel, riskProfile, type = "response", se.fit = TRUE)

round(c(estimate = unname(plogis(onLink$fit)),
        linkLower = unname(plogis(onLink$fit - 1.96 * onLink$se.fit)),
        linkUpper = unname(plogis(onLink$fit + 1.96 * onLink$se.fit)),
        responseLower = unname(onResponse$fit - 1.96 * onResponse$se.fit),
        responseUpper = unname(onResponse$fit + 1.96 * onResponse$se.fit)), 4)
```

```
     estimate     linkLower     linkUpper responseLower responseUpper 
       0.9699        0.8192        0.9956        0.9126        1.0272 
```

The response-scale interval ends above one. The link-scale interval,
transformed afterwards, cannot. 
**Build the interval on the link scale, then transform both ends.**

# Part B: From Ratios to Probabilities and Counts {#part-b}

A ratio is what the model estimates. A probability or a count is what a reader
understands. Getting from one to the other needs a starting point, because the
same ratio moves a small probability or count by less than a large one.

## Fitted Probabilities {#fitted-probabilities}

The smoking odds ratio is 2.331, and that number is the same for every mother
in the data. The change in her probability is not. Take the same mother at
three weights and predict her risk as a non-smoker ($p_0$) and as a smoker
($p_1$). Then there are three ways to report the one effect.

$$\text{risk difference} = p_1 - p_0 \qquad \text{risk ratio} = \frac{p_1}{p_0} \qquad \text{odds ratio} = \frac{p_1/(1-p_1)}{p_0/(1-p_0)}$$


``` r
baseProfile <- function(lwt) {
  data.frame(lwt = lwt, age = 23,
             race = factor("white", levels = levels(bw$race)),
             preterm = factor("no", levels = c("no", "yes")),
             ht = factor("no", levels = c("no", "yes")),
             ui = factor("no", levels = c("no", "yes")))
}

threeContrasts <- function(model, profile) {
  p0 <- predict(model, cbind(profile, smoke = factor("no", levels = c("no", "yes"))),
                type = "response")
  p1 <- predict(model, cbind(profile, smoke = factor("yes", levels = c("no", "yes"))),
                type = "response")
  data.frame(lwt = profile$lwt,
             probabilityNo = p0,
             probabilityYes = p1,
             riskDifference = p1 - p0,
             riskRatio = p1 / p0,
             oddsRatio = (p1 / (1 - p1)) / (p0 / (1 - p0)))
}

round(threeContrasts(logitModel, baseProfile(c(100, 140, 200))), 4)
```

```
  lwt probabilityNo probabilityYes riskDifference riskRatio oddsRatio
1 100        0.1516         0.2940         0.1424    1.9398    2.3312
2 140        0.0896         0.1866         0.0970    2.0829    2.3312
3 200        0.0387         0.0857         0.0471    2.2171    2.3312
```

<img src="glm-gam-part-2_files/figure-html/fitted-probabilities-plot-1.png" alt="" style="display: block; margin: auto;" />

Only the odds ratio is flat. That is not a finding about the data. It is what
the logit link was built to do. The other two move because the probability
moves: for a 100-pound mother smoking adds 14 percentage points of risk, and for
a 200-pound mother it adds 5.

> An odds ratio of 2.33 does not mean the risk doubled. For these mothers it
> meant a risk ratio between 1.9 and 2.2. The gap between the odds ratio and the
> risk ratio grows as the outcome gets more common, which is why reading one as
> the other is such a common error.

Picking a profile means picking a mother who may not exist. The alternative is
to predict every mother in the sample twice, once as a smoker and once as a
non-smoker, and compare the averages. The literature calls this the average
marginal effect, and the `marginaleffects` package computes it, with an
interval, in one line.

## Expected Counts {#expected-counts}

The count model works the same way without the odds. Part A gave the rate ratio
per whole point of magnitude. As with weight, pick steps a reader cares about.


``` r
quakeCI <- confint(quakePoisson)
rbind(perHalfMagnitude = rescaledRatio(quakePoisson, "mag", 0.5, quakeCI),
      per100Km = rescaledRatio(quakePoisson, "depth", 100, quakeCI))
```

```
                 estimate lower upper
perHalfMagnitude    1.812 1.791 1.833
per100Km            1.032 1.026 1.037
```

Half a point of magnitude multiplies the expected number of reporting stations
by 1.81. Every 100 kilometres of depth multiplies it by 1.032, holding magnitude
fixed.

An expected count is the response-scale prediction at a chosen profile, with the
interval built on the link scale and transformed.


``` r
expectedCounts <- function(model, newdata) {
  link <- predict(model, newdata, type = "link", se.fit = TRUE)
  data.frame(newdata,
             expected = exp(link$fit),
             lower = exp(link$fit - 1.96 * link$se.fit),
             upper = exp(link$fit + 1.96 * link$se.fit))
}

quakeProfiles <- data.frame(mag = c(4.5, 5, 5.5, 6), depth = median(quakes$depth))
counts <- expectedCounts(quakePoisson, quakeProfiles)
counts$extraPerHalfPoint <- c(diff(counts$expected), NA)
round(counts, 2)
```

```
  mag depth expected  lower  upper extraPerHalfPoint
1 4.5   247    25.08  24.73  25.43             20.36
2 5.0   247    45.44  44.92  45.96             36.89
3 5.5   247    82.33  80.85  83.84             66.85
4 6.0   247   149.18 145.04 153.45                NA
```

<img src="glm-gam-part-2_files/figure-html/expected-counts-plot-1.png" alt="" style="display: block; margin: auto;" />

At the median depth, a magnitude 4.5 event is expected to reach about 25
stations and a magnitude 5.5 event about 82. Each half point multiplies the
count by the same 1.81, but adds 20 stations at the bottom of the table and 67 at
the top. A probability is squeezed against 0 and 1, so its risk difference rises
and then falls. A count has no ceiling, so the difference just keeps growing.

Two caveats. Only five events in the data reach magnitude 6, so that row leans
on very little. And these intervals assume the Poisson variance, which Part 1
showed is too small for this data. Part D comes back to that.

**Report the ratio for the model and a probability or a count for the reader,
and say which profile it belongs to.**

# Part C: Where the Uncertainty Comes From {#part-c}

## Wald and Profile Intervals {#two-intervals}

The standard errors in `summary()` come from the model's covariance matrix,
`vcov()`. You rarely need it directly, because `predict(..., se.fit = TRUE)`
already uses all of it, including how the coefficients move together.
A coefficient has two standard intervals.

**Wald.** Estimate plus or minus 1.96 standard errors, on the link scale. Fast,
and it assumes the log-likelihood is a symmetric parabola near its peak.
`confint.default()` gives this one.

**Profile likelihood.** Found by moving the coefficient away from its estimate
and refitting everything else until the fit gets worse by a set amount. Slower,
and it does not assume symmetry. `confint()` gives this one.


``` r
waldInterval <- confint.default(logitModel)
profileInterval <- confint(logitModel)

round(data.frame(
  oddsRatio = exp(coef(logitModel)),
  waldLower = exp(waldInterval[, 1]),
  waldUpper = exp(waldInterval[, 2]),
  profileLower = exp(profileInterval[, 1]),
  profileUpper = exp(profileInterval[, 2])), 3)
```

```
            oddsRatio waldLower waldUpper profileLower profileUpper
(Intercept)     1.891     0.170    21.078        0.175       22.277
age             0.963     0.894     1.037        0.892        1.036
lwt             0.985     0.972     0.999        0.971        0.998
raceblack       3.363     1.184     9.548        1.186        9.734
raceother       2.235     0.928     5.382        0.938        5.501
smokeyes        2.331     1.048     5.187        1.058        5.293
pretermyes      3.393     1.369     8.408        1.382        8.602
htyes           6.288     1.585    24.954        1.640       27.258
uiyes           2.036     0.822     5.047        0.812        5.058
```

<img src="glm-gam-part-2_files/figure-html/intervals-plot-1.png" alt="" style="display: block; margin: auto;" />

The two agree when a coefficient is well determined. They part company when a
term rests on few observations, because the likelihood is then skewed and the
Wald interval, symmetric by construction, is too short on one side. The
hypertension term is the one to watch. Its profile interval runs from 1.640 to
27.258, and the Wald interval stops short at 24.954. There are twelve mothers
with hypertension in the whole dataset. When the two disagree, report the
profile interval.

## Means Against Observations {#ci-vs-pi}

A confidence interval for $\mu_i$ says where the average sits. It says nothing
about where the next observation will land. For a count model the gap between
the two can be very large.

The confidence band comes from the standard error of the linear predictor, as in
Part B. Explicitly, the confidence band is
$\exp\!\left(\hat{\eta}_i \pm 1.96 \cdot \text{SE}(\hat{\eta}_i)\right)$, which
describes uncertainty about the mean. The prediction interval instead takes the
2.5th and 97.5th percentiles of a Poisson distribution with mean $\hat{\mu}_i$,
which describes where a single new count is likely to land.


``` r
quakeLink <- predict(quakePoisson, type = "link", se.fit = TRUE)
mu <- exp(quakeLink$fit)

bands <- data.frame(
  observed = quakes$stations,
  mu = mu,
  confidenceLower = exp(quakeLink$fit - 1.96 * quakeLink$se.fit),
  confidenceUpper = exp(quakeLink$fit + 1.96 * quakeLink$se.fit),
  poissonLower = qpois(0.025, mu),
  poissonUpper = qpois(0.975, mu))

round(c(
  confidenceBand = mean(bands$observed >= bands$confidenceLower &
                          bands$observed <= bands$confidenceUpper),
  poissonPrediction = mean(bands$observed >= bands$poissonLower &
                             bands$observed <= bands$poissonUpper),
  target = 0.95), 4)
```

```
   confidenceBand poissonPrediction            target 
            0.045             0.795             0.950 
```

<img src="glm-gam-part-2_files/figure-html/ci-vs-pi-plot-1.png" alt="" style="display: block; margin: auto;" />

Only the prediction band is meant to cover 95 percent of the points. The
confidence band is narrow and covers few of them, which is what it should do.
With 1000 earthquakes the mean is well determined, and it tells you little about
a single event.

The prediction band misses too, covering about four events in five rather than
nineteen in twenty. The Poisson assumes the variance equals the mean, and Part 1
found a dispersion of 2.874 for this model, so the band is too narrow. Part D
fixes that.

**Say which interval you are reporting.** A reader who hears "95 percent
interval" and sees a narrow band might assume it is about observations.

# Part D: Does the Model Fit {#part-d}

## Two Fixes for Overdispersion {#overdispersion-fixes}

Last time we touched on a concept called overdispersion (i.e., where our
dispersion parameter $\phi$ is larger than the value of 1 assumed by the
Poisson). Now we see two ways to deal with overdispersion in count data:

**Quasi-Poisson** keeps the Poisson mean and multiplies its variance by a
constant, $\text{Var}(Y_i) = \phi \, \mu_i$.

**Negative binomial** adds a quadratic term,
$\text{Var}(Y_i) = \mu_i + \mu_i^2/\theta$, which comes from letting the rate
itself vary between observations.


``` r
negativeBinomial <- glm.nb(stations ~ mag + depth, data = quakes)
quakeQuasi <- glm(stations ~ mag + depth, family = quasipoisson(link = "log"),
                  data = quakes)

round(c(quasiDispersion = summary(quakeQuasi)$dispersion,
        negativeBinomialTheta = negativeBinomial$theta), 4)
```

```
      quasiDispersion negativeBinomialTheta 
               2.8736               17.6793 
```

``` r
round(data.frame(
  poisson = summary(quakePoisson)$coefficients[, 2],
  quasiPoisson = summary(quakeQuasi)$coefficients[, 2],
  negativeBinomial = summary(negativeBinomial)$coefficients[, 2]), 5)
```

```
            poisson quasiPoisson negativeBinomial
(Intercept) 0.05909      0.10016          0.11457
mag         0.01171      0.01985          0.02352
depth       0.00003      0.00004          0.00005
```

Both widen the standard errors. The quasi-Poisson is not a real likelihood, so
it has no AIC and no likelihood ratio test. The negative binomial is a real
distribution, and it downweights large counts more. To choose between them,
plot the variance against the mean and see which shape the data follow.


``` r
varianceBins <- cut(fitted(quakePoisson),
                    breaks = quantile(fitted(quakePoisson),
                                      probs = seq(0, 1, length.out = 13)),
                    include.lowest = TRUE)
binnedVariance <- data.frame(
  mean = tapply(quakes$stations, varianceBins, mean),
  variance = tapply(quakes$stations, varianceBins, var))
```

<img src="glm-gam-part-2_files/figure-html/variance-functions-plot-1.png" alt="" style="display: block; margin: auto;" />

The points sit far above the grey Poisson line, curve upward away from the
straight quasi-Poisson line, and follow the negative binomial. That is the model
to report for this data, with its rate ratios and its intervals.

It also fixes the prediction band from Part C. Build the same interval from the
negative binomial and compare the two.


``` r
nbLower <- qnbinom(0.025, mu = fitted(negativeBinomial), size = negativeBinomial$theta)
nbUpper <- qnbinom(0.975, mu = fitted(negativeBinomial), size = negativeBinomial$theta)

compareFrame <- rbind(
  data.frame(mu = bands$mu, lower = bands$poissonLower, upper = bands$poissonUpper,
             observed = bands$observed, model = "Poisson"),
  data.frame(mu = fitted(negativeBinomial), lower = nbLower, upper = nbUpper,
             observed = quakes$stations, model = "Negative binomial"))
compareFrame$model <- factor(compareFrame$model, levels = c("Poisson", "Negative binomial"))
compareFrame$inside <- compareFrame$observed >= compareFrame$lower &
  compareFrame$observed <= compareFrame$upper

round(tapply(compareFrame$inside, compareFrame$model, mean), 3)
```

```
          Poisson Negative binomial 
            0.795             0.953 
```

<img src="glm-gam-part-2_files/figure-html/nb-prediction-plot-1.png" alt="" style="display: block; margin: auto;" />

The Poisson band covers 0.795 of the events, with the misses spread above and
below it along the whole range. The negative binomial band is wider, widening
faster as the mean grows, and covers 0.953, almost exactly the 0.95 it claims.

## Likelihood Ratios and AIC {#lrt-aic}

Part 1 replaced the $F$ tests of linear regression with deviance differences.
`drop1()` removes one term at a time and compares the fit with and without it,
which makes it the right test for a factor with several levels.


``` r
# drop1() is a handy built-in function in R to see the effect of dropping
# a single term from a model on AIC and in our case the likelihood ratio or 
# LRT
drop1(logitModel, test = "LRT")
```

```
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
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

`race` costs two degrees of freedom and is tested as one term here, at 0.041,
while neither of its two coefficients clears 0.05 on its own in `summary()`.
When a Wald $z$ and a likelihood ratio test disagree, prefer the likelihood
ratio test, for the same reason the profile interval beat the Wald interval.

AIC is the deviance plus a penalty of two per parameter. A test asks whether a
term is distinguishable from zero. AIC asks which of several models should
predict new data better.


``` r
round(c(full = AIC(logitModel),
        withoutAge = AIC(update(logitModel, . ~ . - age)),
        poissonQuakes = AIC(quakePoisson),
        negativeBinomialQuakes = AIC(negativeBinomial)), 2)
```

```
                  full             withoutAge          poissonQuakes negativeBinomialQuakes 
                214.83                 213.85                8052.75                7174.96 
```

Dropping `age` lowers the AIC by about one, which is not worth acting on. The
earthquake comparison is a gap of nearly 900, and that is decisive. Only compare
AIC between models fit to the same rows with the same response, and only by
differences.

## Deviance and Pseudo R-squared {#deviance}

Deviance is twice the gap in log-likelihood between your model and a saturated
model that fits every observation perfectly.

$$D = 2\left(\ell_{\text{saturated}} - \ell_{\text{model}}\right)$$


``` r
nullDeviance <- logitModel$null.deviance
residualDeviance <- deviance(logitModel)
round(c(nullDeviance = nullDeviance,
        residualDeviance = residualDeviance,
        mcFadden = 1 - residualDeviance / nullDeviance,
        pValueIfYouBelievedIt = pchisq(residualDeviance, df.residual(logitModel),
                                       lower.tail = FALSE)), 4)
```

```
         nullDeviance      residualDeviance              mcFadden pValueIfYouBelievedIt 
             234.6720              196.8337                0.1612                0.1852 
```

McFadden's pseudo R-squared is 0.16. It is not an $R^2$, and it does not mean 16
percent of anything was explained. Use it to compare models on the same data.

The last number is a tempting mistake. For grouped data, comparing the residual
deviance with a chi-square on its degrees of freedom is a goodness-of-fit test.
For ungrouped binary data like this it is not, whatever the p-value says,
because most covariate patterns contain one mother. That is the gap the
Hosmer-Lemeshow test in Part 1 was meant to fill.

## Calibration {#calibration}

A model you are about to interpret on the response scale should be right on the
response scale. Sort the observations by prediction, cut them into groups, and
compare the average prediction with the average outcome in each group.


``` r
calibrationTable <- function(predicted, observed, groups = 10) {
  cuts <- cut(predicted, quantile(predicted, probs = seq(0, 1, length.out = groups + 1)),
              include.lowest = TRUE)
  data.frame(predicted = tapply(predicted, cuts, mean),
             observed = tapply(observed, cuts, mean),
             n = tapply(observed, cuts, length))
}
round(calibrationTable(fitted(logitModel), bw$low), 3)
```

```
                predicted observed  n
[0.0233,0.0779]     0.057    0.000 19
(0.0779,0.123]      0.102    0.105 19
(0.123,0.185]       0.154    0.263 19
(0.185,0.225]       0.207    0.158 19
(0.225,0.271]       0.243    0.211 19
(0.271,0.301]       0.283    0.389 18
(0.301,0.384]       0.341    0.316 19
(0.384,0.504]       0.450    0.421 19
(0.504,0.613]       0.551    0.579 19
(0.613,0.88]        0.731    0.684 19
```

``` r
round(calibrationTable(fitted(quakePoisson), quakes$stations), 2)
```

```
            predicted observed   n
[13.1,17.2]     15.50    15.60 101
(17.2,19.4]     18.39    18.08  99
(19.4,22]       20.83    20.35 100
(22,24.6]       23.34    21.87 100
(24.6,27.6]     26.33    24.62 100
(27.6,30.8]     29.42    28.20 100
(30.8,34.9]     32.54    32.62 100
(34.9,43.5]     38.39    38.83 100
(43.5,56.5]     49.41    55.05 100
(56.5,231]      80.07    78.98 100
```

Both tables track well. That is worth saying plainly for the earthquake model,
because it has a dispersion of 2.87 and too-narrow intervals. The mean can be
right while the variance is wrong. Calibration checks the first. The residuals,
the rootogram and the dispersion statistic check the second.

## Three Residuals {#residual-types}

A GLM has more than one definition of a residual.

**Pearson.** The raw residual divided by the standard deviation the model
predicts for it, $(y_i - \hat{\mu}_i)/\sqrt{V(\hat{\mu}_i)}$. Their sum of
squares is the numerator of the dispersion statistic.

**Deviance.** The signed square root of each observation's contribution to the
deviance. What `rstandard()` works with.

**Quantile.** Introduced in Part 1. The only one of the three that is normal
under a correct model when the response is discrete.


``` r
quakeMu <- fitted(quakePoisson)
set.seed(7)
quantileResidual <- qnorm(runif(nrow(quakes),
                                ppois(quakes$stations - 1, quakeMu),
                                ppois(quakes$stations, quakeMu)))

round(c(pearsonWithin2 = mean(abs(residuals(quakePoisson, type = "pearson")) < 2),
        devianceWithin2 = mean(abs(residuals(quakePoisson, type = "deviance")) < 2),
        quantileWithin2 = mean(abs(quantileResidual) < 2)), 3)
```

```
 pearsonWithin2 devianceWithin2 quantileWithin2 
          0.789           0.783           0.786 
```

<img src="glm-gam-part-2_files/figure-html/residual-types-plot-1.png" alt="" style="display: block; margin: auto;" />

Read the panels for shape. A trend in the smoother means the mean is wrong
somewhere. A fan means the variance assumption is not met. Under a correct
model about 95 percent of residuals fall inside the dashed lines, and here
fewer than 80 percent do, which is the overdispersion again.

## Rootograms {#rootogram}

A rootogram, compares how often each count was observed with how
often the model expected it, across the whole range of the response.


``` r
# get range of observed values
countRange <- 0:max(quakes$stations)
# get frequency bins
observedFrequency <- as.numeric(table(factor(quakes$stations, levels = countRange)))
# given the observed countRange at k what does our model tell us we should
# expect sum(dpois(k, fitted(quake))) based on the mean fitted(quakePoisson)
poissonFrequency <- sapply(countRange, function(k) sum(dpois(k, fitted(quakePoisson))))
# repeat for the negbin
negBinFrequency  <- sapply(countRange, function(k)
  sum(dnbinom(k, mu = fitted(negativeBinomial), size = negativeBinomial$theta)))


# the -1 appears to ensure that 0 gets included in the lowest frequency bin
# cut works exclusively on the lower interval so we need (-1, 9] to get 
# [0, 9]
countGroups <- cut(countRange, c(-1, 9, 15, 20, 30, 40, 60, 80, 140),
                   labels = c("0-9", "10-15", "16-20", "21-30", "31-40",
                              "41-60", "61-80", "81-140"))
```

<img src="glm-gam-part-2_files/figure-html/rootogram-plot-1.png" alt="" style="display: block; margin: auto;" />

The Poisson is too narrow. It expects too few small and large counts and too
many in the middle. The negative binomial is much closer in the tails.

Not one event in the data wasVreported by fewer than 10 stations, yet the
Poisson expects about 8 such events and the negative binomial about 27. A floor
like that usually means the data were selected, and neither distribution knows
about it. No dispersion statistic would have shown you this.

## The Assumption That Is Left {#curvature}

A GLM assumes the effect of each predictor is a straight line on the link
scale. The two-scales plot in Part A showed that assumption. Here we check it
against the data, by adding each event's residual back onto the fitted depth
effect and drawing a smoother through the result.

<img src="glm-gam-part-2_files/figure-html/curvature-plot-1.png" alt="" style="display: block; margin: auto;" />

The smoother runs a little above the line at moderate depths and below it for
the deepest events. To ask whether that bend is real, fit a model that allows it
and compare the two with a likelihood ratio test, using the negative binomial
from the overdispersion section.


``` r
nbDepthSquared <- glm.nb(stations ~ mag + depth + I(depth^2), data = quakes)
anova(negativeBinomial, nbDepthSquared)
```

```
Likelihood ratio tests of Negative Binomial Models

Response: stations
                     Model    theta Resid. df    2 x log-lik.   Test    df LR stat.    Pr(Chi)
1              mag + depth 17.67934       997       -7166.958                                 
2 mag + depth + I(depth^2) 17.84859       996       -7160.975 1 vs 2     1 5.982347 0.01444976
```

The departure is mild, but with 1000 events the test can see it, and it matters
for interpretation. The single rate ratio of 1.032 per 100 km in Part B averages
over a range where the effect changes. A bend that is not modelled also gets
paid for in the dispersion statistic, which is how a shape problem gets
misdiagnosed as overdispersion. A squared term is one patch, but you have to
guess the shape in advance. Part 3 replaces the guess.

## A note on deviance

$$D = 2\left(\ell_{\text{saturated}} - \ell_{\text{model}}\right)$$

Deviance measures how far a model sits from a saturated model that reproduces
every observation exactly, $D = 2(\ell_{\text{saturated}} - \ell_{\text{model}})$.
On its own it says how much surprise is left, not why. The difference in deviance
between two nested models is a likelihood ratio test, and that is where deviance
earns its keep. Lastly, a null deviance test subtracts the likelihood of the
saturated model $\ell_{\text{saturated}}$ from the likelihood of a null model
$\ell_{\text{null}}$. Note that deviance is a measure of goodness-of-fit but 
not a statistical test.

# YOU TRY! {#you-try}

Work through these for the next 15 minutes. Both datasets come with R.


``` r
library(MASS)
data(Pima.tr)   # 200 women, type = Yes/No for diabetes
data(quine)     # 146 children, Days = days absent from school
```

**Part 1. Two scales.** Fit `glm(type ~ glu + bmi + age + ped, family = binomial, data = Pima.tr)`. Predict for the first five women with `type = "link"` and `type = "response"`, and confirm that `plogis()` takes one to the other.

**Part 2. A useful ratio.** Report the odds ratio for a 10-unit rise in `glu` with a profile interval. Do the multiplication on the link scale.

**Part 3. Fitted probabilities.** Predict the probability of diabetes at the first and third quartiles of `glu`, with everything else at its median, and again 10 units higher. Report the risk difference and the odds ratio at each. Which one stayed the same?

**Part 4. Two intervals.** Compare Wald and profile intervals for all four coefficients. Where do they disagree most?

**Part 5. A count model.** Fit `glm(Days ~ Eth + Sex + Age + Lrn, family = poisson, data = quine)` and report the rate ratio for `Eth`. Predict expected days absent for two otherwise identical children who differ only in `Eth`, with link-scale intervals.

**Part 6. Fit.** Compute the dispersion, fit the `quasipoisson` and `glm.nb` versions, and compare their standard errors. Draw a rootogram and the binned variance plot. Which model would you report?

**Part 7. The honest summary.** Write three sentences on what predicts absence, for a school administrator. Include an effect in days rather than on the log scale, state the uncertainty, and name the model you chose and why.

# So... what did we learn? {#summary}

1. R reports coefficients on the link scale. Readers think on the response scale. `predict()` gives either, depending on `type`, and `fitted()` gives the response scale.
2. Exponentiated, a logit coefficient is an odds ratio and a log coefficient is a rate ratio. For a step of $k$ units, multiply on the link scale and then exponentiate.
3. Build every interval on the link scale and transform both ends.
4. An odds ratio or rate ratio is constant across profiles. The change in probability or count is not, so report the ratio for the model and a probability or count for the reader, and name the profile.
5. An odds ratio is not a risk ratio. The two separate as the outcome becomes common.
6. Wald and profile intervals disagree when a term rests on few observations, and then the profile interval is the one to trust.
7. A confidence interval for a mean is not a prediction interval for an observation.
8. Likelihood ratio tests ask whether a term matters, and AIC asks which model predicts better. For ungrouped binary data the residual deviance is not a goodness-of-fit test.
9. Calibration checks the mean. Residuals, the rootogram and the dispersion check the variance. A model can pass the first and fail the second.
10. Quasi-Poisson and negative binomial assume different variance functions, and the binned variance plot tells you which the data supports.
11. A GLM still assumes a straight line on the link scale. A bend can show up disguised as overdispersion.

# Next Time {#next-time}

**Part 3: Intro to Generalized Additive Models.** Today ended on a bend in a residual plot and a squared term that was not a real answer. Next session removes the straight-line assumption rather than patching around it. We replace $\beta_j x_j$ with a smooth function $f_j(x_j)$ built from basis functions, and let a penalty decide how much the curve is allowed to wiggle rather than fixing the shape in advance. The model becomes

$$g(\mu_i) = \beta_0 + f_1(x_{i1}) + f_2(x_{i2}) + \cdots$$

We move from `glm()` to `mgcv::gam()`, which takes the same `family` argument you already know, fit the earthquake depth effect as a smooth, and compare it with today's quadratic. Every GLM is a GAM with all its smooths forced to be straight, and everything from today about scales, intervals, and diagnostics carries over.

# References {#references}

**Interpretation and marginal effects.**

- Norton, E. C., Dowd, B. E. and Maciejewski, M. L. (2018). Odds ratios, current best practice and use. *JAMA*, 320(1), 84-85. Short, and worth handing to a coauthor.
- Arel-Bundock, V., Greifer, N. and Heiss, A. (2024). How to interpret statistical models using `marginaleffects` in R and Python. *Journal of Statistical Software*, 111(9). The package that averages fitted probabilities over a sample, with intervals.

**Fit and diagnostics.**

- McCullagh, P. and Nelder, J. A. (1989). *Generalized Linear Models*, 2nd edition. Chapman and Hall. Chapter 2 for deviance and residuals.
- Burnham, K. P. and Anderson, D. R. (2002). *Model Selection and Multimodel Inference*, 2nd edition. Springer. The case for AIC, and its limits.
- Dunn, P. K. and Smyth, G. K. (1996). Randomized quantile residuals. *Journal of Computational and Graphical Statistics*, 5(3), 236-244.
- Kleiber, C. and Zeileis, A. (2016). Visualizing count data regressions using rootograms. *The American Statistician*, 70(3), 296-303.
- Hosmer, D. W., Lemeshow, S. and Sturdivant, R. X. (2013). *Applied Logistic Regression*, 3rd edition. Wiley. Chapter 5 for why the residual deviance is not a fit test here.
- Ver Hoef, J. M. and Boveng, P. L. (2007). Quasi-Poisson vs. negative binomial regression, how should we model overdispersed count data? *Ecology*, 88(11), 2766-2772. The paper behind the variance function plot.

**Data.**

- Venables, W. N. and Ripley, B. D. (2002). *Modern Applied Statistics with S*, 4th edition. Springer.
- Run `?birthwt`, `?quakes`, `?Pima.tr` and `?quine` for the variable definitions and original sources.

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
