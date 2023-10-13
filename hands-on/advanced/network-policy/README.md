# Kubernetes Network Policy 練習

```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: hands-on
spec:
  replicas: 1
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

根據上面的 Kubernetes Deployment 範例，請完成以下練習，以瞭解如何使用 Network Policy

## 講師說明

1. 如何撰寫只允許來自指定 Namespace 流量的做法 (Hint: 利用 Allow 與 Deny 優先度來實現)

## 練習步驟

1. 使用上面的範例創建一個名為 `hands-on-deployment.yaml` 的 Kubernetes Deployment 配置文件

2. 使用指令部署該 Deployment

```
$ kubectl apply -f hands-on-deployment.yaml
```

3. 請建立一個叫做 `deny-ingress-from-all-namespace` 的網路策略，拒絕全部 Namespace 的流量流進你所在的 NS 的 Pod 內

4. 請建立一個叫做 `allow-ingress-from-default-namespace` 的網路策略，接受來自於 `default` Namespace 的流量
