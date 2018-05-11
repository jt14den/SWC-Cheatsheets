---
title: Data Cleaning and Databases
subtitle: OpenRefine and SQL
...

## Pre-Workshop Setup ##
- Start OpenRefine
	- Windows: Go to folder you downloaded it to and click on openrefine.exe
    - If OpenRefine doesn't run, install JDK & JRE, add JAVA_HOME and JDK_HOME to environment.
	- Linux: In terminal, go to folder you downloaded it to and type ./refine
	- Mac: Click on OpenRefine app in Applications folder
    - Need to allow OpenRefine to run by "Allow Everything" in Settings > Security
- In your browser (non IE), go to http://localhost:3333
- Download data files from the course website and save to your desktop.
- Make sure someone is recording commands in the Etherpad (no log)
- Setup for DB BRowser
  - 1024 x 768 resolution
  - Data browser font size to 14
  - SQL editor and log font size to 16

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
- `Switch to rows mode`, and show 50 rows at a time. (Records groups rows with the same data in the first row)

### Text Facets (8 minutes)
  - Groups rows with the same value for that column
  - Lets you filter your data and edit many rows at once.
  - `Facet > Text Facet for Tree Species`
  	- Bulk Editing: `Edit White PIne`
  	- Subsetting: `Include White oak`
  	- `Edit cell` (mouseover)
  	- `Include` multiple tree species (Maples)
  	- `Invert selection` (all except Maples)
  - Flagging: Flag "Red oak (?)" `Edit Rows > Flag Rows`

#### Faceting Challenge #1
- Make a text facet for the Direction column and clean it up. Check for equal sample sizes.

### Undo/Redo (1 minute)
- The history of everything you do gets saved.
- You can undo things with `Undo/Redo`, and you can also save that history to play back (`Extract`).  You could also export the history and track with Git.
- Lets `undo the changes` we made to the Direction column

### Transforming Columns (5 minutes)
- Instead of editing subsets, we can make changes to a whole column
- All of the problems in Direction column were capitalization and whitespace.
  - `Edit Cells > Common Transforms > Trim whitespace`
  - `Edit Cells > Common Transforms > Titlecase`
- Now, lets address the blanks in the data: `Edit Cells > Fill Down`
- Splitting Columns: `Site > Edit Column > Split into several columns`

#### Transforming Challenge: 
- Trim whitespace from all columns, and fill down date, Site, and Vegeplot

### Numeric Facets (5 minutes)
- Before doing numeric facets, we need to make a column numeric: 
  - `Edit Cells > Transform > To Number`
- Let's make a `numeric facet of # egg masses`
  - Let's look at the non-numeric data and fix it
  - Let's look at the blank data and flag it
  - We can also look for numeric outliers

***---------- Socrative #1 ----------***: Clean up DBH, any outliers?

- Use a Numeric Facet to clean up the data in the DBH column.  This is the diameter of the trees.  
- Are there any outliers that might represent mistakes?
  - True (*correct*)
  - False 

### Stacking Facets (5 minutes)
- So far, we've only been working with one facet at a time.  You can also stack facets
- Let's say that on May 23rd, a student confused Beech Trees for Red Oaks
	- `Facet by Date, then by Tree Species`
	- Include, then edit the Beech Tree

***---------- Socrative #2 ----------***: # Black Oaks > 40 cm DBH @ BS_GCL

- How many Black Oak trees are at site BS_GCL that are over 40 cm DBH?
  - 5 (black oaks @ site)
  - 2 (*correct*)
  - 27 (total black oaks)
  - 10 (black oaks over 40 cm)

### Exporting (1 minute)
- Click on `Export` to save a CSV of your cleaned data.
- You could also export the entire project to send to someone else.

### Help (1 minute)
- Notice the `Help` button.  This takes you to a wiki.  There is even a simple programming language GREL
- Also some great tutorial videos (Delete all facets and there is a link)

#### 30 minutes #####

----------------------------------------


## 2. Intro To Relational Databases (5 minutes)
- Databases are similar to Excel in many ways, but built for searching
- The relational aspect means that columns in separate tables can be linked (more later)
	
