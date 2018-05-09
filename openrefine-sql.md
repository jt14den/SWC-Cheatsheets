---
title: Data Cleaning and Databases
subtitle: OpenRefine and SQL
...

## Pre-Workshop Setup ##
- Start OpenRefine
	- Windows: Go to folder you downloaded it to and click on openrefine.exe
	- Linux: In terminal, go to folder you downloaded it to and type ./refine
	- Mac: Click on OpenRefine app in Applications folder
- Make sure openrefine interface is open in browser.  If not go to http://127.0.0.1:3333
- Download data files from the course website and save to your desktop.

### Open up Socrative again ###
- You can import my quiz with **<Socrative code>**
- Advise learners to go to <https://b.socrative.com/login/student/>
- Type in UCONNSWC for the room name

**QUESTION: How many of you have had to spend time cleaning up a dataset?**

One of the good things about databases is that they are picky about data being in consistent formats.  This means that data has to be clean to work well with databases.

OpenRefine is a cleaning tool, originally made by Google.  There are other ways to clean data (by hand, Excel, R) but we think this is one of the most efficient.

1.5 hours - break - 1.25 hrs

## 1. OpenRefine (30 minutes)

### Importing Data (3 minutes)
- Go to `Create Project > Choose Files`
  - Pick the burlap-trap.csv file you downloaded, and click Next
- Give your project a name
- Check to make sure columns look right.
	- Get an idea of problems: missing data, data not filled in, note column
- OpenRefine can work with lots of different types of data: Excel, TSV, etc.
- Switch to rows mode, and show 50 rows at a time. (Records groups rows with the same data in the first row)


### Text Facets (8 minutes)
  - Groups rows with the same value for that column
  - Lets you filter and edit many rows at once.
  - `Facet > Text Facet for Tree Species`
  	- Bulk Editing: `Edit White PIne`
  	- Subsetting: `Include White oak`
  	- Edit individual cell (mouseover)
  	- Include multiple tree species (Maples)
  	- `Invert selection` (all except Maples)
  - Flagging: Flag "Red oak (?)" `Edit Rows > Flag Rows`

#### Faceting Challenge #1
- Make a text facet for the Direction column and clean it up. Check for equal sample sizes.

### Undo/Redo (1 minute)
- The history of everything you do gets saved.
- You can undo things with `Undo/Redo`, and you can also save that history to play back (`Extract`).  You could also export the history and track with Git.
- Lets undo the changes we made to the Direction column

### Transforming Columns (5 minutes)
- Instead of editing subsets, we can make changes to a whole column
- All of the problems in Direction column were capitalization and whitespace.
  - `Edit Cells > Common Transforms > Trim whitespace`
  - `Edit Cells > Common Transforms > Titlecase`
- Now, lets address the blanks in the data: `Edit Cells > Fill Down`
- Splitting Columns: `Site > Edit Column > Split into several columns`

#### Transforming Challenge: Trim whitespace from all columns, and fill down date, Site, and Vegeplot

### Numeric Facets (5 minutes)
- Before doing numeric facets, we need to make a column numeric: `Edit Cells > Transform > To Number`
- Let's make a numeric facet of # egg masses
  - Let's look at the non-numeric data and fix it
  - Let's look at the blank data and flag it
  - We can also look for numeric outliers

***---------- Socrative #1 ----------***
- Use a Numeric Facet to clean up the data in the DBH column.  This is the diameter of the trees.  
- Are there any outliers that might represent mistakes?
	- True (*correct*)
	- False 
***---------- Socrative #1 ----------***

### Stacking Facets (5 minutes)
- So far, we've only been working with one facet at a time.  You can also stack facets
- Let's say that on May 23rd, a student confused Beech Trees for Red Oaks
	- Facet by Date, then by Tree species
	- Display, then edit the Beech Trees

***---------- Socrative #2 ----------***
- How many Black Oak trees are at site BS_GCL that are over 40 cm DBH?
	- 5 (black oaks @ site)
	- 2 (*correct*)
	- 27 (total black oaks)
	- 10 (black oaks over 40 cm)
***---------- Socrative #1 ----------***

### Exporting (1 minute)
- Click on export to save a csv of your cleaned data.
- You could also export the entire project to send to someone else.

### Help (1 minute)
- Notice the `Help` button.  This takes you to a wiki.  There is even a simple programming language GREL

## Databases
- Databases are similar to Excel in many ways, but built for searching.
- Workbook = database, worksheet = table, column = field, and row = row.
	
#### Why use a database instead of Excel?
- Designed for large datasets (potentially millions of rows).
- Enforces data types: one column, one kind of data
- Avoid duplicating data, e.g. species names: makes it easier to change/maintain, less space
- Easier to search for subsets of data

## 2. Selecting Data


## 3. 



## 1. Module 1
#### Subheading 

- Showing a code command
  - `plot(0)`

## 2. Module 2



***---------- Socrative #1 ----------***