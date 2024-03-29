---
title: 'Introduction to the Unix Shell Part 1: Navigating Files and Directories'
output:
  html_document:
    keep_md: yes
---


# Introduction to the Unix Shell Part 1: Navigating Files and Directories

## Setup

Before beginning this lesson, you'll need to do a few things:

* 1) Download [shell-lesson-data.zip](https://swcarpentry.github.io/shell-novice/data/shell-lesson-data.zip) and move the file to your desktop
* 2) Unzip/extract the file.  You should end up with a new folder called `shell-lesson-data` on your Desktop.
* 3) If you do not already have the shell software installed, you will need to [download and install it](https://carpentries.github.io/workshop-template/install_instructions/#shell)


## Overview

* What is the Unix Shell?
* Exploring files and directories
* Absolute vs. relative paths
* Putting it all together


## What is the Unix Shell?

Before introducing the Unix Shell, it may be valuable to start by introducing the graphical user interface (GUI).  This is the mide widely used way to interact with a personal computer, and the one that you are most likely familiar with.  The GUI allows you to see various icons and applications, and to use a mouse to navigate your way through the computational landscape.

![](assets/images/gui.png)


[source](https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps)
[source](https://support.apple.com/en-ca/guide/mac-help/mh35840/mac)



As opposed to this graphical interface that can be navigated with a mouse, the Unix Shell is a way of interacting with your computer by providing it with textual instructions.  In this vein, you can think of the shell as a box in which you type instructions for your computer to execute.

![](assets/images/instructions.png)


It's worth noting that there are different "brands" of shell that look different, but that work the same (more or less.  The truth is actually more nuanced, but for the purposes of this session, you can think of the different types of shells working *almost* the same).  

Regardless of the brand/look of shell, each shell begins with some information about where you are in the computer. As an example, these are 3 different shells, all in my personal documents folder:

<img src="assets/images/terminal-brands.png" width="500">

Each shell also has a **prompt**, which indicates that the shell is waiting for input.  The prompts differ across each type of shell, but can include symbols like '>', '%', '$':

![](terminal-prompts.png)

Going back to the concept of the shell as a box in which you type instructions to your computer to execute, it needs to be mentioned that it does not accept human language commands, and that it has its own vocabulary and grammar.  

![](assets/images/instructions2.png)




### Why use the shell?

With this in mind, you might be thinking to yourself, "why would I ever want to use this??  I know how my computer works, and don't need to learn a new language!"  While you would be completely reasonable in thinking that, the shell does provide a much more streamlined approach to automating data-oriented tasks and sequences, and is also the easiest way to work with remote machines and high-performance computing clusters.  

Consider the following scenarios:

* You have 1,000 spreadsheet files, and want to copy the third line of each file to a new file
* You are working with 500 text files, and you want to copy every sentence with the word "migration" to a new file.

You could do this manually, but it's going to be a very long process, and the chance of making mistakes is quite high (and being able to tell if you've made a mistake is an issue in itself!).

<img src="assets/images/bad-time.jpg" width="400">

[source](https://imgflip.com/i/6r02fx)


## Exploring Files and Directories

Before we jump into some commands, it's worth defining two key terms:

**Files**: Objects on a computer that store data, information, settings, or commands used with a computer program.

**Directories**: Also called "folders", are the units that hold files or other directories.


### Paths

A path is a string of characters that specifies a unique location in a directory hierarchy.  A file path specifies the location of a file in a computer's file system structure.

The below picture illustrates the directory structure of a typical computer.  Within this structure, the path to my Desktop would be:

**/Users/Rochlinn/Desktop**

When dealing with paths in Unix, directories are denoted by a slash "/", and each "layer" of the directory heirarchy is separated with a slash.  

<img src="assets/images/path1.png" width="500">

> ### Exercise
> 
> Take a look at the following directory structure.
> 
> * What's the path to the Music directory?
> * What's the path to the S-Club 7 directory?
>
> Answer questions in <a href="https://padlet.com/nickrochlin/unix-exercise-1-1vny67sx59wxjd4z" target="_blank">Padlet</a>

![](assets/images/path2-exercise.png)

## Unix Commands

To start off, here are a few useful commands to get started with navigating your files and directories.  A valuable tip for Unix commands (and most coding languages), is to know that the internet has a lot of documentation of how to solve issues.  When playing around with these commands, it's highly recommended to use a search engine to help you! 

`pwd`

* Stands for "print working directory", and will display the full path of where you currently are on your machine.

<img src="assets/images/pwd.png" width="300">

`ls`

* Lists the contents of a directory.

<img src="assets/images/ls.png" width="400">

`cd`

* Change directories
* Syntax: `cd + {path/to/directory}`

<img src="assets/images/cd.png" width="400">

`cd..`

* Moves you up one directory

<img src="assets/images/cd2.png" width="400">

`cat`

* Prints the whole contents of a file (does not work on directories)
* Syntax: `cat + {file-name}

<img src="assets/images/cat.png" width="700">


### Absolute vs. Relative Paths

When navigating paths through your directories, there are two types of paths that can be used:

**Absolute path**: Includes the entire path from the root directory.

![](assets/images/absolute-path.png)

<br>

**Relative path**: Includes the path relative to where you are.

It should be noted that relative paths only work going down the hierarchy, and not up.  In this example, the path already assumes `/Users/Rochlinn/Music`

![](assets/images/relative-path.png)


> ### Exercise
>
> Using the data files that you downloaded at the beginning of the session, explore the directories and files and answer the following
> questions:
> 
> * What is the full path to the file `methane.pdb`?
> * Who is the author of `methane.pdb`?
> * What command would you type to move from the `alkanes` directory to the `shell-lesson-data` directory?* 
> * What is the last line of the file `NENE01729A.txt`?
>
> Answer questions in <a href="https://padlet.com/nickrochlin/unix-exercise-2-womiyz72vmc3dwax" target="_blank">Padlet</a>

### References & Resources

* <a href="https://swcarpentry.github.io/shell-novice/">Software Carpentries - The Unix Shell</a>
* <a href="http://www.catb.org/~esr/writings/taoup/html/ch10s05.html" target="_blank">Unix flags</a>

