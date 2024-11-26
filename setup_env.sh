#!/bin/bash

# Source shared configuration
source ./config.sh

# Function to detect OS and delegate to appropriate script
detect_and_run() {
    OS=$(uname -s)

    case "$OS" in
    Linux)
        echo "Detected Linux. Delegating to setup_env_linux.sh..."
        echo "Note that only certain distros may be supported, ie Ubuntu"
        sleep 3
        bash ./linux/setup_env_linux.sh
        ;;
    Darwin)
        echo "macOS is not supported in this setup. Exiting."
        exit 1
        ;;
    *)
        echo "Unsupported OS: $OS. Exiting."
        exit 1
        ;;
    esac
}

# Run the OS detection and delegation function
detect_and_run
