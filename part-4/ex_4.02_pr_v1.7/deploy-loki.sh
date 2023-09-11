#!/bin/bash

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable

kubectl create namespace prometheus
helm install prometheus-community/kube-prometheus-stack --generate-name --namespace prometheus

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
kubectl create namespace loki-stack
helm upgrade --install loki --namespace=loki-stack grafana/loki-stack
kubectl get all -n loki-stack

while [[ "${grafana_state}" != "Running" ]]; do
    echo "Waiting for Grafana to be in the 'Running' state"
    sleep 20
    grafana_state=$(kubectl get pods -n prometheus | grep grafana | awk '{print $3}')
done
pod_name=$(kpod -n prometheus --no-headers | grep grafana | awk {'print $1'})
kubectl -n prometheus port-forward ${pod_name} 3000
