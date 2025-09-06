# Blue-Green Deployment Demo with Node.js, Docker, Helm, and Minikube

This repository demonstrates a simple **blue-green deployment** of a Node.js application on a local Minikube Kubernetes cluster using Docker and Helm.

---

## Contents

- `app.js` — Simple Node.js Express app displaying the deployment color (blue or green).
- `package.json` — Node.js dependencies.
- `Dockerfile` — To build the app Docker image.
- `helm/blue-green-demo` — Helm chart for deploying the app with configurable deploy color and namespace.
- `Makefile` — Utility for building Docker images, loading into Minikube, and managing Helm deployments.
- Instructions for blue-green deployment switching and accessing the app.

---

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed locally.
- [Minikube](https://minikube.sigs.k8s.io/docs/start/) installed and running.
- [Helm 3](https://helm.sh/docs/intro/install/) installed.
- `kubectl` CLI configured for your Minikube cluster.

---

## Application Overview

The Node.js app listens on port 3000 and displays a message indicating the current deployment color, passed via environment variable `DEPLOY_COLOR`. This enables verification of blue or green versions running.

---

## How to Use

1. **Build Docker Image:**
   ```sh
   make build
   ```
This builds the Docker image locally as `blue-green-demo:v1`.

---

2. **Deploy Blue Version:**
    ```sh
   make helm-install-blue
   ```

---

3. **Deploy Green Version:**
    ```sh
   make helm-install-green
   ```

---

4. **Apply shared `blue-green-service` **managed separately in k8s-manifests folder** (outside Helm releases) to avoid Helm ownership conflicts.**
    ```sh
   make helm-install-green
   ```

---

5. **Switch Traffic to Green Version:**
    ```sh
   make switch-traffic-to-green
   ```

---

6. **Switch Traffic to Blue Version:**
    ```sh
   make switch-traffic-to-blue
   ```

## References

- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [Helm Official Docs](https://helm.sh/docs/)
- [Kubernetes Service Types](https://kubernetes.io/docs/concepts/services-networking/service/)

---

### Thank you for trying this demo!

Happy Deploying 🚀



