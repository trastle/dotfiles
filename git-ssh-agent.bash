# SSH setup for git, originally copied from:
# https://confluence.atlassian.com/display/BITBUCKET/Set+up+SSH+for+Git
# Some changes made to deal with my non-default ssh key names.

SSH_ENV="$HOME/.ssh/environment"
  
# start the ssh-agent
function git-ssh-start-agent {
    echo "No SSH agent running, initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo "New SSH agent successfully initialised, adding keys..."
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    git-ssh-add-keys
}
  
# test for identities
function git-ssh-test-identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        git-ssh-add-keys
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            git-ssh-start-agent
        fi
    fi
}

# Import all of my ssh keys into the agent
function git-ssh-add-keys {
    find ~/.ssh/. | grep _rsa$ | xargs ssh-add $1
    find ~/.ssh/. | grep _dsa$ | xargs ssh-add $1
}
 
# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
    test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        git-ssh-test-identities
    else
        git-ssh-start-agent
    fi
fi
