# Kubernetes PDB 練習

```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: hands-on
  name: hands-on
spec:
  replicas: 10
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:latest
        name: nginx
        resources: {}
```

根據上面的 Kubernetes Deployment 範例，請完成以下練習，以瞭解如何使用 PDB

## 練習步驟

1. 使用上面的範例創建一個名為 `hands-on-deployment.yaml` 的 Kubernetes Deployment 配置文件

2. 使用指令部署該 Deployment

```
$ kubectl apply -f hands-on-deployment.yaml
```

4. 請根據下面不同條件建立不同需求的 PDB，並套用給上面的 Deployment 產生的 Pod
  - 出現自願性干擾下，不能降低服務能力 10% 負載能力
  - 出現自願性干擾下，最低要保持 3 個 Pod

## 模擬測試

1. 由講師手動 drain node，看是否成功