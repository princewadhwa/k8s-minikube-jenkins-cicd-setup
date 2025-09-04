# k8s-minikube-jenkins-cicd-setup

This project automates the setup of a local Kubernetes cluster using Minikube and integrates Jenkins for CI/CD workflows. It uses Terraform for infrastructure provisioning and Makefile for workflow automation.

## Features

- Automated Minikube installation based on OS (Windows/Linux)
- Terraform modules for cluster provisioning
- Makefile commands for common Terraform operations
- Jenkins integration for CI/CD pipelines

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Make](https://www.gnu.org/software/make/) (or compatible tool)
- [Docker](https://docs.docker.com/get-docker/) (for Minikube driver)
- Windows or Linux OS

## Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/k8s-minikube-jenkins-cicd-setup.git
   cd k8s-minikube-jenkins-cicd-setup
   ```

2. **Configure Minikube installation directory in your PATH:**
   - For Windows, ensure `$env:USERPROFILE\bin` is in your PATH.
   - For Linux, `/usr/local/bin` is typically in PATH.

3. **Initialize Terraform:**
   ```sh
   make init
   ```

4. **Validate and format Terraform code:**
   ```sh
   make validate
   make fmt
   ```

5. **Create and apply Terraform plan:**
   ```sh
   make plan
   make apply
   ```

6. **Destroy the cluster:**
   ```sh
   make destroy
   ```

7. **Clean local state and plan files:**
   ```sh
   make clean
   ```

## Troubleshooting

- If you see `minikube not recognized`, add the Minikube binary directory to your PATH and restart your shell or VS Code.
- Ensure you run your terminal or VS Code as administrator if installing Minikube to system directories on Windows.

## Project Structure

```
k8s-minikube-jenkins-cicd-setup/
├── terraform-minikube-cluster/
│   ├── modules/
│   │   └── minikube-cluster/
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── main.tf
│   └── ...
├── Makefile
├── .gitignore
└── README.md
```

## License

MIT License

---

**If you get 'minikube not recognized', add `$env:USERPROFILE\bin` to your PATH and restart your shell or VS Code.**
