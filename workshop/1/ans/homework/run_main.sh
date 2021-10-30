for f in ./*.yaml; do
  kubectl delete -f $f;
done
kubectl delete configmap fluentd-conf
kubectl delete configmap nginx-conf

set -e

# create configmap
kubectl create configmap fluentd-conf --from-file=conf/fluentd.conf
kubectl create configmap nginx-conf --from-file=conf/nginx.conf

# create mysql app
kubectl create -f mysql-secret.yaml
kubectl create -f mysql-statefulset.yaml
kubectl create -f mysql-service.yaml

# create wordpress app
kubectl create -f wordpress-deployment.yaml
kubectl create -f wordpress-service.yaml

# create nginx app
kubectl create -f nginx-deployment.yaml 
kubectl create -f fluentd-daemonset.yaml
kubectl create -f nginx-service.yaml