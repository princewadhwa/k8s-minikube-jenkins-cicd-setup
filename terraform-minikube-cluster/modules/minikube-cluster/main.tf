resource "null_resource" "install_minikube" {
  provisioner "local-exec" {
    when        = create
    command     = var.os_type == "windows" ? "if (!(Get-Command minikube -ErrorAction SilentlyContinue)) { Write-Output 'Installing Minikube on Windows...'; Invoke-WebRequest -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -OutFile \"$env:USERPROFILE\\bin\\minikube.exe\" } else { Write-Output 'Minikube already installed.' }" : "if ! command -v minikube &> /dev/null; then echo 'Installing Minikube on Linux...'; curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64 && sudo install minikube-linux-amd64 /usr/local/bin/minikube; else echo 'Minikube already installed.'; fi"
    interpreter = var.os_type == "windows" ? ["PowerShell", "-Command"] : ["/bin/bash", "-c"]
  }
}

resource "null_resource" "minikube_cluster" {
  depends_on = [null_resource.install_minikube]

  provisioner "local-exec" {
    when        = create
    command     = "minikube start --driver=${var.driver} --kubernetes-version=${var.k8s_version} --cpus=${var.cpus} --memory=${var.memory} --profile=${var.cluster_name} --nodes=${var.nodes}"
    interpreter = var.os_type == "windows" ? ["PowerShell", "-Command"] : ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube delete --profile=${self.triggers.cluster_name}"
    interpreter = ["PowerShell", "-Command"]
  }

  triggers = {
    cluster_name = var.cluster_name
    k8s_version  = var.k8s_version
    driver       = var.driver
    cpus         = var.cpus
    memory       = var.memory
    os_type      = var.os_type
    nodes        = var.nodes
  }
}