### Why use a database instead of Excel?
- Designed for large datasets (potentially millions of rows), still fast
- Improves quality control, by enforcing data types: one column, one kind of data
- Avoid duplicating data, e.g. species names: makes it easier to change/maintain, less space
- Easier to search for subsets of data
- Less likely to accidentally modify data

### Lots of Different types of databases
- MS Access, Filemaker Pro, MySQL, etc.
- We'll be using SQLite, but the concepts are mostly the same.
  - They all use SQL = Structured Query Language

### Exploring in DB Browser (2 minutes)
- `Open DB Browser`
- Click `Open Database` and find our survey.db file
- Workbook = database, worksheet = table, column = field, and row = record
- Expand the person table and show the fields: field name and data type
  - Click on Browse Data tab to see the table, very similar to Excel
  - Browse the other tables to see what we have.
  - Notice there are some values missing (shown with NULL)


## 3. Selecting Data with SELECT (8 minutes)
- Lets write an SQL query (search term) to display the scientists' names
  - Click on `Execute SQL`
  - We can make comments using `--`
  - Type `SELECT personal, family FROM Person;` and click the Run button to run the selected line
    - The semicolon marks the end of our query
    - SQL is case-insensitive.  We could write `select PERSONAL, family From Person;`
    - Convention is to keep SQL commands in all caps, to differentiate, easier to read
  - Records and fields in a database aren't stored in any particular order, so we can control that
    - Example, swap fields `SELECT family, personal FROM Person;`
  - As a shortcut, we can use * as a wildcard for "all fields"
    - `SELECT * FROM Person;`
  - We could even select a field multiple times:
    - `SELECT id, id FROM Person;`

***---------- Socrative #3 ----------***: person, quant, reading from Survey

Write a query that displays the person, quant, and reading fields from the Survey table

- `SELECT person, quant, reading FROM Survey;`


## 4. Sorting Data (3 minutes)
- It's often useful to sort the output of our query
- We can do this with `ORDER BY`
  - `SELECT * FROM Person ORDER BY id;`
    - This sorts in Ascending order by default.  We could do descending
  - `SELECT * FROM Person ORDER BY id DESC;`
  - NOTE: It may look like records are in a certain order without sorting
    - Only because that's the order the data were imported in
    - Any modifications could easily affect that order
  - We can make things clearer with `ASC`
- We can order by multiple fields
  - `SELECT person, quant, reading FROM Survey ORDER BY person ASC, reading DESC;`


## 5. Filtering with WHERE (15 minutes)
- A very useful database feature is the ability to quickly filter data, even with large datasets
- We do this by adding a WHERE clause to our SELECT query
  - `SELECT * FROM Visited;`
  - `SELECT * FROM Visited WHERE site = 'DR-1';`
    - Now, the database is checking which records match the WHERE clause, and then checking which fields we want
- We can use multiple filters in the WHERE clause: DR-1 before 1930
  - `SELECT * FROM Visited WHERE site = 'DR-1' AND dated < '1930-01-01';`
    - **Sidenote:** This query only works because YYYY-MM-DD HH:MM:SS dates allows sorting.  MySQL and other databases have data types specifically for dates to help with this.
- Find out what measurements were taken by either Lake or Roerich using OR
  - `SELECT * FROM Survey WHERE person = 'lake' OR person = 'roe';`
- Alternatively, we can use IN, to see if a value is in a specific list
  - `SELECT * FROM Survey WHERE person IN ('lake', 'roe');`
- We can combine AND and OR, but need to be careful
  - `SELECT * FROM Survey WHERE quant = 'sal' AND person = 'lake' OR person = 'roe';`
    - Gives us salinity by lake and everything by Roerich
  - Use parentheses to enforce order of operations
    - `SELECT * FROM Survey WHERE quant='sal' AND (person='lake' OR person='roe');`

***---------- Socrative #4 ----------***: normalized salinity outliers ouside of [0.0, 1.0]

Normalized salinity readings are supposed to be between 0.0 and 1.0.  Which query will select all records from Survey with salinity values that are not normalized?

- `SELECT * FROM Survey WHERE quant='sal' AND reading > 1.0 OR reading < 0.0;`
- `SELECT * FROM Survey WHERE quant='sal' AND (reading > 1.0 AND reading < 0.0);`
- `SELECT * FROM Survey WHERE quant='sal' AND (reading > 1.0 OR reading < 0.0);` (*correct*)
- `SELECT * FROM Survey WHERE quant='sal' OR (reading > 1.0 AND reading < 0.0);`

