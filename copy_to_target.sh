#!/bin/bash

# Get the current directory (assumed to be the root of the repository)
REPO_PATH=$(pwd)

# Validate the repository path
if [ ! -d "$REPO_PATH" ]; then
    echo "Error: The current directory is not valid."
    exit 1
fi

# Pull the latest changes
echo "Pulling the freshest copy of the repository from $REPO_PATH..."
cd "$REPO_PATH" || exit 1
if git pull; then
    echo "Successfully pulled the latest changes."
else
    echo "Error: Failed to pull the repository."
    exit 1
fi

# Zip the repository
REPO_NAME=$(basename "$REPO_PATH")
ZIP_FILE="/tmp/${REPO_NAME}.tar.gz"

# Check if an existing tarball exists
if [ -f "$ZIP_FILE" ]; then
    echo "Removing existing tarball: $ZIP_FILE"
    rm -f "$ZIP_FILE" || {
        echo "Error: Failed to remove existing tarball. Exiting."
        exit 1
    }
fi

echo "Zipping the repository..."
tar -czvf "$ZIP_FILE" -C "$(dirname "$REPO_PATH")" "$REPO_NAME" || {
    echo "Error: Failed to create a zip file."
    rm -f "$ZIP_FILE"
    exit 1
}

echo "Repository zipped to $ZIP_FILE."

# Prompt for the SSH command
read -p "Enter the SSH command (e.g., ssh -i 'key.pem' user@host): " SSH_COMMAND

# Transfer the zip file to the remote machine's Desktop
echo "Transferring the zip file to the remote machine's Desktop..."
REMOTE_DESKTOP="~/Desktop"

# Extract the key and destination from the provided SSH command
KEY_PATH=$(echo "$SSH_COMMAND" | sed -n 's/.*-i[ ]*"\(.*\)".*/\1/p')
REMOTE_HOST=$(echo "$SSH_COMMAND" | sed -n 's/.*\(ubuntu@[^ ]*\).*/\1/p')

# Ensure the key file exists
if [ ! -f "$KEY_PATH" ]; then
    echo "Error: Private key file '$KEY_PATH' does not exist."
    exit 1
fi

# Run the scp command to transfer the tarball
scp -i "$KEY_PATH" "$ZIP_FILE" "$REMOTE_HOST:$REMOTE_DESKTOP/" || {
    echo "Error: Failed to transfer the zip file."
    exit 1
}

echo "Successfully transferred the zip file to the remote machine's Desktop."

# Cleanup
echo "Cleaning up temporary files..."
rm -f "$ZIP_FILE"
echo "Done!"
