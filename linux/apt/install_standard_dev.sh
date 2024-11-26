#!/bin/bash
source ../config.sh

PACKAGE_FILE="./linux/dev_packages.txt"

# Validate the package file exists
if [[ ! -f "$PACKAGE_FILE" ]]; then
    error_exit "Standard development package file not found: $PACKAGE_FILE"
fi

# Read and install packages
echo "Installing standard development packages..."
while IFS= read -r package; do
    if [[ -n "$package" ]]; then
        echo "Installing $package..."
        sudo apt install -y "$package" || error_exit "Failed to install $package."
    fi
done <"$PACKAGE_FILE"

log "Standard development packages installed successfully."
