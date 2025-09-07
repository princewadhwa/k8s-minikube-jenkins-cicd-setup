APP_NAME = blue-green-demo
IMAGE_NAME = blue-green-demo
IMAGE_VERSION = v1
NAMESPACE = blue-green-demo
CHART_PATH = ./helm/blue-green-demo
PROJECT_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

ifneq (,$(wildcard .env))
	include .env
	export
endif

.PHONY: build docker-lint sonar-scan test helm-install-blue helm-install-green helm-lint helm-uninstall-blue helm-uninstall-green k8s-apply k8s-delete deploy-all uninstall-all switch-traffic-to-blue switch-traffic-to-green

deploy-all: build helm-lint helm-install-blue helm-install-green k8s-apply
uninstall-all: helm-uninstall-blue helm-uninstall-green k8s-delete

# Build docker image
build:
	@echo "Building Docker image..."
	minikube image build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

# Lint Dockerfile using hadolint to syntax errors and best practices
docker-lint:
	@echo "Linting Dockerfile..."
	@docker run --rm -i hadolint/hadolint < Dockerfile
	@echo "Dockerfile linting passed."

test:
	@echo "PROJECT_DIR is ${PROJECT_DIR}"
	@echo "Running tests with coverage in Docker container..."
	@docker run --rm -v ${PROJECT_DIR}/src:/app -w /app -e NODE_ENV=development node:18-alpine sh -c "ls -lrt && npm install --quiet && npm test"

sonar-scan:
	@echo "Running SonarQube scan..."
	@echo "current dir: ${PROJECT_DIR}"
	@docker run \
		--rm \
		-e SONAR_HOST_URL=${SONAR_HOST_URL} \
		-v ${PROJECT_DIR}:/usr/src \
		-w /usr/src \
		sonarsource/sonar-scanner-cli:latest
	@echo "SonarQube scan completed."

helm-lint:
	@echo "Linting Helm chart..."
	helm lint $(CHART_PATH)
	@echo "Helm chart linting passed."

helm-install-blue:
	@echo "Installing Helm release blue-version with color blue..."
	helm upgrade --install blue-version $(CHART_PATH) --namespace $(NAMESPACE) --create-namespace --set deployColor=blue --set image.name=$(IMAGE_NAME) --set image.tag=$(IMAGE_VERSION) --wait --atomic --timeout 2m

helm-install-green:
	@echo "Installing Helm release green-version with color green..."
	helm upgrade --install green-version $(CHART_PATH) --namespace $(NAMESPACE) --create-namespace --set deployColor=green --set image.name=$(IMAGE_NAME) --set image.tag=$(IMAGE_VERSION) --wait --atomic --timeout 2m

k8s-apply:
	@echo "Applying Kubernetes manifests..."
	kubectl apply -f k8s-manifests/ --namespace $(NAMESPACE)

switch-traffic-to-blue:
	@echo "Switching service to point to blue deployment..."
	kubectl -n $(NAMESPACE) patch service blue-green-service -p '{"spec":{"selector":{"deployColor":"blue"}}}'

switch-traffic-to-green:
	@echo "Switching service to point to green deployment..."
	kubectl -n $(NAMESPACE) patch service blue-green-service -p '{"spec":{"selector":{"deployColor":"green"}}}'

k8s-delete:
	@echo "Deleting Kubernetes manifests..."
	kubectl delete -f k8s-manifests/ --namespace $(NAMESPACE)

helm-uninstall-blue:
	@echo "Uninstalling Helm release blue-version..."
	helm uninstall blue-version --namespace $(NAMESPACE)

helm-uninstall-green:
	@echo "Uninstalling Helm release green-version..."
	helm uninstall green-version --namespace $(NAMESPACE)
