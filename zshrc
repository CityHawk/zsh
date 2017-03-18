source $HOME/zsh/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  # Guess what to install when running an unknown command.
  command-not-found
  git
  git-extras
  osx
  ruby
  gem
  extract
  brew
  pip
  knife
  rvm
  cp
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
EOBUNDLES
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions

# Tell Antigen that you're done.
antigen-apply

# that's my theme. I need it
source  ~/zsh/themes/cityhawk.zsh-theme

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
source ~/zsh/locals.zsh
