output "cluster_name" {
  description = "The name of the Minikube cluster"
  value       = var.cluster_name
}

output "minikube_path_hint" {
  value = "If you get 'minikube not recognized', add $env:USERPROFILE\\bin to your PATH and restart your shell."
}
