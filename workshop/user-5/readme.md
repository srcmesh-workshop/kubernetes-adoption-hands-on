cd workshop/user-5
kubectl create configmap nginx-conf --from-file=configs/nginx.conf
kubectl create configmap fluent-conf --from-file=configs/fluent.conf

kubectl apply -f mysql-configmap.yaml
kubectl apply -f mysql-secret.yaml
kubectl apply -f mysql.yaml
kubectl exec -it mysql sh
mysql -u user -p
password

kubectl apply -f wordpress.yaml
kubectl expose deploy wordpress --port=80 --name=wordpress-svc-clusterip --type=ClusterIP --selector="app=wordpress"

kubectl expose pod mysql --port=3306 --target-port=3306 --name=mysql-svc-clusterip --type=ClusterIP --selector="app=mysql"
kubectl apply -f nginx.yaml
kubectl expose deploy nginx --port=8877 --target-port=80 --name=nginx-svc-loadbalancer --type=LoadBalancer --selector="app=nginx"

## Issues
1. fluent.conf: cannot find the file => rename the real file "fluentd.conf" to "fluent.conf"
2. nginx: Back-off restarting failed container => did not set up wordpress yet
`    upstream backend {
        # must match the target service name
        server <backend-wordpress-svc-name>:80;
    }
`
3. configMap nginx.config does not refresh => delete configMap and create again
4. 
`
    # Path to access.log & error.log
    access_log /var/log/nginx/pod-log-dir/access.log  main;
    error_log /var/log/nginx/pod-log-dir/error.log  warn;
`