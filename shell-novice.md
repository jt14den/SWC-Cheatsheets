
## 1. Introducing the Shell 


### Introduce Socrative

- You can import my quiz with SOC-24313213
- Start the quiz in teacher mode, so you can step through one question at a time
- Advise learners to go to https://b.socrative.com/login/student/
- Type in MICKLEY for the room name


- **QUESTION: How many of you have used the shell before?**

Computers do 4 things:
- run programs
- store data
- communicate with each other
- and interact with us


- Mostly we interact nowadays using a GUI (graphical interface).  

- But we can also use a command interface (CLI) with the shell

- We type something in, the computer evaluates it, and prints out something for us to read

- This is what the shell does, it's a program that lets us run other programs


- The shell has been around a long long time, since the 1960's.  It's survived because it's simple and powerful


- - Useful for repetitive tasks and constructing a workflow
- - Even comes bundled with a lots of little simple programs
- - Important if you’re using something like an HPC cluster


### Our hypothetical example: Nelle the marine biologist
- Nelle has collected 1520 samples of marine life from the North Pacific Gyre.  

- She wants to run protein assays on each of these samples to measure the relative abundances of 300 different proteins.  

- The assay machine she's using spits out a text file with one line for each protein.  


- She's on a deadline and has to: 
- 1. Run each sample through the machine, which will take a few weeks
- 2. Calculate statistics for each of the proteins separately using a program her supervisor wrote called goostat.
- 3. Compare the statistics for the proteins to each other using goodiff, which her labmate wrote.
- 4. Write up her results, ideally within a month.  


- If she had to run goostat and goodiff by hand she'll have to type in the filenames and click OK 46,370 times.  

- Even if she can do this quickly, it will take weeks, and she'll certainly have typeos.  


- We're going to explore the shell to get at what she could do instead.

- We want to automate the repetitive steps in her workflow so that her computer can do all the work 

- while she writes her paper.  

- Plus, once she puts a workflow together, she can use it again if she collects more data.



## 2. Navigating Files and Directories
#### Moving around in the filesystem and seeing what's there

- Setup prompt
  - **`PS1='$ ' # (Or PS1="\n\w: \$ ")`**
- Explain that whoami is a program that is being run and displaying output
  - **`whoami `**
- Print working directory: find out where we are.  Directory = folder
  - **`pwd`**
- Diagram a Unix filesystem and explain the leading / (root directory). There are 2 meanings for /
- Listing the contents of current directory with ls
  - **`ls`**
- Kind of hard to tell what's what (which are folders?).  So we'll add a "flag" (explain flags)
  - **`ls -F # Puts a slash after folders`**
- ls has lots of other options, let's look at the help. man stands for manual
  - **`man ls # Windows users: ls --help`**
- You can move around in man using mouse, or up/down arrows.  Or b and spacebar to move a page.  q to quit
- We can also tell ls to look in a different directory than the current one.
- -F and Desktop are parameters or arguments we're giving to the ls program to tell it how to run
  - **`ls -F Desktop`**
- Hopefully you see the data-shell directory.  If not, put up a red sticky
- Now we can see what's inside our data-shell directory
  - **`ls -F Desktop/data-shell`**
- Instead of just looking, we can change our current directory.  
- Say we want to go to that data directory
  - **`cd Desktop # cd stands for change directory`**
  - **`cd data-shell`**
  - **`cd data`**
- cd doesn't tell us anything back, but we can check using our tools from before to see that we are in the data directory
  - **`pwd`**
  - **`ls -F`**
- So now let's go back to the data-shell directory.  We can try this
  - **`cd data-shell`**
- Oops, that didn't work.  cd can only see subdirectories inside the one we're in
  - **`cd .. # This takes us back.  .. stands for the directory containing this, or the parent`**
- We're back again
  - **`pwd`**
- We can see this parent directory if we use the -a (all) flag for ls
  - **`ls -F -a`**