- We can also find partial matches with LIKE
  - `SELECT * FROM Visited WHERE site LIKE 'DR%' ORDER BY site ASC;`
    - Gives us all the sites that start with DR
    - The percent symbol is a wildcard, matches any characters.  Use anywhere in a string.
- Or,we could use DISTINCT to show unique values
  - `SELECT DISTINCT person, quant FROM Survey WHERE person = 'lake' OR person = 'roe';`
    - Note: only unique for those chosen fields, not entire records.

#### 63 minutes #####

## 6. Missing Data (8 minutes) SKIP/Abbreviate if after 2 PM
- With real-world data, it's common to have missing data
- Let's take a look at the Visited table
  - `SELECT * FROM Visited;`
  - There's a row without a date, where it says NULL
    - NULL means "nothing here".  It's not zero or false, or an empty string.
- NULL doesn't behave like other values
  - Select records before 1930 again: 
    - `SELECT * FROM Visited WHERE dated < '1930-01-01';`
  - And after 1930:
    - `SELECT * FROM Visited WHERE dated >= '1930-01-01';`
  - Neither gives us the NULL row.
    - A comparison operator like > with a NULL value is neither true nor false
      - Just "we don't know"
  - Even checking if it equals NULL doesn't work, looks for a string "NULL" (which isn't NULL)
    - `SELECT * FROM Visited WHERE dated = NULL;`
  - We need to use a special test
    - `SELECT * FROM Visited WHERE dated IS NULL;`
    - or inverse `SELECT * FROM Visited WHERE dated IS NOT NULL;`
- This can cause headaches.  Example: salinity measurements not by Lake:
  - `SELECT * FROM Survey WHERE quant = 'sal' AND person != 'lake';` doesn't work
    - Note: `!=` means "not equal to"
  - `SELECT * FROM Survey WHERE quant='sal' AND (person != 'lake' OR person IS NULL);`
    - We need an explicit check
- In some other kinds of databases, you can specify a default value other than NULL for a field
  - What might be useful in an R context?

***---------- Socrative #5 ----------***: Visted, sorted by date, excluding NULL

Write a query that sorts the records in Visited by date, excluding entries for which the date is not known

- `SELECT * FROM Visited WHERE dated IS NOT NULL ORDER BY dated;` (*works, but less clear*)
- `SELECT * FROM Visited WHERE dated IS NOT NULL ORDER BY dated ASC;` (*correct, preferred*)
- `SELECT * FROM Visited WHERE dated IS NULL ORDER BY dated ASC;`
- `SELECT * FROM Visited WHERE dated > '1900-01-01' ORDER BY dated ASC;` (*works, but less clear*)


