#! /bin/sh

# Reference: https://macos-defaults.com/
# Note that some of these changes require a logout/restart to take effect.

# Environment variables
export COMPUTER_NAME="minima"
export HOST_NAME="minima"
export LOCALHOST_NAME="minima"
export NETBIOS_NAME="minima"
export USER="octa"
export TIMEZONE="Europe/Bucharest"

echo "Starting macOS configuration ..."

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change

osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront

sudo -v

# Keep-alive: update existing `sudo` time stamp until setup has finished

while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

#HOMEBREW SETUP

# Install Homebrew dependencies

#TODO: Make silent install

xcode-select --install

# Install Rosetta2 for macOS

softwareupdate --install-rosetta --agree-to-license

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Bash

brew install bash

# Add bash as login shell

sudo echo '/opt/homebrew/bin/bash' >>/etc/shells

# Set bash as default shell for current user
# TODO: Make this for generic logged in user instead of hardcoded

chsh -s /opt/homebrew/bin/bash $user

# Link shell config files

ln -s $HOME/Dotfiles/bash_profile $HOME/.bash_profile

########## OS - GENERAL ##########

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window

sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

########## DESKTOP & SCREENSAVER ##########

#TODO: Set a custom wallpaper image.

########## DESKTOPS/ WORKSPACES ##########

# Set reduce motion for animation when switching desktops

# defaults write com.apple.Accessibility ReduceMotionEnabled -int 1

########## DOCK ##########

# Set dock position to the right

defaults write com.apple.dock "orientation" -string "right" && killall Dock

# Make the Dock instantly leap back into view when it’s needed, rather than slide

defaults write com.apple.dock autohide-time-modifier -int 0 && killall Dock

# Enable highlight hover effect for the grid view of a stack (Dock)

defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 36 pixels

defaults write com.apple.dock tilesize -int 36

# Change minimize/maximize window effect

defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon

defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items

defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock

defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock (This is only really useful when setting up a new Mac, or if you don’t use the Dock to launch apps.)

# defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock

# defaults write com.apple.dock static-only -bool true

# Don’t animate opening applications from the Dock

# defaults write com.apple.dock launchanim -bool false

########## MISSION CONTROL ##########

# Speed up Mission Control animations

defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)

defaults write com.apple.dock expose-group-by-app -bool false

# Disable Dashboard

defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space

defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use

defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay

defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock

defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock

defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent

defaults write com.apple.dock showhidden -bool true

########## SIRI ##########

# TODO: Siri > Voice Feedback = off

# TODO: Accesibility > Enable type to Siri

########## SPOTLIGHT ##########

# TODO: Implement Spotlight defaults

########## LANGUAGE & REGION ##########

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.

# defaults write NSGlobalDomain AppleLanguages -array "en" "ro"

defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Show language menu in the top right corner of the boot screen

sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values

sudo systemsetup -settimezone "Europe/Bucharest" >/dev/null

# Disable automatic capitalization (annoying when typing code)

defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes (annoying when typing code)

defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution (annoying when typing code)

defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as (annoying when typing code)

defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct

defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

########## INTERNET ACCOUNTS ##########

# TODO: Implement macOS internet account defaults

########## PASSWORDS ##########

# TODO: Implement macOS passwords defaults

########## USERS & GROUPS ##########

# TODO: Implement macOS users and groups defaults

########## ACCESIBILITY & SCREEN TIME ##########

# TODO: Implement

########## EXTENSIONS ##########

# TODO: Implement

########## SECURITY & PRIVACY ##########

# TODO: Implement

########## SOFTWARE UPDATE ##########

# TODO: Implement

########## NETWORK ##########

# TODO: Implement

########## BLUETOOTH, SOUND, KEYBOARD, TRACKPAD & MOUSE ##########

# TODO: Implement

# Turn off Scroll direction: Natural

defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)

defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Increase tracking speed

# TODO: Implement

# Increase scrolling speed

# TODO: Implement

########## DISPLAYS ##########

# TODO: Implement

########## PRINTERS & SCANNERS ##########

# TODO: Implement

########## ENERGY SAVER ##########

# TODO: Implement

########## DATE AND TIME ##########

# TODO: Implement

########## SHARING ##########

# Set computer name (via System Preferences → Sharing)
#TODO: Change to use global variables

sudo scutil --set ComputerName "${computer_name}"
sudo scutil --set HostName "${host_name}"
sudo scutil --set LocalHostName "${localhost_name}"

sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${netbios_name}"

########## TIME MACHINE ##########

# TODO: Implement

########## STARTUP DISK ###########
# TODO: Implement

