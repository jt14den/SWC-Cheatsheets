##################################################
# Lesson 1 - Analyzing Patient Data
# Objectives: 
#  - Read tabular data from a file
#  - Assign values to variables
#  - Select individual values and subsets of data
#  - Perform operations on a data frame
#  - Display simple graphs
##################################################

##### Loading Data
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Set working directory
setwd("~/Desktop/r-novice-inflammation/")

# Read in data
read.csv(file = "data/inflammation-01.csv", header = FALSE)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Save something to a variable
weight_kg <- 55

# convert weight to pounds
2.2 * weight_kg

# Change the value in weight_kg
weight_kg <- 57.5

# Saving weight in pounds, doesn't change weight_kg
weight_lb <- 2.2 * weight_kg

# Changing weight_kg doesn't change weight_lb
weight_kg <- 100.0

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Instead of showing the data, let's store it in dat
dat <- read.csv(file = "data/inflammation-01.csv", header = FALSE)

# Let's inspect the first few rows with head
head(dat)

## Challenge
## mass <- 47.5
## age <- 122
## mass <- mass * 2.0
## age <- age - 20
## Which variables refer to what values?

##### Manipulating data
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# What type of variable or "thing" is dat?
class(dat)

# What are the dimensions (rows and columns) of dat?
dim(dat)

# Get the data in the first cell of the first column
dat[1, 1]

# Or the 30th row and 20th column
dat[30, 20]

# Get rows 1-4 and columns 1-10
# 1:4 called a slice
dat[1:4, 1:10]

# A slice doesn't need to start at 1
dat[5:10, 1:10]

# Using c() to select values that aren't contiguous
dat[c(3, 8, 37, 56), c(10, 14, 29)]

# Or we can slice only rows, blank means "all columns"
dat[5, ]

# All rows from column 16
dat[, 16]

# Now let's look at our data a bit

# Save the first row/patient into a new variable
patient_1 <- dat[1, ]

# find the maximum inflammation for patient 1
max(patient_1)

# Alternatively, we don't need to make a new variable
max(dat[2, ])

# We can also do min, mean, median, and sd

# minimum inflammation on day 7
min(dat[, 7])

# mean inflammation on day 7
mean(dat[, 7])

# median inflammation on day 7
median(dat[, 7])

# standard deviation of inflammation on day 7
sd(dat[, 7])

# What if we want the mean inflammation for each patient?

# Good time to introduce help:
# How to get help on a function
?apply

# Find the mean for each patient across rows (margin = 1)
avg_patient_inflammation <- apply(dat, 1, mean)

# Find the mean for each day across columns
avg_day_inflammation <- apply(dat, 2, mean)

## Challenges on subsetting data


##### Plotting
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Visualizing data is really useful

# Plot the average inflammation for each day
plot(avg_day_inflammation)

# Lets find and plot maximum inflammation by day
max_day_inflammation <- apply(dat, 2, max)
plot(max_day_inflammation)

# And also minimum inflammation by day
min_day_inflammation <- apply(dat, 2, min)
plot(min_day_inflammation)


##################################################
# Lesson 2 - Creating Functions
# Objectives: 
#  - Define a function that takes arguments
#  - Return a value from a function
#  - Test a function
#  - Set default values for function arguments
#  - Why we should divide programs into small functions
##################################################

##### Defining a function
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# So far, we've been using pre-made functions
# but we can make our own

# Make a function to convert fahrenheit to kelvin
fahr_to_kelvin <- function(temp) {
     
     # Do the conversion and store it in kelvin
     # Note: kelvin variable is only inside the function (scope)
     kelvin <- ((temp - 32) * (5 / 9)) + 273.15
     
     # Send the result back to the user
     return(kelvin)
}

# Freezing point of water
fahr_to_kelvin(32)

# Boiling point
fahr_to_kelvin(212)

# We can make another function to convert kelvin to celcius
kelvin_to_celsius <- function(temp) {
     
     # do the conversion and store in celcius
     celsius <- temp - 273.15
     
     # Return the result to the user
     return(celsius)
}

# absolute zero in Celsius
kelvin_to_celsius(0)

