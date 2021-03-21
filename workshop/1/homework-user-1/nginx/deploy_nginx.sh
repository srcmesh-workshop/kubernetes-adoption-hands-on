echo "Set nginx.conf"
kubectl create configmap nginx-conf --from-file=./nginx.conf

echo "\nDeploy Nginx"
kubectl apply -f nginx.yaml