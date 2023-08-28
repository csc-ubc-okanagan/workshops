**Fundamental Concepts with [RStudio][Jupyter Notebook]**

This session will introduce participants to fundamental concepts in [R][Python] that will help them excel at more advanced applications. Topics covered include the application of simple math, core data types and structures, an overview of vector operations, and how to navigate getting help. [For Python, this will include data structures used in the pandas library]. The workshop will be run using [RStudio][Jupyter Notebook].

By the end of the session, participants should feel familar with [RStudio][Jupyter Notebook] as an environemnt for interactive analsysis in [R][Python], be able to identify and articulate use cases for common data structures, and know a few key ways to get additional help when they run into trouble.

* what is r
* what is an IDE
* vector, matrix, list, dataframe
* what is a function
* basic arithmetic functions

**[R][Python]: Importing Data**

This session will address importing Excel and comma seperated value files into R for analysis. Topics covered include variable naming, variable assignment, missing values on import, assigning appropriate data types to variables, and saving data as R data objects.

By the end of the session, participants should be able to import data stored in tabular format (Excel, csv), standardize missing values for subsequent tidying and analysis.

* read.csv with options, readxl() 
* variable naming conventions
* assign data to variable
* character, numeric, and factor data
* export as .RData file

**[R][Python]: Exploring Data**

This session will introduce participants to common tasks of initial data exploration. Topics covered include calculating missing values, basic summaries (quartiles, categories, counts, etc), single variable descriptive stats (range, length, variance, etc), and plotting distributions.

By the end of the session, participants should be able to use a suite of tools to comprehensivley describe their data and establish if it meets underlying criteria for subsequent analysis.

* count NA values
* count complete rows
* summary stats
* hist(), plot() - this is not a lesson on data visualization

**[R][Python]: Subsetting & Filtering Data**

This session will explore the variety of ways that data can be subset in [R][Python].  Working with data frames and vectors, data frames, and lists, participants will learn the nuances of extracting portions of a larger data set for analysis.

By the end of this session, participants will be proficient in extracting observartions, variables, and values from their data and be aware of when attributes of the extracted data will be lost or maintained for further analysis.

* [], [[]], subset(), which(), filter()[dplyr], select()[dplyr]

**[R][Python]: Iterating Over Data**

This session will revisit the vector underpinnings of [R][pandas], introduce the apply() family of functions for iterating, or looping, over objects, and introduce for loops for those instances when no pre-existing solutiong exists.

By the end of this session, participants will be able to efficiently apply looped constructs to their data, using pre-existing tools in [R][pandas], and be familiar with the basics of constructing for loops to handle repeated tasks.

* vector basics
* apply()
* for loops

**[R][Python]: Conditions**

This session will introduce conditionals in [R][Python], addressing those times when, for example, if something is true *x* needs to happen, otherwise *y* needs to happen. Participants will be introduced to pre-exising if / else constructs (such as ifelse() and switch()), as well as how to construct conditional statments from scratch.

By the end of this session, participants will be able effectively implement simple if else constructs into the data analysis pipelines.

* vectorized operations (ifelse)
* if else statements
* switch(), where()[dplyr]

**[R][Python]: Data Visualization**

This session will introduce [ggplot][altair/plotnine/matplotlib] for data visualization. Common visualizations, including bar charts, histograms, scatterplots, etc will be covered.

By the end of this session participants will be able to build, annotate, and customize common data visualizations.

* ggplot

**[R][Python]: Generating Reports**

This session will introduce participants to RMarkdown, a powerful package for interweaving narrative text and data analysis to produce reports in html, pdf, html5 slides, etc. Using RStudio, RMarkdown, and the reticulate package, participants can conduct their analysis in R or Python.

By the end of this session, participants will be familiar with the requisite libraries and document structure to create beautiful, reproducible reports for distribution.

**Research Data Management pt. 1 – The Basics** 

Research Data Management (RDM) is a key aspect of the research lifecycle. With the release of the Tri-Agencies’ Policy on Research Data Management, and the upcoming requirement of data management plans (DMPs) in Tri-Agency applications, it is more important than ever for researchers to implement RDM fundamentals.

This session will begin by giving an introduction of core RDM concepts, and then will shift into how to manage your own files by exploring some best practices in file naming and structuring your folders.  

By the end of this session, participants will be familiar with fundamental concepts of RDM, and will be able to implement best practices in file naming and directory structures.

**Research Data Management pt. 2 – Documentation**

Research Data Management (RDM) is a key aspect of the research lifecycle. With the release of the Tri-Agencies’ Policy on Research Data Management, and the upcoming requirement of data management plans (DMPs) in Tri-Agency applications, it is more important than ever for researchers to implement RDM fundamentals.

This session will build upon the concepts covered in RDM pt. 1, and will focus on the importance of making your work interpretable and reusable to others through documentation.  After covering why documentation is important for research materials, we will explore how to create README files as well as data dictionaries.

By the end of this session, participants will gain an understanding of how to make data interpretable and reusable, and will be able to create a README file and a data dictionary.

