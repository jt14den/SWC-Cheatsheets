---
title: Online Workshop - ggplot2
subtitle: R for Reproducible Scientific Analysis - plotting
...

  
## Before the workshop starts

1.    Turn on Do-Not-Disturb (phone + computer)
2.    Clear desktop, download the data, and save on desktop
3.    Close as many running programs as possible
4.    Open up Socrative and login to the teacher tools
5.    Open up etherpad, and the course website
6.    Make sure Dropbox is running
7.    Screen share the etherpad TODO list: (workshop website, etherpad, introduce yourself, choose breakout room, install packages/test software, pre-workshop survey)

## Workshop introduction

-   Etherpad intro
    +   Collaborative note taking. Anyone can contribute notes, but instructors will be adding a lot, so that you don't have to. This way you can focus on listening and coding, rather than notes.
    +   A place to ask questions. We'd prefer this over the Zoom chat, we can keep the chat.
-   Code of Conduct
    +   We ask that you please be respectful to everyone here.
    +   Teaching this is hard work, and not everyone is on the same knowledge level.
    +   Please do not record this session, there are privacy implications to this
    +   Please pay attention to what you are screen sharing, and any private messages, and practice respect here too. 
-   Helpers
    +   We have a bunch of helpers to help you when we break into small groups
    +   They're also available to answer questions and troubleshoot
-   Socrative
    +   We'll use this to ask questions and do short checkpoint assignments
-   Why do this workshop?
    +   Time-saving!!!  Work smarter, not harder! 
    +   Reproducible research, collaboration

## Intro to Zoom

-   Non-Verbal feedback
    +   Even though we're not in the same room, we want to see your feedback
    +   We will use the Yes and No non-verbal feedback icons in the Participants window to answer questions and as Stop and Go signs. 
        *   If you're stuck, use these to let me know if you need me to slow down
        *   I'll also remind you to use them at times
        *   Go ahead and click on the Participants button at the bottom of your screen
        *   There's also a Raise Hand icon that you can use to ask a question
-   Muting and Unmuting
    +   Please keep yourself muted when you can, so we can hear.
    +   You can temporarily unmute by pressing spacebar.
-   Breakout rooms + screen sharing
    +   We'll use this for you to work through problems in small groups
    +   If you get a message to join or leave a breakout room, say yes.
    +   Your helper will help you out while there.
-   Setting up your screen
    +   If you have a way of using two screens, do that. 
    +   Your main screen will be your coding screen, and you can watch me on your other one
    +   If you only have one screen, try to put RStudio and Zoom side-by-side
        *   Set Zoom to Fit to Window
-   What happens if Zoom crashes?
    +   We will try to return to the same meeting
    +   Watch the Etherpad for updates
-   Let's start
    +   Put up a Yes in the participant window if you have Socrative open in a tab
    +   Now, we're going to break up into groups. 
    +   With your helper and partner, work through the list of tasks on Socrative.

***---------- Socrative #1 ----------***: Test everything in Zoom

## 5. Publication-quality graphics (60 minutes)

### Background R

-   Projects?
-   Read in data
    +   Tab-complete
    +   CTRL+Enter or CMD+Enter
    +   `gap <- read.csv("data/gapminder_data.csv")`
-   Getting help
    +   `?read.csv`
-   Examine data
    +   `head(gap)`
    +   `str(gap)`
-   Dropbox script to follow along

### ggplot

**Question: How many of you have made a plot in R?  How many of you have used ggplot?**

-   R has a few different ways to plot things.  
-   It comes with a basic plotting package, but most people don't use this anymore, it's harder to modify
-   A better option is ggplot2, which is more flexible, build plots in layers (kinda like photoshop)
    -   `library(ggplot2)`
-   Grammar of graphics: Every plot is a dataset, a coordinate system, and a set of layers that are the visual representation
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp)) +
            geom_point()
        ```

-   First we load ggplot2
-   Then we call ggplot, all the options in here apply to all layers (mapping = aes maps the data)
    -   ggplot is smart enough to look for those columns in the data we gave it, no need to subset
    -   If we stop here we don't get a graph
    -   `ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp))`
    -   So finally, we add a points (scatterplot) layer called a geometry
  
***---------- Socrative #2 ----------***: Modify a ggplot graph

-   `ggplot(data = gap, mapping = aes(x=year, y=lifeExp)) + geom_point()`

-   Using a scatterplot probably isn't a good way to show change over time.
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = year, y = lifeExp, 
            by = country, color = continent)) +
            geom_line()
        ```

