---
title: R Novice Gapminder #2
subtitle: R for Reproducible Scientific Analysis Part 2
...

## Pre-Workshop Setup ##

-   Load the gapminder dataset
    -   Make a new R file
    -   `gap <- read.csv("data/gapminder_data.csv")`
-   Install packages
    -   <span></span>

        ```
        install.packages(c("ggplot2", "cowplot", "tidyr", "dplyr", 
            "knitr", "rmarkdown", "formatR"))
        ```

### Open up Socrative again ###
-   You can import my quiz with SOC-26147790
-   Advise learners to go to <https://b.socrative.com/login/student/>
-   Type in MICKLEY for the room name


-   So far, we've just had R do exactly what we told it to do.  
-   It becomes much more powerful if it can make its own decisions or do repetitive tasks
-   We're going to learn conditional statements, functions, and loops that will do just that
    -   These same concepts get used in most other computer languages => portable skills.
    -   We already saw loops in shell, which actually has functions and conditionals too

## 1a. Vectorization (5 minutes)

- One reason why R is used so much for data analysis is that it has a neat feature
- Most functions are "vectorized", meaning they'll operate on a whole list of numbers at once
- Here x is a vector of four numbers
    -   <span></span>

        ```
        x <- 1:4
        x
        x * 2
        ```

- What happens if we add two vectors together
- Explain on the board what is going on
    -   <span></span>

        ```
        y <- 6:9
        x + y
        ```

- This also works for comparison operators, logical operators, or functions
    -   <span></span>

        ```
        x > 2

        a <- x < 2
		b <- x > 3

		a | b

		log(x)
        ```

- **Note:**
	- The `*` operator etc gives you element-wise multiplication
	- For matrix multiplication you need to use %\*%

    -   <span></span>

        ```
		m <- matrix(1:12, nrow=3, ncol=4)
		m * -1

		m * m

		m %*% matrix(1, nrow=4, ncol=1)

        ```


## 1. Conditional Statements (25 minutes)

-   Often when coding, we want to control what happens in certain situations
-   We'll start with making choices using *conditional statements*
    -   <span></span>

        ```
        number <- 37
        if (number > 100) {
            print("greater than 100")
        } else {
            print("less than 100")
        }
        print("Finished checking")
        ```

-   Walk through this example, showing the flow
    -   Draw choice diagram
-   Comparison operators
    -   Greater than: `number > 100`
    -   Less than: `number < 100`
    -   Equal to: `number == 37`
    -   Not equal to: `number != 37`
    -   Also => and <= 

- We don't need an else:
    -   <span></span>

        ```
        if (number > 100) {
            print("greater than 100")
        }
        ```

- We could have more than one test, test the sign of the number
    -   <span></span>

        ```
        number = -3
        if (number > 0) {
             print(1)
        } else if (number < 0) {
             print(-1)
        } else {
             print(0)
        }
        ```

- We can combine tests with logical operators
    -   <span></span>

        ```
        number1 = 15
        number2 = 40

        if (number1 >= 0 & number2 >= 0) {
            print("Both numbers are positive")
        } else {
            print("At least one number is negative")
        }

        if (number1 >= 0 | number2 >= 0) {
            print("At least one number is not negative")
        } else {
            print("Both numbers are negative")
        }
        ```

***---------- Socrative #1 ----------***: Test whether number is between 45 and 50 (inclusive)

This is a tricky one, 3 correct answers

## 2. Loops (40 minutes)

-   Just like the shell, R has for loops, which can do repetitive tasks
-   But the syntax is slightly different
    -   <span></span>

        ```
        numbers <- c(1:10)
        print(numbers)
        for (number in numbers) {
             print(number)
        }

        for(i in 1:5){
            print(numbers[i])
        }
        ```

- Walk through this again
    - i is an *increment variable*, keeps track of where we are
    - `1:10` returns a sequence

-   The loop or increment variable is just a variable.  
-   Overwrites previous variable, and when the loop finishes, it's the last loop
-   <span></span>

    ```
    letter <- "z"
    print(letter)
    for (letter in c("a", "b", "c")) {
        print(letter)
    }
    print(letter)
    ```

***---------- Socrative #2 ----------***: For loop to calculate sum of vector

-   <span></span>

    ```
    numbers <- c(4, 8, 15, 16, 23, 42)
    running_sum = 0
    for (number in numbers) {
         running_sum = running_sum + number
    }
    print(running_sum)
    ```

