---
title: R Novice Gapminder #2
subtitle: R for Reproducible Scientific Analysis Part 2
...

## Pre-Workshop Setup ##

-   

### Open up Socrative again ###
-   You can import my quiz with 
-   Advise learners to go to <https://b.socrative.com/login/student/>
-   Type in MICKLEY for the room name

**QUESTION: How many of you end up doing the same thing more than once while analyzing your data?**

***---------- Socrative #1 ----------***

## 1. Creating and using functions
- Functions package a bit of code we want to re-use so that we don't have to re-write it or remember how it works later
- Often, the function will take some variables as arguments and return something back to us (but doesn't have to)
- We've actually been using them all along!
  - `read.csv()` is a function.  We give it a filename and it gives us a dataframe
  - Do any of you know what it actually does?
- <span></span>
    ```
    fahr_to_kelvin <- function(temp) {
      kelvin <- ((temp - 32) * (5 / 9)) + 273.15
      return(kelvin)
    }
    ```

- Testing things
  -   `plot(0)`

## 2. Loops and conditional statements


## 3. Plotting and creating publication-quality graphics


## 4. Subsettingand reshaping data with dplyr and tidyr


## 5. Producing reports and notebooks with knitr


## 6. Writing good software


#### Subheading 
