#!/bin/bash
source ../config.sh

TERRAFORM_VERSION=$1

if [[ -z "$TERRAFORM_VERSION" ]]; then
    error_exit "No Terraform version specified."
fi

echo "Installing Terraform $TERRAFORM_VERSION..."
wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -O /tmp/terraform.zip || error_exit "Failed to download Terraform."
sudo unzip -o /tmp/terraform.zip -d /usr/local/bin/ || error_exit "Failed to install Terraform."
rm /tmp/terraform.zip

log "Terraform $TERRAFORM_VERSION installed successfully."