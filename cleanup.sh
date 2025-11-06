#!/bin/bash
# cleanup.sh

echo "=== Destroying Kubernetes Resources ==="
# This will still show an error if the cluster never existed,
# but we'll add '|| true' to ignore the error and continue.
kubectl delete -f kubernetes/ || true

echo "Waiting 30 seconds for resources to terminate..."
sleep 30

echo "=== Destroying AWS Infrastructure with Terraform ==="
cd terraform

# --- THIS IS THE FIX ---
# Initialize terraform so it can run the destroy command
echo "Initializing Terraform modules..."
terraform init
# ---------------------

# Now, destroy the infrastructure
echo "Destroying infrastructure..."
terraform destroy -auto-approve

echo "=== Cleanup Complete ==="