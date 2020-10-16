# YAML

因 Kubernetes 不支援直接修改 Pod spec，下面改用 Deployment 加速課程進度

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  # template in deployment.spec means pod template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

請為 Pod 加上

1. resource requests & limits 設定
2. 參考投影片寫出一個可以連線到該 Pod 的 service (type 為 LoadBalancer)

完成後 `kubectl apply -f <file-name>` 測試是否能正常連線到該 Nginx pod

# Probes

請為 Pod 加上

1. Liveness probe
    * 使用 httpGet 方式偵測路徑 `/`
2. Readiness probe
    * 使用 tcp 方式偵測 port `80`

完成後 `kubectl apply -f <file-name>` 測試是否能正常連線到該 Nginx pod，
並 describe pod 看是否有正確測定

# Volume (emptyDir)

修改下面的 Deployment，利用 volume `emptyDir` 作為 shared volume 讓 Nginx 可以寫入 log files，並且能在 busybox 內看到該 log files。

請參考 volume 的 volumeMounts 投影片章節

* Nginx 預設寫入 log 位置為 `/var/log/nginx`
* 讓 Busybox 能在 `/logs` 的位置看到能夠看到該 log files

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
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
      - name: nginx
        image: nginx:latest
        volumeMounts:
        xxxxxxxxxxxxxxxxxx
      - name: busybox
        image: busybox
        command: ["sleep", "3600"]
        volumeMounts:
        xxxxxxxxxxxxxxxxxx
      volumes:
      - name: log-volume
        emptyDir: {}
```

apply 後可以進到 busybox 容器內確認是否成功