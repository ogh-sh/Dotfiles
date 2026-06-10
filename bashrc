echo " .bashrc loaded"

########## BREW ##########
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/opt/homebrew/bin:$PATH"

# Unistall via brew
function _8uninstallBrewApp() {
  brew uninstall "$1"
  brew autoremove
  brew cleanup -s
}

# Weekly macOS maintenance
function _8BrewMaintenance() {
  # Update Applications
  brew update
  brew upgrade
  brew cleanup -s
  brew doctor
}

########## SHELL CONFIG (BASH) ##########
alias lvl="echo $SHLVL"

# Add vi-mode in bash
set -o vi

# Set CLICOLOR
export CLICOLOR=1

# Set shell history file
export HISTFILE="$HOME/.local/state/bash_history"

# Stop creating session files
export SHELL_SESSION_HISTORY=0

# Append to bash history instead of overwritting
shopt -s histappend

# Don't add to historyduplicates or lines begining with a space to history
export HISTOCONTROL=ignoreboth

# Set history format to include timestamps
export HISTTIMEFORMAT="%Y-%m-%d %T"

# XDG_DATA_HOME - defaults to $HOME/.local/share/
# XDG_CONFIG_HOME - defaults to $HOME/.config/
# XDG_CACHE_HOME - defaults to $HOME/.cache/

########### STARSHIP ###################

eval "$(starship init bash)"
export STARSHIP_CONFIG=~/Dotfiles/config/starship.toml

########## SSH ##########

# Add ssh key when starting a session
eval "$(ssh-agent -s)"
echo "󰯄 ssh-agent started"

########## VIM / NVIM ##########

export EDITOR=nvim

########## THE FUCK ##########

# Fix misstyped commands
eval "$(thefuck --alias)"

##########  LS / EZA  ##########
export EZA_USE_FZF=true
export EZA_ICON_SPACING=2

alias ll="eza --all --icons --color=always --group-directories-first"
alias ls="eza --icons --color=always --group-directories-first"

########## CD + ZOXIDE ##########

eval "$(zoxide init bash)"

# Change directory even if path is misstyped without cd
shopt -s autocd

# Change directory and list files
_8cdls() {
  cd "$1" && eza --all --icons=always --color=always --group-directories-first
}

alias cd="_8cdls"

########## MKDIR ##########

# Create directory and enter it
function _8mkcd() {
  mkdir "$1" && cd "$1" && eza --all --icons=always --color=always --group-directories-first
}

alias mkcd="_8mkcd"

########## BAT ##########

export BAT_STYLE="full"
export BAT_CONFIG_PATH="$HOME/.config/bat/config"
export BAT_CONFIG_DIR="$HOME/.config/bat/"

alias cat="bat -f"

########## FZF ##########
eval "$(fzf --bash)"

export FZF_DEFAULT_OPTS="--preview 'if [ -d {} ]; then eza --tree --color=always {}; else bat --color=always --style=numbers --line-range=:500 {}; fi'"

##########  LESS + MAN ##########

export LESSHISTFILE=-
# 31 – red, 32 – green, 33 – yellow, 0 – reset/normal, 1 – bold, 4 – underlined
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESSHISTFILE=-

export MANPAGER="less -R --use-color -Dd+r -Du+b"

########## TLDR ##########

alias tlds="tldr -C"

########## ATUIN #########

eval "$(atuin init bash)"

alias asr="atuin scripts run"
alias asl="atuin scripts list"

############ YAZI ############

alias yz="yazi"

##########  JQ ##########

alias jq="jq --color-output"

##########  GIT ##########

export GIT_CONFIG_GLOBAL=$HOME/Dotfiles/config/git/gitconfig

alias ga="git add ."
alias gc="git commit -m"
alias gcl="git clone"
alias gd="git diff"
alias gi="git init"
alias gl="git log"
alias gp="git pull"
alias gpsh="git push"
alias gs="git status"

##########  NODE ##########

alias npi="npm init"
alias nps="npm start"
alias npr="npm run"

##########  NVM COMPLETION ##########

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

######### PYTHON ##########

# Help python find openSSL
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

##########  RUBY ##########

if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=$(gem environment gemdir)/bin:$PATH
fi
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

##########  JAVA ##########

export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

##########  POSTGRESQL ##########

#export PATH="/opt/homebrew/Cellar/postgresql@17/17.4_1/bin:$PATH"

##########  OPENSSL ##########

# Generate new key and CSR
function _8createCSR() {
  openssl req -new -newkey rsa:"$1" -keyout "$1".key -out "$1".csr
}

# Read CSR
function _8readCSR() {
  openssl req -text -in "$1" -noout
}

#TODO: Sign CSR
function _8signCSR() {
  openssl x509 -req -in request.csr -CA domainCAPrivate.pem -CAKey CAPrivate.key -CAcreateserial -extfile metadata.ext -out cert_name.crt -days 365 -sha256
}

# Read info from .pem files
function _8readPEM() {
  openssl x509 -in "$1" -noout -text
}

# Read info from .p12 files
function _8readP12() {
  openssl pkcs12 -info -nodes -in "$1"
}

# Extract certificate from p12 and get cert info
function _8extractP12() {
  openssl pkcs12 -in "$1" -out out.crt -nokeys
  openssl x509 -in out.crt -text -noout
}

##########  GO ##########

export PATH=$PATH:/opt/homebrew/bin/go

########## BOOKMARKS  ##########

alias @home="cd \$HOME && yazi"
alias @dotfiles="cd \$HOME/Dotfiles && yazi"
alias @config="cd \$HOME/Dotfiles/config/ && yazi"

alias +rc="source \$HOME/Dotfiles/bashrc"
alias *rc="nvim \$HOME/Dotfiles/bashrc"

alias @dt="cd \$HOME/Desktop/ && yazi"
alias @dw="cd \$HOME/Downloads/ && yazi"
alias @dc="cd \$HOME/Documents && yazi"

alias @oghsh="cd \$HOME/Work/Projects/Personal/_oghsh && tree -L 2"
alias @soda="cd \$HOME/Work/Projects/Personal/_SODA-Studios/ && tree -L 2"

alias @wrk="cd \$HOME/Work/ && yazi"
alias @prj="cd \$HOME/Work/Projects/ && yazi"
alias @sdbx="cd \$HOME/Work/Sandbox/ && yazi"

##########  SCRIPTS / UTILS/ FUNCTIONS ##########
alias @res="cd \$HOME/Work/_RESOURCES/ && yazi"

## Remove .DS_Store files in current directory
alias rmd="rm -rf"
alias rmds="find . -type f -name ".DS_Store" -exec rm -rf {} +"

# Clear the screen
alias cls="clear"

# Get week number
alias wk='date +%V'

# Get public IPv4
alias ip="dig +short txt ch whoami.cloudflare @1.0.0.1"

# Check login attempts
function _8checkLogins {
  tail -n 10 -f /var/log/auth.log
}

##########  END .bashrc ##########
