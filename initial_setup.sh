#!/usr/bin/env bash

set -o errexit

declare -a DOCK_APPS
declare -a FOLDERS

DOCK_APPS=()

FOLDERS=(
  ~/.config/git
  ~/.config/direnv
  ~/.config/zsh
  ~/.config/plugins/zsh
  ~/.config/yamllint
  ~/.config/aerospace
  ~/.config/starship
  ~/.config/tmux
  ~/.config/pip
  ~/.config/ghostty
  ~/.config/1Password/ssh
  ~/.cache/zsh
  ~/.ssh
  ~/.kube
  ~/bin
  ~/tmp
  ~/work/kubeconfigs
)

# Install Rosetta 2
sudo softwareupdate --install-rosetta

# Create folders
for folder in "${FOLDERS[@]}"; do
  mkdir -p "$folder"
done

# Install Homebrew
echo "If this step fails, then run it from the internet directly"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH="/opt/homebrew/bin:$PATH"
brew bundle install --file=./Brewfile # Install all packages

touch ~/.hushlogin # Disable login message

defaults write "Apple Global Domain" AppleReduceDesktopTinting -int 1 # Disable window tinting

defaults write com.apple.dock autohide -int 1      # Automatically hide Dock
defaults write com.apple.dock tilesize -int 50     # Set Dock size
defaults write com.apple.dock magnification -int 1 # Enable magnification
defaults write com.apple.dock largesize -int 80    # Set magnification size
defaults write com.apple.dock show-recents -int 0  # Do not display recent apps

# Configure Dock apps
defaults write com.apple.dock persistent-apps -array
for app in "${DOCK_APPS[@]}"; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

killall Dock

defaults write com.apple.finder _FXSortFoldersFirst -int 1     # Keep folders on top
defaults write com.apple.finder NewWindowTarget -string "PfHo" # New Finder windows open home directory

defaults write -g ApplePressAndHoldEnabled -bool false # Enable key repeat

defaults write NSGlobalDomain _HIHideMenuBar -bool true # Hide menu bar

# Install zsh plugins
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ~/.config/plugins/zsh/catppuccin-zsh-syntax-highlighting
git clone https://github.com/ahmetb/kubectl-aliases.git ~/.config/plugins/zsh/kubectl-aliases

# Install kubectl plugins
kubectl krew update
kubectl krew install cnpg
kubectl krew install get-all
kubectl krew install neat
kubectl krew install node-shell
kubectl krew install resource-capacity
kubectl krew install tree

# Configure pyenv
# renovate datasource=github-tags depName=python/cpython
PYTHON_VERSION=v3.13.0
pyenv install ${PYTHON_VERSION//v/}
pyenv global ${PYTHON_VERSION//v/}

# Disable animations when opening and closing windows.
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Accelerated playback when adjusting the window size.
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Install SNOW lookup
cd automator
./setup.sh

echo "Nearly done! Connect to the internet and press any key to continue..."
read
brew bundle install --file=./Brewfile_internet

# Create symlinks
stow .

echo "Done! Please restart your computer."
