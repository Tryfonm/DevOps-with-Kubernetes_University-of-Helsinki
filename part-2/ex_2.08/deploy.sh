#!/bin/bash

k3d cluster delete --all                                                        # delete; if required
k3d cluster create --port 8082:30080@agent:0 -p 8088:80@loadbalancer --agents 2 # expose agent:0 and loadbalancer  # to create with exposed ports
docker exec k3d-k3s-default-agent-0 mkdir -p /tmp/kube/shared-image             # allocate space for the shared image
docker exec k3d-k3s-default-agent-0 mkdir -p /tmp/kube/postgres                 # allocate space for the database | even if the container goes down the db data persists

docker container prune -f
docker rmi tryfonm/todo-frontend:v2.08
docker rmi tryfonm/todo-backend:v2.08
docker rmi tryfonm/postgres:v2.08

docker build -t tryfonm/todo-frontend:v2.08 -f todo-frontend.Dockerfile .
docker push tryfonm/todo-frontend:v2.08
docker build -t tryfonm/todo-backend:v2.08 -f todo-backend.Dockerfile .
docker push tryfonm/todo-backend:v2.08
docker build -t tryfonm/postgres:v2.08 -f postgres.Dockerfile .
docker push tryfonm/postgres:v2.08

# Ecrypt the secret
# age-keygen -o key.txt
rm -f ./manifests/secret.enc.yaml
sops --encrypt \
    --age age167kr29lnhsua7arhufctcgufdugjkeyrj5jchn6hte2tetfclc0sdc7hzk \
    --encrypted-regex '^(data)$' \
    manifests/secret.yaml >manifests/secret.enc.yaml
export SOPS_AGE_KEY_FILE=$(pwd)/key.txt

kubectl apply -f manifests/namespace.yaml
sops --decrypt manifests/secret.enc.yaml | kubectl apply -f -
# Execute once only
kubectl apply -f manifests/persistentvolume.yaml
kubectl apply -f manifests/persistentvolumeclaim.yaml

kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/statefulset.yaml
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/ingress.yaml
## then access through http://localhost:8088
