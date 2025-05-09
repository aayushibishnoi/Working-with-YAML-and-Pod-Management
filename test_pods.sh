#!/bin/bash

# Test script for Kubernetes Pod Management

# Check if kubectl is installed
echo "Checking for kubectl..."
if ! command -v kubectl >/dev/null 2>&1; then
    echo "FAIL: kubectl not found. Install it with 'sudo apt install kubectl'."
    exit 1
fi
echo "PASS: kubectl found"

# Test 1: Create pod
echo "Testing pod creation..."
kubectl apply -f pod.yaml > /dev/null
kubectl wait --for=condition=Ready pod/nginx-pod --timeout=60s > /dev/null
if kubectl get pod nginx-pod | grep -q "Running"; then
    echo "PASS: Pod 'nginx-pod' created and running"
else
    echo "FAIL: Pod creation failed"
fi

# Test 2: Verify pod details
echo "Testing pod details..."
kubectl describe pod nginx-pod > pod_details.txt
if grep -q "Image:.*nginx:latest" pod_details.txt; then
    echo "PASS: Pod uses correct nginx image"
else
    echo "FAIL: Incorrect image in pod"
fi

# Test 3: Delete pod
echo "Testing pod deletion..."
kubectl delete -f pod.yaml > /dev/null
sleep 5
if ! kubectl get pod nginx-pod 2>/dev/null; then
    echo "PASS: Pod 'nginx-pod' deleted successfully"
else
    echo "FAIL: Pod deletion failed"
fi

# Test 4: Recreate pod
echo "Testing pod recreation..."
kubectl apply -f pod.yaml > /dev/null
kubectl wait --for=condition=Ready pod/nginx-pod --timeout=60s > /dev/null
if kubectl get pod nginx-pod | grep -q "Running"; then
    echo "PASS: Pod 'nginx-pod' recreated and running"
else
    echo "FAIL: Pod recreation failed"
fi

# Clean up
kubectl delete -f pod.yaml > /dev/null
rm -f pod_details.txt

echo "All tests completed!"
