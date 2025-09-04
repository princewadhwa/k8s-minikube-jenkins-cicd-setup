variable "cluster_name" {
  type        = string
  default     = "minikube"
  description = "Name of the Minikube cluster"
}

variable "k8s_version" {
  type        = string
  default     = "v1.30.0"
  description = "Kubernetes version for Minikube"
}

variable "driver" {
  type        = string
  default     = "docker"
  description = "Minikube driver (docker, hyperv, virtualbox, etc.)"
}

variable "cpus" {
  type        = number
  default     = 2
  description = "Number of CPUs to allocate"
}

variable "memory" {
  type        = number
  default     = 4096
  description = "Memory to allocate in MB"
}

variable "os_type" {
  type        = string
  default     = "linux"
  description = "Operating system: linux or windows"
  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = "os_type must be either 'linux' or 'windows'."
  }
}
