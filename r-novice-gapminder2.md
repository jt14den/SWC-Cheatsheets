---
title: R Novice Gapminder #2
subtitle: R for Reproducible Scientific Analysis Part 2
...

## Pre-Workshop Setup ##

-   Load the gapminder dataset
    -   `gapminder <- read.csv("data/gapminder-FiveYearData.csv")`
-   Install packages
    -   `install.packages(c("ggplot2", "cowplot", "tidyr", "dplyr"))`

-   <span></span>

    ```

    ```

    -   <span></span>

        ```

        ```

### Open up Socrative again ###
-   You can import my quiz with 
-   Advise learners to go to <https://b.socrative.com/login/student/>
-   Type in MICKLEY for the room name


**QUESTION: How many of you end up doing the same thing more than once while analyzing your data?**

***---------- Socrative #1 ----------***

## 1. Creating and using functions
-   Functions package a bit of code we want to re-use so that we don't have to re-write it or remember how it works later
-   Often, the function will take some variables as arguments and return something back to us (but doesn't have to)
-   We've actually been using them all along!
    -    `read.csv()` is a function.  We give it a filename and it gives us a dataframe
    -    Do any of you know what it actually does?
-   <span></span>

    ```
    fahr_to_kelvin <- function(temp)
      kelvin <- ((temp - 32) * (5 / 9)) + 273.15
      return(kelvin)
    }

    # Without running previous code: 
    fahr_to_kelvin(32)
    ```

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

***---------- Socrative #1 ----------***


-   Defensive programming: notice how we used a different name for the output of the function = better

-   We can mix, match and combine functions with themselves to get larger chunks of code
    -   <span></span>

        ```
        fahr_to_celsius <- function(temp) {
          temp_k <- fahr_to_kelvin(temp)
          result <- kelvin_to_celsius(temp_k)
          return(result)
        }

        # freezing point of water in Celsius
        fahr_to_celsius(32.0)
        ```

-   Another way to do this would be to nest the first two functions together (walk through this)
    -   `kelvin_to_celsius(fahr_to_kelvin(32.0))`
   
### Challenge

-   Write a function to convert celsius to fahrenheit
-   Write a function to calculate GDP from our dataset
    -   Function should take a dataset with pop and gdpPercap columns and return a vector of gdps
    -   <span></span>

        ```
        # Takes a dataset and multiplies the population column
        # with the GDP per capita column.
        calcGDP <- function(dat) {
          gdp <- dat$pop * dat$gdpPercap
          return(gdp)
        }
        ```






   
### Centering data

-   In stats, especially regression, it's useful to center data
-   Say we regress population against year with our dataset.  
-   We'll get a y-intercept for 0 AD.  This is useless!  We don't care about that!
-   If we shifted our data so that a year of interest was the y-intercept, we'll get the mean population for that year.
    -   Demonstrate on whiteboard
-   To center around 0, we just subtract the mean from all the data points.  eg: `c(1, 2, 3)` --> `c(-1, 0, 1)`
-   To center around a different number (say 1960), we subtract the mean, and then add that number
   


### Challenge

-   Write a function called center() to center data around a particular number
-   Should take two arguments, a vector called data, and a number to center around called desired
-   Return the centered vector
    -   <span></span>

        ```
        center <- function(data, desired) {
            new_data <- (data - mean(data)) + desired
            return(new_data)
        }
        ```

-   Test your function first on made-up data to make sure it works
    -   <span></span>

        ```
        test <- c(0, 0, 0, 0)
        test
        center(test, 3)
        ```

-   It looks like it works, so let's try on our data and store as a separate column
    -   `dat$year_centered <- center(dat$year, 1990)`
    -   **TODO: check if this works!**

-   When you write a function like this, you often don't use it again until months later.  Or someone else needs to use it.  
-   So it's a good idea to add documentation!
-   We can also add a default value for some of the arguments, so we don't need to include them unless we want to
-   <span></span>

    ```
    center <- function(data, desired = 0) {
    # Centers data around zero or a specified value
    # Takes a vector and the desired center as arguments
    # Returns a new vector containing the original data 
    # centered around the desired center
    # Example: center(c(1, 2, 3), 0) => c(-1, 0, 1)
    new_data <- (data - mean(data)) + desired
    return(new_data)
    }
      
    center(c(1,2,3,4,5,6))
    ```

-   Specifically, we want to say: 
    1.  What does the function do?  
    2.  What are it's arguments?
    3.  What does it return?
-   Note that we need to re-run the function code for the changes to take effect!





    
    

## 2. Loops and conditional statements



## 3. Plotting and creating publication-quality graphics

**Question: How many of you have made a plot in R?  How many of you have used ggplot?**

-   R has a few different ways to plot things.  
-   It comes with a basic plotting package, but most people don't use this anymore, it's harder to modify
    -   `plot(x = dat$gdpPercap, y = dat$lifeExp)`
-   Show how to zoom a graph in Rstudio
-   A better option is ggplot2, which is more flexible, build plots in layers (kinda like photoshop)
    -   `install.packages("ggplot2")`
    -   `library(ggplot2)`
-   Grammar of graphics: Every plot is a dataset, a coordinate system, and a set of layers that are the visual representation
    -   <span></span>

        ```
        library("ggplot2")
        ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
          geom_point()
        ```

-   First we load ggplot2
-   Then we call ggplot, all the options in here apply to all layers (aes maps the data)
    -   ggplot is smart enough to look for those columns in the data we gave it, no need to subset
    -   If we stop here we don't get a graph
    -   `ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp))`
    -   So finally, we add a points (scatterplot) layer called a geometry
  
***---------- Socrative #??? ----------***

-   Modify the graph to show how life expectancy has changed over time
    -   `ggplot(data = gapminder, aes(x = year, y = lifeExp)) + geom_point()`

-   Using a scatterplot probably isn't a good way to show change over time.
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = year, y = lifeExp, 
            by = country, color = continent)) +
            geom_line()
        ```

-   We're using a line geometry instead of a points geometry now
-   the **by** aesthetic draws a line for each country, and then we color each continent differently.
-   **Question: What if we wanted the points on the graph too? **
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = year, y = lifeExp, 
            by = country, color = continent)) +
            geom_line() + 
            geom_point()
        ```

