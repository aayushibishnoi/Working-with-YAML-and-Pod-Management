#!/bin/bash

# Script to manage Kubernetes pods using declarative YAML

# Check if kubectl is installed
if ! command -v kubectl >/dev/null 2>&1; then
    echo "Error: kubectl not found. Please install kubectl."
    exit 1
fi

# Launch the pod (declarative)
echo "Launching pod using declarative YAML..."
kubectl apply -f pod.yaml
if [ $? -eq 0 ]; then
    echo "Pod 'nginx-pod' launched successfully."
else
    echo "Failed to launch pod."
    exit 1
fi

# Wait for pod to be ready
echo "Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod/nginx-pod --timeout=60s

# Display pod status
echo "Pod status:"
kubectl get pod nginx-pod

# Delete the pod
echo "Deleting pod..."
kubectl delete -f pod.yaml
if [ $? -eq 0 ]; then
    echo "Pod 'nginx-pod' deleted successfully."
else
    echo "Failed to delete pod."
    exit 1
fi

# Recreate the pod
echo "Recreating pod..."
kubectl apply -f pod.yaml
if [ $? -eq 0 ]; then
    echo "Pod 'nginx-pod' recreated successfully."
else
    echo "Failed to recreate pod."
    exit 1
fi

# Display final pod status
echo "Final pod status:"
kubectl get pod nginx-pod

# Demonstrate imperative command (for comparison)
echo "Demonstrating imperative pod creation..."
kubectl run temp-pod --image=nginx --restart=Never --dry-run=client -o yaml > temp-pod.yaml
echo "Generated YAML for imperative command:"
cat temp-pod.yaml
rm temp-pod.yaml

echo "Pod management completed!"
