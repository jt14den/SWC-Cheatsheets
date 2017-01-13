#!/bin/bash

LogDir=~/Application\ Libraries/Dropbox/SWC

# The script utility records all terminal activity.  
# -q = quiet mode, -t 5 flushes to disk every 5 seconds
script -q -t 5 "$LogDir/shell.txt"

# Needs to be done manually
#source .bash_profile
