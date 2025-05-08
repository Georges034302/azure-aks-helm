#!/bin/bash

set -e

CLUSTER_NAME="myAKSCluster"
RESOURCE_GROUP="myResourceGroup"
RELEASE_NAME="nginx-app"

echo "📲 Logging in to Azure..."
az login --use-device-code

echo "🔗 Getting AKS credentials..."
az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME"

echo "🚀 Deploying Helm chart..."
helm upgrade --install "$RELEASE_NAME" ./nginx-helm

echo "🌐 Checking service external IP..."
kubectl get svc "$RELEASE_NAME"-nginx --watch
