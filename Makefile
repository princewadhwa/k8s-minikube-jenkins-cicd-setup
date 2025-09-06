# Variables
TF_DIR := terraform-minikube-cluster
TF_COMMAND := terraform
TF_PLAN_OUT := tfplan

# Detect OS
ifeq ($(OS),Windows_NT)
    CLEAN_CMD = del /Q $(TF_DIR)\$(TF_PLAN_OUT) 2>nul & rmdir /S /Q $(TF_DIR)\.terraform 2>nul & del /Q $(TF_DIR)\.terraform.lock.hcl 2>nul
    CD_CMD = cd $(TF_DIR) &&
    JENKINS_INSTALL_CMD = powershell -ExecutionPolicy ByPass -File scripts\install-jenkins.ps1
else
    CLEAN_CMD = rm -f $(TF_DIR)/$(TF_PLAN_OUT) && rm -rf $(TF_DIR)/.terraform && rm -f $(TF_DIR)/.terraform.lock.hcl
    CD_CMD = cd $(TF_DIR) &&
    JENKINS_INSTALL_CMD = bash scripts/install-jenkins.sh
endif

# Default target
.PHONY: all
all: init validate fmt plan apply install-jenkins

## Initialize Terraform (with backend & providers)
.PHONY: init
init:
	@echo "==> Initializing Terraform..."
	$(CD_CMD) $(TF_COMMAND) init -upgrade

## Validate Terraform code
.PHONY: validate
validate:
	@echo "==> Validating Terraform..."
	$(CD_CMD) $(TF_COMMAND) validate

## Check formatting of Terraform code
.PHONY: fmt
fmt:
	@echo "==> Checking formatting..."
	$(CD_CMD) $(TF_COMMAND) fmt -recursive

## Generate execution plan
.PHONY: plan
plan:
	@echo "==> Creating Terraform plan..."
	$(CD_CMD) $(TF_COMMAND) plan -out=$(TF_PLAN_OUT)

## Apply execution plan
.PHONY: apply
apply:
	@echo "==> Applying Terraform plan..."
	$(CD_CMD) $(TF_COMMAND) apply $(TF_PLAN_OUT)

## Destroy infrastructure
.PHONY: destroy
destroy:
	@echo "==> Destroying infrastructure..."
	$(CD_CMD) $(TF_COMMAND) destroy -auto-approve

## Clean local state and plan files
.PHONY: clean
clean:
	@echo "==> Cleaning up..."
	$(CLEAN_CMD)

.PHONY: install-jenkins
install-jenkins:
	@echo "==> Installing Jenkins via Helm chart..."
	$(JENKINS_INSTALL_CMD)