- The loop variable can be useful to us
    -   <span></span>

        ```
        for(i in 1:10){
            print(gap$year[i])
        }
        ```

    -   Instead of 10, I could use `nrow(gap)`


### Nesting For loops

- For loops can also be nested
    -   <span></span>

        ```
        # First for loop
        for(i in 1:3){

        	# Second for loop
            for(j in c('a', 'b', 'c')){
                print(paste(i, j))
            } # End of second

        } # End of first
        ```
    -   Gives me every combination.  Notice the order of nesting matters


***---------- Socrative #3 ----------***: For loop to find years with life expectancy < 35

-   <span></span>

    ```
    for (i in 1:10) {
         if (gap$lifeExp[i] < 35) {
              print(gap$year[i])
         }
    }
    ```

- We could extend this to the whole dataset, and have it tell us the country too
    -   <span></span>

        ```
        for (i in 1:nrow(gap)) {
             if (gap$lifeExp[i] < 35) {
                  print(paste(gap$country[i], gap$year[i]))
             }
        }
        ```

### While Loops (5 minutes, optional)

- Sometimes we need to just keep doing something until a certain condition is met
- Break R with a While loop, stop the script

    -   <span></span>

        ```
		z <- 1
		while (z > 0.1) {
		    print(z)
		}
        ```

- Let's fix it by updating z, so it has a chance to quit
	- `runif()` is used to pick a random number between zero and 1
    -   <span></span>

        ```
        runif(1)
		z <- 1
		while (z > 0.1) {
			z <- runif(1)
		    print(z)
		}
        ```



## 3. Creating and using functions (30 minutes)

**QUESTION: How many of you end up doing the same thing more than once while analyzing your data?**

