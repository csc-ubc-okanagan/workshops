---
title: "Workshops"
pagetitle: "Workshops"
---

# Workshops

<style>
html { scroll-behavior: smooth; }

.footer { display: none; }
  
.ws-layout {
  display: flex;
  gap: 36px;
  align-items: flex-start;
  max-width: 1150px;
  margin: 0 auto;
}

.ws-sidebar {
  position: sticky;
  top: 20px;
  flex: 0 0 240px;
  max-height: calc(100vh - 40px);
  overflow-y: auto;
  font-size: 0.9rem;
}
.ws-sidebar .ws-sidebar-title {
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  font-size: 0.78rem;
  color: #888;
  padding: 0 12px 8px;
}
.ws-sidebar nav ul { list-style: none; margin: 0; padding: 0; }
.ws-sidebar nav a {
  display: block;
  padding: 7px 12px;
  color: #333;
  text-decoration: none;
  border-left: 2px solid transparent;
  line-height: 1.35;
}
.ws-sidebar nav a:hover {
  border-left-color: #666;
  background: rgba(0, 0, 0, 0.04);
  color: #000;
}

.ws-content { flex: 1 1 auto; min-width: 0; }

.ws-series {
  margin-bottom: 46px;
  scroll-margin-top: 80px;
}
.ws-series h2 {
  border-bottom: 2px solid #333;
  padding-bottom: 6px;
  margin-bottom: 12px;
}
.ws-series-desc { margin-bottom: 18px; line-height: 1.6; }
.ws-series-desc.placeholder { color: #999; font-style: italic; }

.ws-list { list-style: none; margin: 0; padding: 0; }
.ws-item {
  padding: 12px 0;
  border-bottom: 1px solid #ececec;
}
.ws-item-title { font-weight: 600; }

.ws-controls {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 8px 18px;
  margin-top: 7px;
}

.ws-desc { font-size: 0.9rem; }
.ws-desc > summary {
  cursor: pointer;
  list-style: none;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  color: #2c2c2c;
  font-weight: 600;
  user-select: none;
}
.ws-desc > summary::-webkit-details-marker { display: none; }
.ws-desc > summary::before {
  content: '';
  display: inline-block;
  width: 0;
  height: 0;
  border-left: 5px solid currentColor;
  border-top: 4px solid transparent;
  border-bottom: 4px solid transparent;
  transition: transform 0.2s ease;
}
.ws-desc[open] > summary::before { transform: rotate(90deg); }
.ws-desc-body {
  margin-top: 8px;
  padding: 12px 14px;
  width: min(100%, 660px);
  min-height: 1.2em;
  background: rgba(0, 0, 0, 0.03);
  border-radius: 6px;
  font-size: 0.93rem;
  line-height: 1.6;
}

.ws-links { font-size: 0.9rem; }
.ws-links a { font-weight: 600; }
.ws-links a + a { margin-left: 4px; }

@media (max-width: 820px) {
  .ws-layout { flex-direction: column; gap: 16px; }
  .ws-sidebar {
    position: static;
    flex-basis: auto;
    width: 100%;
    max-height: none;
    border-bottom: 1px solid #ddd;
    padding-bottom: 12px;
    margin-bottom: 8px;
  }
}
</style>

<div class="ws-layout">

  <aside class="ws-sidebar">
    <div class="ws-sidebar-title">Workshop Series</div>
    <nav>
      <ul>
        <li><a href="#r-fundamentals">R Fundamentals for Data Analysis</a></li>
        <li><a href="#python-basics">Python Basics for Data Analysis</a></li>
        <li><a href="#statistical-fundamentals">Statistical Fundamentals: A Visual Approach</a></li>
        <li><a href="#clustering-classification">Clustering &amp; Classification in R</a></li>
        <li><a href="#dimensionality-reduction">Dimensionality Reduction in R</a></li>
        <li><a href="#linear-regression">Linear Regression in R</a></li>
        <li><a href="#glms-gams">GLMs and GAMs in R</a></li>
        <li><a href="#survival-analysis">Survival Analysis in R</a></li>
        <li><a href="#rdm">Research Data Management (RDM)</a></li>
        <li><a href="#bash-shell">Introduction to the Bash shell</a></li>
        <li><a href="#git-github">Git and GitHub</a></li>
      </ul>
    </nav>
  </aside>

  <div class="ws-content">

    <section id="r-fundamentals" class="ws-series">
      <h2>R Fundamentals for Data Analysis</h2>
      <p class="ws-series-desc">This series of introductory workshops are intended for individuals with little to no familiarity with R or similar tools that rely on a scripted environment. They are intended as a low barrier entry into the world of using your computer to engage with data outside of graphical tools like Excel or SPSS.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">R: Fundamental Concepts with RStudio</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="R_fundamental-concepts-with-RStudio.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">R: Importing Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="R_importing-data.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">R: Exploring Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="R_exploring-data.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">R: Subsetting &amp; Filtering Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="R_subsetting-and-filtering-data.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">R: Iterating Over Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="R_iterating-over-data.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">R: Conditions</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="R_conditions.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">R: Visualizations</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="R_visualization.html">workshop page</a></span>
          </div>
        </li>
      </ul>
    </section>

    <section id="python-basics" class="ws-series">
      <h2>Python Basics for Data Analysis</h2>
      <p class="ws-series-desc">This series of introductory workshops are intended for individuals with little to no familiarity with Python or similar tools that rely on a scripted environment. They are intended as a low barrier entry into the world of using your computer to engage with data outside of graphical tools like Excel or SPSS.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Python: Fundamental Concepts with Jupyter Notebook</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Python_fundamental-concepts-with-Jupyter-Notebook.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Importing and Exporting Data with Python</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Python_importing-data.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Exploratory Data Analysis</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Exploratory_Data_Analysis_Workshop3.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Subsetting and Filtering Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Subsetting_and_Filtering_Data_Workshop4.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Iterating Over Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Iterating_Over_Data_Workshop5.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Conditions</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Python_conditions.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Visualizations</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Python_Visualization.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Data Analysis and Visualization</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Workshop8_Visualization_continued.html">workshop page</a></span>
          </div>
        </li>
      </ul>
    </section>

    <section id="statistical-fundamentals" class="ws-series">
      <h2>Statistical Fundamentals: A Visual Approach</h2>
      <p class="ws-series-desc">This series will use R and Python to help develop an intuition for fundamental statistical concepts using data visualization. These workshops are equally suitable to those hoping to enhance their ability to interpret common statistical tests and concepts as it is for those applying statistical modelling to their work. No background in statistics is required, but some familiarity with R or Python will be advantageous. You may wish to review the asynchronous content of either <a href="https://csc-ubc-okanagan.github.io/workshops/#r-fundamentals-for-data-analysis">R Fundamentals for Data Analysis</a> or <a href="https://csc-ubc-okanagan.github.io/workshops/#python-basics-for-data-analysis">Python Basics for Data Analysis</a>, or keep an eye out for the next time these workshops are offered.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Population, Sampling, Sampling Distribution, and Central Limit Theorem</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="statistical-distribution-and-central-limit-theorem.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Visualizing Errors and Common Pitfalls</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="error-bars-and-misconceptions.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">P value, Significance, and T-test</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="P_values.md">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Bar, Box, and Violin: Navigating Data Visualization for Insightful Analysis</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Bar_Box_and_Violin_Navigating_Data_Visualization_for_Insightful_Analysis.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">All about t-tests and visualizations</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="T_tests.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Non-parametric tests and visualizations</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Non_parametric_tests.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">ANOVA and Blocking</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Anova_blocks.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Correlation, causation, and association</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Correlation_Causation.html">workshop page</a></span>
          </div>
        </li>
      </ul>
    </section>

    <section id="clustering-classification" class="ws-series">
      <h2>Clustering &amp; Classification in R</h2>
      <p class="ws-series-desc">Data rarely comes neatly labelled or structured, yet patterns can still exist even when they are not immediately obvious. Clustering methods help researchers uncover that structure by grouping similar observations, while classification provides a framework for understanding and predicting known groups.</p><p class="ws-series-desc">This six-part series introduces several of the main ways that similarity and group structure can be defined. Participants will work with hierarchical, centroid-based, fuzzy, distribution-based, graph-based, and density-based models. Emphasis is placed on understanding how each method forms groups, recognizing the assumptions behind the method, evaluating the resulting clusters, and choosing an approach that makes sense for the data rather than simply using the most familiar algorithm.</p><p class="ws-series-desc">All workshops will use R and RStudio, so some experience with R or another programming language is encouraged but not required. See <a href="#r-fundamentals">R Fundamentals for Data Analysis</a> for an introduction to R and RStudio. Attendees without prior experience are encouraged to review this content. No prior knowledge of clustering or classification is required, and each workshop will introduce the background needed for that session.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Hierarchical Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Centroid-Based Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Fuzzy Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Distribution-Based Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Graph-Based Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: Density-Based Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
      </ul>
    </section>

    <section id="dimensionality-reduction" class="ws-series">
      <h2>Dimensionality Reduction in R</h2>
      <p class="ws-series-desc placeholder">[Series description &mdash; add here]</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Linear Methods I &ndash; PCA and ICA</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Linear Methods II &ndash; Factor Analyzers</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Nonlinear Methods I &ndash; T-SNE and UMAP</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Nonlinear Methods II &ndash; MDS and Kernel PCA</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Supervised Methods &ndash; LDA and PLS</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: FAMD for Mixed-type Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
      </ul>
    </section>

    <section id="linear-regression" class="ws-series">
      <h2>Linear Regression in R</h2>
      <p class="ws-series-desc placeholder">[Series description &mdash; add here]</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Intro to Linear Regression</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Multiple Linear Regression</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Interpreting Results</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Fitting vs. Predicting</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Interaction Terms and Hierarchical Linear Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: Penalized Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
      </ul>
    </section>

    <section id="glms-gams" class="ws-series">
      <h2>GLMs and GAMs in R</h2>
      <p class="ws-series-desc placeholder">[Series description &mdash; add here]</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Intro to Generalized Linear Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Interpreting Generalized Linear Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Intro to Generalized Additive Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Interpreting Generalized Additive Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Predicting from GLMs and GAMs</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: Generalized Linear Mixed Effects Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
      </ul>
    </section>

    <section id="survival-analysis" class="ws-series">
      <h2>Survival Analysis in R</h2>
      <p class="ws-series-desc placeholder">[Series description &mdash; add here]</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Survival Data, Censoring, and Truncation</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Kaplan-Meier Estimation</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Cox Proportional Hazards Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Model Diagnostics and Interpretation</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Parametric and Accelerated Failure Time Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: Prediction</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
          </div>
        </li>
      </ul>
    </section>

    <section id="rdm" class="ws-series">
      <h2>Research Data Management (RDM)</h2>
      <p class="ws-series-desc">These sessions address fundamental concepts in research data management (RDM), including its relevance in the context of research, approaches to implementing effective management through documentation and file system organization, and how to use the Data Management Plan (DMP) Assistant, an online tool, to help researchers adhere to funder requirements to submit a DMP.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">RDM Part 1: The Basics</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="RDM_pt1-the-basics.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">RDM Part 2: Documentation</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="RDM_pt2-documentation.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">RDM Part 3: Data Management Plans</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="https://ubc-library-rc.github.io/rdm/content/06_Data_Management_Plan.html">workshop page</a></span>
          </div>
        </li>
      </ul>
    </section>

    <section id="bash-shell" class="ws-series">
      <h2>Introduction to the Bash shell</h2>
      <p class="ws-series-desc">The command line interface can seem daunting to new users, but it is a very powerful tool that, with some foundational understanding, can be used for a number of different computational and data management tasks, for example routinizing repetetive file management activities or working with UBC's high performance computing (HPC) infrastructure. These sessions are aimed at those who have little to no experience with the command line; it introduces the Bash shell, its core functions, and the basics of navigating files and directories.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Introduction to the Bash shell Part 1: Navigating Files and Directories</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="UNIX_pt1.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Introduction to the Bash shell Part 2: Working with Files and Directories</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="UNIX_pt2.html">workshop page</a></span>
          </div>
        </li>
      </ul>
    </section>

    <section id="git-github" class="ws-series">
      <h2>Git and GitHub</h2>
      <p class="ws-series-desc">These sessions provide an introduction to Git and GitHub, respectively a version control application and a remote Git server to facilitate file sharing and back-ups. Topics covered include automated version control and basic Git functions including initiating a Git repository, pushing to and pulling from a remote repository, managing workflows with branching, etc.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Introduction to GitHub Part 1</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Intro-GitHub-Part-1.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Introduction to GitHub Part 2</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body"></div></details>
            <span class="ws-links"><a href="Intro-GitHub-Part-2.html">workshop page</a></span>
          </div>
        </li>
      </ul>
    </section>

  </div>
</div>
