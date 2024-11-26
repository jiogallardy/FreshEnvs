#!/bin/bash

# Update and install basic dependencies
echo "Updating package lists and installing prerequisites..."
sudo apt update && sudo apt install -y software-properties-common curl || {
    echo "Failed to update and install prerequisites."
    exit 1
}
echo "Prerequisites installed."

# Call the Python installation script
echo "Starting Python installation..."
bash ./install_python.sh || {
    echo "Python installation failed."
    exit 1
}

# Install xclip for clipboard functionality
echo "Installing xclip for clipboard support..."
sudo apt install -y xclip || {
    echo "Failed to install xclip."
    exit 1
}
echo "xclip installed. You can now use 'xclip -selection clipboard' for clipboard operations."

# Add PROMPT_COMMAND to log bash commands
echo "Configuring PROMPT_COMMAND to log bash commands..."
PROMPT_COMMAND_SETUP='export PROMPT_COMMAND='\''echo "$(date +%Y-%m-%d %H:%M:%S) $(history 1 | sed "s/^[ ]*[0-9]*[ ]*//")" >> ~/bash_command_log.txt'\'''

if ! grep -q "$PROMPT_COMMAND_SETUP" ~/.bashrc; then
    echo "$PROMPT_COMMAND_SETUP" >> ~/.bashrc
    echo "PROMPT_COMMAND added to ~/.bashrc."
else
    echo "PROMPT_COMMAND already exists in ~/.bashrc."
fi

# Apply .bashrc changes
echo "Applying changes to the current shell..."
source ~/.bashrc || {
    echo "Failed to source ~/.bashrc."
    exit 1
}

# Call the tunnels installation script
echo "Installing VS Code Tunnels..."
bash ./install_tunnels.sh || {
    echo "VS Code Tunnels installation failed."
    exit 1
}

echo "Environment setup complete. Please restart your terminal for all changes to take effect!"
