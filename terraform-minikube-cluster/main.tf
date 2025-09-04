module "minikube" {
  source       = "./modules/minikube-cluster"
  cluster_name = var.cluster_name
  k8s_version  = var.k8s_version
  driver       = var.driver
  cpus         = var.cpus
  memory       = var.memory
  os_type      = var.os_type
}
