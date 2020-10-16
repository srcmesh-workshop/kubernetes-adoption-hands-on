# CLI

## Workshop Online IDE

* `https://workshop.srcmesh.dev/user/<user-id>/`

* 預設 namespace 為 `default`，為避免衝突請切換至剛建立的 ns

```bash
# 指令
$ kubectl config set-context <context-name>
$ kubectl config use-context <context-name>
$ kubectl config set-context --current --namespace=<ns>

# 範例
$ kubectl config set-context default
$ kubectl config use-context default
$ kubectl config set-context --current --namespace=user-<user-id>
```

## 確認是否已經切換成功

```bash
$ kubectl config view --minify | grep namespace:
```

## Create Nginx Pod and expose it

image: `nginx:latest`
labels: `app=nginx`

```
kubectl run <name> --image=nginx --labels="<k>=<v>,<k>=<v>"

kubectl expose <resource> <name> --port=<port> --name=<svc-name> --type=<svc-type> --selector=="<k>=<v>,<k>=<v>"
```

## Resource Operation

```
kubectl get <resource> <name> 

kubectl describe <resource> <name>
```

## Check Pod Logs

```
kubectl logs -f <name>
```

## Example

* 建立 Nginx Pod 與瞭解基本除錯指令

```
kubectl run nginx-pod --image=nginx:latest --labels="app=nginx"

# 呈現指定 Pod 列表與 Pod 狀態
kubectl get pod -o wide

# 呈現指定物件的資訊
kubectl get pod nginx-pod

# 呈現指定物件的 YAML 
kubectl get pod nginx-pod -o yaml

# 呈現指定物件在系統內的相關資訊
kubectl describe pod nginx-pod
```

* 利用 Service 將 Pod 開放給其他客戶端連線

```
kubectl expose pod nginx-pod --port=80 --name=nginx-svc-lb --type=LoadBalancer --selector="app=nginx"

kubectl expose pod nginx-pod --port=80 --name=nginx-svc-clusterip --type=ClusterIP --selector="app=nginx"

kubectl expose pod nginx-pod --port=80 --name=nginx-svc-nodeport --type=NodePort --selector="app=nginx"

# svc 為 service 縮寫
kubectl get svc
```

* 在叢集內建立 Pod 來除錯

```
# 執行一個 troubleshooting 用的 Busybox Pod 在叢集內進行測試
# 要利用舊版 busybox，否則會遇到 nslookup 的 bug (https://github.com/kubernetes/kubernetes/issues/66924)
kubectl run busybox --image=busybox:1.28.1 -- sleep 3600

kubectl exec -it busybox sh

> curl http://<pod-ip>
> nslookup nginx-svc-clusterip
> nslookup nginx-svc-clusterip.<your-namespace>
> nslookup nginx-svc-clusterip.<others-namespace>
> curl http://<nginx-svc-clusterip>

# 離開 Busybox Pod 後
kubectl logs -f nginx-pod
```