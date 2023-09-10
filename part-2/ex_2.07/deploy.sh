#!/bin/bash

k3d cluster delete --all  # to delete; if required
k3d cluster create --port 8082:30080@agent:0 -p 8088:80@loadbalancer --agents 2  # to expose agent:0 and loadbalancer
docker exec k3d-k3s-default-agent-0 mkdir -p /tmp/kube  # creating the /tmb/kube within the node

docker container prune -f
docker rmi tryfonm/ping-pong:v2.07
docker rmi tryfonm/log-output:v2.07
docker rmi tryfonm/postgres:v2.07

docker build -t tryfonm/ping-pong:v2.07 -f ping-pong.Dockerfile .
docker build -t tryfonm/log-output:v2.07 -f log-output.Dockerfile .
docker build -t tryfonm/postgres:v2.07 -f postgres.Dockerfile .
docker push tryfonm/ping-pong:v2.07
docker push tryfonm/log-output:v2.07
docker push tryfonm/postgres:v.207

# Ecrypt the secret
# age-keygen -o key.txt
# sops --encrypt \
#        --age age167kr29lnhsua7arhufctcgufdugjkeyrj5jchn6hte2tetfclc0sdc7hzk \
#        --encrypted-regex '^(data)$' \
#        manifests/secret.yaml > manifests/secret.enc.yaml
export SOPS_AGE_KEY_FILE=$(pwd)/key.txt

kubectl apply -f manifests/namespace.yaml
kubectl create configmap ping-pong-configmap -n ping-pong-ns --from-env-file=.env 
sops --decrypt manifests/secret.enc.yaml | kubectl apply -f -
kubectl apply -f manifests/configmap.yaml
kubectl apply -f manifests/persistentvolume.yaml
kubectl apply -f manifests/persistentvolumeclaim.yaml
kubectl apply -f manifests/statefulset.yaml
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/ingress.yaml