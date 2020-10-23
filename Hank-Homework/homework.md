###  setup
```
kubectl create configmap nginx-conf --from-file=nginx.conf
kubectl create configmap fluent-conf --from-file=fluent.conf
kubectl create secret generic mysql-pass --from-literal=password=Test1234
kubectl apply -f .
```