# We can combine the two to go from fahrenheit to celcius
fahr_to_celsius <- function(temp) {
     
     # Convert to kelvin first
     temp_k <- fahr_to_kelvin(temp)
     
     # Then convert to celsius
     result <- kelvin_to_celsius(temp_k)
     
     # Return the result
     return(result)
}

# freezing point of water in Celsius
fahr_to_celsius(32.0)

# The idea here is bite-sized chunks, fit in working memory

# We could also combine the two functions instead of making a 3rd
kelvin_to_celsius(fahr_to_kelvin(32.0))

## Challenge: create a function
## Remember, we've learned what c() concatenate does (example)
##fence <- function(original, wrapper) {
##     answer <- c(wrapper, original, wrapper)
##     return(answer)
##}


##### Testing and Documenting
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Lets write a function to center data
center <- function(data, desired) {
     
     # Subtract the mean from each data point and add the center
     new_data <- (data - mean(data)) + desired
     
     # return the centered data
     return(new_data)
}

# Some test data to play with
z <- c(0, 0, 0, 0)

# Center our test data around 3
center(z, 3)

# Now let's try to center our real data from day 4 around 0

# Read in the data again
dat <- read.csv(file = "data/inflammation-01.csv", header = FALSE)

# Center day 4 around 0
centered <- center(dat[, 4], 0)

# Look at the first few values
head(centered)

# hard to tell if it worked, so more tests

# original minimum
min(dat[, 4])

# original mean
mean(dat[, 4])

# original max
max(dat[, 4])

# centered min
min(centered)

# centered mean
mean(centered)

# centered max
max(centered)

# We can also check standard deviation hasn't changed

# original sd
sd(dat[, 4])

# centered sd
sd(centered)

# difference in standard deviations before and after
sd(dat[, 4]) - sd(centered)

# R has a function to compare, detects very small differences
all.equal(sd(dat[, 4]), sd(centered))

# It's important to add documentation for functions too
center <- function(data, desired) {
     # return a new vector containing the original data centered around the
     # desired value.
     # Example: center(c(1, 2, 3), 0) => c(-1, 0, 1)
     
     # Subtract the mean from each data point and add the center
     new_data <- (data - mean(data)) + desired
     
     # return the centered data
     return(new_data)
}

## Challenge - A more advanced function
## Write a function called analyze that takes a filename
## and displays the 3 graphs from lesson 1 (avg, min max)



##### Defining Defaults
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# We don't actually have to specify the argument names (file, header)
dat <- read.csv("data/inflammation-01.csv", FALSE)

# But the order matters if we don't specify.  This works
dat <- read.csv(header = FALSE, file = "data/inflammation-01.csv")

# But this doesn't work
dat <- read.csv(FALSE, "data/inflammation-01.csv")

# Lets redefine our function, but we'll set desired = 0
center <- function(data, desired = 0) {
     # return a new vector containing the original data centered around the
     # desired value (0 by default).
     # Example: center(c(1, 2, 3), 0) => c(-1, 0, 1)
     
     # Subtract the mean from each data point and add the center
     new_data <- (data - mean(data)) + desired
     
     # return the centered data
     return(new_data)
}

# This works the same as before
test_data <- c(0, 0, 0, 0)
center(test_data, 3)

# But now we can call center with only one argument

# Add 5 to our test data
more_data <- 5 + test_data

# Center the data (assuming desired = 0)
# Useful if that's usually the way it should work
center(more_data)

# Let's make another function with 3 arguments (with defaults)
display <- function(a = 1, b = 2, c = 3) {
     
     # Store the three arguments in a vector
     result <- c(a, b, c)
     
     # This names each element of the vector
     names(result) <- c("a", "b", "c")  
     
     # Return the whole vector
     return(result)
}

# Run with no arguments
display()

# Give it one argument
display(55)

# two arguments
display(55, 66)

# three arguments
display (55, 66, 77)

# So R is overriding the defaults from left to right

# only setting the value of c
display(c = 77)

# Let's go back to that error with read.csv()
dat <- read.csv(FALSE, "data/inflammation-01.csv")

# Read the help
?read.csv

# file doesn't have a default value, the rest do
# So we failed because we gave FALSE as a filename

## Challenge
## Rewrite the rescale function to scale btwn 0 and 1
## But allow to specify other upper/lower bounds

