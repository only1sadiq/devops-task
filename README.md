# DevOps Internship Task - Cloud Application Deployment

This project demonstrates a full, automated deployment of a simple web application to a Kubernetes cluster on AWS. It fulfills all requirements, including:
* A containerized Python Flask application.
* Infrastructure as Code (IaC) using Terraform to provision an EKS cluster.
* Kubernetes manifests to deploy the application.
* A single script to provision and deploy.
* An automated test to validate the deployment.
* A cleanup script to destroy all resources.

## Project Structure

```
.
├── app/
│   ├── app.py           # The Python Flask application
│   └── requirements.txt # Python dependencies
├── terraform/
│   ├── main.tf          # Main Terraform file (VPC & EKS Cluster)
│   ├── outputs.tf       # Terraform outputs (cluster info)
│   └── variables.tf     # Terraform variables (region, cluster name)
├── kubernetes/
│   ├── deployment.yaml  # k8s Deployment manifest
│   └── service.yaml     # k8s Service (LoadBalancer) manifest
├── .gitignore           # Files to ignore
├── deploy.sh            # **Single command to deploy**
├── test.sh              # Script to validate the deployment
├── cleanup.sh           # Script to destroy all resources
├── Dockerfile           # Dockerfile for the application
└── README.md            # This file
```

## Prerequisites

Before you begin, you must have the following tools installed and configured:

1.  **AWS Account:** An active AWS account.
2.  **AWS CLI:** [Installed](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) and [Configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) with credentials:
    ```bash
    aws configure
    ```
3.  **Terraform:** [Installed (v1.x)](https://learn.hashicorp.com/tutorials/terraform/install-cli).
4.  **`kubectl`:** [Installed](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
5.  **Docker Desktop:** [Installed](https://www.docker.com/products/docker-desktop/) and running.
6.  **Docker Hub Account:** You will need to change the image name in `kubernetes/deployment.yaml` and `deploy.sh` to point to your own image registry.

## How to Run

### 1. (One-Time Setup) Build and Push Your Docker Image

You only need to do this once.

```bash
# Log in to Docker Hub
docker login

# Build the image (replace 'your-username' with your Docker Hub ID)
docker build -t your-username/my-app:v1.0 .

# Push the image
docker push your-username/my-app:v1.0
```

**IMPORTANT:** You MUST update `kubernetes/deployment.yaml` (line 18) and the `echo` command in `deploy.sh` (line 11) to use the image name you just pushed.

### 2. Run the Deployment

This single command will provision the AWS EKS cluster, configure `kubectl`, and deploy the application. **This will take 15-20 minutes** as EKS clusters take time to build.

```bash
./deploy.sh
```

### 3. Run the Automated Test

After the `deploy.sh` script finishes, wait another 2-3 minutes for the AWS Load Balancer to become active. Then, run the test script.

```bash
./test.sh
```

You should see an "=== TEST PASSED! ===" message and the public URL. You can paste this URL into your browser to see the JSON.

### 4. Clean Up All Resources

To avoid AWS charges, run the cleanup script when you are finished. This will destroy the EKS cluster and all related resources.

```bash
./cleanup.sh
```