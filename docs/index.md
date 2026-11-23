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

      <!-- Overall description -->
      <p class="ws-series-desc">{% include_relative r-fundamentals/ws-descriptions/series.txt %}</p>

      <!-- Workshop list -->
      <ul class="ws-list">

        <!-- Workshop 1: Fundamental Concepts -->
        <li class="ws-item">
          <span class="ws-item-title">R: Fundamental Concepts with RStudio</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">{% include_relative r-fundamentals/ws-descriptions/ws1-fundamental-concepts-with-rstudio.txt %}</div></details>
            <span class="ws-links"><a href="r-fundamentals/output/ws1-fundamental-concepts-with-rstudio-flat.html">workshop page</a></span>
            <span class="ws-links"><a href="r-fundamentals/output/ws1-fundamental-concepts-with-rstudio-js.html">slides page</a></span>
          </div>
        </li>

        <!-- Workshop 2: Importing Data -->
        <li class="ws-item">
          <span class="ws-item-title">R: Importing Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">{% include_relative r-fundamentals/ws-descriptions/ws2-importing-data.txt %}</div></details>
            <span class="ws-links"><a href="r-fundamentals/output/ws2-importing-data-flat.html">workshop page</a></span>
            <span class="ws-links"><a href="r-fundamentals/output/ws2-importing-data-js.html">slides page</a></span>
          </div>
        </li>

        <!-- Workshop 3: Exploring Data -->
        <li class="ws-item">
          <span class="ws-item-title">R: Exploring Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">{% include_relative r-fundamentals/ws-descriptions/ws3-exploring-data.txt %}</div></details>
             <span class="ws-links"><a href="r-fundamentals/output/ws3-exploring-data-flat.html">workshop page</a></span>
             <span class="ws-links"><a href="r-fundamentals/output/ws3-exploring-data-js.html">slides page</a></span>
          </div>
        </li>

        <!-- Workshop 4: Subsetting & Filtering Data -->
        <li class="ws-item">
          <span class="ws-item-title">R: Subsetting &amp; Filtering Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">{% include_relative r-fundamentals/ws-descriptions/ws4-subsetting-and-filtering-data.txt %}</div></details>
             <span class="ws-links"><a href="r-fundamentals/output/ws4-subsetting-and-filtering-data-flat.html">workshop page</a></span>
             <span class="ws-links"><a href="r-fundamentals/output/ws4-subsetting-and-filtering-data-js.html">slides page</a></span>
          </div>
        </li>

        <!-- Workshop 5: Iterating Over Data -->
        <li class="ws-item">
          <span class="ws-item-title">R: Iterating Over Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">{% include_relative r-fundamentals/ws-descriptions/ws5-iterating-over-data.txt %}</div></details>
             <span class="ws-links"><a href="r-fundamentals/output/ws5-iterating-over-data-flat.html">workshop page</a></span>
             <span class="ws-links"><a href="r-fundamentals/output/ws5-iterating-over-data-js.html">slides page</a></span>
          </div>
        </li>

        <!-- Workshop 6: Conditional Statements  -->
        <li class="ws-item">
          <span class="ws-item-title">R: Conditions</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">{% include_relative r-fundamentals/ws-descriptions/ws6-conditions.txt %}</div></details>
            <span class="ws-links"><a href="r-fundamentals/output/ws6-conditions-flat.html">workshop page</a></span>
            <span class="ws-links"><a href="r-fundamentals/output/ws6-conditions-js.html">slides page</a></span>
            </div>
        </li>

        <!-- Workshop 7: Visualizing Data -->
        <li class="ws-item">
          <span class="ws-item-title">R: Visualizations</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">{% include_relative r-fundamentals/ws-descriptions/ws7-visualization.txt %}</div></details>
            <span class="ws-links"><a href="r-fundamentals/output/ws7-visualization-flat.html">workshop page</a></span>
            <span class="ws-links"><a href="r-fundamentals/output/ws7-visualization-js.html">slides page</a></span>
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
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will introduce participants to fundamental concepts in Python that will help them excel at more advanced applications. Topics covered include the application of simple math, core data types and structures, an overview of vector operations, and how to navigate getting help. This will include data structures used in the pandas library. The workshop will be run using Jupyter Notebook. By the end of the session, participants should feel familar with Jupyter Notebook as an environemnt for interactive analsysis in Python, be able to identify and articulate use cases for common data structures, and know a few key ways to get additional help when they run into trouble.</div></details>
            <span class="ws-links"><a href="Python_fundamental-concepts-with-Jupyter-Notebook.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Importing and Exporting Data with Python</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">In this session, we’ll learn how to import data from Excel and CSV files into Python for analysis using the pandas and numpy libraries. By the end of this workshop, participants will be able to import data, handle missing values, assign appropriate data types to variables, and save the data for subsequent analyses.</div></details>
            <span class="ws-links"><a href="Python_importing-data.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Exploratory Data Analysis</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will introduce participants to common tasks of initial data exploration. Topics covered include calculating missing values, basic summaries (quartiles, categories, counts, etc), single variable descriptive stats (range, length, variance, etc), and plotting distributions. By the end of the session, participants should be able to use a suite of tools to comprehensivley describe their data and establish if it meets underlying criteria for subsequent analysis.</div></details>
            <span class="ws-links"><a href="Exploratory_Data_Analysis_Workshop3.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Subsetting and Filtering Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will explore the variety of ways that data can be filtered and subset in Python. Working with data frames and vectors, data frames, and lists, participants will learn the nuances of extracting portions of a larger data set for analysis. By the end of this session, participants will be proficient in extracting observartions, variables, and values from their data and be aware of when attributes of the extracted data will be lost or maintained for further analysis.</div></details>
            <span class="ws-links"><a href="Subsetting_and_Filtering_Data_Workshop4.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Iterating Over Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will revisit the vector underpinnings of pandas, functions for iterating, or looping, over objects, and introduce for loops for those instances when no pre-existing solutiong exists. By the end of this session, participants will be able to efficiently apply looped constructs to their data, using pre-existing tools in pandas, and be familiar with the basics of constructing for loops to handle repeated tasks.</div></details>
            <span class="ws-links"><a href="Iterating_Over_Data_Workshop5.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Conditions</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will introduce conditionals in Python, addressing those times when, for example, if something is true x needs to happen, otherwise y needs to happen. Participants will be introduced to pre-exising if / else constructs, as well as how to construct conditional statments from scratch. By the end of this session, participants will be able effectively implement simple if else constructs into their data analysis pipelines.</div></details>
            <span class="ws-links"><a href="Python_conditions.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Visualizations</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will introduce data visualization in Python. Common visualizations, including bar charts, histograms, scatterplots, etc will be covered.By the end of this session participants will be able to build, annotate, and customize common data visualizations.</div></details>
            <span class="ws-links"><a href="Python_Visualization.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Python: Data Analysis and Visualization</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will continue the Python: Vizualizations workshop from the last session, where more advance visualization techniques will be introduced.</div></details>
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
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will introduce participants to the foundational concepts of statistical inference, including population distributions and the process of random sampling. Attendees will learn how sampling distributions evolve towards normality as sample sizes increase and will visually explore the Central Limit Theorem. By the end of the session, participants should be able to visualize and understand population distributions, illustrate random sampling processes, recognize the normalizing effect of larger samples on sampling distributions, and demonstrate the Central Limit Theorem visually.</div></details>
            <span class="ws-links"><a href="statistical-distribution-and-central-limit-theorem.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Visualizing Errors and Common Pitfalls</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will address the visualization of standard deviation (s.d.), standard error of the mean (s.e.m.), and confidence interval (CI) error bars to enhance the understanding of uncertainty in data analysis. The interpretation of error bars for statistical significance will be discussed, along with common misinterpretations to avoid. By the end of the session, participants should be able to visualize and interpret error bars, understand the implications of their spacing and width, and be cautious of common pitfalls such as misinterpreting non-overlapping error bars as evidence of significance.</div></details>
            <span class="ws-links"><a href="error-bars-and-misconceptions.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">P value, Significance, and T-test</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will introduce participants to the concept of P values and their role in hypothesis testing, highlighting that P values reflect the probability of observing the data under the null hypothesis, not the biological significance of the findings. The session will cover the computation of P values and delve into the nuances of one-sample t-tests. By the end of the session, participants should be able to comprehend the meaning of P values, understand how hypothesis tests calculate P values, recognize when small P values indicate unlikely events under the null hypothesis, and explore the assumptions behind one-sample t-tests.</div></details>
            <span class="ws-links"><a href="P_values.md">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Bar, Box, and Violin: Navigating Data Visualization for Insightful Analysis</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will address the advantages of box plots over bar charts for displaying the spread and variability in data. Participants will learn how box plots can be used to compare multiple samples, the impact of sample size on data representation, and the efficient identification of outliers. By the end of the session, participants should be able to create and interpret box plots, appreciate their usefulness in comparing multiple samples, understand the implications of sample size, and identify outliers and median confidence intervals through notches in box plots.</div></details>
            <span class="ws-links"><a href="Bar_Box_and_Violin_Navigating_Data_Visualization_for_Insightful_Analysis.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">All about t-tests and visualizations</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">
            This session will introduce participants to the various types of t-tests, including one-sample, two-sample, paired, and one-sided tests. Attendees will learn about the appropriate applications for each type and the visualization techniques that can enhance the interpretation of t-test results. By the end of the session, participants should be able to apply and visually represent different t-tests, interpret their results, understand the implications of multiple testing corrections, and select the appropriate test for their data.</div></details>
            <span class="ws-links"><a href="T_tests.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Non-parametric tests and visualizations</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will introduce participants to non-parametric tests, which are useful when data distributions do not meet the assumptions of parametric tests. Attendees will learn to compare the adaptability of these tests with different data distributions and to visualize their operation. By the end of the session, participants should be able to choose and apply the appropriate non-parametric tests for their data, visualize the operation of these tests, and understand the challenges of multiple testing with non-parametric methods.</div></details>
            <span class="ws-links"><a href="Non_parametric_tests.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">ANOVA and Blocking</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will introduce participants to the Analysis of Variance (ANOVA), a statistical method used for comparing the means of three or more groups. The concept of blocking will also be introduced to reduce noise and isolate sources of variation. By the end of the session, participants should be able to use ANOVA for multi-treatment analysis, implement blocking in experimental design, calculate the F statistic for assessing significance, and appreciate how blocking can improve the efficiency of a study.</div></details>
            <span class="ws-links"><a href="Anova_blocks.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Correlation, causation, and association</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will address the concepts of correlation, causation, and association in data. Participants will learn to differentiate between these concepts and to recognize and interpret various types of correlations. By the end of the session, participants should be able to distinguish between correlation and causation, recognize the impact of confounding variables on associations, evaluate correlation reliability, and understand the significance of correlation results.</div></details>
            <span class="ws-links"><a href="Correlation_Causation.html">workshop page</a></span>
          </div>
        </li>
      </ul>
    </section>

    <section id="clustering-classification" class="ws-series">
      <h2>Clustering &amp; Classification in R</h2>
      <p class="ws-series-desc">Data rarely comes neatly labelled or structured, yet patterns can still exist even when they are not immediately obvious. Clustering methods help researchers uncover that structure by grouping similar observations, while classification provides a framework for understanding and predicting known groups.</p>
      <p class="ws-series-desc">This six-part series introduces several of the main ways that similarity and group structure can be defined. Participants will work with hierarchical, centroid-based, fuzzy, distribution-based, graph-based, and density-based models. Emphasis is placed on understanding how each method forms groups, recognizing the assumptions behind the method, evaluating the resulting clusters, and choosing an approach that makes sense for the data rather than simply using the most familiar algorithm.</p>
      <p class="ws-series-desc">All workshops will use R and RStudio, so some experience with R or another programming language is encouraged but not required. See <a href="#r-fundamentals">R Fundamentals for Data Analysis</a> for an introduction to R and RStudio. Attendees without prior experience are encouraged to review this content. No prior knowledge of clustering or classification is required, and each workshop will introduce the background needed for that session.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Hierarchical Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Hierarchical clustering builds groups step by step, making it possible to explore structure without selecting the number of clusters in advance. Participants will learn how distance measures and linkage methods affect the resulting hierarchy, create and interpret dendrograms, and use common diagnostics to decide where the hierarchy should be divided.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Centroid-Based Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Centroid-based methods assign observations to groups represented by a central point. This session introduces methods such as k-means and k-medoids, including how to select the number of clusters, assess the stability and quality of a solution, and recognize when a centroid-based model may not suit the shape or structure of the data.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Fuzzy Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Not every observation belongs cleanly to a single group. Fuzzy clustering replaces hard assignments with degrees of membership, allowing uncertainty and overlap between clusters to be represented directly. Participants will fit fuzzy clustering models in R, interpret membership values, and compare fuzzy and hard cluster solutions.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Distribution-Based Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Distribution-based clustering treats the data as arising from a mixture of underlying probability distributions. Participants will be introduced to finite mixture models and model-based clustering, learn how these models describe clusters with different shapes and variability, and use statistical criteria and uncertainty estimates to evaluate a fitted solution.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Graph-Based Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Graph-based methods represent observations as a network of connections, allowing clusters to emerge from patterns of local similarity. This session introduces graph construction and spectral clustering, with attention to how the similarity measure and graph structure influence the final groups. Participants will apply these methods and interpret the resulting cluster structure in R.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: Density-Based Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Density-based clustering finds groups as regions where observations are concentrated and treats isolated observations as potential noise. Participants will use methods such as DBSCAN to identify clusters with irregular shapes, examine the effect of tuning parameters, and determine when a density-based approach is more appropriate than methods built around cluster centres.</div></details>
          </div>
        </li>
      </ul>
    </section>

    <section id="dimensionality-reduction" class="ws-series">
      <h2>Dimensionality Reduction in R</h2>
      <p class="ws-series-desc">Large datasets often contain many variables, but more variables do not always mean more information. Strong relationships, redundant measurements, and noise can make patterns harder to see and models harder to interpret. Dimensionality reduction provides a collection of tools for representing complex data with fewer dimensions while retaining the information that matters most.</p>
      <p class="ws-series-desc">This six-part series introduces both linear and nonlinear approaches to dimensionality reduction. Participants will work with methods designed for visualization, feature extraction, latent structure, supervised outcomes, and mixed-type data. Emphasis is placed on understanding what each reduced dimension represents, what information may be lost, and how the purpose and structure of the analysis should guide the choice of method.</p>
      <p class="ws-series-desc">All workshops will use R and RStudio, so some experience with R or another programming language is encouraged but not required. See <a href="#r-fundamentals">R Fundamentals for Data Analysis</a> for an introduction to R and RStudio. Attendees without prior experience are encouraged to review this content. No prior knowledge of dimensionality reduction is required, and each workshop will introduce the background needed for that session.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Linear Methods I &ndash; PCA and ICA</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Principal component analysis and independent component analysis both create new variables from existing ones, but they look for different kinds of structure. Participants will learn how the methods differ, fit both in R, determine how many components to retain, and interpret the resulting components, loadings, and visualizations.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Linear Methods II &ndash; Factor Analyzers</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Factor analysis explains relationships among observed variables through a smaller number of unobserved factors. This session introduces the underlying model, its distinction from principal component analysis, and practical decisions such as selecting the number of factors and choosing a rotation. Participants will interpret factor loadings, communalities, and factor scores in R.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Nonlinear Methods I &ndash; T-SNE and UMAP</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Some patterns cannot be represented well by a straight line or a linear combination of variables. This session introduces t-SNE and UMAP for constructing low-dimensional representations of nonlinear data. Participants will create and compare embeddings, explore the effect of tuning parameters, and learn what conclusions these popular visualizations can and cannot support.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Nonlinear Methods II &ndash; MDS and Kernel PCA</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Multidimensional scaling and kernel principal component analysis provide two different ways to uncover structure beyond ordinary linear projections. Participants will learn how distances and kernels define the resulting representation, implement both approaches in R, and evaluate how well the lower-dimensional space preserves meaningful relationships in the original data.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Supervised Methods &ndash; LDA and PLS</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Unlike unsupervised methods, supervised dimensionality reduction uses information about an outcome when constructing a smaller set of features. This session introduces linear discriminant analysis and partial least squares, with attention to how the two methods use outcome information differently. Participants will fit, visualize, and evaluate these models in R for classification or prediction.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: FAMD for Mixed-type Data</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Many real datasets contain both numeric and categorical variables, making standard principal component analysis an incomplete solution. Factor analysis of mixed data provides a joint representation that balances information across variable types. Participants will apply FAMD in R, interpret the reduced dimensions and variable contributions, and use the resulting representation to explore heterogeneous data.</div></details>
          </div>
        </li>
      </ul>
    </section>

    <section id="linear-regression" class="ws-series">
      <h2>Linear Regression in R</h2>
      <p class="ws-series-desc">Linear regression is often one of the first statistical models researchers encounter, but using it well involves much more than drawing a straight line. Researchers must understand what the model is estimating, whether its assumptions are reasonable, and how the results relate to the original research question.</p>
      <p class="ws-series-desc">This series introduces linear regression as a framework for studying relationships, testing hypotheses, and making predictions. Participants will progress from simple and multiple linear regression to model interpretation, prediction, interaction effects, hierarchical models, and penalized regression. Emphasis is placed on understanding model assumptions, evaluating model fit and predictive performance, and communicating results without overstating what the model can establish.</p>
      <p class="ws-series-desc">All workshops will use R and RStudio, so some experience with R or another programming language is encouraged but not required. See the <a href="#r-fundamentals">R Fundamentals for Data Analysis</a> for an introduction to R and RStudio. Attendees without prior experience are encouraged to review this content. No prior knowledge of linear regression is required, and each workshop will introduce the background needed for that session.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Intro to Linear Regression</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Linear regression provides a direct way to describe how a continuous outcome changes with an explanatory variable. Participants will fit simple linear regression models in R, interpret the slope and intercept, visualize fitted relationships, and examine the main assumptions that determine whether the model can be trusted.</div></details>
            <span class="ws-links"><a href="Linear-Regression-Series/linear-regression-part-1.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Multiple Linear Regression</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Research questions rarely involve only one explanatory variable. This session extends the linear model to include several predictors and explores how the interpretation of a coefficient changes once other variables are included. Participants will fit and compare multiple regression models, work with numeric and categorical predictors, and examine collinearity and confounding.</div></details>
             <span class="ws-links"><a href="Linear-Regression-Series/linear-regression-part-2.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Interpreting Results</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Regression output contains a great deal of information, but statistical significance alone does not tell the whole story. Participants will learn to interpret coefficients, confidence intervals, hypothesis tests, and measures of model fit in the context of a research question. The session will also discuss practical significance and how to communicate results without overstating what the model establishes.</div></details>
            <span class="ws-links"><a href="Linear-Regression-Series/linear-regression-part-3.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Fitting vs. Predicting</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">A model that describes the observed data well does not necessarily predict new observations well. This session separates explanatory modelling from prediction and introduces training and test data, out-of-sample evaluation, and common prediction metrics. Participants will also distinguish confidence intervals from prediction intervals and examine how overfitting can give a misleading impression of performance.</div></details>
            <span class="ws-links"><a href="Linear-Regression-Series/linear-regression-part-4.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Interaction Terms and Hierarchical Linear Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Relationships can change across groups, settings, or levels of another variable, and observations collected within the same group may not be independent. Participants will use interaction terms to model changing effects and hierarchical linear models to account for grouped or repeated observations. Emphasis is placed on interpreting conditional effects and understanding the roles of fixed and random effects.</div></details>
            <span class="ws-links"><a href="Linear-Regression-Series/linear-regression-part-5.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: Penalized Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Models with many or strongly related predictors can become unstable and difficult to interpret. Penalized regression controls model complexity by shrinking coefficient estimates and, in some cases, selecting variables. Participants will fit ridge, lasso, and elastic-net models in R, use cross-validation to choose the amount of penalization, and compare their predictive performance.</div></details>
            <span class="ws-links"><a href="Linear-Regression-Series/linear-regression-part-6.html">workshop page</a></span>
          </div>
        </li>
      </ul>
    </section>

    <section id="glms-gams" class="ws-series">
      <h2>GLMs and GAMs in R</h2>
      <p class="ws-series-desc">Linear regression is a powerful starting point, but many outcomes are not continuous and many relationships are not straight lines. Binary responses, counts, proportions, and nonlinear trends require models that can adapt to the structure of the data while remaining interpretable.</p>
      <p class="ws-series-desc">This six-part series introduces generalized linear models and generalized additive models as flexible extensions of ordinary linear regression. Participants will learn how response distributions, link functions, smooth effects, prediction, and grouped data can be incorporated into a statistical model. Emphasis is placed on selecting a model that matches the outcome, interpreting results on the correct scale, checking model adequacy, and communicating what the fitted model can support.</p>
      <p class="ws-series-desc">All workshops will use R and RStudio, so some experience with R or another programming language is encouraged but not required. See <a href="#r-fundamentals">R Fundamentals for Data Analysis</a> for an introduction to R and RStudio. Attendees without prior experience are encouraged to review this content. No prior knowledge of generalized linear or additive models is required, and each workshop will introduce the background needed for that session.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Intro to Generalized Linear Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Generalized linear models extend linear regression to outcomes such as binary responses and counts. Participants will learn how the response distribution and link function define a model, fit introductory logistic and Poisson regression models in R, and recognize when an ordinary linear model is not appropriate.</div></details>
            <span class="ws-links"><a href="GAM-GLM-Series/glm-gam-part-1.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Interpreting Generalized Linear Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Coefficients from a generalized linear model are not always expressed on the scale researchers care about most. This session shows how to move between the link and response scales and interpret quantities such as odds ratios, rate ratios, fitted probabilities, and expected counts. Participants will also examine uncertainty, model fit, and common diagnostics.</div></details>
            <span class="ws-links"><a href="GAM-GLM-Series/glm-gam-part-2.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Intro to Generalized Additive Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Generalized additive models allow relationships to bend when a straight line is too restrictive. Participants will learn how smooth terms are constructed and controlled, fit additive models in R, and compare linear and nonlinear representations of the same relationship without having to specify its shape in advance.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Interpreting Generalized Additive Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">The flexibility of an additive model is useful only if its fitted effects are interpreted carefully. This session focuses on visualizing smooth terms, understanding their uncertainty and effective degrees of freedom, and describing nonlinear relationships in clear language. Participants will also use diagnostics to identify models that are too simple, unnecessarily complex, or poorly supported by the data.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Predicting from GLMs and GAMs</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Predictions from generalized models depend on the outcome distribution, the link function, and the scale on which results are reported. Participants will generate predictions and uncertainty intervals from GLMs and GAMs, evaluate performance on new data, and choose measures suited to continuous, binary, or count outcomes.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: Generalized Linear Mixed Effects Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Binary, count, and other non-normal outcomes often arise from grouped, repeated, or multilevel data. Generalized linear mixed-effects models combine the flexibility of a generalized linear model with random effects that account for this dependence. Participants will fit these models in R, interpret fixed and random effects, and examine how the data structure influences model specification.</div></details>
          </div>
        </li>
      </ul>
    </section>

    <section id="survival-analysis" class="ws-series">
      <h2>Survival Analysis in R</h2>
      <p class="ws-series-desc">Time-to-event data (sometimes referred to as 'survival' data) are commonplace across a diverse set of disciplines including biology, engineering, medicine, economics, and the social sciences and occur whenever researchers are interested in modeling how long it takes for an event of interest (e.g., disease remission, death, or component failure) to occur. However, working with time-to-event data can be difficult for a variety of reasons including incomplete observation times prior to or after an event (often referred to as 'censored' data); skewed distributions (waiting times between events can have highly 'skewed' or uneven distributions — often 'piling' up very quickly or having long-tailed distributions); and nonconstancy of 'risk' or the likelihood of an event occurring over time.</p>
      <p class="ws-series-desc">This series introduces researchers to the approaches and programming tools needed to tackle challenges associated with time-to-event data. Participants will learn progressively more advanced frameworks—from the basics of understanding incomplete observation periods using censoring data formats and Kaplan-Meier survival curves, to accounting for nonconstant risk and skewed distributions using parametric models. Throughout, attendees will explore model diagnostics to ensure their findings are statistically valid, and implement predictive validation techniques to assess how accurately their models forecast future events. Emphasis is placed on understanding model assumptions and output, evaluating model fit, and selecting methods that align with the model assumptions.</p>
      <p class="ws-series-desc">All workshops will use R and RStudio, so some experience with R or other programming languages is encouraged but not required. See the <a href="#r-fundamentals">R Fundamentals for Data Analysis</a> for an introduction to R and RStudio. Attendees without prior experience are encouraged to review this content.</p>
      <ul class="ws-list">
        <li class="ws-item">
          <span class="ws-item-title">Part 1: Survival Data, Censoring, and Truncation</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Survival analysis is, at its core, about modeling risk, or the probability that an event occurs, over time. But before that risk can be modeled, the data must be structured correctly. However,  time-to-event data are rarely complete: some subjects leave a study before experiencing the event of interest, and others enter observation only after time has already passed. We show why ignoring incomplete data risks biasing estimates from the very first model fit. Participants will learn how to establish a consistent 'time origin' across subjects with different start dates, define who is at risk of the event at any given point in follow-up, and represent this structure correctly in R using the Surv() function.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 2: Kaplan-Meier Estimation</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Once our data are structured with a clear time origin and event status, the natural next question is: what does survival look like over time? This workshop introduces the survival curve — a 'step-shaped' plot showing the estimated probability of remaining event-free at each point in follow-up. We build this curve using Kaplan-Meier estimation — an approach that typically requires no assumptions about the underlying 'shape' of risk (or in other words is non-parametric) — making it an ideal first step for describing time-to-event data before introducing more structured models later in the series. </div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 3: Cox Proportional Hazards Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">After developing an understanding of how risk changes over time, we may want to model that risk as a function of some factors of interest. Cox proportional hazards (Cox PH) models extend the simple survival curve from Part 2 into a framework that allows us to ask not only what survival 'looks' like, but also why it differs across individuals. Rather than modeling survival probability directly, the Cox model works on the instantaneous risk of the event at a given moment (the 'hazard') and allows us to estimate how covariates (e.g., age; control or treatment status; or disease stage) change that risk. Critically, this modelling framework assumes that the relative proportion of risk between 'groups' remains the same over time — and hence is called 'proportional'. This model leaves the underlying shape of the baseline hazard unspecified, just as in the case of survival curve estimation. Cox PH models are thus referred to as semi-parametric.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 4: Model Diagnostics and Interpretation</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Having fit a Cox model in Part 3, the next (and most important) task is making sense of and communicating the results. In this workshop we build that skill by reading hazard ratios, confidence intervals, and coefficient tables, and translating those outputs into meaningful statements about risk. However, up to this point we have supposed that the model is appropriate for our data — an assumption that the relative risk  between individuals remains constant over time. In the second half of the workshop, we introduce the tools used to test whether the 'proportionality' assumption actually holds — spoiler alert: it rarely does. We close by setting up the question the rest of the series must answer: what do we do when it doesn't?</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 5: Parametric and Accelerated Failure Time Models</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">Part 4 left us with a critical (and unresolved) question: What do we do when the proportional hazards assumption fails? One answer is to step outside the Cox framework altogether. This workshop introduces  survival models, which specify the exact shape of the hazard function using a chosen probability distribution (such as Weibull or exponential). Within this framework, we will focus on Accelerated Failure Time (AFT) models. AFT asks how a variable speeds up or slows down time to the event itself. Because AFT models completely bypass the proportional hazards assumption, they offer a valid alternative when your diagnostics flag a violation.</div></details>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Part 6: Prediction</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">It has been asserted that the utility of any given model is best measured by how well it predicts data it has not yet seen. In this final workshop, we take this assertion seriously and ask: how well do our models predict outcomes for new individuals? We shift from describing and explaining the data used to build a model, to evaluating a model's ability to generalize beyond it. In the process we introduce two complementary ways to assess model predictions: discrimination (the model's ability to correctly rank risk among individuals) and calibration (the model's ability to accurately predict survival probabilities).</div></details>
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
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will begin by giving an introduction of core RDM concepts, and then will shift into how to manage your own files by exploring some best practices in file naming and structuring your folders. By the end of this session, participants will be familiar with fundamental concepts of RDM, and will be able to implement best practices in file naming and directory structures. Research Data Management (RDM) is a key aspect of the research lifecycle. With the release of the Tri-Agencies’ Policy on Research Data Management, and the upcoming requirement of data management plans (DMPs) in Tri-Agency applications, it is more important than ever for researchers to implement RDM fundamentals. This session is the first of a three-part series on RDM, and is part of the larger Researcher Toolkit series, an eight-part series which aims to introduce participants to a variety of research tools and concepts, and build core competencies applicable across the research lifecycle. There is no obligation to take every course, but as some courses build on content from previous sessions, it is expected that you have sufficient knowledge of key concepts relevant to certain courses (any courses with pre-requisites will send participants links to necessary information).</div></details>
            <span class="ws-links"><a href="RDM_pt1-the-basics.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">RDM Part 2: Documentation</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will build upon the concepts covered in RDM pt. 1, and will focus on the importance of making your work interpretable and reusable to others through documentation. After covering why documentation is important for research materials, we will explore how to create README files as well as data dictionaries. By the end of this session, participants will gain an understanding of how to make data interpretable and reusable, and will be able to create a README file and a data dictionary. Research Data Management (RDM) is a key aspect of the research lifecycle. With the release of the Tri-Agencies’ Policy on Research Data Management, and the upcoming requirement of data management plans (DMPs) in Tri-Agency applications, it is more important than ever for researchers to implement RDM fundamentals. This session is the second of a three-part series on RDM, and is part of the larger Researcher Toolkit series, an eight-part series which aims to introduce participants to a variety of research tools and concepts, and build core competencies applicable across the research lifecycle. There is no obligation to take every course, but as some courses build on content from previous sessions, it is expected that you have sufficient knowledge of key concepts relevant to certain courses (any courses with pre-requisites will send participants links to necessary information).</div></details>
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
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session is aimed at those who have little to no experience with the command line, and will begin by introducing the Unix Shell and its functions, and then will cover the basics of navigating files and directories. By the end of this session, participants will become familiar with the command line interface and file paths, and will be able to execute Unix commands to navigate through the files and folders in their computers. The command line interface can seem daunting to new users, but it is a very powerful tool that, with some foundational understanding, can be used for a number of different computational and data management tasks. This session is the first of a two-part series on the Unix Shell, and is part of the larger Researcher Toolkit series, an eight-part series which aims to introduce participants to a variety of research tools and concepts, and build core competencies applicable across the research lifecycle. There is no obligation to take every course, but as some courses build on content from previous sessions, it is expected that you have sufficient knowledge of key concepts relevant to certain courses (any courses with pre-requisites will send participants links to necessary information).</div></details>
            <span class="ws-links"><a href="UNIX_pt1.html">workshop page</a></span>
          </div>
        </li>
        <li class="ws-item">
          <span class="ws-item-title">Introduction to the Bash shell Part 2: Working with Files and Directories</span>
          <div class="ws-controls">
            <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">This session will build up concepts covered in the Unix Shell pt. 1, and will shift to working with files and directories, focusing on how to create, edit, move, and remove files and directories. By the end of this session, participants will be able to create, edit, move, and remove files and directories using Unix commands. The command line interface can seem daunting to new users, but it is a very powerful tool that, with some foundational understanding, can be used for a number of different computational and data management tasks. This session is the second of a two-part series on the Unix Shell, and is part of the larger Researcher Toolkit series, an eight-part series which aims to introduce participants to a variety of research tools and concepts, and build core competencies applicable across the research lifecycle. There is no obligation to take every course, but as some courses build on content from previous sessions, it is expected that you have sufficient knowledge of key concepts relevant to certain courses (any courses with pre-requisites will send participants links to necessary information).</div></details>
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