- We can also stack multiple flags together like this instead of writing them separately
  - **`ls -Fa`**
- Explain hidden files, eg .bash_profile, .DS_Store, ./ (current directory).
- . and .. don't just belong to cd.  Any program can use them, eg this shows my Desktop:
  - **`ls ..`**
- So ls, cd, and pwd are how we navigate around our filesystem
- What happens if you just type cd and press enter?  Where do you go?  Let's figure it out, 
- and put up a green sticky when think you have the answer

***---------- Socrative #2 ----------***

- Takes us back to the home directory
  - **`cd`**
  - **`pwd`**
- Let's go back to the data directory.  This time, we don't need to use 3 separate commands, we can string together
  - **`cd Desktop/data-shell/data`**
- So far, we've been using "relative paths" (explain).  ls and cd are trying to find where we mean
- We could also use "absolute paths" these will work no matter where we are.  Remember that leading / means root?
  - **`pwd`**
  - **`cd /Volumes/mickles/Desktop/data-shell`**
- Some shortcuts:
  - **`cd ~/Desktop # Tilda is the same as the user's home directory (/Volumes/mickles for me)`**
  - **`cd - # This takes you to the previous directory you were in, very useful for switching back and forth`**

***---------- Socrative #3 ----------***

***---------- Socrative #4 ----------***

**QUESTION: What does the command ls do when used with the -l and -h arguments?** Use your stickies

### Back to Nelle
- Nelle makes a directory called north-pacific-gyre for where the data came from
  - **`ls `**
- Inside of it is a folder named by the date
  - **`ls north-pacific-gyre`**
- Notice how this is named.  
- The filesystem sorts things by name, so if she makes more directories, they'll automatically be sorted
- This becomes more important later on if we want to run something that works with each directory in sequence
- Let's see what's inside the dated folder. 
- Lots to type, introduce tab completion: folder 1, folder2, and contents
  - **`ls nor`**


## 3. Working With Files and Directories
#### Creating, copying, deleting, and editing


- Ok, we know how to explore files and directories, but how do we create them?
  - **`cd ~/Desktop/data-shell`**
  - **`ls -F`**
- Let's create a new directory called thesis using mkdir
  - **`mkdir thesis # Make directory.  Relative path, so in current working directory`**
- Check that it's there.  We can also check with our GUI
  - **`ls -F`**
- Good naming conventions
  1. Don't use spaces.  It's possible to (and I do), but the shell interprets them as arg breaks
  2. Don't begin the name with -, since that means "flag"
  3. Stick with letters, numbers, ., -, _  Many other characters have special meanings
- Now let's make a new file, using an editor in the shell called nano
- You could use any other text editor instead, nano is just convenient
- Notepad++ (Windows) or Sublime are good ones
  - **`cd thesis`**
  - **`nano draft.txt`**
- Explore nano commands using the control key (^)
- Write something like: 
  - `As the facts change, change your thesis!  Don't be a stubborn mule or you'll get killed.`
- Now let's write this out using Ctrl+O
- Our file exists!
  - **`ls `**
- We can remove this file using rm
- Careful though!  In shell, deleting is forever!  No "are you sure?".  No trash bin.
  - **`rm draft.txt`**
  - **`ls`**
- Let's recreate the file, and move back one directory to data-shell
  - **`nano draft.txt`**
  - **`ls`**
  - **`cd ..`**
- Now let's try to remove the whole thesis directory
- Doesn't work.  rm only works with files by default, not directories.  This is a good thing.
  - **`rm thesis`**
- If we add the recursive (-r) flag, we can delete everything inside thesis, and it too
- But this is super powerful, and again you need to be careful!!  We might forget what else is inside.
  - **`rm -r thesis`**
- A better way is to add the interactive flag to rm too
- We use y and n for yes and no (which also work)
  - **`rm -r -i thesis`**
  - **`ls -F `**

***---------- Socrative #5 ----------***


