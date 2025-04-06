# Rapport de Projet Cloud - Autoscaling et Infrastructure as Code



## Architecture générale

Le projet repose sur les composants suivants :

- **Frontend React** : Interface utilisateur servie via NGINX
- **Backend Node.js (redis-node)** : Serveur stateless qui échange avec Redis
- **Redis** : Base de données clé-valeur avec stockage persistant
- **Prometheus** : Monitoring des services via exposition de métriques HTTP
- **Grafana** : Visualisation des métriques Prometheus
- **Ingress NGINX** : Point d’entrée unifié via `monapp.local`

### Schéma d’architecture

```
Utilisateur ──▶ Ingress NGINX
                    │
     ┌──────────────┴──────────────┐
     │                             │
 Frontend (React)       Backend (Node.js)
                                  │
                              Redis (ClusterIP + PV)
```

## Choix techniques

- **Kubernetes (Minikube)** a été retenu pour simuler un environnement de production localement.
- **Ingress** est préféré à NodePort pour la gestion fine des routes et une meilleure reproduction d’environnements cloud réels.
- **Volumes persistants** ont été utilisés pour Redis, afin d’assurer la conservation des données même après suppression du pod.
- **Docker local** (via `eval $(minikube docker-env)`) permet d’éviter l’utilisation d’un registre Docker public.
- **Monitoring** via Prometheus + Grafana, pour observer les performances du backend.
- **Autoscaling** mis en œuvre avec HorizontalPodAutoscaler, déclenché par la charge CPU.

## Autoscaling

L'autoscaling est basé sur un `HorizontalPodAutoscaler` qui surveille la consommation CPU du déploiement `redis-node`.

- Le HPA est configuré pour scaler entre 1 et 5 pods si la charge CPU dépasse 50%.
- Un script `stress-backend.sh` permet de simuler une montée en charge.
- La montée ou descente des pods peut être observée avec `kubectl get hpa` et `kubectl get pods`.

## Monitoring

Prometheus scrape les métriques exposées par `redis-node` sur `/metrics`, fournies par `express-prometheus-middleware`.

Dans Grafana :
- Une datasource Prometheus est configurée avec l’URL `http://prometheus:9090`
- Des dashboards ont été créés pour suivre les requêtes HTTP, la disponibilité des services (`up`), et la charge.

## Déploiement

Le script `deploy.sh` automatise :

- Le démarrage de Minikube
- Le build local des images Docker
- Le déploiement de tous les composants via `kubectl apply`
- L’accès final à l’application via `http://monapp.local`

## Conclusion


- Conteneurisation complète
- Déploiement déclaratif
- Observabilité intégrée
- Scalabilité automatique


