#!/bin/bash
# Install the various config files in the current user's home directory.

# Create a link to one of the config files in the home directory.
# Clean up any file or link that is already there.
function doLink {
   local fileName="$1"
   if [ -L ~/."$fileName" ]; then
       unlink ~/."$fileName"
   elif [ -f ~/."$fileName" ]; then
       mv ~/."$fileName" ~/."$fileName"_old
   fi
   ln -s `pwd`/"$fileName" ~/."$fileName" 
}

# Main
doLink bash_profile
doLink bashrc
doLink vimrc
doLink inputrc
doLink git-ssh-agent.bash

mkdir -p ~/.config/terminator
