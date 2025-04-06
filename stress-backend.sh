#!/bin/bash

echo "[+] Génération de charge sur l'API backend..."

for i in {1..1000}; do
  curl -s http://monapp.local/item > /dev/null &
done

echo "[✓] Stress lancé (1000 requêtes concurrentes)"