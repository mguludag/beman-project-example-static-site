#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Install Go if not already installed
if ! command_exists go; then
  echo "Installing Go..."
  sudo apt update
  sudo apt install -y golang

  # Verify Go installation
  if ! command_exists go; then
    echo "Go installation failed. Please check your setup."
    exit 1
  fi
  echo "Go installed successfully."
else
  echo "Go is already installed. Skipping installation."
fi

# Install Hugo if not already installed
if ! command_exists hugo; then
  echo "Installing Hugo..."
  sudo apt install -y hugo

  # Verify Hugo installation
  if ! command_exists hugo; then
    echo "Hugo installation failed. Please check your setup."
    exit 1
  fi
  echo "Hugo installed successfully."
else
  echo "Hugo is already installed. Skipping installation."
fi

# Create alias for beman-serve
echo "Creating alias 'beman-serve'..."
if ! grep -q "alias beman-serve=" ~/.bashrc; then
  echo "alias beman-serve='hugo server --logLevel debug --disableFastRender -p 1313'" >> ~/.bashrc
else
  echo "Alias 'beman-serve' already exists in ~/.bashrc. Skipping alias creation."
fi

# Reload shell configuration
source ~/.bashrc

echo "Setup complete! You can now use the 'beman-serve' command to start the Hugo server."