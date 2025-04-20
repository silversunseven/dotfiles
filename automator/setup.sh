#!/bin/bash
# Uses Edge as the default browser

echo "Setting up 'SNOW' lookup app on this Mac..."

APP_SRC="SNOW.app"
APP_DEST="/Applications/"

# Install Automator App (for Spotlight)
if [ -d "$APP_SRC" ]; then
  echo "Installing Automator App..."
  sudo cp -r "$APP_SRC" "$APP_DEST"
  echo "App installed to $APP_DEST"
fi

# Ensure Microsoft Edge is installed
if ! open -Ra "Microsoft Edge"; then
  echo "Microsoft Edge is not installed. Installing via Homebrew..."
  brew install --cask microsoft-edge
else
  echo "Microsoft Edge is already installed."
fi

# Refresh Spotlight index
if [ -d "$APP_SRC" ]; then
  echo "Refreshing Spotlight index..."
  mdimport /Applications/
fi

echo "Setup complete! You can now use 'SNOW'."
echo "IMPORTANT: it will past what you have in your buffer."
echo "Try it, copy ID and <cmd + space>, type SNOW <enter>"
exit 0