**Research Data Management pt. 3 – Data Management Plans (DMPS)**

Research Data Management (RDM) is a key aspect of the research lifecycle. With the release of the Tri-Agencies’ Policy on Research Data Management, and the upcoming requirement of data management plans (DMPs) in Tri-Agency applications, it is more important than ever for researchers to implement RDM fundamentals.

This session will build upon concepts covered in RDM pt. 2 and 3, and will delve into the DMP Assistant, a Canadian tool for creating DMPs. We’ll walk through the sections of a DMP, and discuss questions and aspects to consider when planning a research project, to ensure that your data workflows and processes are purposeful and unnecessary disruptions are avoided.

By the end of this session, participants will be able to navigate the DMP Assistant and its various functions, and identify key questions and components of a DMP.

**Introduction to the Unix Shell pt. 1: Navigating Files and Directories**

*do we need to say that this is BASH?*
*https://www.educative.io/answers/how-to-install-git-bash-in-windows*

The command line interface can seem daunting to new users, but it is a very powerful tool that, with some foundational understanding, can be used for a number of different computational and data management tasks.  

This session is aimed at those who have little to no experience with the command line, and will begin by introducing the Unix Shell and its functions, and then will cover the basics of navigating files and directories.

By the end of this session, participants will become familiar with the command line interface and file paths, and will be able to execute Unix commands to navigate through the files and folders in their computers.

Prerequisites: 

* Download and be able to open the shell software [here](https://carpentries.github.io/workshop-template/install_instructions/#the-bash-shell)
* Download [shell-lesson-data.zip](shell-lesson-data.zip) and move the file to your Desktop.
* Unzip/extract the file. **Let your instructor know if you need help with this step**. You should end up with a new folder called shell-lesson-data on your Desktop.

* list commands covered

**Introduction to the Unix Shell pt. 2: Working with Files and Directories**

The command line interface can seem daunting to new users, but it is a very powerful tool that, with some foundational understanding, can be used for a number of different computational and data management tasks.  

This session will build up concepts covered in the Unix Shell pt. 1, and will shift to working with files and directories, focusing on how to create, edit, move, and remove files and directories.  

By the end of this session, participants will be able to create, edit, move, and remove files and directories using Unix commands.

Prerequisites: 

* Familiarity with the basics of navigating files and directories with Unix commands, which can be acquired in Introduction to the Unix Shell pt. 1: Navigating Files and Directories.
* Download and be able to open the shell software [here](https://carpentries.github.io/workshop-template/install_instructions/#the-bash-shell)
* Download [shell-lesson-data.zip](shell-lesson-data.zip) and move the file to your Desktop.
* Unzip/extract the file. **Let your instructor know if you need help with this step**. You should end up with a new folder called shell-lesson-data on your Desktop.

* list commands covered

**Introduction to GitHub** 

When working on a project with multiple collaborators, issues can arise when people are working on the same document at the same time.  If the group has to take turns working individually, a lot of time can be lost waiting for the other to finish, but if they work on their own copies and share them back and forth, things can be lost, overwritten, or duplicated.

This is where automated version control can be valuable, which will prevent any updates or additions from ever being lost, will keep a record of whom made any changes, and will notify users when there is a conflict between one person’s work an another’s.  

This session will provide an introduction to GitHub, a version control software, and will cover the concept of automated version control, as well as basic GitHub functions including push, pull, branching, and others.  

By the end of this session, participants will gain familiarity with GitHub as a version control tool, and will set up a GitHub repository and be able to execute basic GitHub commands.

Prerequisites: 

* Basic familiarity with Unix commands (which can be acquired in the Unix Shell workshops).
* As part of this lesson, you will need to set up a GitHub account prior to joining, which can be done [here](https://github.com/)

* authenticate machine
* set up global options - username, email, text editor
* pull, push, branch, merge, gitignore
* resolve conflict 

**Introduction to GitHub Pages pt. 1**

Building on concepts covered in Introduction to GitHub *and Unix Shell*, this session will introduce GitHub pages as a way to create a personal website or blog, or create a website for your project.  After introducing the concept of GitHub pages, we will then go through the steps of generating a GitPages website, and will introduce markdown as a way to add content to your pages, as well as how to push (save) content to the website. 

By the end of this session, participants will be able to initiate a website on GitHub pages, and be able to add content to the website.

Prerequisites: 

* Basic familiarity with Unix commands (which can be acquired in the Unix Shell workshops).
* As part of this lesson, you will need to set up a GitHub account prior to joining, which can be done [here](https://github.com/)

* touch a readme and licence md file
* git init
* set up git repo
* git push
* publish to pages
* touch index.md and repeat
* add img directory and insert images, add hyperlinks

**Introduction to GitHub Pages pt. 2**

Building on concepts covered in Introduction to GitHub and Introduction to GitHub Pages pt. 1, this session will go deeper into the capabilities of GitHub pages, exploring how to implement themes to your pages and customizing content.

* theme documentation
* markdown and yaml
* css and scss

* add yaml to pages
* add theme
* add custom css (inspect and asset folder)