# Our analyze function lets us visualize each dataset
# But this is still a lot of work to type in all the names


##################################################
# Lesson 3 - Analyzing multiple datasets
# Objectives: 
#  - Explain what a for loop does
#  - Write for loops to repeat simple calculations
#  - Trace changes for a loop value as it runs
#  - Use a function to get a list of filenames matching a pattern
#  - Use a for loop to process multiple files
##################################################


analyze <- function(filename) {
     # Plots the average, min, and max inflammation over time.
     # Input is character string of a csv file.
     
     # Read in the data file
     dat <- read.csv(file = filename, header = FALSE)
     
     # find means by day and plot them
     avg_day_inflammation <- apply(dat, 2, mean)
     plot(avg_day_inflammation)
     
     # find max by day and plot them
     max_day_inflammation <- apply(dat, 2, max)
     plot(max_day_inflammation)
     
     # find min by day and plot them
     min_day_inflammation <- apply(dat, 2, min)
     plot(min_day_inflammation)
}

# Run the function on the first data file
analyze("data/inflammation-01.csv")

# We could do this one-by-one but there's a better way
analyze("data/inflammation-02.csv")


##### For loops
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Let's say we want to print each word in a sentence

# Our example sentence
best_practice <- c("Let", "the", "computer", "do", "the", "work")

# We could build a function to print each word
print_words <- function(sentence) {
     print(sentence[1])
     print(sentence[2])
     print(sentence[3])
     print(sentence[4])
     print(sentence[5])
     print(sentence[6])
}

# And run the function
print_words(best_practice)

# That works, but what if we had thousands of words?
# Doesn't scale, and only prints part of the data

# Only show the first 5 words
best_practice[-6]

# This doesn't work as expected
print_words(best_practice[-6])

# What is NA?
?NA

# A better approach using a for loop in the functin
print_words <- function(sentence) {
     
     # For loop
     for (word in sentence) {
          print(word)
     }
}

# Run the function
print_words(best_practice)

# This works the way we want it to
print_words(best_practice[-6])

# General form of a loop
# for (variable in collection) {
#      do things with variable
# }

# Another example

# Set length to zero to start
len <- 0

# Make a vector of vowels
vowels <- c("a", "e", "i", "o", "u")

# Figure out how many vowels are in the vector
for (v in vowels) {
     
     # For each vowel, we add 1 to len
     len <- len + 1
}


# display number of vowels
len

# Set letter to z
letter <- "z"

# Loop through and print each letter in a fector
for (letter in c("a", "b", "c")) {
     print(letter)
}

# After the loop, letter is the the letter from the last iteration
letter

# R has a built-in function for length
length(vowels)

## Challenge - Using loops
## Using seq() write a function that prints the first N numbers
## one per line
# Challenge - Using loops
# print_N <- function(N) {
#      nseq <- seq(N)
#      for (num in nseq) {
#           print(num)
#      }
# }
# print_N(3)


##### Processing Multiple Files
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Now we want to get on towards analyzing all our files

# R has a function called list.files() that shows
# all the files in a folder
?list.files

# Let's try to run it -> Wrong place
list.files()

# Show all files in the data folder that match "csv"
list.files(path = "data", pattern = "csv")

# More than we wanted, so lets match inflammation
list.files(path = "data", pattern = "inflammation")

# But we also want the path in the filename
list.files(path = "data", pattern = "inflammation", full.names = TRUE)

# Lets save all the filenames to a variable
filenames <- list.files(path = "data", pattern = "inflammation", full.names = TRUE)

# And just keep the first 3 of them
filenames <- filenames[1:3]

# Now we can use a for loop to analyze each of them
for (f in filenames) {
     
     # Print the filename
     print(f)
     
     # Analyze the data file
     analyze(f)
}

## Challenge
## Write a function analyze_all that takes a filename pattern 
## as the only argument and runs analyze for each file that matches


##################################################
# Lesson 4 - Making choices
# Objectives: 
#  - Save plots in a pdf file
#  - Write condition statements with if and else
#  - Evaluate expressions with & and |
##################################################


