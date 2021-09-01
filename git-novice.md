---
title: Git Guacamole
subtitle: Novice Git Lesson
...

**Credits to:**

1. Bryon Smith ([&#64;bsmith89](https://github.com/bsmith89)) for this.  He started [this lesson](https://github.com/bsmith89/git-novice-outline) & 
2. Dr. James Mickley @mickley who enhanced and extended. 

I've altered it a bit. Added the part on SSH keys. 

## Pre-Workshop Setup ##

~~~
mv ~/.gitconfig ~/.gitconfig~
mv ~/.bash_aliases ~/.bash_aliases~
PS1="$ "
~~~

-   Open lesson for PhDComics slide: <http://swcarpentry.github.io/git-novice/01-basics/>
-   Open hackmd slides <https://hackmd.io/@timdennis/HJ0a0nuBD#/>
-   Etherpad <https://pad.carpentries.org/2021-rt2>

### Open up Socrative again ###
-   You can import my quiz with 
-   Advise learners to go to <https://b.socrative.com/login/student/>
-   Type in **DENNIS3943** for the room name

**QUESTION: How many of you have used git or other version control software before?**

## 1. Introduction: Automated Version Control ##

-   Run thru slides 
-   Show the PhDComics slide
-   Talk about a time when git saved my ass!! 
-   Unlimited undo, helps us know what each change does: Who made it & why?
-   Lets people collaborate on the same code at the same time (Have you used google docs?)
-   All of these things are useful for repeatability, history, fixing problems etc.  
-   Introduce the concept of repositories and commits

## 2. Setting up Git ##

- Git needs to know who we are (so we know who changed what)

~~~
git config --global user.name "Vlad Dracula"
git config --global user.email "vlad@tran.sylvan.ia"
git config --global color.ui "auto"
git config --global core.editor "nano -w"
~~~ 

-   `git config --list`
-   To get help
    -   `git config --help` or git <command> -h
-   Talk about how git is run with subcommands `git <verb>`
    -   Kind of like saying bash <verb>.  Git is another commandline interpreter
-   If email privacy is needed: 
    - <https://help.github.com/articles/keeping-your-email-address-private/>

## 3. Creating a repository ##

#### Where does git store information

-   Create the repository

~~~
cd ~/Desktop
mkdir guacamole
cd guacamole
git init
~~~

-  We can check that it's there.  That `.git` folder stores all the data, don't delete!

~~~
ls -F -a`
~~~

~~~
git status
~~~

## 4. Tracking changes ##
#### Recording changes, checking status, and adding notes

-   `nano instructions.txt`
-   Write a super simple recipe (with bullet points)
    -   Chop avocados, squeeze lime, add salt, and mix well
-   `git status`
    -   One untracked file

~~~
git add instruction.txt
git status
~~~

-   Now git knows to keep track of instructions.txt, but it hasn't recorded changes yet
-   `git commit`
    -   Adding instructions.txt
    -   This is a short recipe for guacamole
    -   Usually we add a 50 character summary as a title, and then get more descriptive
-   Now that we've run commit, git saves it in the .git directory
-   Point out the identifier/hash
-   `git status`
-   `git log`


-   `nano instructions.txt`
-   Add "Enjoy!" as the last line
-   `git status`
    -   Point out the checkout to discard changes bit
-   `git diff`
-   Discuss how to read a diff

***---------- Socrative #1 ----------***

-   Instead of opening an editor, we can just put the commit message in the command

~~~
git commit -m "Edited the guacamole instructions"
~~~

-  What happened? 
-  Yes we need to add the file before we commit. Any thoughts on why? 

~~~
git status
git add instructions.txt
git commit -m "Edited the guacamole instructions
# what do you predict this will do?
git log
~~~

-   Show image of the three "areas" of git:
-   <https://hackmd.io/@timdennis/HJ0a0nuBD#/10>

-  Think of commit as taking a snapshot, 
-  And add as deciding what's in it
-  Staging area
    -  Lets us only commit some of our file changes. 
    -  Keep changes with a related theme together
 -  Why might we want to do this? 
 -  Yeah, this let's us be working on multiple files and bundle up changes that relate.
 -  There's an adage of committing early and often - we also like smaller commits
 -  This makes the commits easier to understand and gives us more flexibilty on rolling back.


***---------- Socrative #2 ----------***

***---------- Socrative #3 ----------***

- Let's add a new file `ingredients.txt`: 
- How do we do this? 
- Yes, we type:

~~~
nano ingredients.txt
~~~

Then in nano we add: 

~~~
2 Avocados, 
1 lime, 
2 tsp salt
~~~

* Let's see what we've done. 
* What command do we use to see the state of our repository? 

~~~
git status
git add ingredients.txt
git commit
~~~

* Add a new ingredient, onion, to both the instructions and the ingredients;

~~~
git status
git diff
git add .
git status
git commit -m "Added onion to the recipe"
~~~

-   Discuss changes to multiple files

~~~
git log
~~~ 

-   Our log is getting long, some solutions:
    -   navigate by: 
    -   d = down, u = up, q = quit
    -   Your up and down arrows work too

~~~
git log -2
git log --oneline
~~~

***---------- Socrative #4 ----------***


## 5. Exploring History ##
#### Identifying and recovering old versions of files, reviewing changes

-   Let's add another step to instructions.txt: **Squeeze orange**

~~~ 
nano instructions.txt 
~~~

- add "Squeeze orange" 
-   Remember when we learned that each commit has an identifier?
    -   The most recent commit is called HEAD, 

~~~
git diff HEAD instructions.txt
git diff HEAD~1 instructions.txt
~~~

-   `HEAD` refers to the most recent commit
-   `~1` means "minus one"

~~~
git log --oneline
git diff <HASH> instructions.txt
~~~

-   If we can see past states, we can also restore them!  Let's get rid of orange.

~~~
git status
git checkout HEAD instructions.txt
git status
cat instructions.txt
~~~

- Notice that reverting a small change is much easier becuase we've split our work up into multiple files.


***---------- Socrative #5 ----------***

***---------- Socrative #6 ----------***

### skip for RT2
## 6. Ignoring things (`.gitignore`) ##

-   What if we include some files that we don't want to track?
    -   `nano a.log`
    -   `nano b.log`
    -   `git status` could get obnoxious
    -   `nano .gitignore`
    -   `git status`
    -   `git add .gitignore`
    -   `git commit -m "Ignore some files."`
    -   `git status`
-   We could add anyway by using the -f force option
    -   `git add a.log`
    -   `git add -f a.log`
    -   `git status`
    -   `git reset HEAD .`
    -   `git status`
    -   `git status --ignored`


## 7. Remotes in Github ##

-   Git is great for collaboration!
-   Direct learners to make a github account and/or log in
-   Make a github repository called 'guacamole'
    -   This is like mkdir, cd, and git init on the GitHub server
    -   But we want to connect the two
-   Follow the instructions to add the remote repository
    -   Be sure to use the SSH instructions b/c as of last week this is required! 

![](https://librarycarpentry.org/lc-git/fig/github-repo-connect.png)

~~~
 git remote add origin [gitURL]
 git branch -M main
 git remote -v
~~~

### One more step: SSH setup 

-   SSH is now required and more secure, but it's more complicated to setup.
-   SORRY!!! 
  
1. Let's look in our .ssh folder. We do this b/c our key might already exist! 

~~~
ls -al ~/.ssh
~~~

* My output shows an empty folder 
* Your output is going to look a little different depending on whether or not SSH has ever been set up on the computer you are using. 
* If you have not set up SSH on you computer, your output will be like this: 

~~~
ls: cannot access '/c/Users/Vlad Dracula/.ssh': No such file or directory
~~~

* If SSH has been set up on the computer you’re using, the public and private key pairs will be listed. 
* The file names are either `id_ed25519/id_ed25519.pub` or `id_rsa/id_rsa.pub` depending on how the key pairs were set up.
* Who has your keys set? 
* Since they don’t exist on my computer, I'll uses this command to create them:

~~~
$ ssh-keygen -t ed25519 -C "vlad@tran.sylvan.ia"
~~~

If you are using a legacy system that doesn't support the Ed25519 algorithm, use:

~~~ 
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
~~~

~~~
Generating public/private ed25519 key pair.
Enter file in which to save the key (/c/Users/Vlad Dracula/.ssh/id_ed25519):
~~~

* We want to use the default file, so just press <kbd>Enter</kbd>.

~~~
Created directory '/c/Users/Vlad Dracula/.ssh'.
Enter passphrase (empty for no passphrase):
~~~

* Now, it is prompting us for a passphrase.  
* You can leave blank if you are the only one who uses your machine. 
* if not create a passphrase.  
* Be sure to use something memorable or save your passphrase somewhere, as there is no "reset my password" option. 

~~~
Enter same passphrase again:
~~~

* After entering the same passphrase a second time, we receive the confirmation

~~~
Your identification has been saved in /c/Users/Vlad Dracula/.ssh/id_ed25519
Your public key has been saved in /c/Users/Vlad Dracula/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:SMSPIStNyA00KPxuYu94KpZgRAYjgt9g4BA4kFy3g1o vlad@tran.sylvan.ia
The key's randomart image is:
+--[ED25519 256]--+
|^B== o.          |
|%*=.*.+          |
|+=.E =.+         |
| .=.+.o..        |
|....  . S        |
|.+ o             |
|+ =              |
|.o.o             |
|oo+.             |
+----[SHA256]-----+
~~~

* The "identification" is actually the private key. 
* You should never share it.  
* The public key is appropriately named.  
* The "key fingerprint" is a shorter version of a public key.

* Now that we have generated the SSH keys, we will find the SSH files when we check.

~~~
ls -al ~/.ssh
~~~

~~~
drwxr-xr-x 1 Vlad Dracula 197121   0 Jul 16 14:48 ./
drwxr-xr-x 1 Vlad Dracula 197121   0 Jul 16 14:48 ../
-rw-r--r-- 1 Vlad Dracula 197121 419 Jul 16 14:48 id_ed25519
-rw-r--r-- 1 Vlad Dracula 197121 106 Jul 16 14:48 id_ed25519.pub
~~~

Now we run the command to check if GitHub can read our authentication.  

~~~
ssh -T git@github.com
~~~

~~~
The authenticity of host 'github.com (192.30.255.112)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? y
Please type 'yes', 'no' or the fingerprint: yes
Warning: Permanently added 'github.com' (RSA) to the list of known hosts.
git@github.com: Permission denied (publickey).
~~~

* What happened?
* Right, we forgot that we need to give GitHub our public key!  
* First, we need to copy the public key.  Be sure to include the `.pub` at the end, otherwise you’re looking at the private key. 

~~~
cat ~/.ssh/id_ed25519.pub
~~~

~~~
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmRA3d51X0uu9wXek559gfn6UFNF69yZjChyBIU2qKI vlad@tran.sylvan.ia
~~~

1. Now, going to GitHub.com, click on your profile icon in the top right corner to get the drop-down menu.  
2. Click "Settings," then on the settings page, click "SSH and GPG keys," on the left side "Account settings" menu.  
3. Click the "New SSH key" button on the right side. 
4. Now, you can add the title (I us "Tim's Laptop" so he can remember where the original key pair files are located), paste your SSH key into the field, and click the "Add SSH key" to complete the setup.

Now that we’ve set that up, let’s check our authentication again from the command line. 

~~~
$ ssh -T git@github.com
~~~

~~~
Hi Tim! You've successfully authenticated, but GitHub does not provide shell access.
~~~

* Whew! give yourself a hand! That was a lot. 


### Pushing our Changes 

-   The name origin is the local nickname for the remote repository.  
-   Push our local repository to the remote
    -   `git push origin main`
    -   Pushing branch main to origin
-   Explore the repository on github
    -   Viewing files, seeing history of file, editing
-   Show students that local changes which are NOT committed don't end up on the remote.
-   Ask students to discuss the difference between 'commit' and 'push'.
-   To get the latest version FROM the remote:

~~~
git pull origin main`
~~~

## 8. Collaborating ##

-   Pair students up into groups of two.
-   One student should add the other as a collaborator
    - Explain git clone

~~~
cd ~/Desktop
git clone https://github.com/jt14den/guacamole.git ~/Desktop/james-guacamole
cd james-guacamole
~~~

-   Make changes and push back to the collaborator's repository.
-   Back in your original repository:

~~~
git pull origin main
git status
~~~

-   Pull the collaborators changes to your own repository.
-   Check out the result.

## 9. Conflicts ##
#### How git handles conflicts

-   When people are working in parallel (or on 2 computers), there's a chance they could both edit the same file & line 
-   So let's make one, and see what happens and what to do about it
-   Make a change to your collaborators `instructions.txt`.
-   Push that change upstream.
-   Make (and commit) a different change to _your_ `instructions.txt` **on the same
    line as your collaborator changed**.
-   `git push origin main`

-   What happened?  Git detected overlap and prevented us from messing it up
-   We now have to get the changes from the server, and merge them with ours

~~~
git pull origin main
git status
cat instructions.txt
~~~

- HEAD is your version, the commit id is the version on the github repository (your collaborator's)
-  You need to rectify things first before you can send it back to the repository

~~~
nano instruction.txt
git add instuctions.txt
git status
git commit <...>  
~~~~

This actually is the merge:

~~~
git log
git push origin main
~~~

-   In practice, it's a good idea to run `git pull origin main` before making changes
-   Show them how to comment on a diff in Github
-   Merging is another reason to split up changes into small groups of files


## Fork and Create a PULL REQUEST practice (larger scale)

1. Go to this repository I made:  https://github.com/ucla-data-archive/git-collaboration
2. Click on the 'fork'  - this will make a copy of my repo into your account - notice how they are linked
3. Inside the countries folder, edit one country and provide the information needed 
4. Add a commit message and save. 
5. Navigate to the repository home page, you should see a note above the files "This branch is 1 commit ahead of jt14den:master." with a "Pull Request" link towards the right. 
6. Click on the "Pull Request" and then 'Create pull request button" - leave a short message and add to it if you need to say more, then "Create pull request"
7. This will send a message to me (the owner of the repository you forked from), that you have changes you want me to incorporate in my repository.
8. I'll merge your changes, initiate a discussion about your changes, or resolve conflicts if needed. 
9. This is how changes and improvements are incorporated in the Carpentries and most big coding projects

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
