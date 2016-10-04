# Git Guacamole

*Credits to Bryon Smith ([@bsmith89](https://github.com/bsmith89)) for this.  He started [this lesson](https://github.com/bsmith89/git-novice-outline), and I've merely added to it*

## Pre-Workshop Setup ##

**`mv ~/.gitconfig ~/.gitconfig~`**
**`mv ~/.bash_aliases ~/.bash_aliases~`**
**`PS1="$ "`**

### Open up Socrative again ###
- You can import my quiz with SOC-24313213
- Advise learners to go to https://b.socrative.com/login/student/
- Type in MICKLEY for the room name

**QUESTION: How many of you have used git or other version control software before?**


## 1. Introduction: Automated Version Control ##

-   Show the PhDComics slide
-   Talk about a time when git saved my ass
-   Introduce the concept of repositories and commits
-   Lets people collaborate on the same code at the same time (Have you used google docs?)
-   Unlimited undo, helps us know what each change does: Who made it & why?
-   All of these things are useful for repeatability, history, fixing problems etc.  

## 2. Setting up Git ##

- Git needs to know who we are (so we know who changed what)
    -   **`git config --global user.name "Vlad Dracula"`**
    -   **`git config --global user.email "vlad@tran.sylvan.ia"`**
    -   **`git config --global color.ui "auto"`**
    -   **`git config --global core.editor "nano -w"`**
-   **`git config --list`**
-   To get help
    -   **`git config --help`** or git <command> -h
-   Talk about how git is run with subcommands **`git <verb>`**
    -   Kind of like saying bash <verb>.  Git is another commandline interpreter
-   If email privacy is needed: 
    - https://help.github.com/articles/keeping-your-email-address-private/

## 3. Creating a repository ##
#### Where does git store information

-   Create the repository
    -   **`cd ~/Desktop`**
    -   **`mkdir guacamole; cd guacamole`**
    -   **`git init`**
-   We can check that it's there.  That .git folder stores all the data, don't delete!
    -   **`ls -F -a`**
-   **`git status`**

## 4. Tracking changes ##
#### Recording changes, checking status, and adding notes

-   **`nano instructions.txt`**
-   Write a super simple recipe (with bullet points)
    -   Chop avocados, squeeze lime, add salt, and mix well
-   **`git status`**
    -   One untracked file
-   **`git add instruction.txt`**
-   **`git status`**
-   Now git knows to keep track of instructions.txt, but it hasn't recorded changes yet
-   **`git commit`**
    -   Adding instructions.txt
    -   This is a short recipe for guacamole
    -   Usually we add a 50 character summary as a title, and then get more descriptive
-   Now that we've run commit, git saves it in the .git directory
-   Point out the identifier/hash
-   **`git status`**
-   **`git log`**


-   **`nano instructions.txt`**
-   Add "Enjoy!" as the last line
-   **`git status`**
    -   Point out the checkout to discard changes bit
-   **`git diff`**
-   Discuss how to read a diff

***---------- Socrative #1 ----------***

-   Instead of opening an editor, we can just put the commit message in the command
    -   **` git commit -m "Edited the guacamole instructions`**
    -   Oops, we need to add the file first
    -   **`git status`**
    -   **`git add instructions.txt`**
    -   **` git commit -m "Edited the guacamole instructions`**
-   **`git log`**
-   Draw a diagram of the three "areas" of git
    -   [filesystem] -->add [staging area] -->commit [repository]
    -   Think of commit as taking a snapshot, and add as deciding what's in it
    -   Staging area
        -   Lets us only commit some of our file changes. 
        -   Keep changes with a related theme together


***---------- Socrative #2 ----------***

***---------- Socrative #3 ----------***


-   Add a new file **`ingredients.txt`**: 2 Avocados, 1 lime, 2 tsp salt
    -   **`git status`**
    -   **`git add ingredients.txt`**
    -   **`git commit`**
-   Add a new ingredient, onion, to both the instructions and the ingredients;
    -   **`git status`**
    -   **`git diff`**
    -   **`git add .`**
    -   **`git status`**
    -   **`git commit -m "Added onion to the recipe"`**
-   Discuss changes to multiple files
-   **`git log`**
-   Our log is getting long, some solutions:
    -   d = down, u = up, q = quit
    -   **`git log -2`**
    -   **`git log --oneline`**


***---------- Socrative #4 ----------***


## 5. Exploring History ##
#### Identifying and recovering old versions of files, reviewing changes


-   Let's add another step to instructions.txt: Squeeze orange
-   Remember when we learned that each commit has an identifier?
    -   The most recent commit is called HEAD, 
-   **`git diff HEAD instructions.txt`**
-   **`git diff HEAD~1 instructions.txt`**
-   **`HEAD`** refers to the most recent commit
-   **`~1`** means "minus one"
-   **`git log --oneline`**
-   **`git diff <HASH> instructions.txt`**

-   If we can see past states, we can also restore them!  Let's get rid of orange.
-   **`git status`**
-   **`git checkout HEAD instructions.txt`**
-   **`git status`**
-   **`cat instructions.txt`**
-   Notice that reverting a small change is much easier becuase we've split
    our work up into multiple files.


***---------- Socrative #5 ----------***

***---------- Socrative #6 ----------***


## 6. Ignoring things (**`.gitignore`**) ##

-   What if we include some files that we don't want to track?
    -   **`nano a.log`**
    -   **`nano b.log`**
    -   **`git status`** could get obnoxious
    -   **`nano .gitignore`**
    -   **`git status`**
    -   **`git add .gitignore`**
    -   **`git commit -m "Ignore some files."`**
    -   **`git status`**
-   We could add anyway by using the -f force option
    -   **`git add a.log`**
    -   **`git add -f a.log`**
    -   **`git status`**
    -   **`git reset HEAD .`**
    -   **`git status`**
    -   **`git status --ignored`**


## 7. Remotes in Github ##

-   Git is great for collaboration!
-   Direct learners to make a github account and/or log in
-   Make a github repository called 'guacamole'
    -   This is like mkdir, cd, and git init on the GitHub server
    -   But we want to connect the two
-   Follow the instructions to add the remote repository
    -   Be sure to use HTTPS
    -   SSH is preferred and more secure, but it's more complicated to setup
    -   **`git remote add origin [URL]`**
    -   **`git remote -v`**
    -   The name origin is the local nickname for the remote repository.  
-   Push our local repository to the remote
    -   **`git push origin master`**
    -   Pushing branch master to origin
-   Explore the repository on github
    -   Viewing files, seeing history of file, editing
-   Show students that local changes which are NOT committed don't end up on the remote.
-   Ask students to discuss the difference between 'commit' and 'push'.
-   To get the latest version FROM the remote:
    -   **`git pull origin master`**



## 8. Collaborating ##

-   Pair students up into groups of two.
-   One student should add the other as a collaborator
    - Explain git clone
    -   **`cd ~/Desktop`**
    -   **`git clone https://github.com/mickley/guacamole.git ~/Desktop/james-guacamole`**
    -   **`cd james-guacamole`**
-   Make changes and push back to the collaborator's repository.

-   Back in your original repository:
    -   **`git pull origin master`**
    -   **`git status`**
    -   Pull the collaborators changes to your own repository.
    -   Check out the result.

## 9. Conflicts ##
#### How git handles conflicts

-   When people are working in parallel (or on 2 computers), there's a chance they could both edit the same file 
-   So let's make one, and see what happens and what to do about it

-   Make an arbitrary change to your collaborators **`instructions.txt`**.
-   Push that change upstream.
-   Make (and commit) a different change to _your_ **`instructions.txt`** **on the same
    line as your collaborator changed**.
-   **`git push origin master`**

-   What happened?  Git detected overlap and prevented us from messing it up
-   We now have to get the changes from the server, and merge them with ours
-   **`git pull origin master`**
-   **`git status`**
-   **`cat instructions.txt`**
-   HEAD is your version, the commit id is the version on the github repository (your collaborator's)
-   You need to rectify things first before you can send it back to the repository
    -   **`nano instruction.txt`**
    -   **`git add instuctions.txt`**
    -   **`git status`**
    -   **`git commit <...>`**  This actually is the merge
-   **`git log`**
-   **`git push origin master`**

-   In practice, it's a good idea to run **`git pull origin master`** before making changes
-   Show them how to comment on a diff in Github
-   Merging is another reason to split up changes into small groups of files

## 15. Branching ##

-   Branching is just collaboration with yourself.  
-   You're carrying on a parallel line of thought
-   Experiment with reformatting your entire thesis without risking your progress.
-   Or rewrite a paper for a particular publication

## 13. Hosting

-   One nice thing about git is that it's "distributed"
    -   Any git repository can also be the server, there's no need for a central server
    -   So two users can just collaborate with each other without the need for github etc.
    -   It's also easy to move from github to some other service
-   But websites like GitHub are very useful.  They're a little nicer than the commandline version of git.
    -   Github, however, is built on openness.  By default all repositories are public
    -   This may not be ideal for you, or may even be illegal (HIPAA)
    -   Some options:
        1.  Use another service that allows private repositories.  Gitlab and Bitbucket are a bit better.  
        2.  Apply for gitlab for Educational Use: https://education.github.com/discount_requests/new
        3.  Setup a computer as a server at your institution.  More maintainence but you have control
            -   You can even install your own private Gitlab or BitBucket

## 10. Open Science ##
    
    -   This is basically an electronic lab notebook
    -   It's also a good way to share information for reproducibility
        -   The data, and code are there together.  Maybe also figures or the paper itself

## 14. Using Git from RStudio ##

## 11. Licensing ##

## 12. Citation ##