- Let's recreate it again.  This time we don't need to be in the thesis directory
  - **`pwd`**
  - **`mkdir thesis`**
  - **`nano thesis/draft.txt`**
  - **`ls thesis`**
- Let's change the name to something more appropriate
- mv stands for move.  First argument is the file we're moving, 2nd is where to go
  - **`mv thesis/draft.txt thesis/quotes.txt `**
  - **`ls thesis`**
- Be careful with mv too.  It overwrites files without telling you.  
- You can avoid this with -i
- Let's move quotes.txt into the current working directory.  Remember, . is pwd
  - **`mv thesis/quotes.txt .`**
  - **`ls thesis`**
- If we give a filename to ls, it only looks for that file
  - **`ls quotes.txt`**
- We also have a copy command called cp
  - **`cp quotes.txt thesis/quotations.txt`**
  - **`ls quotes.txt thesis/quotations.txt`**
- Just to prove we have a copy, let's delete the original
  - **`rm quotes.txt`**
  - **`ls quotes.txt thesis/quotations.txt`**
- Names and extensions
- The files we're working with have names that are something dot something
- This extension at the end isn't required.  We could have just called this quotes
- But extensions are helpful for us (and programs) to know how to interpret them


***---------- Socrative #6 ----------***

***---------- Socrative #7 ----------***



## 4. Pipes and Filters
#### Combining commands to do novel things


- Combining commands or programs together is where we really get into the shell's power
- Let's look in the molecules directory.  
  - **`This has some files describing some organic molecules in protein data bank (pdb) format`**
  - **`pwd`**
  - **`ls molecules`**
- Let's go into that directory and run wordcount
- This shows the # of lines, words, and characters
  - **`cd molecules`**
  - **`wc *.pdb`**
- The * character is a "wildcard". It matches 0 or more characters, so *.pdb matches all pdb files
- We could also use p*.pdb for only pentane and propane
  - **`wc p*.pdb`**
- Another wildcard is ?, but it only matches a single character.  
- So p?.pdb wouldn't match pentane.pdb, only pi.pdb
- We could use multiple wildcards at once
  - **`wc ??hane.p* # This will only match ethane`**
- One note:  If nothing matches, our wildcard match gets passed as-is, eg:
- The shell is creating a list of matching files BEFORE running wc
  - **`wc *.pdf # Doesn't work`**


***---------- Socrative #8 ----------***


- If we add the -l flag to wc we only get the # of lines
- We could also use -w and -c for the # of words or characters
  - **`wc -l *.pdb`**
