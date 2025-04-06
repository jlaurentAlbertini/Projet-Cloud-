# 🚀 Projet Cloud avec Kubernetes

## Objectif

Déployer une application complète (React + Node.js + Redis) dans un cluster **Minikube** en utilisant **Ingress** pour tout exposer via `http://monapp.local`.

---

## 🗂️Structure du projet

```
Projet-Cloud-/
├── redis-node/               # Backend Node.js
├── redis-react/              # Frontend React
├── k8s/                      # Fichiers Kubernetes (YAML)
│   ├── redis.yaml
│   ├── redis-node.yaml
│   ├── redis-react.yaml
│   └── ingress.yaml
├── deploy.sh                 # Script de déploiement complet
├── docker-compose.yaml       # (optionnel pour test local)
└── README.md
```

---

##  Prérequis

- Docker
- Minikube (`brew install minikube`)
- Node.js et Yarn installés
- Cloner ce repo :
  ```bash
  git clone https://github.com/jlaurentAlbertini/Projet-Cloud-.git
  cd Projet-Cloud-
  ```

---

##  Configuration locale

Ajoute cette ligne dans `/etc/hosts` pour que `monapp.local` fonctionne :
```bash
echo "$(minikube ip) monapp.local" | sudo tee -a /etc/hosts
```

---

##  Déploiement avec Minikube

### 1. Lance le script :
```bash
chmod +x deploy.sh
./deploy.sh
```

### 2. Ce que fait le script :
- Démarre Minikube
- Active l’addon Ingress
- Configure Docker local pour Minikube
- Build les images backend et frontend
- Applique les YAML Kubernetes dans `k8s/`

---

##  Accès à l’application

- `http://monapp.local` → Frontend React
- `http://monapp.local/item` → Backend Node.js
- `http://monapp.local/metrics` → Prometheus (Node.js)

---

##  Debug / Vérifications

```bash
kubectl get pods
kubectl get svc
kubectl get ingress
kubectl logs deployment/redis-node
kubectl logs deployment/redis-react
```

---

## 🧹 Nettoyage

```bash
minikube delete
```
