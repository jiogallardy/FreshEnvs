#!/bin/bash

# File to store standard development packages
PACKAGE_LIST_FILE="$HOME/standard_dev_packages.txt"
REPO_DIR="$HOME/dev_env_repo"  # Directory of your Git repository

# Function to detect system architecture
detect_architecture() {
    echo "Detecting system architecture..."
    ARCH=$(uname -m)
    OS=$(uname -s)
    
    case "$ARCH" in
        x86_64) ARCH_TYPE="x86_64" ;;
        arm*|aarch64) ARCH_TYPE="ARM" ;;
        *) ARCH_TYPE="Unknown" ;;
    esac

    echo "System Architecture: $ARCH_TYPE, Operating System: $OS"
}

# Function to add a package to the standard dev list and push to remote
add_to_package_list() {
    local package=$1
    echo "Adding package '$package' to the standard development environment list..."
    
    # Ensure the repo exists
    if [ ! -d "$REPO_DIR" ]; then
        echo "Creating repository directory at $REPO_DIR..."
        mkdir -p "$REPO_DIR"
        git init "$REPO_DIR"
    fi
    
    # Add package to the file
    echo "$package" >> "$PACKAGE_LIST_FILE"

    # Commit and push to remote
    cd "$REPO_DIR"
    cp "$PACKAGE_LIST_FILE" .
    git add "$(basename "$PACKAGE_LIST_FILE")"
    git commit -m "Add package: $package"
    git push origin main  # Ensure 'origin' is set up beforehand
    cd -
}

# Intercept apt commands
if [[ $1 == "install" ]]; then
    package=$2
    echo "Detected apt install command for package: $package"
    sudo apt "$@"  # Run the actual apt command
    
    # Ask user whether to add package to standard dev environment list
    read -p "Would you like to add this package to your standard dev environment? (y/n): " response
    if [[ "$response" == "y" ]]; then
        add_to_package_list "$package"
    fi
else
    sudo apt "$@"  # For all other apt commands, just pass them through
fi

# Detect system architecture
detect_architecture
