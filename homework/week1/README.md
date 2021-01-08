# 第一週回家作業

回顧今日所學

```
# If you want to operate resources in the different namespace
# add `-n` like `kubectl -n user-xxx get pod`

# Create Pod from CLI
kubectl run <pod-name> --image=<image>

# Get Pod information
kubectl get pod <pod-name> -o wide

# Get Pod YAML
kubectl get pod <pod-name> -o yaml > pod.yaml

# Expose Pod with Service
kubectl expose pod <pod-name> --name=<service-name> --port=<client-access-port> --target-port=<application-port>

# Get Service YAML
kubectl get svc <svc-name> -o yaml > svc.yaml
```

其他詳細指令請參照 hands-on-1/README.md

目前 Kubernetes 不支援直接更新 Pod YAML，你必須先刪掉該 Pod 並重建 

有兩種方式

```
1. kubectl delete -f pod.yaml
2. kubectl delete pod <pod-name>
```

利用 `apply` 重建

```
# Apply YAML files
kubectl apply -f pod.yaml
kubectl apply -f svc.yaml
```

# 作業要求

利用前面指令得到 Pod、Service YAML 後，請按照投影片內容

1. 為 Pod YAML 加上 Resource Requests & Limits (因共用叢集，以下數值僅為讓各位練習使用，不等於生產環境之適合數值)
    * CPU requests (50m) & limits (100m)
    * Memory requests (50m) & limits (100m)
2. 為 Pod YAML 加上環境變數 `DUMMY_DATABASE_PASSWORD=admin`
3. 為 Pod YAML 加上一個 `busybox` container，並且
    * 利用 emptyDir 方式建立一個 shared volume 掛載進 busybox 與 nginx 容器內 (投影片 p53)
    * 利用 command 讓他持續 echo 環境變數的值到 (投影片 p70)
4. 為 Pod YAML 加上三種探針 (投影片 p76~p86)
    * 檢測方式
        * Liveness、Startup 使用 `httpGet` 檢測 `/` 是否為 200
        * Readiness 使用 `tcpSocket` 檢測 `port 80`
    * 可參考 https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/
    
# 求助

若有任何疑問可以直接 
1. github issue
2. email: course@srcmesh.com