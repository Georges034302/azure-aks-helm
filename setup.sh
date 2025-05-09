#!/bin/bash

set -e

echo "🔧 Installing dependencies for AKS + Helm in GitHub Codespaces..."

# Update system packages
sudo apt-get update

# Install kubectl
echo "📦 Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install Azure CLI
echo "📦 Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Helm
echo "📦 Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install jq
sudo apt-get install -y jq

# Log in and register the AKS provider
echo "🔐 Logging into Azure..."
az login --use-device-code

echo "🔗 Registering Microsoft.ContainerService provider..."
az provider register --namespace Microsoft.ContainerService

echo "⏳ Waiting for provider registration..."
az provider show --namespace Microsoft.ContainerService --query "registrationState"

echo "✅ Tools installed and provider registered: kubectl, az, helm, jq"