-   Functions package a bit of code we want to re-use so that we don't have to re-write it or remember how it works later
-   Almost like little programs in the shell
-   Often, the function will take some variables as arguments and return something back to us (but doesn't have to)
-   We've actually been using them all along!
    -    `read.csv()` is a function.  We give it a filename and it gives us a dataframe
    -    Do any of you know what it actually does?
    -    Show that we can actually see the code (wrapper for read.table())
-   <span></span>

    ```
    fahr_to_kelvin <- function(temp) {
        kelvin <- ((temp - 32) * (5 / 9)) + 273.15
        return(kelvin)
    }

    # Without running previous code: 
    fahr_to_kelvin(32)
    ```

- Function code must be run before it's called
- Freezing point
    -    `fahr_to_kelvin(32)`
- Boiling point
    -    `fahr_to_kelvin(212)`

- We can make another function to convert to Celsius
    -   <span></span>
    
        ```
        kelvin_to_celsius <- function(temp) {
            celsius <- temp - 273.15
            return(celsius)
        }
        
        kelvin_to_celsius(0)
        ```

-   Variable Scope: Variables defined inside functions stay there, a function is it's own little box/environment
-   Pass-by-Value: Functions don't change the variables we give them either (usually), we work on a copy.  Safer!
    -   `print(celsius)`

***---------- Socrative #4 ----------***: Testing variable scope

Both B and D are correct.  

-   Defensive programming: notice how we used a different name for the output of the function = better

-   We can mix, match and combine functions with themselves to get larger chunks of code
    -   <span></span>

        ```
        fahr_to_celsius <- function(temp) {
            temp_k <- fahr_to_kelvin(temp)
            temp_c <- kelvin_to_celsius(temp_k)
            return(temp_c)
        }

        # freezing point of water in Celsius
        fahr_to_celsius(32.0)
        ```

-   Another way to do this would be to nest the first two functions together (walk through this)
    -   `kelvin_to_celsius(fahr_to_kelvin(32.0))`

   
***---------- Socrative #4 ----------***: Write a C to F function

-   <span></span>

    ```
    celsius_to_fahr <- function(temp){
      fahr <- temp * 9 / 5 + 32
      return(fahr)
    }

    celsius_to_fahr(100)
    ```


### Function Challenge
Now write a function that takes two arguments: one the temp to be converted, and another that says whether to convert from fahrenheit to celsius or celsius to fahrenheit.  Using if...then, make the same function do both.

- `tempconvert(temp = 14, to = "fahrenheit")`
    -   <span></span>

        ```
        tempconvert <- function(temp, to) {
             if (to == "fahrenheit") {
                  converted = temp * 9 / 5 + 32
             } else if (to == "celsius") {
                  converted = (temp - 32) * (5 / 9)
             }
             return(converted)
        }

        tempconvert(100, "fahrenheit")
        tempconvert(212, "celsius")
        ```

-   What happens if we capitalize celsius?: `tempconvert(212, "Celsius")`
    -   Good idea to try to forsee ways that things might break
    -   adding an "else" is a good idea:

        -   <span></span>

            ```
            else {
                converted = NA
                print("Error: 'to' was not fahrenheit or celsius")
            }
            ```

    -   Note that we need to re-run the function code for the changes to take effect!
-   When you write a function like this, you often don't use it again until months later.  
-   Or someone else needs to use it.  
    -   So it's a good idea to add documentation!
        1.  What does the function do?  
        2.  What are it's arguments?
        3.  What does it return?
-   We can also add a default value for some of the arguments, so we don't need to include them unless we want to
    -   <span></span>

        ```
        tempconvert <- function(temp, to = "celsius") {
            # Converts a temperature from celsius to fahrenheit
            #   or from fahrenheit to celsius.
            # Takes a temperature and the desired unit as arguments
            # Returns the converted temperature
            # Example: tempconvert(212, "celsius") => 100

        tempconvert(212)
        ```


### Advanced Functions

- Make a function that calculates gdp of a nation from gapminder
    -   Function should take a dataset with pop and gdpPercap columns and return a vector of gdps
    -   <span></span>

        ```
		# Takes a dataset and multiplies the population column
		# with the GDP per capita column.
		calcGDP <- function(dat) {
		  gdp <- dat$pop * dat$gdpPercap
		  return(gdp)
		}

		calcGDP(head(gapminder))
        ```

- A more useful version edits the dataset
    -   <span></span>

        ```
		calcGDP <- function(dat, year=NULL, country=NULL) {
		  if(!is.null(year)) {
		    dat <- dat[dat$year %in% year, ]
		  }
		  if (!is.null(country)) {
		    dat <- dat[dat$country %in% country,]
		  }
		  gdp <- dat$pop * dat$gdpPercap
		  new <- cbind(dat, gdp=gdp)
		  return(new)
		}

		head(calcGDP(gapminder, year=2007))

		calcGDP(gapminder, country="Australia")

        ```

- Lots going on here
	- Optional arguments
	- Checking arguments and defensive programming
	- Subsetting the dataset
	- Adding a column with cbind


## 4. Subsetting and reshaping data with dplyr and tidyr

-   Now we're going to switch gears!
-   We have a grasp of basic programming in R
-   Most of our work here is 3 things: data wrangling, graphs, and analyses
-   We'll cover the first two, since the same stuff applies to everyone

-   The subsetting and data-wrangling tools bundled with R are not the best
-   We're going to use dplyr and tidyr instead.

### dplyr

-   Setup
-   Install packages
    -   `install.packages(c("tidyr", "dplyr", "knitr", "rmarkdown", "formatR"))`
    -   `library(dplyr)`
-   Select lets you only use some columns.  You can also re-order them
    -   <span></span>

        ```
        head(gap)
        yr_country_gdp <- select(gap, year, country, gdpPercap)
        head(year_country_gdp)
        ```


-   Select lets us subset columns, but what if we want to subset rows?  filter() does that

    -   <span></span>

        ```
        str(gap)
        gap_eu <- filter(gap, continent == "Europe")
        str(gap_eu)
        ```

-   We can stack these functions to do both

    -   <span></span>

        ```
        yr_country_gdp_eu <- filter(select(gap, year, country, gdpPercap), 
            continent=="Europe")
        ```

- This stacking can quickly become difficult to read, we really want a workflow that's easy to follow
    -   dplyr also can use an R version of pipes, like what we saw in the shell lesson
        -   `yr_country_gdp <- gap %>% select(year, country, gdpPercap)`
        -   You don't have to bother giving it the data argument anymore.  Easier to read

    -   <span></span>

        ```
        yr_country_gdp_eu <- gap %>%
            filter(continent=="Europe") %>%
            select(year,country,gdpPercap)
        ```

    -   Walk through this example, showing the flow


***---------- Socrative #1 ----------***: Filter using 2 filters and select 3 cols

Write a command with pipes that filters the gapminder dataset to only include data from 2007 in Africa, and then select the year, country, and lifeExp columns. 

How many rows are left in the resulting dataset? If you're not sure how to find the number of rows, discuss with your neighbors.

-   <span></span>

    ```
    africa_07_lifeExp %
        filter(continent == "Africa") %>% 
        filter(year == 2007) %>%
        select(year, country, lifeExp)

    nrow(africa_07_lifeExp)

    africa_07_lifeExp %
        filter(continent == "Africa", year == 2007) %>% 
        select(year, country, lifeExp)

    str(africa_07_lifeExp)
    ```

    -   Note that the order is really important!  Since select removes continent, it has to come second
    -   We could have used two filter commands instead

-   Summarize lets us condense data down
    -   `mean_gdp <- gap %>% summarize(meanGDP = mean(gdpPercap))`
-   Not very useful by itself, we could have used this instead
    -   `mean(gap$gdpPercap)`
-   But if we combine it with the group_by() function, we can get the mean gdp for each continent
    -   <span></span>

        ```
        gdp_by_cont <- gap %>%
            group_by(continent) %>%
            summarize(mean_gdp = mean(gdpPercap))

        gdp_by_cont
        ```

-   Here we're grouping by continent, which means we calculate a **separate** mean for each one


***---------- Socrative #2 ----------***: Avg lifeExp by year for Africa

Let's compute the average life expectancy across all African countries by year. In how many years did average African life expectancy decrease?

-   <span></span>

    ```
    africa_lifeExp_yr <- gap %>%
        filter(continent == "Africa") %>%
        group_by(year) %>%
        summarize(avg_life = mean(lifeExp))
         
    africa_lifeExp_yr
    ```

-   What if we wanted to create a new column for gdp per billion people w/o condensing our data down?  Use mutate()

    -   <span></span>

        ```
        bill_gdp_country_07 <- gap %>%
            filter(year == 2007) %>%
            mutate(billion_gdp = gdpPercap * pop / 10^9) %>%
            select(continent, country, billion_gdp)

        head(bill_gdp_country_07)
        ```

-   We can group multiple variables and summarize multiple things

    -   <span></span>

        ```
        gdp_by_cont <- gap %>%
            group_by(continent, year) %>%
            summarize(mean_gdp = mean(gdpPercap), 
                sd_gdp = sd(gdpPercap), 
                mean_pop = mean(pop), 
                sample_size = n(),
                se_gdp = sd_gdp / sqrt(sample_size))

        gdp_by_cont
        ```

    -   n() is a special function that gives the sample size for that grouping, very useful
    -   Notice that we only see 10 rows.  Summarize actually has returned a "special" table-dataframe
    -   In most cases it acts the same, but if we want to see the whole thing, we can pipe it to data.frame()
        -   `gdp_by_continents %>% data.frame()`

-   We can combine dplyr and ggplot2

    -   <span></span>

        ```
        gap %>% filter(continent == "Americas") %>%
            ggplot(aes(x = year, y = lifeExp, color = country)) + 
            geom_line() + 
            geom_point()
        ```

- One of the reasons we like dplyr so much, is there's not a lot to remember.
    - Most of your work can be done with the 5 functions we just learned
        - `select(), filter(), group_by(), summarize(), and mutate()`


### tidyr

-   Setup
    -   `install.packages("tidyr")`
    -   `library(tidyr)`

-   The same dataset can be represented in different ways
-   Wide format: 
    -   <span></span>

        ```
        Genus   Weight  Length
        Ursus   122     82
        Felis   5       14
        ```

-   Long format: 
    -   <span></span>

        ```
        Genus   Measurement     Value
        Ursus   Weight          122
        Ursus   Length          82
        Felis   Weight          5
        Felis   Length          14
        ```

-   In long format, each column is a variable and each row is a single measurement or observation
-   We tend to use wide format more because it's more concise, easy to ready, datasheety
-   R, databases, and other programming languages usually prefer long format

***---------- Socrative #3 ----------***: What format is the gap dataset

Answer: intermediate

-   We could have a column for each year * pop/lifeExp/gdpPerCap
-   We have 3 ID columns (country, continent, year), and 3 observation columns (gdpPercap, lifeExp, pop) (instead of 1)
    -   Important to be able to convert, some R tools need specific format

-   <span></span>

    ```
    gap_wide <- read.csv("data/gapminder_wide.csv", stringsAsFactors = FALSE)
    str(gap_wide)
    ```

    -   So this is the wide format of our data
    -   Notice it's got lots of columns and only 142 rows, one for each country
-   We're going to convert it to long format with gather()

    -   <span></span>

        ```
        gap_long <- gap_wide %>%
             gather(obstype_year, obs_values, starts_with('pop'),
                    starts_with('lifeExp'), starts_with('gdpPercap'))
        str(gap_long)
        head(gap_long)
        ```

-   Notice how we've mixed dplyr pipes with the gather() function from tidyr
-   The first two arguments are new column names: The old column name goes in 1st & value in 2nd
-   Instead of using starts_with(), we could have just written out all the columns we wanted to gather
-   We could also just exclude the columns we don't want to gather

    -   <span></span>

        ```
        gap_long <- gap_wide %>% 
            gather(obstype_year, obs_values, -continent, -country)
        str(gap_long)
        ```

- Our new column obstype_year actually has 2 pieces of information.  We should separate them
    -   <span></span>

        ```
        gap_long <- gap_long %>% 
             separate(obstype_year, into = c('obs_type', 'year'), sep = "_") %>%
             mutate(year = as.integer(year))
        ```


***---------- Socrative #4 ----------***: Use dplyr on the long dataset

Using gap_long, summarize the mean life expectancy by continent

-   <span></span>

    ```
    gap_long %>%
        filter(obs_type == "lifeExp") %>%
        group_by(continent) %>%
        summarize(lifeExp = mean(obs_values))
    ```


-   Now that we have our long format, let's convert it to the intermediate format
    -   <span></span>

        ```
        gap_normal <- gap_long %>% 
            spread(obs_type, obs_values)
        head(gap_normal)
        dim(gap_normal)
        dim(gap)
        ```

-   Notice how the contents of obs_type became the column names
-   Looks like the same dataset, cool, we're back
-   Columns are in a different order though, let's fix that
    -   <span></span>

        ```
        names(gap_normal)
        names(gap)
        gap_normal <- gap_normal %>%
            select(country, year, pop, continent, lifeExp, gdpPercap)
        names(gap_normal)
        ```

-   Let's see if they're equal.  Not so good, they're sorted differently
    -   <span></span>

        ```
        all_equal(gap_normal, gap)
        head(gap_normal)
        head(gap)
        ```

-   The new dataset is sorted first by continent, gap was by country
    -   <span></span>

        ```
        gap_normal <- gap_normal %>% 
            arrange(country, continent, year)

        all.equal(gap_normal, gap)
        head(gap_normal)
        head(gap)
        ```

    -   Arrange is a dplyr function
    -   Defensive programming: It's a good idea to do checks all the time (like all_equal)

-   Ok, now let's go back to wide
-   Remember, we used gather() to put all the columns together, and then separate() to split the year from the variable
-   So we just have to do the opposite in reverse order
    -   <span></span>

        ```
        gap_wide_new <- gap_long %>% 
            unite(var_names, obs_type, year, sep = "_") %>%
            spread(var_names, obs_values)
        str(gap_wide_new)
        ```

- Just like dplyr, tidyr is nice because it's only a few functions
    - We can go from wide to long and back, and combine or split columns with 4 functions
        - `gather(), spread(), separate(), unite()`

### Resources:

-   Rstudio cheatsheets: [https://www.rstudio.com/resources/cheatsheets/](https://www.rstudio.com/resources/cheatsheets/)
-   Package documentation: [https://rdrr.io/cran/dplyr/](https://rdrr.io/cran/dplyr/), [https://rdrr.io/cran/tidyr/](https://rdrr.io/cran/tidyr/)
-   R Cookbook: [http://www.cookbook-r.com/Manipulating_data/](http://www.cookbook-r.com/Manipulating_data/)
-   Data Wrangling Webinar: [https://www.rstudio.com/resources/webinars/data-wrangling-with-r-and-rstudio/](https://www.rstudio.com/resources/webinars/data-wrangling-with-r-and-rstudio/)


## 5. Plotting and creating publication-quality graphics (60 minutes)

-   Now we're going to switch gears!
-   We have a grasp of basic programming in R
-   Most of our work here is 3 things: data wrangling, graphs, and analyses
-   We'll cover the first two, since the same stuff applies to everyone

**Question: How many of you have made a plot in R?  How many of you have used ggplot?**

-   R has a few different ways to plot things.  
-   It comes with a basic plotting package, but most people don't use this anymore, it's harder to modify
    -   `plot(x = gap$gdpPercap, y = gap$lifeExp)`
-   Show how to zoom a graph in Rstudio
-   A better option is ggplot2, which is more flexible, build plots in layers (kinda like photoshop)
    -   `install.packages(c("tidyr", "dplyr", "knitr", "rmarkdown", "formatR"))`
    -   `library(ggplot2)`
-   Grammar of graphics: Every plot is a dataset, a coordinate system, and a set of layers that are the visual representation
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = gdpPercap, y = lifeExp)) +
            geom_point()
        ```

-   First we load ggplot2
-   Then we call ggplot, all the options in here apply to all layers (aes maps the data)
    -   ggplot is smart enough to look for those columns in the data we gave it, no need to subset
    -   If we stop here we don't get a graph
    -   `ggplot(data = gap, aes(x = gdpPercap, y = lifeExp))`
    -   So finally, we add a points (scatterplot) layer called a geometry
  
***---------- Socrative #1 ----------***: Modify a ggplot graph

-   `ggplot(data = gap, aes(x=year, y=lifeExp)) + geom_point()`

-   Using a scatterplot probably isn't a good way to show change over time.
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = year, y = lifeExp, 
            by = country, color = continent)) +
            geom_line()
        ```

-   We're using a line geometry instead of a points geometry now
-   the **by** aesthetic draws a line for each country, and then we color each continent differently.
-   **Question: What if we wanted the points on the graph too?**
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = year, y = lifeExp, 
            by = country, color = continent)) +
            geom_line() + 
            geom_point()
        ```

-   Layers get drawn on top of each other
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = year, y = lifeExp, by = country)) +
            geom_line(aes(color = continent)) + 
            geom_point()
        ```

-   Here we've switched the color aesthetic from global to just the lines
-   If we want to set everything on a geometry to the same color, we set it outside the aesthetic function
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = year, y = lifeExp, by = country)) +
            geom_line(aes(color = continent)) + 
            geom_point(color = "blue")
        ```

-   Let's go back to our first example, but color the points by continent
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = gdpPercap, y = lifeExp, color = continent)) +
            geom_point()
        ```

