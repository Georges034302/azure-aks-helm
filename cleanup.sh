#!/bin/bash

set -e

# Configuration
RESOURCE_GROUP="myResourceGroup"
CLUSTER_NAME="myAKSCluster"
RELEASE_NAME="nginx-app"

echo "🧼 Uninstalling Helm release..."
helm uninstall "$RELEASE_NAME" || true

echo "☠️ Deleting AKS cluster..."
az aks delete --name "$CLUSTER_NAME" --resource-group "$RESOURCE_GROUP" --yes --no-wait

echo "💣 Deleting resource group..."
az group delete --name "$RESOURCE_GROUP" --yes --no-wait

echo "✅ Cleanup initiated. Resources will be deleted shortly."
