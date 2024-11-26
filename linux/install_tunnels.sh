#!/bin/bash

# Variables
VSCODE_CLI_URL="https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64"
VSCODE_CLI_TAR="vscode-cli-alpine-x64.tar.gz"
VSCODE_BINARY_PATH="/usr/local/bin/code"

# Step 1: Download VS Code CLI
echo "Downloading VS Code CLI..."
curl -L $VSCODE_CLI_URL -o $VSCODE_CLI_TAR

# Step 2: Extract the tarball
echo "Extracting VS Code CLI..."
tar -xvzf $VSCODE_CLI_TAR || { echo "Failed to extract tarball. Exiting."; exit 1; }

# Step 3: Move the binary to /usr/local/bin for global access
echo "Installing VS Code CLI..."
sudo mv code /usr/local/bin/code || { echo "Failed to move the binary. Exiting."; exit 1; }

# Step 4: Verify the installation
echo "Verifying VS Code CLI installation..."
$VSCODE_BINARY_PATH --version || { echo "VS Code CLI installation failed. Exiting."; exit 1; }

echo "VS Code CLI installed successfully!"

# Step 5: Install VS Code Tunnel as a service
echo "Installing VS Code Tunnel as a service..."
$VSCODE_BINARY_PATH tunnel service install || { echo "Failed to install VS Code Tunnel service. Exiting."; exit 1; }

echo "VS Code Tunnel service installed successfully!"

