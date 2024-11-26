#!/bin/bash

# Add Python 3.10 repository and install
echo "Adding Python 3.10 repository..."
sudo add-apt-repository -y ppa:deadsnakes/ppa || {
    echo "Failed to add Python 3.10 repository."
    exit 1
}
echo "Python 3.10 repository added."

echo "Installing Python 3.10..."
sudo apt update && sudo apt install -y python3.10 python3.10-venv python3.10-distutils || {
    echo "Failed to install Python 3.10."
    exit 1
}
echo "Python 3.10 installed."
