kubectl delete -f configmap/fluent-conf.yaml
kubectl delete -f configmap/nginx-conf.yaml

kubectl delete -f secret/mysql-secret.yaml
kubectl delete -f secret/wordpress-secret.yaml

kubectl delete -f mysql.yaml
kubectl delete -f wordpress.yaml
kubectl delete -f nginx.yaml