-   Layers get drawn on top of each other
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country)) +
            geom_line(aes(color = continent)) + 
            geom_point()
        ```

-   Here we've switched the color aesthetic from global to just the lines
-   If we want to set everything on a geometry to the same color, we set it outside the aesthetic function
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country)) +
            geom_line(aes(color = continent)) + 
            geom_point(color = "blue")
        ```

-   Let's go back to our first example, but color the points by continent
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
            geom_point()
        ```

- Hard to see relationship with all those outliers, so let's use a log scale
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
            geom_point(alpha = 0.5) + 
            scale_x_log10()
        ```

-   Notice the data has been transformed before graphing, x axis reflects this (1,000, 10,000, 100,000)
-   Here we also use transparency so that overlapping points are easier to see.  This works with any geometry.  We could also set this to use a data column inside aes()

-   We can fit a simple linear regression line (linear model) using a geom_smooth geometry
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
            geom_point() + scale_x_log10() + geom_smooth(method="lm")
        ```

-   It even gives us a confidence interval!  We can make the line thicker using size
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
            geom_point() + scale_x_log10() + geom_smooth(method="lm", size=1.5)
        ```

***---------- Socrative #??? ----------***

-   Many peope are colorblind.  In addition to color, it's a good idea to also use shape
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
            geom_point(size = 2, aes(shape = continent)) + 
            scale_x_log10() + 
            geom_smooth(method="lm")
        ```

-   Let's clean it up for publication.  We'll add nicer axis labels, a title, and change the y-axis and theme
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
            geom_point(size = 2, aes(shape = continent)) + 
            scale_x_log10() + 
            geom_smooth(method="lm") + 
            scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, by = 10)) + 
            theme_bw() + 
            ggtitle("Effects of per-capita GDP on Life Expectancy")
            xlab("GDP per Capita ($)") + 
            ylab("Life Expectancy (yrs)")
        ```

-   Now we have this graph, but we want to save it!
    -   Rstudio has an export button: pdf, image, or to clipboard, lets you change size
        -   The problem with this is that it's not reproducible.  You fiddle with the size, but then months from now you need to change something
    -   Better to do it programmatically
        -   `ggsave(file = "life_expectancy.png")`
        -   `ggsave(file = "life_expectancy.pdf")`

***---------- Socrative #??? ----------***
  
