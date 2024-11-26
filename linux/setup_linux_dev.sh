#!/bin/bash
source ../config.sh

# Function to install standard development packages
install_standard_packages() {
    local PACKAGES_FILE="./linux/apt/apt_packages.txt"

    echo "Would you like to install your standard development packages? (y/n)"
    read -r response
    if [[ "$response" == "y" ]]; then
        if [[ ! -f "$PACKAGES_FILE" ]]; then
            error_exit "Packages file not found: $PACKAGES_FILE"
        fi

        echo "Installing standard development packages..."
        while IFS= read -r package; do
            if [[ -n "$package" ]]; then
                echo "Installing $package..."
                sudo apt install -y "$package" || error_exit "Failed to install $package."
            fi
        done <"$PACKAGES_FILE"
    fi
}

# Function to dynamically query and install components
query_and_install_components() {
    COMPONENTS_FILE="./linux/installations/installations.txt"

    # Validate the components file exists
    if [[ ! -f "$COMPONENTS_FILE" ]]; then
        error_exit "Components file not found: $COMPONENTS_FILE"
    fi

    # Read and query each component
    while IFS= read -r component; do
        if [[ -z "$component" ]]; then
            continue
        fi

        # Check if a corresponding install script exists
        INSTALL_SCRIPT="./linux/installations/install_${component}.sh"
        if [[ -f "$INSTALL_SCRIPT" ]]; then
            echo "Would you like to install $component? (y/n)"
            read -r response
            if [[ "$response" == "y" ]]; then
                bash "$INSTALL_SCRIPT"
            fi
        else
            echo "Skipping $component: No installation script found."
        fi
    done < "$COMPONENTS_FILE"
}

# Run the setup
install_standard_packages
query_and_install_components
