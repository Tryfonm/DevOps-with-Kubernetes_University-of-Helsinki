#!/bin/bash

k3d cluster delete --all  # to delete; if required
k3d cluster create --port 8082:30080@agent:0 -p 8088:80@loadbalancer --agents 2  # to expose agent:0 and loadbalancer
# docker exec k3d-k3s-default-agent-0 mkdir -p /tmp/kube  # creating the /tmb/kube within the node

docker container prune -f
docker rmi tryfonm/todo-frontend:v2.06
docker rmi tryfonm/todo-backend:v2.06

docker build -t tryfonm/ping-pong:v2.06 -f ping-pong.Dockerfile .
docker build -t tryfonm/log-output:v2.06 -f log-output.Dockerfile .
docker push tryfonm/ping-pong:v2.06
docker push tryfonm/log-output:v2.06

kubectl apply -f manifests/namespace.yaml
kubectl create configmap ping-pong-configmap -n ping-pong-ns --from-env-file=.env 

kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/ingress.yaml