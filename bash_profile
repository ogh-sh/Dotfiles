echo " .bash_profile loaded"

export rc="~/Dotfiles/bashrc"

# Run .bashrc file for both login and non-login shells
if [ -f "$HOME/Dotfiles/bashrc" ]; then
    source "$HOME/Dotfiles/bashrc"
fi
