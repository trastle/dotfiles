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
alias installhomebrew='ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"'

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

# Git tab completion
if [ ! -f ~/.git-completion.bash ]; then 
    curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
source ~/.git-completion.bash

# homebrew tab completion
if [ ! -f ~/.homebrew-completion.bash ]; then 
   curl https://gist.github.com/ktheory/774554/raw/b5552619c8dcac38f954bcfb7bde9ff879de46fc/brew_completer.sh -o ~/.homebrew-completion.bash
fi
source ~/.homebrew-completion.bash


if [  -f ~/.local.bash ]; then 
    source ~/.local.bash
fi

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