-   We're using a line geometry instead of a points geometry now
-   the **by** mapping = aesthetic draws a line for each country, and then we color each continent differently.
-   **Question: What if we wanted the points on the graph too?**
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = year, y = lifeExp, 
            by = country, color = continent)) +
            geom_line() + 
            geom_point()
        ```

-   Layers get drawn on top of each other
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = year, y = lifeExp, by = country)) +
            geom_line(mapping = aes(color = continent)) + 
            geom_point()
        ```

-   Here we've switched the color mapping = aesthetic from global to just the lines
-   If we want to set everything on a geometry to the same color, we set it outside the mapping = aesthetic function
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = year, y = lifeExp, by = country)) +
            geom_line(mapping = aes(color = continent)) + 
            geom_point(color = "blue")
        ```

-   Let's go back to our first example, but color the points by continent
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) +
            geom_point()
        ```

- Hard to see relationship with all those outliers, so let's use a log scale
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp)) +
            geom_point(alpha = 0.5) + 
            scale_x_log10()
        ```

-   Notice the data has been transformed before graphing, x axis reflects this (1,000, 10,000, 100,000)
-   Here we also use transparency so that overlapping points are easier to see.  This works with any geometry.  We could also set this to use a data column inside mapping = aes()

-   We can fit a simple linear regression line (linear model) using a geom_smooth geometry
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp)) +
            geom_point() + scale_x_log10() + geom_smooth(method="lm")
        ```

-   It even gives us a confidence interval!  We can make the line thicker using size
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp)) +
            geom_point() + scale_x_log10() + geom_smooth(method="lm", size=1.5)
        ```

***---------- Socrative #2 ----------***: Color by continent & add separate trends

-   <span></span>

    ```
    ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) +
        geom_point(size = 1.5) +
        scale_x_log10() +
        geom_smooth(method = "lm")
    ```

-   Many peope are colorblind.  In addition to color, it's a good idea to also use shape
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) +
            geom_point(size = 2, mapping = aes(shape = continent)) + 
            scale_x_log10() + 
            geom_smooth(method = "lm")
        ```

-   Let's clean it up for publication.  We'll add nicer axis labels, a title, and change the y-axis and theme
    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) +
            geom_point(size = 2, mapping = aes(shape = continent)) + 
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

    ggplot(data = gap, mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) + 
        facet_wrap(~ year) + 
        geom_point(size = 2, mapping = aes(shape = continent)) + 
        scale_x_log10() +
        geom_smooth(method = "lm")
    ```

### Alternate: Facets with dplyr (if time permits)

-   <span></span>

    ```
    L.countries <- gap %>% 
        filter(country %in% c("Lebanon", "Lesotho", "Liberia", "Libya"))

    L.countries

    ggplot(L.countries, mapping = aes(x = year, y = lifeExp, color = country)) + 
        geom_line() + facet_wrap( ~ country)
    ```
  
-   Draws a panel for each unique value in that column

### GGplot2 Challenge #2: write a function that takes vector of countries & creates faceted graph

-   <span></span>

    ```
    lifeExp_country <- function(data, countries) {
         country_subset <- data %>%
              filter(country %in% countries)
         ggplot(country_subset, mapping = aes(x = year, y = lifeExp, color = country)) + 
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
        ggplot(data = gap, mapping = aes(x = continent, y = lifeExp)) + 
           geom_boxplot() + 
           geom_jitter(width = 0.2, alpha = 0.5, color = "tomato")

        ggplot(data = gap, mapping = aes(x = continent, y = lifeExp)) + 
            geom_boxplot() + 
            geom_jitter(width = 0.2, alpha = 0.5, size = 2, 
                mapping = aes(color = factor(year)))
        ```

### GGplot2 Challenge #3: 

-   Create a grouped barplot showing life expectancy by year for each continent

    -   <span></span>

        ```
        ggplot(data = gap, mapping = aes(x = continent)) + 
            geom_bar()

        ggplot(data = gap, mapping = aes(x = continent, y = lifeExp, fill = factor(year))) + 
            geom_bar(stat = "summary", fun.y = "mean", position = "dodge")
        ```


### Resources

-   R Graph catalog: [http://shiny.stat.ubc.ca/r-graph-catalog/](http://shiny.stat.ubc.ca/r-graph-catalog/)
-   GGPlot2 online help: [http://docs.ggplot2.org/]()
-   R Graph Cookbook: [http://www.cookbook-r.com/Graphs/](http://www.cookbook-r.com/Graphs/)
-   ggplot2 essentials: [http://www.sthda.com/english/wiki/ggplot2-essentials](http://www.sthda.com/english/wiki/ggplot2-essentials)
-   Rstudio cheatsheets: [https://www.rstudio.com/resources/cheatsheets/](https://www.rstudio.com/resources/cheatsheets/)
-   Cowplot: [https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html)



