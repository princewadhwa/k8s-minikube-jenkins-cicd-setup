variable "cluster_name" {
  description = "Name of the Minikube cluster"
  type        = string
  default     = "minikube"
}

variable "k8s_version" {
  description = "Kubernetes version for Minikube"
  type        = string
  default     = "v1.30.0"
}

variable "driver" {
  description = "Minikube driver (docker, hyperv, virtualbox, etc.)"
  type        = string
  default     = "docker"
}

variable "cpus" {
  description = "Number of CPUs to allocate"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory to allocate (MB)"
  type        = number
  default     = 4096
}

variable "os_type" {
  description = "Operating system: linux or windows"
  type        = string
  default     = "linux"
  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = "os_type must be either 'linux' or 'windows'."
  }
}