##### Saving Plots to a File
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# We have an analyze function
analyze <- function(filename) {
     # Plots the average, min, and max inflammation over time.
     # Input is character string of a csv file.
     dat <- read.csv(file = filename, header = FALSE)
     avg_day_inflammation <- apply(dat, 2, mean)
     plot(avg_day_inflammation)
     max_day_inflammation <- apply(dat, 2, max)
     plot(max_day_inflammation)
     min_day_inflammation <- apply(dat, 2, min)
     plot(min_day_inflammation)
}

# And an analyze_all function
analyze_all <- function(pattern) {
     # Runs the function analyze for each file in the current working directory
     # that contains the given pattern.
     filenames <- list.files(path = "data", pattern = pattern, full.names = TRUE)
     for (f in filenames) {
          analyze(f)
     }
}

# But this would create lots of plots we'd have to save

# Instead we can save to PDF

# Start saving to pdf named inflammation-01
pdf("inflammation-01.pdf")

# Run our analyze function
analyze("data/inflammation-01.csv")

# Stop saving to PDF
dev.off()

# We could update analyze to save this way
# but might not always want this, might want to choose


##### Conditionals
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Make a variable
num <- 37

# Test whether the variable is more than 100
if (num > 100) {
     print("greater")
} else {
     print("not greater")
}
print("done")

# Lets take this apart

# First we do a comparison, which is false
num > 100

# This one is true
num < 100

# There doesn't have to be an else (does nothing)
num <- 53
if (num > 100) {
     print("num is greater than 100")
}

# We can also chain several tests together

# Make a function to return the sign of a number
sign <- function(num) {
     
     # Check if the number is > 0 and return 1
     if (num > 0) {
          return(1)
          
     # Otherwise, check if the number is 0, and return 0
     # == means "is equal to", not "="
     } else if (num == 0) {
          return(0)
          
     # Finally, if neither of those, return -1
     } else {
          return(-1)
     }
}

# Test the function
sign(-3)
sign(0)
sign(2/3)

# We can also use >=, <=, and !=

# We can combine tests: & = and and "|" = or

# Check if both of these are true
if (1 > 0 & -1 > 0) {
     print("both parts are true")
} else {
     print("at least one part is not true")
}

# Check if either or both of these are true
if (1 > 0 | -1 > 0) {
     print("at least one part is true")
} else {
     print("neither part is true")
}

## Challenge - using conditions to change behavior


##### Saving automatically generated figures
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Now let's update our analyze function
analyze <- function(filename, output = NULL) {
     # Plots the average, min, and max inflammation over time.
     # Input:
     #    filename: character string of a csv file
     #    output: character string of pdf file for saving
     
     # Check whether we should save to PDF
     # Note: ! means "not", so !is.null means "is not null"
     if (!is.null(output)) {
          pdf(output)
     }
     
     # Read in the data
     dat <- read.csv(file = filename, header = FALSE)
     
     # find means by day and plot them
     avg_day_inflammation <- apply(dat, 2, mean)
     plot(avg_day_inflammation)
     
     # find max by day and plot them
     max_day_inflammation <- apply(dat, 2, max)
     plot(max_day_inflammation)
     
     # find min by day and plot them
     min_day_inflammation <- apply(dat, 2, min)
     plot(min_day_inflammation)
     
     # Check whether to turn off saving to PDF
     if (!is.null(output)) {
          dev.off()
     }
}

# Let's see how is.null works
output <- NULL
is.null(output)

# And this shows what ! does
!is.null(output)

# Now we can analyze interactively
analyze("data/inflammation-01.csv")

# Or we can save plots
analyze("data/inflammation-01.csv", output = "inflammation-01.pdf")

# Now we want to update analyze_all
# But how do we tell it the output file?

# We can use sub to substitute pdf for csv
f <- "data/inflammation-01.csv"
sub("csv", "pdf", f)

# Update analyze_all
analyze_all <- function(pattern) {
     # Runs the function analyze for each file in the current working directory
     # that contains the given pattern.
     
     # Get the list of filenames
     filenames <- list.files(path = "data", pattern = pattern, full.names = TRUE)
     
     # Analyze each filename, saving to a PDF
     for (f in filenames) {
          pdf_name <- sub("csv", "pdf", f)
          analyze(f, output = pdf_name)
     }
}

# Run the function
analyze_all("inflammation")

## Challenge - change behavior of plot command
## Make the figures with lines instead of points


