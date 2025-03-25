#!/bin/bash
docker rm -f redis redis-node redis-react 2>/dev/null
echo " Conteneurs arrêtés et supprimés."