-   Facets (if time permits)
    -   <span></span>
    
        ```
        starts.with <- substr(gapminder$country, start = 1, stop = 1)
        az.countries <- gapminder[starts.with %in% c("A", "Z"), ]
        ggplot(data = az.countries, aes(x = year, y = lifeExp, color=continent)) +
        geom_line() + facet_wrap( ~ country)
        ```

    -   <span></span>
    
        ```
        L.countries <- gapminder %>% 
            filter(country %in% c("Lebanon", "Lesotho", "Liberia", "Libya"))

        L.countries

        ggplot(L.countries, aes(x = year, y = lifeExp, color = country)) + 
            geom_line() + facet_wrap( ~ country)
        ```
  
-   Draws a panel for each unique value in that column

-   Cover cowplot: 
    -   `library("cowplot")`
    -   Nicer quality than default ggplot, it's a theme
    -   Also provides a way to merge two plots into one, eg A & B figures, and annotations
-   Resources:
    -   R Graph catalog: [http://shiny.stat.ubc.ca/r-graph-catalog/](http://shiny.stat.ubc.ca/r-graph-catalog/)
    -   GGPlot2 online help: [http://docs.ggplot2.org/]()
    -   R Graph Cookbook: [http://www.cookbook-r.com/Graphs/](http://www.cookbook-r.com/Graphs/)
    -   ggplot2 essentials: [http://www.sthda.com/english/wiki/ggplot2-essentials](http://www.sthda.com/english/wiki/ggplot2-essentials)
    -   Rstudio cheatsheets: [https://www.rstudio.com/resources/cheatsheets/](https://www.rstudio.com/resources/cheatsheets/)
    -   Cowplot: [https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html)

### Challenge: 

-   Create a boxplot showing the spread of life expectancy for each continent
    -   <span></span>

        ```
        ggplot(data = gapminder, aes(x = continent, y = lifeExp)) + 
           geom_boxplot() + 
           geom_jitter(alpha = 0.5, color = "tomato")
        ```




## 4. Subsetting and reshaping data with dplyr and tidyr

-   Like, graphing, the subsetting and data-wrangling tools bundled with R are not the best
-   We're going to use dplyr and tidyr instead.

### dplyr

-   Setup
    -   `install.packages("dplyr")`
    -   `library(dplyr)`
  
-   dplyr is especially nice because you can do most of what you need to with only a handful of functions, easy to remember
    -   select(), filter(), group_by(), summarize(), mutate()
-   Select lets you only use some columns.  You can also re-order them
    -   <span></span>

        ```
        head(gapminder)
        year_country_gdp <- select(gapminder, year, country, gdpPercap)
        head(year_country_gdp)
        ```

-   dplyr also can use an R version of pipes, like what we saw in the shell lesson
    -   `year_country_gdp <- gapminder %>% select(year, country, gdpPercap)`
    -   You don't have to bother giving it the data argument anymore.  Easier to read
-   Select lets us subset columns, but what if we want to subset rows?  filter() does that
    -   <span></span>

        ```
        year_country_gdp_euro <- gapminder %>%
            filter(continent=="Europe") %>%
            select(year,country,gdpPercap)
        ```

    -   Walk through this example, showing the flow

    -   <span></span>

        ```
        year_country_gdp_euro <- filter(select(gapminder, year,country,gdpPercap), 
            continent=="Europe")
        ```

***---------- Socrative #??? ----------***

-   Socrative answer: 
    -   <span></span>

        ```
        Africa_2007_lifeExp <- gapminder %>%
            filter(continent == "Africa", year == 2007) %>%
            select(year, country, lifeExp)

        str(Africa_2007_lifeExp)
        ```

    -   Note that the order is really important!  Since select removes continent, it has to come second
    -   We could have used two filter commands instead

-   Summarize lets us condense data down
-   `mean_gdp <- gapminder %>% summarize(meanGDP = mean(gdpPercap))`
-   Not very useful by itself, we could have used this instead
    -   `mean(gapminder$gdpPercap)`
-   But if we combine it with the group_by() function, we can get the mean gdp for each continent
    -   <span></span>

        ```
        gdp_by_continents <- gapminder %>%
            group_by(continent) %>%
            summarize(mean_gdp = mean(gdpPercap))

        gdp_by_continents
        ```

-   Here we're grouping by continent, which means we calculate a **separate** mean for each one

### Challenge socrative:
-   Let's compile the average life expectancy across all African countries by year.  In how many years did it decrease?

    -   <span></span>

        ```
        africa_lifeExp <- gapminder %>%
            filter(continent == "Europe") %>%
            group_by(year) %>%
            summarize(avg_life = mean(lifeExp))
             
        africa_lifeExp
        ```

-   We can group multiple variables and summarize multiple things
    -   <span></span>
        ```
        gdp_by_continents <- gapminder %>%
            group_by(continent, year) %>%
            summarize(mean_gdp = mean(gdpPercap), 
                sd_gdp = sd(gdpPercap), 
                mean_pop = mean(pop), 
                sample_size = n())

        gdp_by_continents
        ```

    -   n() is a special function that gives the sample size for that grouping, very useful
    -   Notice that we only see 10 rows.  Summarize actually has returned a "special" table-dataframe
    -   In most cases it acts the same, but if we want to see the whole thing, we can pipe it to dataframe
        -   `gdp_by_continents %>% data.frame()`


-   What if we wanted to create a new column without condensing our data down?  Use mutate()
    -   <span></span>
        ```
        billion_gdp_country_2007 <- gapminder %>%
            filter(year == 2007) %>%
            mutate(billion_gdp = gdpPercap*pop/10^9) %>%
            select(continent, country, billion_gdp)

        head(billion_gdp_country_2007)
        ```

### tidyr

-   Setup
    -   `install.packages("tidyr")`
    -   `library(tidyr)`

-   The same dataset can be represented in different ways
-   Wide format: 
    -   <span></span>

        ```
        Genus   Weight  Height
        Ursus   122     82
        ```

-   Long format: 
    -   <span></span>

        ```
        Genus   Measurement     Value
        Ursus   Weight          122
        Ursus   Height          82
        ```

-   In long format, each column is a variable and each row is a single measurement or observation
-   We tend to use wide format more because it's more concise, easy to ready, datasheety
-   R, databases, and other programming languages usually prefer long format

***---------- Socrative #??? ----------***
What format is the gapminder dataset we've been using in?

-   We have 3 ID columns, and 3 observation columns (instead of 1)
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
            gather(obstype_year,obs_values,-continent,-country)
        str(gap_long)
        ```

- Our new column obstype_year actually has 2 pieces of information.  We should separate them
    -   <span></span>

        ```
        gap_long <- gap_long %>% 
             separate(obstype_year, into = c('obs_type', 'year'), sep = "_") %>%
             mutate(year = as.integer(year))
        ```



**Socrative: Using gap_long, calculate the mean life expectancy by continent**

gap_long %>%
     filter(obs_type == "lifeExp") %>%
     group_by(continent) %>%
     summarize(lifeExp = mean(obs_values))

-   Now that we have our long format, let's convert it to the intermediate format
    -   <span></span>

        ```
        gap_normal <- gap_long %>% 
            spread(obs_type,obs_values)
        head(gap_normal)
        dim(gap_normal)
        dim(gapminder)
        ```
-   Notice how the contents of obs_type became the column names
-   Looks like the same dataset, cool, we're back
-   Columns are in a different order though, let's fix that
    -   <span></span>

        ```
        names(gap_normal)
        names(gapminder)
        gap_normal <- gap_normal %>%
            select(country, year, pop, continent, lifeExp, gdpPercap)
        names(gap_normal)
        ```

-   Let's see if they're equal.  Not so good, they're sorted differently
    -   <span></span>

        ```
        all.equal(gap_normal, gapminder)
        head(gap_normal)
        head(gapminder)

        ```

-   The new dataset is sorted first by continent, gapminder was by country
    -   <span></span>

        ```
        gap_normal <- gap_normal %>% 
            arrange(country, continent, year)
        all.equal(gap_normal, gapminder)

        ```
        
    -   Arrange is a dplyr function
    -   It's a good idea to do checks all the time (like all_equal)







-   Resources:
    -   Rstudio cheatsheets: [https://www.rstudio.com/resources/cheatsheets/](https://www.rstudio.com/resources/cheatsheets/)




-   <span></span>

    ```

    ```

    -   <span></span>

        ```

        ```



## 5. Producing reports and notebooks with knitr


## 6. Writing good software


#### Subheading 
