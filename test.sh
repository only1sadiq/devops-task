#!/bin/bash
# test.sh

echo "Attempting to find the public URL of the service..."

# Loop until the LoadBalancer has an external IP/hostname
COUNTER=0
while [ -z "$SERVICE_URL" ]; do
    SERVICE_URL=$(kubectl get service my-app-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
    
    if [ "$COUNTER" -gt 20 ]; then
        echo "Error: Timed out waiting for Load Balancer."
        echo "Please check the 'kubectl get service' status manually."
        exit 1
    fi
    
    if [ -z "$SERVICE_URL" ]; then
        echo "Service URL not ready, waiting 15 seconds..."
        sleep 15
        COUNTER=$((COUNTER+1))
    fi
done

echo "=== Service is LIVE at: http://$SERVICE_URL ==="

echo "Running automated test (curl)..."

# Add http:// to the URL for curl
PUBLIC_URL="http://$SERVICE_URL"

# Run curl and check if the output contains "Automate all the things!"
if curl -s $PUBLIC_URL | grep "Automate all the things!"; then
    echo "=== TEST PASSED! ==="
    echo "Application is responding correctly."
else
    echo "=== TEST FAILED! ==="
    echo "Did not receive expected JSON response from $PUBLIC_URL"
    exit 1
fi