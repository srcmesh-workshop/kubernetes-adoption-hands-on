# gen nginx.yaml
kubectl run nginx --generator=run-pod/v1 --image=nginx:lastes
kubectl get pod nginx -o yaml > ~/workspace/kubernetes-adoption-hands-on/hands-on-1/nginx.yaml

# test nginx.yaml
kubectl apply -f ~/workspace/kubernetes-adoption-hands-on/hands-on-1/nginx.yaml

# get pods check is running or not
# kubectl get pod 

# NAME    READY   STATUS    RESTARTS   AGE
# nginx   1/1     Running   1          12m

