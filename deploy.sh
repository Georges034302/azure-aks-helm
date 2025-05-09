#!/bin/bash

set -e

# 🔧 REQUIRED: Set these explicitly
RESOURCE_GROUP="myResourceGroup"
CLUSTER_NAME="myAKSCluster"
LOCATION="australiaeast"
RELEASE_NAME="nginx-app"
CHART_DIR="./nginx-helm"

# 📁 Create resource group if it doesn't exist
if ! az group show --name "$RESOURCE_GROUP" &> /dev/null; then
  echo "📁 Creating resource group '$RESOURCE_GROUP' in '$LOCATION'..."
  az group create --name "$RESOURCE_GROUP" --location "$LOCATION"
else
  echo "✅ Resource group '$RESOURCE_GROUP' already exists."
fi

# ☸️ Create AKS cluster if it doesn't exist
if ! az aks show --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME" &> /dev/null; then
  echo "🔧 Creating AKS cluster '$CLUSTER_NAME' in '$LOCATION'..."
 az aks create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$CLUSTER_NAME" \
  --node-count 1 \
  --node-vm-size Standard_B2s \
  --no-ssh-key
else
  echo "✅ AKS cluster '$CLUSTER_NAME' already exists."
fi

# 🔗 Get kubectl credentials
echo "🔗 Getting AKS credentials..."
az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME" --overwrite-existing

# 🚀 Deploy Helm chart
echo "🚀 Deploying Helm chart as release '$RELEASE_NAME'..."
helm upgrade --install "$RELEASE_NAME" "$CHART_DIR"

# 🌐 Monitor service for external IP
echo "🌐 Waiting for external IP on service '$RELEASE_NAME-nginx'..."
kubectl get svc "$RELEASE_NAME"-nginx --watch
