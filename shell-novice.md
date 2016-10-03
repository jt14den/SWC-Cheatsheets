

```bash
##### 1. Introducing the Shell #####


##### 2. Navigating Files and Directories #####

# Setup prompt
PS1='$ ' # (Or PS1="\n\w: \$ ")

# Explain that whoami is a program that is being run and displaying output
whoami 

# Print working directory: find out where we are.  Directory = folder
pwd

# Diagram a Unix filesystem and explain the leading / (root directory). There are 2 meanings for /

ls # Listing the contents of current directory

# Kind of hard to tell what's what (which are folders?).  So we'll add a "flag" (explain flags)
ls -F # Puts a slash after folders

# ls has lots of other options, let's look at the help. man stands for manual
man ls # Windows users: ls --help

# You can move around in man using mouse, or up/down arrows.  Or b and spacebar to move a page.  q to quit

# We can also tell ls to look in a different directory than the current one.
# -F and Desktop are parameters or arguments we're giving to the ls program to tell it how to run
ls -F Desktop

# Hopefully you see the data-shell directory.  If not, put up a red sticky

# Now we can see what's inside our data-shell directory
ls -F Desktop/data-shell

# Instead of just looking, we can change our current directory.  
# Say we want to go to that data directory
cd Desktop # cd stands for change directory
cd data-shell
cd data

# cd doesn't tell us anything back, but we can check using our tools from before, to see that we are in the data directory
pwd
ls -F

# So now let's go back to the data-shell directory.  We can try this
cd data-shell

# Oops, that didn't work.  cd can only see subdirectories inside the one we're in
cd .. # This takes us back.  .. stands for the directory containing this, or the parent

# We're back again
pwd

# We can see this parent directory if we use the -a (all) flag for ls
ls -F -a

# We can also stack multiple flags together like this instead of writing them separately
ls -Fa

# Explain hidden files, eg .bash_profile, .DS_Store, ./ (current directory).

# . and .. don't just belong to cd.  Any program can use them, eg this shows my Desktop:
ls ..

# So ls, cd, and pwd are how we navigate around our filesystem
# What happens if you just type cd and press enter?  Where do you go?  Let's figure it out, and put up a green sticky when you have the answer

# Takes us back to the home directory
cd
pwd

# Let's go back to the data directory.  This time, we don't need to use 3 separate commands, we can string together
cd Desktop/data-shell/data

# So far, we've been using "relative paths" (explain).  ls and cd are trying to find where we mean

# We could also use "absolute paths" these will work no matter where we are.  Remember that leading / means root?
pwd
cd /Volumes/mickles/Desktop/data-shell

# Some shortcuts:
cd ~/Desktop # Tilda is the same as the user's home directory (/Volumes/mickles for me)
cd - # This takes you to the previous directory you were in, very useful for switching back and forth

# %%%%% Challenge %%%%%
#
# %%%%%%%%%%%%%%%%%%%%%








# %%%%% Challenge %%%%%
#
# %%%%%%%%%%%%%%%%%%%%%

##### 3. Working With Files and Directories #####


##### 4. Pipes and Filters #####


##### 5. Loops #####


##### 6. Shell Scripts #####


##### 7. Finding Things #####


```


