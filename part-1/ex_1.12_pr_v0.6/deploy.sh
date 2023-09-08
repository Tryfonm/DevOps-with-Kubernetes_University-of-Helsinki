#!/bin/bash

# k3d cluster delete --all                                                        # delete; if required
# k3d cluster create --port 8082:30080@agent:0 -p 8088:80@loadbalancer --agents 2 # expose agent:0 and loadbalancer  # to create with exposed ports
# docker exec k3d-k3s-default-agent-0 mkdir -p /tmp/kube                          # creating the /tmb/kube within the node

docker build -t tryfonm/simple-server:v1.12 .
docker push tryfonm/simple-server:v1.12

## Do only once
# kubectl apply -f manifests/persistentvolume.yaml
# kubectl apply -f manifests/persistentvolumeclaim.yaml

kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/ingress.yaml
## then access through http://localhost:8088