- Hard to see relationship with all those outliers, so let's use a log scale
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = gdpPercap, y = lifeExp)) +
            geom_point(alpha = 0.5) + 
            scale_x_log10()
        ```

-   Notice the data has been transformed before graphing, x axis reflects this (1,000, 10,000, 100,000)
-   Here we also use transparency so that overlapping points are easier to see.  This works with any geometry.  We could also set this to use a data column inside aes()

-   We can fit a simple linear regression line (linear model) using a geom_smooth geometry
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = gdpPercap, y = lifeExp)) +
            geom_point() + scale_x_log10() + geom_smooth(method="lm")
        ```

-   It even gives us a confidence interval!  We can make the line thicker using size
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = gdpPercap, y = lifeExp)) +
            geom_point() + scale_x_log10() + geom_smooth(method="lm", size=1.5)
        ```

***---------- Socrative #2 ----------***: Color by continent & add separate trends

-   <span></span>

    ```
    ggplot(data = gap, aes(x = gdpPercap, y = lifeExp, color = continent)) +
        geom_point(size = 1.5) +
        scale_x_log10() +
        geom_smooth(method="lm")
    ```

-   Many peope are colorblind.  In addition to color, it's a good idea to also use shape
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = gdpPercap, y = lifeExp, color = continent)) +
            geom_point(size = 2, aes(shape = continent)) + 
            scale_x_log10() + 
            geom_smooth(method="lm")
        ```

