#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update macOS and install Xcode Command Line Tools
echo "Updating macOS..."
softwareupdate --all --install --force
echo "Installing Xcode Command Line Tools..."
xcode-select --install

# Install Homebrew if not installed
if ! command_exists brew; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Install essential tools using Homebrew
echo "Installing essential tools via Homebrew..."
brew install git make wget curl

# Install Python via Homebrew and pyenv for managing Python versions
echo "Installing pyenv and Python 3.10..."
brew install pyenv
pyenv install 3.10.12
pyenv global 3.10.12
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile
source ~/.bash_profile


# Install Docker
if ! command_exists docker; then
    echo "Installing Docker..."
    brew install --cask docker
else
    echo "Docker is already installed."
fi

# Install VS Code Insiders
if ! command_exists code-insiders; then
    echo "Installing VS Code Insiders..."
    brew install --cask visual-studio-code-insiders
else
    echo "VS Code Insiders is already installed."
fi

# Install additional useful tools via Homebrew
echo "Installing additional useful tools..."
brew install htop tree tmux

# Install Node.js and npm (required for some VS Code extensions or tools)
echo "Installing Node.js and npm..."
brew install node

# Install Docker Compose
if ! command_exists docker-compose; then
    echo "Installing Docker Compose..."
    brew install docker-compose
else
    echo "Docker Compose is already installed."
fi

# Install GitHub CLI (optional but useful for managing GitHub repos)
if ! command_exists gh; then
    echo "Installing GitHub CLI..."
    brew install gh
else
    echo "GitHub CLI is already installed."
fi

# Setup complete
echo "Development environment setup complete!"
echo "Please restart your terminal or run 'source ~/.bash_profile' to apply changes."

