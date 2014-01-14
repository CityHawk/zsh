export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:$HOME/.rvm/bin
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export EDITOR="mvim -f"

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git)

# Override stupid knife plugin behavior

KNIFE_COOKBOOK_PATH=("cookbooks" "community-cookbooks")

ZSH_THEME=cityhawk
plugins=(git osx ruby gem history-substring-search extract brew pip knife rvm tmuxinator git-extras cp terminalapp zsh-syntax-highlighting)

setopt PROMPT_SUBST
source $ZSH/oh-my-zsh.sh
unsetopt auto_cd
unsetopt cdablevarS
#
# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
  if [[ -x `which dircolors` ]]; then
    eval `dircolors -b`
    alias 'ls=ls --color=auto'
    alias grep='grep --colour=auto'
  fi
fi


# Customize to your needs...

alias ncssh="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $@"
#alias knife_pp2="knife $argv -c $HOME/.chef/ppctest.rb"

# Use MacVim on a Mac
if [ 'Darwin' = `uname -s` ];
then
    alias vim="/Applications/MacVim.app/Contents/MacOS/Vim $@"
fi

export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim

alias -g L='|less'
alias -g H='|head'
alias -g T='|tail'
alias truecrypt='/Applications/TrueCrypt.app/Contents/MacOS/Truecrypt --text'

server_mount() {
    mkdir -p /Volumes/$1
    sshfs $1: /Volumes/$1 -oasync
}

if [ "`uname`" = "Darwin" ]; then
compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
   alias run='open -a'
fi


source ~/zsh/locals.zsh
zstyle ':completion:*' hosts off

expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
rvm use 2.0.0-p353