-   Let's clean it up for publication.  We'll add nicer axis labels, a title, and change the y-axis and theme
    -   <span></span>

        ```
        ggplot(data = gap, aes(x = gdpPercap, y = lifeExp, color = continent)) +
            geom_point(size = 2, aes(shape = continent)) + 
            scale_x_log10() + 
            geom_smooth(method="lm") + 
            scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, by = 10)) + 
            theme_bw() + 
            labs(title = "Effects of per-capita GDP on Life Expectancy", 
                 x = "GDP per Capita ($)", 
                 y = "Life Expectancy (yrs)", 
                 color = "Continents", 
                 shape = "Continents")
        ```

-   Now we have this graph, but we want to save it!
    -   Rstudio has an export button: pdf, image, or to clipboard, lets you change size
        -   The problem with this is that it's not reproducible.  You fiddle with the size, but then months from now you need to change something
    -   Better to do it programmatically
        -   `ggsave(file = "life_expectancy.png")`
        -   `ggsave(file = "life_expectancy.pdf")`

***---------- Socrative #3 ----------***: Optional ggsave & ggplot variables
- ggsave will overwrite the graph

### Facets (if time permits)

-   <span></span>

    ```

    ggplot(data = gap, aes(x = gdpPercap, y = lifeExp, color = continent)) + 
        facet_wrap(~ year) + 
        geom_point(size = 2, aes(shape = continent)) + 
        scale_x_log10() +
        geom_smooth(method = "lm")
    ```

