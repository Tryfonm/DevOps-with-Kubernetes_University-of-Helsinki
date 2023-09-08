#!/bin/bash

docker build -t tryfonm/simple-server:v1.02 .
docker push tryfonm/simple-server:v1.02
kubectl create deployment simple-server-dep --image=tryfonm/simple-server:v1.02