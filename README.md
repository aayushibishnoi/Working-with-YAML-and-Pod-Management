# Working-with-YAML-and-Pod-Management

A project to learn Kubernetes pod management using declarative YAML configurations.

# Project Structure
  Create the following directory structure:

    k8s-pod-management/
        ├── pod.yaml
        ├── manage_pods.sh
        ├── test_pods.sh
        └── README.md

## Features
- Defines a pod with YAML running an Nginx container.
- Manages pods (launch, delete, recreate) using `kubectl`.
- Demonstrates declarative vs. imperative management.
- Tests pod operations with a script.

## Files
- `pod.yaml`: YAML definition for an Nginx pod.
- `manage_pods.sh`: Script for pod management.
- `test_pods.sh`: Script to test pod operations.

## Setup
1. Install Minikube: `curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && sudo install minikube-linux-amd64 /usr/local/bin/minikube`.
2. Start Minikube: `minikube start`.
3. Install kubectl: `curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl && sudo mv kubectl /usr/local/bin/`.
4. Run management script: `bash manage_pods.sh`.
5. Run tests: `bash test_pods.sh`.
