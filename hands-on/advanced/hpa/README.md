# Kubernetes HPA 練習

```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: hands-on
  name: hands-on
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hands-on
  template:
    metadata:
      labels:
        app: hands-on
    spec:
      containers:
      - image: registry.k8s.io/hpa-example
        name: php-apache
        resources: {}
```

根據上面的 Kubernetes Deployment 範例，請完成以下練習，以瞭解如何使用 Horizontal Pod Autoscaler (HPA) 根據 CPU 和 Memory 使用情況自動調整 Pod 數量。

## 練習步驟

1. 使用上面的範例創建一個名為 `hands-on-deployment.yaml` 的 Kubernetes Deployment 配置文件。

2. 為 Deployment 中的 nginx 容器添加資源限制和請求。請設置以下參數：
    - CPU 請求: 100m
    - CPU 限制: 200m
    - Memory 請求: 100Mi
    - Memory 限制: 200Mi

   這些參數將確保容器不會超過指定的資源使用量。

3. 使用指令部署應用。

```
$ kubectl apply -f hands-on-deployment.yaml
```

4. 編寫一個名為 `hands-on-hpa.yaml` 的配置文件，以創建一個 `v2beta2` 版本的 Horizontal Pod Autoscaler (HPA) 資源，讓它根據以下條件自動縮放 `hands-on` Deployment 的副本數量：
    - 最小副本數量: 1
    - 最大副本數量: 3
    - CPU 使用率目標: 30%
    - Memory 使用率目標: 50%

5. 使用指令部署 HPA 資源。

```
$ kubectl apply -f hands-on-hpa.yaml
```

6. 使用指令檢查 HPA 的狀態。

```
$ kubectl get hpa
```

## 模擬負載

1. 首先，暴露您的 `hands-on` 服務，以便能夠從集群內部訪問它。如果您尚未創建服務，可以使用以下命令創建一個 ClusterIP 類型的服務：

```
$ kubectl expose deployment hands-on --type=ClusterIP --name=hands-on-service
```

2. 接下來，使用 `kubectl run` 命令創建一個名為 `load-generator` 的繁忙 Pod，使其向 `hands-on-service` 服務發送大量請求。這裡我們使用 `busybox` 鏡像並運行 `wget` 命令進行持續持續的 HTTP 請求：

```
$ kubectl run load-generator --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://hands-on-service; done"
```

此命令將創建一個 load-generator Pod，它將不斷發送 HTTP 請求到 `hands-on-service` 服務。請注意，您可能需要根據您的集群配置和命名空間更改服務的 URL。

當負載運行時，使用以下命令觀察 HPA 如何根據 CPU 和 Memory 使用率調整副本數量。

```
$ kubectl get hpa
$ kubectl get pods
```

當您完成觀察時，刪除 load-generator Pod 和 hands-on-service 服務：

```
$ kubectl delete pod load-generator
$ kubectl delete svc hands-on-service
```

通過以上步驟，您可以模擬應用的負載並觀察 Kubernetes HPA 如何根據資源使用情況自動調整應用的副本數量。

我們已經完成了 Kubernetes HPA 練習的所有步驟，您應該已經掌握了如何使用 Kubernetes 的 HPA 功能自動擴展和縮小應用，以滿足不同的負載需求。