## Fitting Models to Data Not Data to Models

You might have heard someone say that "all models are wrong, but some are useful". The best way to ensure models are useful is to choose a model that is appropriate to your data and research questions, rather than forcing your data to fit your model's assumptions (e.g., normality, independence, constant variance).

This series introduces early-career researchers to statistical models that extend beyond linear models (i.e., ANOVAs) so that they may learn how to *fit models to their data rather than fitting their data to models*. All workshops will use `R` and RStudio, so some experience with `R` or other programming languages is encouraged but not required. See the [R Fundamentals for Data Anlysis](https://csc-ubc-okanagan.github.io/workshops/#r-fundamentals-for-data-analysis) for an introduction to `R` and RStudio. Attendees who do not have experience with `R` are encouraged to review this content or take the introductory workshop concurrently if it's being offered.

**Simple Linear Regression**

This workshop will introduce linear models (i.e., one-way ANOVAs), their assumptions, and limitations, in a format tailored towards visual and spatial learners.

By the end of the session, participants should be able to visualize and explain simple linear regression models, their assumptions, and their limitations.

**Fitting linear models in `R`**

This workshop will illustrate how to fit linear models in `R`, diagnose any issues with model assumption violations, and interpret linear model summaries, including model coefficients, degrees of freedom, standard error estimates, $t$ statistics, $F$ statistics, p-values, $R^2$, statistical significance, adjusted $R^2$.

By the end of this session, participants will be able to fit linear models in `R` and interpret model outputs, including the output of the `summary()` function in `R`.

**Multiple linear regression in `R`**

This workshop will demystify ANOVAs by framing them in the context of linear models with multiple predictors (i.e. multiple linear regression). The session will also introduce attendees to Directed Acyclical Graphs (DAGs) and demonstrate how to use them to infer causality in one's model.

By the end of this session participants should be able to fit linear models with more than one predictor, check for collinearity between predictors, and interpret linear models using DAGs.

**Interaction terms and Hierarchical Linear Models/Linear Mixed Models**

This workshop will introduce interaction terms in linear models along with random and fixed effects, including random and fixed intercepts and slopes, in the context of Hierarchical Linear Models (also known as Linear Mixed Models).

By the end of this session, participants should be able to fit (Hierarchical) Linear Models (HLMs) with interaction terms and interpret the output of the `summary()` function for Hierarchical Linear Models. Additionally, participants will be able to identify the limitations of (H)LMs.

**(Hierarchical) Generalized Linear Models**

This workshop will introduce Generalized Linear Models (GLMs), which allow one to model non-Gaussian (i.e., non-normal) data.

By the end of this session, participants will be familiar with the three parts of GLMs (family of distribution, linear predictor, and link function) and will be able to decide what family of distributions and link function to choose for their data. They will also be able to interpret the output of the `summary()` function and diagnostic plots for (H)GLMs and recognize the limitations of (H)GLMs. 

**Generalized Additive Models**

This workshop will introduce Generalized Additive Models (GAMs), which allow one to fit models that are complex and nonlinear but easily interpretable, unlike many "black-box" machine learning models.

By the end of this session, participants will be able to fit GAMs in `R` using the `mgcv` package and understand the advantages of GAMs over GLMs and LMs.

**Interpreting and predicting from Generalized Additive Models**

This workshop will show how to interpret GAMs and how to use GAMs to make publication-level figures.

By the end of this session, participants should be able to interpret GAMs and the output of the `summary()` function, predict from GAMs, and make figures using GAMs.

**Hierarchical GAMs**

This workshop will re-visit random and fixed effects with Hierachical GAMs (HGAMs) and expand the concepts of random slopes by introducing random smooths. The workshop will also cover smooth, nonlinear interaction terms via the `ti()` and `te()` functions.

By the end of this session, participants should be able to fit HGAMs with smooth interaction terms, plot and interpret the models.
