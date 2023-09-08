#!/bin/bash

# k3d cluster delete --all  # to delete; if required
# k3d cluster create --port 8082:30080@agent:0 -p 8081:80@loadbalancer --agents 2  # to expose agent:0 and loadbalancer  # to create with exposed ports
docker build -t tryfonm/simple-server:v1.08 .
docker push tryfonm/simple-server:v1.08

kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/ingress.yaml
# then access through http://localhost:8081