### Alternate: Facets with dplyr (if time permits)

-   <span></span>

    ```
    L.countries <- gap %>% 
        filter(country %in% c("Lebanon", "Lesotho", "Liberia", "Libya"))

    L.countries

    ggplot(L.countries, aes(x = year, y = lifeExp, color = country)) + 
        geom_line() + facet_wrap( ~ country)
    ```
  
-   Draws a panel for each unique value in that column

### GGplot2 Challenge #2: write a function that takes vector of countries & creates faceted graph

-   <span></span>

    ```
    lifeExp_country <- function(data, countries) {
         country_subset <- data %>%
              filter(country %in% countries)
         ggplot(country_subset, aes(x = year, y = lifeExp, color = country)) + 
              geom_line() + facet_wrap( ~ country)
    }

    lifeExp_country(gap, c("Ethiopia", "Australia", "Canada"))
    ```

-   Cover cowplot: 
    -   `library(cowplot)`
    -   Nicer quality than default ggplot, it's a theme
    -   Also provides a way to merge two plots into one, eg A & B figures, and annotations

-   Themes
    - Text size

        -   <span></span>

            ```
            theme(
                # Text size for axis ticks
                axis.text.y = element_text(size = 14),
                axis.text.x = element_text(size = 14),
                
                # Text size for axis labels
                # Also move them away from the axes a bit for more space
                axis.title.x = element_text(size = 18, face = "bold", vjust = -1),
                axis.title.y = element_text(size = 18, face = "bold", vjust = 1.5),
                
                # Plot title size, move away from plot
                plot.title = element_text(size = 20, face = "bold", vjust = 5)
                )
            ```

    - Adjust the legend

        -   <span></span>

            ```
            theme(
                # Text size
                legend.text = element_text(size = 14),
                legend.title = element_text(size = 16, face = "bold"),

                # Position
                legend.position = c(x = 0.8, y = 0.2)
                )
            ```

