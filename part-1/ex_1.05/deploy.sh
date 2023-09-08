#!/bin/bash

docker build -t tryfonm/simple-server:v1.05 .
docker push tryfonm/simple-server:v1.05

kubectl apply -f manifests/deployment.yaml
kubectl port-forward $(kubectl get pod --no-headers | awk {'print $1'}) 3003:3000  # access through 3003