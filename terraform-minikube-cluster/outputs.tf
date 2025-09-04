output "minikube_cluster_name" {
  description = "The name of the created Minikube cluster"
  value       = module.minikube.cluster_name
}
