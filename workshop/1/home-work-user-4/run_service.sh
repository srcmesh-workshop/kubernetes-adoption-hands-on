kubectl apply -f secret.yaml
kubectl apply -f configmap.yaml

kubectl apply -f pod-mysql.yaml
kubectl apply -f pod-wordpress.yaml

kubectl apply -f svc.yaml

kubectl apply -f pod-nginx.yaml