- Say we wanted to know which file was the shortest.  
- Easy with only 6 (methane), but what if there were thousands of files?
- First step, save the lengths to a file
- The > symbol REDIRECTS the output to the filename (and we don't see it!)
- Creates or overwrites the file
  - **`wc -l *.pdb > lengths.txt`**
  - **`ls lengths.txt`**
- Now we want to see what's in the file
- We can print it using cat = concatenate (can be used with multiple files)
  - **`cat lengths.txt`**
- One disadvantage of cat is it dumps the entire file.  Not so good if file is long
- Can use less instead to just show a screen at a time
  - **`less lengths.txt  # Press q to quit`**
- Now that we have a file, we can use the sort command to sort its contents
- We also have to use the -n flag for numeric sort (otherwise 100 and 10 will end up together)
  - **`sort -n lengths.txt`**
- We can save these sorted lengths
  - **`sort -n lengths.txt > sorted-lengths.txt`**
  - **`cat lengths.txt`**
  - **`cat sorted-lengths.txt`**
- We can also use a command called head to just get the first line. -n is the # of lines to get
  - **`head -n 1 sorted-lengths.txt`**
- Things are getting confusing with all these intermediate files
- Fortunately we can avoid those intermediates by running everything together
  - **`sort -n lengths.txt | head -n 1`**
- The | is called a pipe, and it's very useful!!!
- It means take the output of the left side and use it as input for the right side
- We could also do this for wordcount and sort
  - **`wc -l *.pdb | sort -n`**
- And for everything all at once, no intermediate files!
- Go over what this is doing, basically reading backwards: head of sort of wordcount
  - **`wc -l *.pdb | sort -n | head -n 1`**


***---------- Socrative #9 ----------***


- So we end up with lots of little tools that do one job well and can be strung together
- Keeps things from getting too complicated
- wc and sort then act as filters and pipe between each other.  
- They take input, transform and give us output
- We used > to redirect output to a file.  We can also redirect a file to input using < 
  - **`wc < methane.pdb # same as wc methane.pdb, but there's no filename to open, it's redirected`**

### Back to our biologist Nelly

- Nelle decides to check the length of her data files
  - **`cd north-pacific-gyre/2012-07-03`**
  - **`wc -l *.txt`**
- Things like this can be good for error checking.  There's a file that's too short, missing data
- Still a lot of work to go through though if she's got thousands of files
- So we do this instead to look at the shortest 5
  - **`wc -l *.txt | sort -n | head -n 5`**
- We could also look for files that are too big using tail (similar to head, but last lines)
- That looks ok sizewize, but what's that Z doing in the 2nd line?  
- Should just be A or B for 2 different depths
  - **`wc -l *.txt | sort -n | tail -n 5`**
- Let's see if there are any others like it
- Turns out there are two, where depth wasn't recorded
  - **`ls *Z.txt`**
- We could delete these files using rm, but we might want to use them later
- Instead we can just exclude them from all analyses with wildcards
- [AB] means match one character that is either an A or a B
  - **`wc -l *[AB].txt`**


***---------- Socrative #10 ----------***

***---------- Socrative #11 ----------***



## 5. Loops
#### How can we perform the same repetitive actions on many files? Using loops

- Also reduces amount of typing and mistakes
- We're going to work in the creatures directory
- Here we have two files, let's assume they're genome data files and we have a lot more than 2
  - **`cd ../creatures`**
  - **`ls`**
- We can inspect one to see
  - **`head -n 10 unicorn.dat`**
- Say we wanted to modify these files, but we wanted to save a backup first
- We could try, this but it won't work
  - **`cp *.dat original-*dat`**
- That would expand to the following, and try to copy 2 files to a directory that doesn't exist
  - **`cp basilisk.dat unicorn.dat original-*.dat`**
- Instead, we'll have to use a loop.  We'll come back to this example
- A simple example of a for loop
- Note that the > character here means that our command isn't finished yet.  
- We need the done to finish it
  - 
    
    ```
    for filename in basilisk.dat unicorn.dat
    do
    head -n 3 $filename`
    done
    ```

- The for loop does something for each thing in a list.  In this case, the list is the two filenames
- Each time through the loop, the filename we're working on is saved in a variable named filename
- Inside the loop, we can get and substitute the variable's value by putting a $ in front of it
- Finally, the thing we're actually doing each time is just head
- Note that the > now has multiple meanings.  It can mean "redirect to a file" if we put it in our command. Or the shell prints it it's expecting us to type something, command not finished. 
- > and $ are two different "prompts"
- We could use x as a variable name instead
- Indenting the things we're doing inside the loop makes the code easier to read
  - 
    
    ```
    for x in basilisk.dat unicorn.dat
    do
        head -n 3 $x
    done
    ```

- Best to pick variable names that make sense with what you're doing, filename is better than x


***---------- Socrative #12 ----------***


- A slightly more complicated loop
- We could also use curly braces to get our variable ${filename} is the same as $filename
  - 
    
    ```
    for filename in *.dat
    do
        echo $filename
    head -n 100 ${filename} | tail -n 20
    done
    ```

- We use a wildcard for the filenames instead of listing them ourself
- This time we run two commands.  The first is echo, which just echos/prints the filename
- We couldn't just put $filename there. 
- Then the shell would expand it to basilisk.dat and try to run that
- Finally, we take the first 100 rows, and then the last 20 of those, = rows 81-100
- Testing echo
  - **`echo hello there`**
- Say we had some filenames with spaces, eg red dragon.dat.  We'd have to quote them. Otherwise, the shell would treat them as separate files
- Again, it's often easier to just avoid spaces
  - **`for filename in "red dragon.dat" "purple unicorn.dat"`**
- Back to our file copying problem, we can solve it with this loop
  - 

    ```
    for filename in *.dat
    do
        cp $filename original-$filename
    done
    ```

- Each time through it runs a different file as if we run this
  - 
    
    ```
    cp basilisk.dat original-basilisk.dat
    cp unicorn.dat original-unicorn.dat
    ```

- Check for copies
  - **`ls`**

### Back to our friend Nelle, building her pipeline

- First she wants to make sure she can select the right files
  - **`cd ../north-pacific-gyre/2012-07-03`**
  - 
    
    ```
    for datafile in *[AB].txt
    do
        echo $datafile
    done
    ```

- Now she wants to run her goostats program on them and write the results to files
- To be safe, we're still using echo here
  - 
    
    ```
    for datafile in *[AB].txt
    do
        echo $datafile stats-$datafile
    done
    ```

- All this typing is increasing our chance of mistakes though.  Fortunately, we can reuse some of our typing
- Hitting the up arrow key gives us the last command.  Note the semicolons, these separate different lines.  We can then move around and change echo to bash goostats to run the program
- Now it's running the stats, but we have no idea as to progress!  We can stop the for loop with CTRL+C
- Lets add echo $datafile; back in so we can see which file we're working on.  If you know how many files you have, you can estimate how long this will take to run
- Editing the previous command still takes a while using the arrow keys. CTRL+A takes us the the beginning of the line, and CTRL+E to the end.  
- Also, we could keep hitting up arrow to go through our history, eg find the ls command.  Alternatively we could use the history command and pipe it through tail to get the last 15
  - **`history | tail -n 15`**
- Notice that the history entries are numbered.  We can run any of them with an exclamation point
  - **`!132 # Run the ls command"`**


***---------- Socrative #13 ----------***

***---------- Socrative #14 ----------***


## 6. Shell Scripts
#### How we save and reuse groups of commands


- Now we're going to save our whole workflow in a file, so that we can just run the file
- First let's go back to the molecules directory
  - **`cd ~/Desktop/data-shell/molecules`**
- Now let's edit a new file
  - **`nano middle.sh`**
- Put in the following: which selects lines 11-15
- We're not running this as a command, we're just putting it in a file
  - **`head -n octane.pdb | tail -n 5`**
- Save and exit: CTRL+O, CTRL+X
- Now we can run the file, which in turn runs the commands inside of it
  - **`bash middle.sh`**
- Compare to running the command directly: they're the same
  - **`head -n 15 octane.pdb | tail -n 5`**
- What if we want to select lines of an arbitrary file?
- Editing middle.sh isn't a great solution
- Instead, we can use a special variable called $1
- This will be replaced by whatever argument we give our middle.sh
  - **`nano middle.sh`**
  - **`head -n 15 "$1" | tail -n 5`**
- Now we can run the following
  - **`bash middle.sh octane.pdb`**
  - **`bash middle.sh pentane.pdb`**
- We put it in quotes in case it has spaces (better safe than sorry)
- What if we wanted to change the range of lines though?
- We can add more special variables for more arguments
  - **`nano middle.sh`**
  - **`head -n "$2" "$1" | tail -n "$3"`**
- Now we can run:
  - **`bash middle.sh pentane.pdb 15 5`**
  - **`bash middle.sh pentane.pdb 20 5`**
- Works great, but what if someone else needs to use this, or we want to use it 6 months later?
- Add Comments!!! They start with a #, and the computer ignores these lines when parsing them.
  - **`nano middle.sh`**
  -
    
    ```
    # Select lines from the middle of a file.
    # Usage: bash middle.sh filename end_line num_lines
    ```

- What if we want to process many files in one pipeline?  
- We could put something like this in a file, but it'd only work for .pdb
- $1 and $2 won't work either, we don't know how many files there will be
  - **`wc -l *.pdb | sort -n`**
- Luckily, there's a special variable $@ which means "All the arguments"
  - **`nano sorted.sh`**
  - **`wc -l "$@" | sort -n `**
- And it works:
  - **`bash sorted.sh *.pdb`**
  - **`bash sorted.sh *.pdb ../creatures/*.dat`**
- What if we don't give it any arguments?  Now $@ expands to nothing
- wc just waits for input, since it didn't get a filename
  - **`bash sorted.sh`**
- We could save our history, to avoid typos, but it'll take some editing
  - **`history | tail -n 5 > redo-figure-3.sh`**
  - **`cat redo-figure-3.sh`**

### Nelle's script

- Nelle forgot some arguments for goostats.  Luckily, its easy to re-run, and she can make a script
  - **`cd ../north-pacific-gyre/2012-07-03`**
  - **`nano do-stats.sh`**
  - 
    
    ```
    # Calculate reduced stats for data files at J = 100 c/bp.
    for datafile in "$@"
    do
        echo $datafile
        bash goostats -J 100 -r $datafile stats-$datafile
    done
    ```

- Now she can run it, specifying which files to run on
  - **`bash do-stats.sh *[AB].txt`**
- She could have put the *[AB].txt inside her script.  
- This might be safer, but it's less flexible



***---------- Socrative #15 ----------***


## 7. Finding Things

  - **`cd ~/Desktop/data-shell/writing`**
  - **`cat haiku.txt`**
- Look for lines that have "not" in them
  - **`grep not haiku.txt`**
- Or day.  But this includes words containing day
  - **`grep day haiku.txt`**
- To just get day, we can use -w (for word)
  - **`grep -w day haiku.txt`**
- We can also search for a phrase with quotes
  - **`grep -w "is not" haiku.txt`**
- It's also useful to get the line numbers of the lines that match
  - **`grep -n "it" haiku.txt`**
- Flags can be combined: line numbers and words
  - **`grep -n -w "the" haiku.txt`**
- Line numbers, words, and case-insensitive
  - **`grep -n -w -i "the" haiku.txt`**
- Or we can invert our search, show the lines that do NOT contain "the"
  - **`grep -n -w -v "the" haiku.txt`**
- Grep has lots of other options
  - **`man grep`**
  - **`grep --help`**
- Grep supports something called regular expressions, which is like our wildcards
  - http://regexr.com/
- -E extended regex, Quotes to prevent shell expansion, ^ = beginning, . = single character
  - **`grep -E '^.o' haiku.txt`**
- grep finds lines in files, but the find command finds files themselves
- This finds all the files in the current directory (and it's recursive)
  - **`find .`**
- Only show directories
  - **`find . -type d`**
- Only show files
  - **`find . -type f`**
- We can also match by name
- This doesn't actually find all of them, remember the shell expands BEFORE command runs
  - **`find . -name *.txt`**
  - **`find . -name haiku.txt # Ends up same as this`**
- Putting in single quotes prevents shell from expanding
  - **`find . -name '*.txt'`**
- Pretty similar to ls right?  But find lets us restrict our search
- Shell runs whatever is inside $() first
  - **`wc -l $(find . -name '*.txt')`**
- Same as this
  - **`wc -l ./data/one.txt ./data/two.txt ./haiku.txt`**
- We often string grep and find together
- Find all the .pdb files contained in the parent directory of this one, then look for FE in them.
  - **`grep "FE" $(find .. -name '*.pdb')`**

***---------- Socrative #15 ----------***


### Challenge

- Write a short explanatory comment for the following shell script:
  - **`wc -l $(find . -name '*.dat') | sort -n`**

