# Terraform Module: Minikube Cluster

This module installs **Minikube** and creates a local Kubernetes cluster.  
Supports **Linux** and **Windows**.

## Example Usage

```hcl
module "minikube" {
  source       = "./modules/minikube-cluster"
  cluster_name = "demo-minikube"
  k8s_version  = "v1.29.8"
  driver       = "docker"
  cpus         = 2
  memory       = 4096
  os_type      = "linux" # or "windows"
}
