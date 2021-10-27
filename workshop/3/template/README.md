```
kubectl apply -f secret.yaml
kubectl apply -f statefulset-mysql.yml

kubectl apply -f deployment-wordpress.yml
kubectl apply -f hpa-wordpress.yml

kubectl create configmap nginx-conf --from-file=conf/nginx.conf
kubectl create configmap fluent-conf --from-file=conf/fluent.conf

kubectl apply -f deployment-nginx.yml
kubectl apply -f daemonset-fluent.yml
```