# Add custom script directory to path
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# Start typing part of a command and up/down arrows will only jump to those
# commands in the history which start with the same fragment of a command.
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# some more ls aliases
alias ls='ls --color=auto -F -h'
alias ll='ls -l'
alias la='ls -A'
alias l='ls'
alias g='git'
alias c='gcloud'
alias diff='diff --color=auto'
alias dfd='df -h | grep -e "/dev/sd" -e "Filesystem" --color=never'
alias psx='ps axfo pid,euser,egroup,args'
alias rm_junk='rm *:Zone.Identifier *:com.dropbox.attrs'

# Command aliases
alias o='xdg-open'
alias date_update='sudo timedatectl set-ntp off && sudo timedatectl set-ntp on'

# setup autocompletion for git alias
if [ -f "/usr/share/bash-completion/completions/git" ]; then
  source /usr/share/bash-completion/completions/git
  __git_complete g __git_main
else
  echo "Error loading git completions"
fi
