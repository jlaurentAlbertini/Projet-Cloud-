#!/bin/bash

echo "📦 Rebuild des images Docker..."
docker build -t redis-node:local ./redis-node
docker build -t redis-react:local ./redis-react

echo "📤 Chargement des images dans Minikube..."
minikube image load redis-node:local
minikube image load redis-react:local

echo "📄 Déploiement des fichiers YAML..."
kubectl apply -f k8s/

echo "🔄 Redémarrage des déploiements..."
kubectl rollout restart deployment redis-node
kubectl rollout restart deployment redis-react

echo "✅ Déploiement terminé. Attends quelques secondes puis lance ./check-status.sh"