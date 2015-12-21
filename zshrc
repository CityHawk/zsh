export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:$HOME/.rvm/bin
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

KNIFE_COOKBOOK_PATH=("cookbooks" "community-cookbooks")

ZSH_THEME=cityhawk
plugins=(git
osx
ruby
gem
history-substring-search
extract
brew
pip
knife
rvm
git-extras
cp
zsh-syntax-highlighting
vagrant
aws
common-aliases
bundler
vim-interaction
sudo
web-search
z
httpie
ssh-agent
)

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

# Use MacVim on a Mac
# if [ 'Darwin' = `uname -s` ];
# then
#     alias vim="/Applications/MacVim.app/Contents/MacOS/Vim $@"
# fi

# export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim

alias truecrypt='/Applications/TrueCrypt.app/Contents/MacOS/Truecrypt --text'


server_mount() {
    mkdir -p /Volumes/$1
    sshfs $1: /Volumes/$1 -oasync
}

if [ "`uname`" = "Darwin" ]; then
compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
   alias run='open -a'
fi

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
# rvm use 2.0.0-p353
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
# ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=red,bold'
# ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow,bold'
# ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'
# ZSH_HIGHLIGHT_STYLES[cursor]='bg=blue'

source ~/zsh/locals.zsh

function postCallVim
{
  osascript -e 'tell application "MacVim" to activate'
}

if [[ -x /usr/local/bin/thefuck ]]
then
    eval $(thefuck --alias)
fi
