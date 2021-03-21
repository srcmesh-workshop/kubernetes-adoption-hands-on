# MySQL
echo "Set Volume"
kubectl apply -f ./mysql/mysql-storage-class.yaml
kubectl apply -f ./mysql/mysql-pv-pvc.yaml

echo "\nSet Secret"
kubectl apply -f ./mysql/mysql-secret.yaml

echo "\nDeploy MySQL"
kubectl apply -f ./mysql/mysql.yaml

# Wordpress
echo "Deploy wordpress"
kubectl apply -f ./wordpress/wordpress.yaml

# Nginx
echo "Set nginx.conf"
kubectl create configmap nginx-conf --from-file=./nginx/nginx.conf

echo "\nDeploy Nginx"
kubectl apply -f ./nginx/nginx.yaml

# Fluentd
echo "Set fluentd.conf"
kubectl create configmap fluentd-conf --from-file=./fluentd/fluent.conf

echo "\nDeploy Fluentd"
kubectl apply -f ./fluentd/fluentd.yaml
