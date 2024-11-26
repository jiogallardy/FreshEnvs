#!/bin/bash
source ../config.sh

read -p "Enter the Node.js version to install (e.g., 16): " NODE_VERSION

if [[ -z "$NODE_VERSION" ]]; then
    error_exit "No Node.js version specified."
fi

echo "Installing Node.js $NODE_VERSION..."
curl -fsSL https://deb.nodesource.com/setup_"$NODE_VERSION".x | sudo -E bash - || error_exit "Failed to setup Node.js repository."
sudo apt install -y nodejs || error_exit "Failed to install Node.js $NODE_VERSION."

log "Node.js $NODE_VERSION installed successfully."
