$ErrorActionPreference = "Stop"
$namespace = "jenkins"

kubectl create namespace $namespace -ErrorAction SilentlyContinue
helm install jenkins ./helm/jenkins --namespace $namespace --create-namespace