## 7. Combining Data with JOIN (12 minutes)
- We need to do an analysis and need the data fields `latitude, longitude, date, quantity, and reading`
  - But this data is in multiple tables (lat/long in Site, dates in Visited, and Readings in Survey)
    - Show figure
    - We did it this way to make it easier to manage (eg. change a site's lat/long only once)
- We can combine data from multiple tables with JOIN
  - `SELECT * FROM Site JOIN Visited ON Site.name = Visited.site;`
    - The ON part tells SQL to match the name field in the sites table with the site field in the Visited table
    - Note that we are now using `Table.field`.  Tables can have fields with the same name, so this distinguishes
- We can now select the fields we actually need and format the SQL nicely
  -   <span></span>

      ```
      SELECT Site.lat, Site.long, Visited.dated
      FROM Site JOIN Visited
      ON Site.name = Visited.site;
      ```

- We can do more than one JOIN at once to get the data we want
  -   <span></span>

      ```
      SELECT Site.lat, Site.long, Visited.dated, Survey.quant, Survey.reading
      FROM Site JOIN Visited JOIN Survey
      ON Site.name = Visited.site
      AND Visited.id = Survey.taken
      AND Visited.dated IS NOT NULL;
      ```

- And now we can export the output of that SQL command to CSV (button)

- The reason we can do this is because this database was carefully set up
  - In the Sites and Person table, each record has a unique ID, called a Primary Key
    - For example, the Person table has an ID field with no duplicates
  - In a table such as Survey, and Visited which refer to data in other tables, we use the same IDs
    - In this case they are called Foreign Keys: they refer to data in other tables.
  - What we end up doing then is matching a foreign key to a primary key
- Good database design gives every table a field to act as a primary key
  - Ideally this should NOT be data, in case data needs to be changed. 
  - Just have a field numbering the records works well
    - **Why might the last name used in the Person table be a bad Primary Key?**

***---------- Socrative #6 ----------***: Site name and salinity readings

Write a query that lists all the salinity readings along with the site names they were collected at

-   <span></span>

    ```
    SELECT Site.name, Survey.reading 
    FROM Site JOIN Visited JOIN Survey 
    ON Site.name = Visited.site
    AND Visited.id = Survey.taken
    WHERE Survey.quant = "sal";
    ```


#### 90 minutes: BREAK #####


## 8. Data Hygiene (4 minutes)
- **Rule 1:** Fields shouldn't have multiple pieces of data**
  - If we stored the full name in a field, it would be hard to pull out all the Franks
- **Rule 2: Every record should have a unique primary key**
  - A unique number with no meaining is good
  - If you remember back to our OpenRefine dataset, our lab is using the 3-letter site code
- **Rule 3: No redundant information** 
  - If we run our join query, we could have stored data in a table this way.
    - But if a date was wrong, we'd be changing it multiple times
      - The bigger the dataset, the worse the problem

## 8. Creating Databases (15 minutes)
- Let's recreate the Site table

### DROP TABLE
- First, we drop the old table
  - `DROP TABLE Site;`
    - BE CAREFUL WITH THIS! You can lose data!

### CREATE TABLE
- `CREATE TABLE Site (name text, lat real, long real);`
- Now we have the table back, but it is empty

### Data Types
- Note that after the field names there's an additional qualifier (e.g. text)
- This is the data type
- SQLite only has a few: text, real (for decimals), integer, blob (binary data like an image)
  - Many other databases have additional types for true/false, date, time, and more number/text types

### Insert Data
- We can add data back by writing INSERT INTO queries
  -   <span></span>

      ```
      INSERT INTO Site VALUES('DR-1', -49.85, -128.57);
      INSERT INTO Site VALUES('DR-3', -47.15, -126.72);
      INSERT INTO Site VALUES('MSK-4', -48.87, -123.40);
      ```


***---------- Socrative #7 ----------***: Make family table with unique ID, names, and age

Create a table named Family.  Make fields for a unique identifier,  first and last names, and age. Add a record for yourself, and one for a family member.  

-   <span></span>

    ```
    -- Create the table.  id is my unique identifier (a number).  
    -- age is also a number.  The names will be text fields.
    CREATE TABLE Family (id integer, firstname text, lastname text, age integer);

    -- Insert two records
    INSERT INTO Family VALUES(1, 'James', 'Mickley', 34);
    INSERT INTO Family VALUES(2, 'Peter', 'Mickley', 28);
    ```


### Exporting a Database 
- We can save a database as an SQL file, which can be shared and imported in another database
  - Also works well with Git
- `File > Export > SQL File`
- Let's take a look
  - Notice the `IF NOT EXISTS`, This is a precaution to prevent overwriting tables that are already there

### Importing a CSV
- We could also import a CSV File, such as our burlap trap data
  - `File > Import > CSV`
- This works, but the data types are conservative: all text, no NULLS


## 9. Modifying Data (10 minutes)
- In addition to inserting data, we can also modify or remove data that is already there

### UPDATE
- We can modify using the UPDATE command
- Let's say we found that our MSK-4 site had the wrong lat/long, off by one degree
  - `UPDATE Site SET lat = -47.87, long = -122.4 WHERE name = 'MSK-4';`

***---------- Socrative #8 ----------***: **OPTIONAL**

We want to change the first salinity value in the Survey table to be 0.5. What happens when we run the following query?

- `UPDATE Survey SET reading = 0.5 WHERE quant = 'sal';`

It works just as we expected and changes the first salinity value to 0.5
We get an error
It changes all the salinity values to 0.5


***---------- Socrative #9 ----------***: **OPTIONAL**

Write a SQL query to replace all the NULL cells in Survey.person with the string 'unknown'

- `UPDATE Survey SET person = 'unknown' WHERE person IS NULL;`


### DELETE
- To delete records, we use DELETE FROM.  We can delete Frank Danforth from the Person table, he has no data
  - `DELETE FROM Person WHERE id = 'danforth';`
- What problems might we have if we try to delete Anderson Lake instead?
  - Our Survey table would still contain records of measurements he'd taken, but a JOIN wouldn't work anymore because lake doesn't exist
    - That's a big problem with relational databases! It's called referential integrity
      - Before we delete something, we need to ensure that all references between tables can be resolved
      - A few options
        - Delete all the lake data records first (cascading delete)
        - Prevent the deletion of a record that is referenced by other tables (restrict)
        - Just delete the record in Person, which will probably break things (no action)
        - Other databases like MySQL can have these set up to happen automatically.

## 10. Calculating New Values (if time)
  - Fix Roerich salinity readings (collected as percentages)
    - `SELECT taken, reading / 100 FROM Survey WHERE person='roe' AND quant='sal';`
  - Use UNION to combine with everyone else's
    - `SELECT taken, reading FROM Survey WHERE person != 'roe' AND quant = 'sal' UNION SELECT taken , reading / 100 FROM Survey WHERE person='roe' AND quant='sal';`


## 11. Programming with Databases in R (30 minutes)
- We can actually run SQL queries in R

### Setup
- Let's copy the survey.db database to our R Project folder & open our project
- Make a new R script Database.R (**note**: dropbox link)
- We need to install and load some libraries
  - `install.packages("RSQLite")`
  - `library(RSQLite) library(dplyr)`

### Connecting & Simple Functions
- In order to use R functions with a database, we need to make a connection and save it
  - `conn <- dbConnect(drv = SQLite(), dbname = "data/survey.db")`
    - Note: other databases (MySQL) often require a username and password as well
  - Now, the connection info is stored in the variable con
- We can get some simple information
  - List tables: `dbListTables(conn)`
  - Show fields in a table: `dbListFields(conn, "Site")`

### Executing Queries in R
- What we really want to do is query our database and get the resulting data into R
  - `coords <- dbGetQuery(conn, "SELECT lat, long FROM Site;")`
  - `coords`

***---------- Socrative #10 ----------***: 

Write some R code to execute one of our JOIN queries from earlier, and return the results in R

-   <span></span>

    ```
    joined_data <- dbGetQuery(conn, 
      "SELECT Site.lat, Site.long, Visited.dated
      FROM Site JOIN Visited
      ON Site.name = Visited.site;")
    ```

- An alternative to get an entire table
  - `person <- dbReadTable(conn, "Person")`

### Using Databases with dplyr
- Instead of writing queries, we can use dplyr functions to query and filter a database
  - We use a function called tbl()
    - `tbl(conn, "Survey")`
  - We can pipe the results to select and filter
    - Note: Show output before using collect, to compare
      - Explain lazy queries   
    -   <span></span>

        ```
        tbl(conn, "Survey") %>%
          select(person, quant, reading) %>%
          filter(quant == "sal") %>%
          collect()
        ```

    - We could then graph this data:
    -   <span></span>

        ```
        tbl(conn, "Survey") %>%
          select(person, quant, reading) %>%
          filter(quant == "sal") %>%
          collect() %>% 
          ggplot(aes(x = person, y = reading)) + 
            geom_boxplot()
        ```

### Inserting Data
- Inserting data: We could add a site using dbSendQuery()
  - `status <- dbSendQuery(conn, "INSERT INTO Site Values('PK-2', -45, -125);")`
    - This doesn't return any result, just some status stuff
    - `status`
    - `dbClearResult(status)`
  - And check the result
    - `dbGetQuery(conn, "SELECT * FROM Site;")`
- Or we could just store a whole table into the database
  - `dbWriteTable(conn, name = "iris", value = iris, row.names = FALSE)`
  - `dbGetQuery(conn, "SELECT * FROM iris;") %>% head()`

### Disconnect the database
- We need to release the database when we're done
  - `dbDisconnect(conn)`