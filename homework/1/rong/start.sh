kubectl apply -f configmap/fluent-conf.yaml
kubectl apply -f configmap/nginx-conf.yaml

kubectl apply -f secret/mysql-secret.yaml
kubectl apply -f secret/wordpress-secret.yaml

kubectl apply -f mysql.yaml
kubectl apply -f wordpress.yaml
kubectl apply -f nginx.yaml
