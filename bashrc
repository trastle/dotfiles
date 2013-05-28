# ---------------------------------------------------------------------
# .bashrc for OSX
# ---------------------------------------------------------------------

# Turn on colors (black background)
# ---------------------------------
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Some aliases I like
# -------------------
alias rebash="source ~/.bashrc"
alias ll="ls -la"
alias ls='ls -G'
alias quit='exit'
alias reboot='shutdown -r now'
alias wget="wget -c -t0 -T60" #Set wget to auto re-try downloads, give up after 60 seconds timeout
alias sss="s3cmd"


# Improve bash history
shopt -s histappend
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTCONTROL=ignoredups

alias gut="git" # fat fingers much
alias gst="git status"
alias sst="svn status" #Still lazy as ever

# Remove all files in an S3 bucket.
function sssrmrf {
    local s3dir="$1"
    s3cmd ls "$s3dir" | s3cmd del --recursive `awk '{print $2}'`
}

function zipdir
{
    if [ -z "$1"  ] || [ -z "$2" ] || [ -n "$3" ];
    then
       echo " "
       echo "INCORRECT USAGE:"
       echo "Expected: zipdir source destination"
       echo "Example:  zipdir  ./example ./example.zip"
       echo " "
    else
       zip -r "$2" "$1"
    fi
}

function searchdir
{
    find . -exec grep -H "$1" {} \;
}

function bgl
{
    if [ -z "$1" ];
    then
       echo " "
       echo "INCORRECT USAGE:"
       echo "Expected: bgl command"
       echo "Example:  bgl firefox"
       echo " "
    else
       $@ &
       disown
    fi
}

# Git SSH agent script
if [ -f ~/.git-ssh-agent.bash ]; then 
   source ~/.git-ssh-agent.bash
fi

# Git tab completion
if [ ! -f ~/.git-completion.bash ]; then 
    curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
source ~/.git-completion.bash


# SVN tab completion
if [ ! -f ~/.svn-completion.bash ]; then 
    curl http://svn.apache.org/repos/asf/subversion/trunk/tools/client-side/bash_completion -o ~/.svn-completion.bash
fi
source ~/.svn-completion.bash

# Source the local system specific bashrc.
if [  -f ~/.bashrc_local ]; then 
    source ~/.bashrc_local
fi


# Parse the SVN branch for use in the prompt
function get_svn_branch() {
    if test -d .svn; then
        local svn_dirty=$(svn status -q)
        local svn_branch=$(svn info | grep URL | sed -e 's/.*\///')

        if [ "$svn_branch" != "" ]; then
            local trimmed=`echo -ne "$svn_branch" | sed -e 's/^ *//g' -e 's/ *$//g'`
            echo -ne " SVN=$trimmed"
        fi
    fi
}

# Parse the git branch for use in the prompt
function get_git_branch() {
    local git_branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'`
    if [ "$git_branch" != "" ]; then
        local trimmed=`echo -ne "$git_branch" | sed -e 's/^ *//g' -e 's/ *$//g'`
        echo -ne " GIT=$trimmed"
    fi
}

# Just chain the two prompts together
function get_scm_branch(){
    get_svn_branch
    get_git_branch
}

export PS1="\u@\h\[\033[32m\]\$(get_scm_branch)\[\033[00m\] \W $ "

