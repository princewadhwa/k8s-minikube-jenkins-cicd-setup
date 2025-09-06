$namespace = "jenkins"

# Wait for Kubernetes API to be ready
$maxApiTries = 20
$apiTries = 0
do {
    $apiReady = kubectl get nodes 2>$null
    if ($apiReady) { break }
    Start-Sleep -Seconds 2
    $apiTries++
} until ($apiReady -or $apiTries -ge $maxApiTries)
if (-not $apiReady) {
    Write-Error "Kubernetes API server is not ready."
    exit 1
}

# Check if namespace exists
$maxNsTries = 10
$nsTries = 0
do {
    $nsExists = kubectl get namespace $namespace --no-headers -o custom-columns=:metadata.name 2>$null | Select-String "^$namespace$"
    if ($nsExists) { break }
    if ($nsTries -eq 0) {
        kubectl create namespace $namespace 2>$null
    }
    Start-Sleep -Seconds 1
    $nsTries++
} until ($nsExists -or $nsTries -ge $maxNsTries)
if (-not $nsExists) {
    Write-Error "Namespace '$namespace' was not created successfully."
    exit 1
}

helm upgrade --install jenkins ./helm/jenkins --namespace $namespace --create-namespace -f ./helm/jenkins/values.yaml