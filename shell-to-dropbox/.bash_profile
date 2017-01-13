#!/bin/bash

#LogDir=~/Application\ Libraries/Dropbox/SWC

#script -q "$LogDir/shell.txt"

# Setup the terminal: just the directory path we're in
#export PS1="\n\w: \$ "
export PS1="\n$ "

# Move the contents of Desktop to a folder in the HOME directory
#mkdir ~/Contents
#mv ~/Desktop/* ~/Contents/

# Download and unzip the data
#cd ~/Desktop
#wget http://swcarpentry.github.io/shell-novice/data/shell-novice-data.zip
#unzip shell-novice-data.zip

# Setup aliases for recording to a file
# Usage: record [foldername] [filename] to start recording.  Foldername must already exist
record () { 
	LogDir="~/Application\ Libraries/Dropbox/SWC"; 
	Lines="wc -l < $LogDir/shell.txt"; 
	export PROMPT_COMMAND="tail -n +$(expr $(eval $Lines) + 2) $LogDir/shell.txt | perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | col -b > $LogDir/$1/$2"; 
}
alias stop='export PROMPT_COMMAND=""'
alias prompt='echo "export PS1=\"\n\w: \$ \""'
alias simple='echo "export PS1=\"\n$ \""'

# Clear history
history -c
