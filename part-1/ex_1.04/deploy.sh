#!/bin/bash

docker build -t tryfonm/simple-server:v1.04 .
docker push tryfonm/simple-server:v1.04
kubectl apply -f manifests/deployment.yaml