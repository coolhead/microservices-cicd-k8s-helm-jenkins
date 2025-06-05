#!/bin/bash

set -e

# Name of the Helm release and namespace
RELEASE_NAME=devstack
NAMESPACE=dev

# Set Docker environment to Minikube
echo "⛽ Setting Docker context to Minikube..."
eval $(minikube -p docker-env)

# Build Docker images locally
echo "🐳 Building Docker images..."
docker build -t web:latest ./web
docker build -t auth:latest ./auth

echo "✅ Docker images built successfully."

# Deploy with Helm
echo "🚀 Deploying with Helm..."
helm upgrade --install $RELEASE_NAME ./helm-chart -n $NAMESPACE --create-namespace

# Wait for pods to become ready
echo "⏳ Waiting for pods to be ready..."
kubectl rollout status deployment/web -n $NAMESPACE
kubectl rollout status deployment/auth -n $NAMESPACE
kubectl rollout status deployment/postgres -n $NAMESPACE

# Port-forward to access the service
echo "🌐 Starting port-forwarding to http://localhost:8080"
echo "(Press Ctrl+C to stop port-forwarding)"
kubectl port-forward svc/web 8080:80 -n $NAMESPACE
