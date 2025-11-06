#!/bin/bash
# deploy.sh

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Phase 1: Building and Pushing Docker Image ==="
# (We already did this manually, but in a true CI/CD this would be here)
# For this task, we assume the image is already in Docker Hub.
echo "Skipping Docker build/push, assuming image 'my-docker-username/my-app:v1.0' exists."

echo "=== Phase 2: Provisioning Infrastructure with Terraform ==="
cd terraform

# Initialize Terraform (downloads providers)
terraform init

# Apply the Terraform plan
# -auto-approve skips the "yes" prompt
terraform apply -auto-approve

# Get the command to update kubeconfig from Terraform output
KUBECONFIG_CMD=$(terraform output -raw kubeconfig_command)

echo "=== Phase 3: Configuring kubectl and Deploying Application ==="
# Go back to the root directory
cd ..

# Run the command to configure kubectl
echo "Configuring kubectl..."
$KUBECONFIG_CMD

# Wait for 30 seconds for the cluster nodes to be ready
echo "Waiting 30 seconds for cluster nodes to register..."
sleep 30

# Apply the Kubernetes manifests
kubectl apply -f kubernetes/

echo "=== Deployment Complete ==="
echo "It may take a few minutes for the Load Balancer to be active."
echo "Run './test.sh' to check the status and get the URL."