#!/bin/bash

echo "[1/5] ▶️ Lancement de Minikube..."
minikube start

echo "[2/5] ⚙️ Configuration Docker local..."
eval $(minikube docker-env)

echo "[3/5] 🐳 Build des images Docker..."
docker build -t redis-node ./redis-node
docker build -t redis-react ./redis-react

echo "[4/5] 📦 Déploiement des ressources Kubernetes..."
kubectl apply -f k8s/redis-volume.yaml
kubectl apply -f k8s/redis.yaml
kubectl apply -f k8s/redis-node.yaml
kubectl apply -f k8s/redis-react.yaml
kubectl apply -f k8s/prometheus.yaml
kubectl apply -f k8s/grafana.yaml
kubectl apply -f k8s/redis-node-hpa.yaml
kubectl apply -f k8s/ingress.yaml

echo "[5/5] 🌐 Ingress disponible via :"
echo "  http://monapp.local"
echo "  http://monapp.local/grafana"
echo "  http://monapp.local/prometheus"

echo "[✓] Déploiement terminé"
