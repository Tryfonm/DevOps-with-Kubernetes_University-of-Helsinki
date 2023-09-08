#!/bin/bash

# k3d cluster create --port 8082:30080@agent:0 -p 8081:80@loadbalancer --agents 2  # to expose agent:0 and loadbalancer
docker build -t tryfonm/simple-server:v1.06 .
docker push tryfonm/simple-server:v1.06

kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
# then access through 8082