########## FINDER ##########

# TODO: Show Recents, MacintoshHD, Applications, home dir, Desktop, Documents, Downloads and Airdrop in sidebar

# Set sidebar icon size to large

defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 3

# Set home dir as the default location for new Finder windows.

defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Use column view (`clmv`) in all Finder windows by default. Four-letter codes for the other view modes: icon view (`icnv`), gallery view(`glyv`), list view (`Nlsv`)

defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Finder: show status bar

defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar

defaults write com.apple.finder ShowPathbar -bool true

#TODO: Finder: show tab bar

# Finder: show hidden files by default

defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions

defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: Show icons for hard drives, servers, and removable media on the desktop

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Disable the warning when changing a file extension

defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# TODO: View options: Text size 16, Group by None, Sort by name

# Keep folders on top when sorting by name

defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Avoid creating .DS_Store files on network or USB volumes

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

########## MAIL ##########

# Disable send and reply animations in Mail.app

defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app

defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app

defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# Display emails in threaded mode, sorted by date (oldest at the top)

defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"

defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"

defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Disable inline attachments (just show the icons)

defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Disable automatic spell checking

defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

########## ACTIVITY MONITOR ##########

# Show the main window when launching Activity Monitor

defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon

defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor

defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage

defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

########## MAC APP STORE ##########

# Enable the automatic update check

defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week

defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background

defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates

defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs

defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update

defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates

defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

########## PHOTOS ##########

# Prevent Photos from opening automatically when devices are plugged in

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

########## MESSAGES ##########

# Disable automatic emoji substitution (i.e. use plain text smileys)

defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes as it’s annoying for messages that contain code

defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking

defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

echo "macOS configuration finished ..."

########## APPS Brewfile) ##########

echo "Installing applications ..."

# TODO: Change to use Brewfile for installation

### PRODUCTIVITY ###

brew install --cask notion-calendar
brew install --cask notion-mail
# TODO: Install Raycast

# TODO: Install excalidraw

brew install --cask 1password
brew install --cask 1password-cli

# WINDOW MANAGEMENT

# brew install --cask mission-control-plus
# brew install --cask swish
# brew install --cask notchnook

# WEB BROWSING

brew install --cask arc
# brew install --cask google-chrome

# BREAK TIMER (dejal)
brew install --cask time-out
# TODO: Install oghsh-break-theme in '$HOME/Library/Group Containers/6Z7QW53WB6.com.dejal.timeout/Themes'

# UTILS

brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font

# IPAD

# brew install --cask astropad
# brew install --cask duet

### COMMS ####

# brew install --cask beeper
# brew install --cask slack
brew install --cask whatsapp
brew install --cask discord

### PRESENTATION & SCREEN ANNOTATION ###

# TODO: Install Presentify - setapp
# brew install --cask pitch

# Screenshot

brew install --cask cleanshot

echo "Setting up local software development environment..."

# Link app configurations
ln -s $HOME/Dotfiles/config/ $HOME/.config

# Install Starship prompt
brew install starship

# Install terminal
# brew install --cask iterm2
# brew install --cask warp
brew install --cask ghostty

# CLI TOOLS

brew install htop # improved top (interactive process viewer)
# brew install tmux    # terminal multiplexer
brew install wget    # internet file retriever
brew install xclip   # clipboard tool
brew install jq      # JSON processor
brew install eza     # ls replacement
brew install bat     # cat replacement
brew install tldr    # man replacement
brew install httpie  # curl replacement
brew install grep    # as ggrep
brew install thefuck # command line tool to correct previous console commands
brew install zoxide  # a replacemend for cd
brew install ripgrep # a replacement for grep
brew install yazi ffmpegthumbnailer ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font

##### Runtimes #####

### Install NVM

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

### Install latest version of node using nvm

nvm install --lts

### Npm global packages

npm install -g reveal-md
npm install -g vtop

## TODO: Python + environment manager

### Java

brew tap homebrew/cask-versions
brew install --cask temurin17

##### Environments #####

brew install --cask docker

##### Software development tools #####

brew install --cask visual-studio-code
# TODO: Install oghsh-code-theme
brew install neovim
brew install git
brew install gh # GitHub CLI

echo "Setting up creative workspace..."

### MUSIC ###

# brew install --cask ableton-live-suite
# TODO: Install Capo https://apps.apple.com/us/app/capo/id696977615?mt=12
brew install --cask musescore

# Video recording/editing

brew install --cask obs
brew install --cask capcut

##### Graphic design #####

brew install --cask figma
brew install --cask canva

echo "App installation finished"
