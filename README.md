# Projet Cloud — Architecture full Docker/Kubernetes avec monitoring et autoscaling

## 🔧 Technologies utilisées

- React (frontend)
- Node.js (backend stateless)
- Redis (base clé/valeur persistante)
- Prometheus + Grafana (monitoring)
- Kubernetes (Minikube)
- Ingress NGINX (exposition)
- Docker

---

## 🚀 Déploiement automatique

### Pré-requis

- Docker
- Minikube installé (`brew install minikube`)
- Ajouter à `/etc/hosts` :
  ```
  127.0.0.1 monapp.local
  ```

### Lancer le déploiement

```bash
chmod +x deploy.sh
./deploy.sh
```

---

## 🌐 Accès

- Frontend React : http://monapp.local
- API Backend : http://monapp.local/items
- Monitoring Prometheus : http://monapp.local/prometheus
- Grafana : http://monapp.local/grafana (admin/admin)

---

## 📈 AutoScaling

Le backend `redis-node` scale automatiquement selon la charge CPU grâce à un `HorizontalPodAutoscaler`.

Test de montée en charge avec :

```bash
./stress-backend.sh
```

Surveiller avec :

```bash
watch kubectl get hpa
```

---

## 🧱 Architecture

```
Utilisateur ──▶ Ingress NGINX
                    │
     ┌──────────────┴──────────────┐
     │                             │
 Frontend (React)       API (Node.js /redis-node)
                                  │
                              Redis (ClusterIP)
```

---

## ✅ Composants Kubernetes

- `redis.yaml` : déploiement + service Redis avec volume persistant
- `redis-node.yaml` : backend stateless
- `redis-react.yaml` : frontend
- `prometheus.yaml`, `grafana.yaml` : monitoring
- `redis-node-hpa.yaml` : autoscaling HPA
- `ingress.yaml` : exposition via domaine `monapp.local`

