#!/bin/bash

k3d cluster delete --all  # to delete; if required
k3d cluster create --port 8082:30080@agent:0 -p 8088:80@loadbalancer --agents 2  # to expose agent:0 and loadbalancer  # to create with exposed ports
docker build -t tryfonm/log-output-writer:v1.10 -f writer.Dockerfile .
docker build -t tryfonm/log-output-reader:v1.10 -f reader.Dockerfile .
docker push tryfonm/log-output-writer:v1.10
docker push tryfonm/log-output-reader:v1.10

kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/ingress.yaml
# then access through http://localhost:8088