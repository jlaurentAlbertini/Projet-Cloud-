#!/bin/bash

echo "[1/5] Lancement de Minikube..."
minikube start

echo "[2/5] Activation de l'addon ingress..."
minikube addons enable ingress

echo "[3/5] Configuration Docker locale..."
eval $(minikube docker-env)

echo "[4/5] Build des images Docker locales..."
docker build -t redis-node ./redis-node
docker build -t redis-react ./redis-react

echo "[5/5] Déploiement Kubernetes..."
kubectl apply -f k8s/

echo "➡️  N'oublie pas d'ajouter cette ligne à /etc/hosts :"
echo "$(minikube ip) monapp.local"