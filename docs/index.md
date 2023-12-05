---
title: "Menu"
pagetitle: "Menu"
---

# Workshop Outlines

> Dates and registration details available at [https://csc.ok.ubc.ca/workshops/](https://csc.ok.ubc.ca/workshops/)

## R Fundamentals for Data Analysis

### R: Fundamental Concepts with RStudio

<div class = "content" class = "other">
    {% include descriptions/r_fundamental.md %}

    {{ content }}
</div>

### R: Importing Data

<div markdown = "1" class = "content">

[Link](R_importing-data.html)

This session will address importing Excel and comma seperated value files into R for analysis. Topics covered include variable naming, variable assignment, missing values on import, assigning appropriate data types to variables, and saving data as R data objects.

By the end of the session, participants should be able to import data stored in tabular format (Excel, csv), standardize missing values for subsequent tidying and analysis.

</div>

### [R: Exploring Data](R_exploring-data.html)

### [R: Subsetting & Filtering Data](R_subsetting-and-filtering-data.html)

### [R: Iterating Over Data](R_iterating-over-data.html)

### [R: Conditions](R_conditions.html)

### [R: Visualizations](R_visualization.html)

## Python Basics for Data Analysis

[Python: Importing Data Sets](Importing_data_sets.html)

[Python: Fundamental Concepts with Jupyter Notebook](JupyterNotebook_workshop1.html)

[Python: Importing and Exporting Data with Python](Importing_Exporting_Data_Workshop2.html)

[Python: Exploratory Data Analysis](Exploratory_Data_Analysis_Workshop3.html)

[Python: Subsetting and Filtering Data](Subsetting_and_Filtering_Data_Workshop4.html)

[Python: Iterating Over Data](Iterating_Over_Data_Workshop5.html)

[Python: Conditions](Python_conditions.html)

[Python: Visualizations](Python_Visualization.html)

[Python: Data Analysis and Visualization](Workshop8_Visualization_continued.html)

## Researcher Toolkit

### Research Data Management (RDM)

[RDM Part 1: The Basics](RDM_pt1-the-basics.html)

[RDM Part 2: Documentation](RDM_pt2-documentation.html)

[RDM Part 3: Data Management Plans](https://ubc-library-rc.github.io/rdm/content/06_Data_Management_Plan.html)


### Introduction to the Shell

[Introduction to the Unix Shell Part 1: Navigating Files and Directories](UNIX_pt1.html)

[Introduction to the Unix Shell Part 2: Working with Files and Directories](UNIX_pt2.html)

## GitHub and GitHub Pages

[Introduction to GitHub Part 1](Intro-GitHub-Part-1.html)

[Introduction to GitHub Part 2](Intro-GitHub-Part-2.html)

<script>
var acc = document.getElementsByTagName("H3");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    /* Toggle between adding and removing the "active" class,
    to highlight the button that controls the panel */
    this.classList.toggle("active");

    /* Toggle between hiding and showing the active panel */
    var panel = this.nextElementSibling;
    if (panel.style.display === "block") {
      panel.style.display = "none";
    } else {
      panel.style.display = "block";
    }
  });
} 
</script>





