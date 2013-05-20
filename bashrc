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

# improve bash history
shopt -s histappend
# Store 10000 commands in bash history
export HISTFILESIZE=10000
export HISTSIZE=10000
# Don't put duplicate lines in the history
export HISTCONTROL=ignoredups

alias gut="git" # fat fingers much
alias gst="git status"

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


# Pretty prompt with GIT and SVN support
if [ ! -f ~/.pretty.bash ]; then 
    curl https://raw.github.com/KeyboardCowboy/Bash-Beautify/master/.bash_beautify -o ~/.pretty.bash
fi
source ~/.pretty.bash


if [  -f ~/.bashrc_local ]; then 
    source ~/.bashrc_local
fi

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h$(vcs_branch): \w \$ "



