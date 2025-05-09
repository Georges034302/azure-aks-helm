## 🚀 Azure AKS Helm Deployment Example

This project demonstrates how to deploy a simple NGINX application to **Azure Kubernetes Service (AKS)** using **Helm** — fully configured to run in **GitHub Codespaces**.

---

### 📁 Project Structure

```
azure-aks-deploy/
├── setup.sh                # Installs kubectl, Helm, Azure CLI, and jq
├── deploy.sh               # Connects to AKS and deploys the Helm chart
├── README
├── nginx-helm/             # Helm chart for deploying NGINX
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       └── service.yaml
└── .devcontainer/          # GitHub Codespaces setup
    ├── devcontainer.json
    └── Dockerfile
```

---

### 🧰 Tools Installed Automatically

When your Codespace starts, the following tools are auto-installed:

- `kubectl` – Kubernetes CLI
- `helm` – Helm 3 package manager
- `az` – Azure CLI
- `jq` – JSON processor (used in automation)

---

### ✅ Prerequisites

Before using this project:

- You have an **AKS cluster** deployed on Azure
- You know your:
  - `CLUSTER_NAME`
  - `RESOURCE_GROUP`
- Your Azure CLI is authorized

---

### 🚀 How to Deploy

1. **Open the repo in GitHub Codespaces**
   > Tools are installed automatically via `.devcontainer` setup

2. **Login to Azure**
   ```bash
   az login --use-device-code
   ```

3. **Set AKS cluster details (edit in `deploy.sh`):**
   ```bash
   CLUSTER_NAME="myAKSCluster"
   RESOURCE_GROUP="myResourceGroup"
   ```

4. **Deploy the app**
   ```bash
   ./deploy.sh
   ```

5. **Get the External IP**
   ```bash
   kubectl get svc
   ```

6. **Open in your browser**
   ```
   http://<EXTERNAL-IP>
   ```

---

### 📦 Helm Chart Overview

| File | Purpose |
|------|---------|
| `Chart.yaml` | Helm chart metadata |
| `values.yaml` | Configurable values (replicas, image, service) |
| `deployment.yaml` | Kubernetes Deployment template for NGINX |
| `service.yaml` | Exposes app to the internet via LoadBalancer |

---

### 🧹 Cleanup

To uninstall the app:
```bash
helm uninstall nginx-app
```

To delete your AKS cluster (optional):
```bash
az group delete --name myResourceGroup --yes --no-wait
```

---

### 📌 Notes

- Helm allows parameterized, repeatable Kubernetes deployments.
- GitHub Codespaces makes this fully portable — zero local setup required.
- Easily adapt this chart to deploy other services (e.g., React or Node.js apps).

---

### ✍️ Author: *Georges Bou Ghantous*
*Built for AKS deployment demonstrations with GitHub Codespaces, Helm, and Kubernetes 💙*
