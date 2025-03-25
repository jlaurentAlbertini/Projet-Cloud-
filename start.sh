#!/bin/bash

# Build des images
docker build -t redis-node:local ./redis-node
docker build -t redis-react:local ./redis-react

# Création du réseau s'il n'existe pas
docker network inspect projet-net >/dev/null 2>&1 || \
  docker network create projet-net

# Suppression des conteneurs s'ils existent
docker rm -f redis redis-node redis-react 2>/dev/null

# Lancement des conteneurs
docker run -d --name redis --network projet-net redis

docker run -d -p 8081:3000 \
  --name redis-node \
  --network projet-net \
  -e REDIS_URL=redis://redis:6379 \
  redis-node:local

docker run -d -p 3000:80 \
  --name redis-react \
  --network projet-net \
  redis-react:local

echo "Tout est lancé !"
echo " Backend : http://localhost:8081"
echo " Frontend : http://localhost:3000"