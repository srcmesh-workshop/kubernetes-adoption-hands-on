#!/usr/bin/env bash

for f in ./*.yaml; do
  kubectl delete -f $f;
done
kubectl delete configmap fluentd-conf
kubectl delete configmap nginx-conf

set -e

# create mysql secret
kubectl create -f mysql-secret.yaml

# create configmap
kubectl create configmap fluentd-conf --from-file=conf/fluentd.conf
kubectl create configmap nginx-conf --from-file=conf/nginx.conf

# create mysql pv, pvc
kubectl create -f pv-volume.yaml
kubectl create -f pv-claim.yaml

# create mysql app
kubectl create -f mysql-pod.yaml
kubectl create -f mysql-service.yaml

# create wordpress app
kubectl create -f wordpress-pod.yaml
kubectl create -f wordpress-service.yaml

# create nginx app
kubectl create -f nginx-pod.yaml
kubectl create -f nginx-service.yaml
