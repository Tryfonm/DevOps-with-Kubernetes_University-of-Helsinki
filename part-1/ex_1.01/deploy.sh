#!/bin/bash

docker build -t tryfonm/generate-string:v1.01 .
docker push tryfonm/generate-string:v1.01
kubectl create deployment generate-string-dep --image=tryfonm/generate-string:v1.01