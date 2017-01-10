---
title: R Novice Gapminder #2
subtitle: R for Reproducible Scientific Analysis Part 2
...

## Pre-Workshop Setup ##

-   

- <span></span>
  ```
  ```

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
- Freezing point
  - `fahr_to_kelvin(32)`
- Boiling point
  - `fahr_to_kelvin(212)`
- We can make another function to convert to Celsius
  - <span></span>
    ```
    kelvin_to_celsius <- function(temp) {
      celsius <- temp - 273.15
      return(celsius)
    }
    
    kelvin_to_celsius(0)
    ```
- Variable Scope: Variables defined inside functions stay there, a function is it's own little box/environment
  - `print(celsius)`
  - Why might this be useful?  Socrative???
- Pass-by-Value: Functions don't change the variables we give them either (usually), we work on a copy.  Safer!
- We can mix, match and combine functions with themselves to get larger chunks of code
  - <span></span>
    ```
    fahr_to_celsius <- function(temp) {
      temp_k <- fahr_to_kelvin(temp)
      result <- kelvin_to_celsius(temp_k)
      return(result)
    }

    # freezing point of water in Celsius
    fahr_to_celsius(32.0)
    ```
 - Another way to do this would be to chain the first two functions together (walk through this)
   - `kelvin_to_celsius(fahr_to_kelvin(32.0))`
 - Centering data
   - In stats, especially regression, it's useful to center data
   - Say we regress population against year with our dataset.  
   - We'll get a y-intercept for 0 AD.  This is useless!  We don't care about that!
   - If we shifted our data so that a year of interest was the y-intercept, we'll get the mean population for that year.
     - Demonstrate on whiteboard
   - To center around 0, we just subtract the mean from all the data points.  eg: `c(1, 2, 3)` --> `c(-1, 0, 1)`
   - To center around a different number (say 1960), we subtract the mean, and then add that number

### Challenge

- Write a function called center() to center data around a particular number
- Should take two arguments, a vector called data, and a number to center around called desired
- Return the centered vector

- <span></span>
  ```
  center <- function(data, desired) {
    new_data <- (data - mean(data)) + desired
    return(new_data)
  }
  ```

- Test your function first on made-up data to make sure it works
- <span></span>
  ```
  test <- c(0, 0, 0, 0)
  test
  center(test, 3)
  ```
- It looks like it works, so let's try on our data and store as a separate column
  - `dat$year_centered <- center(dat$year, 1990)`
  - **TODO: check if this works!**

- When you write a function like this, you often don't use it again until months later.  Or someone else needs to use it.  
- So it's a good idea to add documentation!
- We can also add a default value for some of the arguments, so we don't need to include them unless we want to
- <span></span>
  ```
  center <- function(data, desired = 0) {
    # Centers data around zero or a specified value
    # Takes a vector and the desired center as arguments
    # Returns a new vector containing the original data centered around the desired center
    # Example: center(c(1, 2, 3), 0) => c(-1, 0, 1)
    new_data <- (data - mean(data)) + desired
    return(new_data)
  }
  
  center(c(1,2,3,4,5,6))
  ```
- Specifically, we want to say: 
  1. What does the function do?  
  2. What are it's arguments?
  3. What does it return?
- Note that we need to re-run the function code for the changes to take effect!





    
    

## 2. Loops and conditional statements


## 3. Plotting and creating publication-quality graphics


## 4. Subsettingand reshaping data with dplyr and tidyr


## 5. Producing reports and notebooks with knitr


## 6. Writing good software


#### Subheading 
