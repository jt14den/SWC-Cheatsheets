

```bash
##### 1. Introducing the Shell #####



### Introduce socrative ###
# Start the quiz in teacher mode
# Advise to go to https://b.socrative.com/login/student/
# Type in MICKLEY for the room name

# QUESTION: How many of you have used the shell before?

# Computers do 4 things:
# - run programs
# - store data
# - communicate with each other
# - and interact with us

# Mostly we interact nowadays using a GUI (graphical interface).  
# But we can also use a command interface (CLI) with the shell
# We type something in, the computer evaluates it, and prints out something for us to read
# This is what the shell does, it's a program that lets us run other programs

# The shell has been around a long long time, since the 1960's.  It's survived because it's simple and powerful

# - Useful for repetitive tasks and constructing a workflow
# - Even comes bundled with a lots of little simple programs
# - Important if you’re using something like an HPC cluster

### Our hypothetical example: Nelle the marine biologist ###
# Nelle has collected 1520 samples of marine life from the North Pacific Gyre.  
# She wants to run protein assays on each of these samples to measure the relative abundances of 300 different 
# proteins.  
# The assay machine she's using spits out a text file with one line for each protein.  

# She's on a deadline and has to: 
# 1). Run each sample through the machine, which will take a few weeks
# 2). Calculate statistics for each of the proteins separately using a program her supervisor wrote called goostat.
# 3). Compare the statistics for the proteins to each other using goodiff, which her labmate wrote.
# 4). Write up her results, ideally within a month.  

# If she had to run goostat and goodiff by hand she'll have to type in the filenames and click OK 46,370 times.  
# Even if she can do this quickly, it will take weeks, and she'll certainly have typeos.  

# We're going to explore the shell to get at what she could do instead.
# We want to automate the repetitive steps in her workflow so that her computer can do all the work 
# while she writes her paper.  
# Plus, once she puts a workflow together, she can use it again if she collects more data.


###############################################


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

# cd doesn't tell us anything back, but we can check using our tools from before, 
# to see that we are in the data directory
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
# What happens if you just type cd and press enter?  Where do you go?  Let's figure it out, 
# and put up a green sticky when think you have the answer

# %%%%% Socrative #2 %%%%%

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

# %%%%% Socrative #3 %%%%%
# %%%%% Socrative #4 %%%%%

# QUESTION: What does the command ls do when used with the -l and -h arguments?
# Use your stickies

### Back to Nelle ###
# Nelle makes a directory called north-pacific-gyre for where the data came from
ls 

# Inside of it is a folder named by the date
ls north-pacific-gyre

# Notice how this is named.  
# The filesystem sorts things by name, so if she makes more directories, they'll automatically be sorted
# This becomes more important later on if we want to run something that works with each directory in sequence

# Let's see what's inside the dated folder. 
# Lot's to type, introduce tab completion: folder 1, folder2, and contents
ls nor


#################################################


##### 3. Working With Files and Directories #####

# Ok, we know how to explore files and directories, but how do we create them?
cd ~/Desktop/data-shell
ls -F

# Let's create a new directory called thesis using mkdir
mkdir thesis # Make directory.  Relative path, so in current working directory

# Check that it's there.  We can also check with our GUI
ls -F

# Good naming conventions
# 1. Don't use spaces.  It's possible to (and I do), but the shell interprets them as arg breaks
# 2. Don't begin the name with -, since that means "flag"
# 3. Stick with letters, numbers, ., -, _  Many other characters have special meanings

# Now let's make a new file, using an editor in the shell called nano
# You could use any other text editor instead, nano is just convenient
# Notepad++ (Windows) or Sublime are good ones
cd thesis
nano draft.txt

# Explore nano commands using the control key (^)

# Write something like: 
# As the facts change, change your thesis!  Don't be a stubborn mule or you'll get killed.

# Now let's write this out using Ctrl+O

# Our file exists!
ls 

# We can remove this file using rm
# Careful though!  In shell, deleting is forever!  No "are you sure?".  No trash bin.
rm draft.txt
ls

# Let's recreate the file, and move back one directory to data-shell
nano draft.txt
ls
cd ..

# Now let's try to remove the whole thesis directory
# Doesn't work.  rm only works with files by default, not directories.  This is a good thing.
rm thesis

# If we add the recursive (-r) flag, we can delete everything inside thesis, and it too
# But this is super powerful, and again you need to be careful!!  We might forget what else is inside.
rm -r thesis

# A better way is to add the interactive flag to rm too
# We use y and n for yes and no (which also work)
rm -r -i thesis
ls -F 

# %%%%% Socrative #5 %%%%%

# Let's recreate it again.  This time we don't need to be in the thesis directory
pwd
mkdir thesis
nano thesis/draft.txt
ls thesis

# Let's change the name to something more appropriate
# mv stands for move.  First argument is the file we're moving, 2nd is where to go
mv thesis/draft.txt thesis/quotes.txt 
ls thesis

# Be careful with mv too.  It overwrites files without telling you.  
# You can avoid this with -i

# Let's move quotes.txt into the current working directory.  Remember, . is pwd
mv thesis/quotes.txt .
ls thesis

# If we give a filename to ls, it only looks for that file
ls quotes.txt

# We also have a copy command called cp
cp quotes.txt thesis/quotations.txt
ls quotes.txt thesis/quotations.txt

# Just to prove we have a copy, let's delete the original
rm quotes.txt
ls quotes.txt thesis/quotations.txt

# Names and extensions
# The files we're working with have names that are something dot something
# This extension at the end isn't required.  We could have just called this quotes
# But extensions are helpful for us (and programs) to know how to interpret them

# %%%%% Socrative #6 %%%%%
# %%%%% Socrative #7 %%%%%


################################


##### 4. Pipes and Filters #####


##### 5. Loops #####


##### 6. Shell Scripts #####


##### 7. Finding Things #####


```


