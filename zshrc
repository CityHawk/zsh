# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

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

ZSH_THEME=cityhawk
#ZSH_THEME=fishy
plugins=(git osx ruby gem zsh-syntax-highlighting zsh-history-substring-search taskwarrior knife extract macports)

setopt PROMPT_SUBST
source $ZSH/oh-my-zsh.sh
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
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin:/opt/local/bin:/usr/X11R6/bin:/usr/local/mysql/bin

alias ppp="cd ~/workspace/paypal-cloud-ppc"
alias cssh="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $@"
alias yatr="/opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin/yaslov $@"
#alias knife_pp2="knife $argv -c $HOME/.chef/ppctest.rb"
#alias knife_pp4="knife $argv -c $HOME/.chef/ppc4.rb"
#alias knife_pp6="knife $argv -c $HOME/.chef/ppc6.rb"
#knife_pp9 () { knife $* -c $HOME/.chef/ppc9.rb }
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim $@"
alias -g L='|less'
alias -g H='|head'
alias -g T='|tail'

cleanMediaFlash() { 
    pushd $argv
    rm -rf .Spotlight-V100
    rm -rf .Trashes 
    rm -rf ._.Trashes
    rm -rf .fseventsd
    find . -name "\._*" -exec rm -rf "{}" \;  
    popd 
    hdiutil eject $argv 
}
#cleanMediaFlash="pushd $@; rm -rf .Spotlight-V100; rm -rf .Trashes; rm -rf ._.Trashes; rm -rf .fseventsd; find . -name \"\._*\" -exec rm -rf "{}" \;; popd; hdiutil eject $@"

