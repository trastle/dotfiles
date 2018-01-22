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

# OSX ssh auto complete
if [ -f ~/.ssh-complete.bash ]; then
   source ~/.ssh-completion.bash
fi

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

# kops completion (if kops installed)
if [ -x "$(command -v kops)" ]; then
    kops completion bash >> ~/.kops-completion.bash
    source ~/.kops-completion.bash
fi

# kubectl completion (if kubectl installed)
if [ -x "$(command -v kubectl)" ]; then
    kubectl completion bash >> ~/.kubectl-completion.bash
    source ~/.kubectl-completion.bash
fi

# kubectx completion
if [ -f ~/.kubectx-completion.bash ]; then
   source ~/.kubectx-completion.bash
fi

# terraform completion
if [ -f ~/.terraform-completion.bash ]; then
   source ~/.terraform-completion.bash
fi

# Add the local system bash setup
if [  -f ~/.local.bash ]; then
    source ~/.local.bash
fi

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