### GGplot2 Challenge #2: 

-   Create a boxplot showing the spread of life expectancy for each continent

    -   <span></span>

        ```
        ggplot(data = gap, aes(x = continent, y = lifeExp)) + 
           geom_boxplot() + 
           geom_jitter(width = 0.2, alpha = 0.5, color = "tomato")

        ggplot(data = gap, aes(x = continent, y = lifeExp)) + 
            geom_boxplot() + 
            geom_jitter(width = 0.2, alpha = 0.5, size = 2, 
                aes(color = factor(year)))
        ```

### GGplot2 Challenge #3: 

-   Create a grouped barplot showing life expectancy by year for each continent

    -   <span></span>

        ```
        ggplot(data = gap, aes(x = continent)) + 
            geom_bar()

        ggplot(data = gap, aes(x = continent, y = lifeExp, fill = factor(year))) + 
            geom_bar(stat = "summary", fun.y = "mean", position = "dodge")
        ```


### Resources

-   R Graph catalog: [http://shiny.stat.ubc.ca/r-graph-catalog/](http://shiny.stat.ubc.ca/r-graph-catalog/)
-   GGPlot2 online help: [http://docs.ggplot2.org/]()
-   R Graph Cookbook: [http://www.cookbook-r.com/Graphs/](http://www.cookbook-r.com/Graphs/)
-   ggplot2 essentials: [http://www.sthda.com/english/wiki/ggplot2-essentials](http://www.sthda.com/english/wiki/ggplot2-essentials)
-   Rstudio cheatsheets: [https://www.rstudio.com/resources/cheatsheets/](https://www.rstudio.com/resources/cheatsheets/)
-   Cowplot: [https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html)



## 6. Producing reports and notebooks with knitr (20 minutes)

**Question: How many of you could just send your code to your advisor or collaborator?**

-   We often need to put this stuff in a presentable format: word, powerpoint, email, etc.
-   Then we need to change a graph, and update our presentation
-   We can do this all in one step, with less work by having R handle it.  It's also easier to reproduce.
-   We'll do this with an R notebook, which will give us a single html file with all the code, data, graphs, and our notes.  We can upload this online, show it as a presentation, or send it to someone.  
-   Basically a fancy lab notebook!

-   Create a new R notebook and save it.  
    -   Talk about the header chunk
    -   Explain code chunks
        -   Run the graph code
        -   Add a new chunk with `head(cars, 30)` and run it
        -   Show how to switch between inline and console, explain inline usefulness
    -   Click preview to see the html
    -   Show where the file is saved
-   Notice how we got some nice formatted text.  This is using something called markdown
    -   [http://rmarkdown.rstudio.com](http://rmarkdown.rstudio.com)
    -   Demo
        -   headings `### Heading`
        -   bullets `* Bullet or - Bullet`
        -   numbered lists `1. list`
        -   bold `**bold**`
        -   italic `*italic*`
        -   links `[Software Carpentry](http://software-carpentry.org/)`

***---------- Socrative ----------***: R Notebook Challenge

Modify your R notebook to load the data from gap, show the first 10 lines, and display a graph.  
Give each R code section a heading and short summary.
    -   <span></span>

        ```
        ## Reading & Displaying Data

        This chunk reads in the gap dataset and shows the first 10 lines

        ``{r}
        gap <- read.csv("data/gapminder-data.csv")
        head(gap, 10)
        ``

        ## Graph Gap Dataset

        This chunk shows a graph

        ``{r}
        library(ggplot2)
        ggplot(data = gap, aes(x = gdpPercap, y = lifeExp)) + 
          geom_point()
        ``
        ```

-   Variables are shared between chunks
    -   Add a variable to a chunk and print it in another
-   You could also knit to a word file instead.  Or pdf, though this requires some extra setup
-   You can publish stuff to the internet, and run code from other languages, eg bash shell and python. 
-   There's a format to publish reports to github

    -   <span></span>

        ```
        github_document:
            toc: yes
            toc_depth: 5
        ```

    - You can name chunks, and control output for graphs

    -   <span></span>

        ```
        {r "test_graph", fig.height = 6, fig.width = 8, dpi = 300}
        ```


## 7. Writing good software (5 Minutes)

-   It's really easy to be in a hurry and just quickly write the code for a graph or an analysis with no commentary on how the code works or the results you got!
    -   This will come back to bite you!
    -   You'll end up re-spending hours trying remember how something works.  

-   Readable code is super important!
    -   We often collaborate
    -   We often do analyses and then come back a year later (when writing thesis)
-   Rules of thumb
    -   Indent code inside loops, functions, and if statements
    -   Use good variable & function names and don't overwrite variables
    -   Use lots of comments to explain what lines of code do
    -   There's an R style guide: [http://style.tidyverse.org](http://style.tidyverse.org)
        -   Preferences > Code > Diagnostics, gives you tiny warnings to enforce
-   Break down problems into bite-sized pieces and keep things modular
    -   e.g. using functions, or even separate files.  
    -   I like to have an R script to get my data from csv ready for analysis
        -   Then I can just pull this in to different analyses I do.
-   Don't repeat yourself!  
    -   Re-use code, build functions, use loops
-   Always be thinking of ways your code might break
    -   Anticipate those failures and leave messages to yourself with if statements
    -   Test your functions over different inputs to make sure they always work.

-   I like to print out `sessionInfo()` in my R Notebooks so I know what package versions I used
    -   Mention `packrat` 



## 8. Using Git from RStudio (15 minutes)

-   Setup RStudio to use git
    -   In RStudio, click on Tools > Global Options... > Git/SVN
    -   Make sure there's a git executable listed there. If not, browse for it, or ask for help
    -   Make sure the grey box under "SSH RSA Key" shows a file name and a "View public key" link exists next to it.
        - Clicking on "View public key" opens a window opens which is not blank.  
    -   If the "SSH RSA Key" box is blank, click "Create RSA key..." and leave the optional Passphrase blank and click "Create".

-   Setup the Project with a git repository
    -   Go to Tools > Project Options > Git/SVN
    -   Set version control system to Git, and allow RStudio to initialize repository

-   Now we have a git tab: Explore the interface
    -   Check the boxes on some files (**stage**)
    -   Commit, and add a message. Notice it shows a diff
    -   Make some changes to a file and save
    -   Show how to diff and how to revert
    -   Click the history button to see the history

-   Syncing with GitHub
    -   We have push and pull buttons, but they're grayed out
    -   To enable them, we need to add a remote
    -   Go to Tools > Terminal > New Terminal or Git > Gear > Shell

    -   <span></span>

        ```
        git remote add origin https://github.com/mickley/rstudio-test.git
        git push -u origin master
        ```

