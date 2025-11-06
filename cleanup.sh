#!/bin/bash
# cleanup.sh

echo "=== Destroying Kubernetes Resources ==="
kubectl delete -f kubernetes/

echo "Waiting 30 seconds for resources to terminate..."
sleep 30

echo "=== Destroying AWS Infrastructure with Terraform ==="
cd terraform
terraform destroy -auto-approve

echo "=== Cleanup Complete ==="