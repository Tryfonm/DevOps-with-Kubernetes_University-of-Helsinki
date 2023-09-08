#!/bin/bash

k3d cluster delete --all  # to delete; if required
k3d cluster create --port 8082:30080@agent:0 -p 8088:80@loadbalancer --agents 2  # to expose agent:0 and loadbalancer 

docker build -t tryfonm/ping-pong:v1.09 -f ping-pong.Dockerfile .
docker build -t tryfonm/log-output:v1.09 -f log-output.Dockerfile .
docker push tryfonm/ping-pong:v1.09
docker push tryfonm/log-output:v1.09

kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/ingress.yaml