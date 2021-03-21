echo "Set fluentd.conf"
kubectl create configmap fluentd-conf --from-file=./fluent.conf

echo "\nDeploy Fluentd"
kubectl apply -f fluentd.yaml