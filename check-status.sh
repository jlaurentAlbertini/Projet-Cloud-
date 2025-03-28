#!/bin/bash

echo "🔍 Vérification de l'état du cluster..."

READY=$(kubectl get pods --no-headers | grep -c "1/1")

if [ "$READY" -lt 3 ]; then
    echo "⚠️  Certains pods ne sont pas prêts :"
    kubectl get pods
    exit 1
fi

echo "✅ Tous les pods sont prêts."

echo "🌐 Vérification de l'Ingress..."
ADDR=$(kubectl get ingress app-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
if [ -z "$ADDR" ]; then
    ADDR=$(minikube ip)
fi

if grep -q "monapp.local" /etc/hosts; then
    echo "✅ 'monapp.local' est bien configuré dans /etc/hosts"
else
    echo "⚠️  Ajoute cette ligne à ton /etc/hosts :"
    echo "$ADDR monapp.local"
fi

echo
echo "🧪 Test de l'API :"
curl -s http://monapp.local/api/items && echo ""

echo "🟢 Tu peux maintenant ouvrir : http://monapp.local"