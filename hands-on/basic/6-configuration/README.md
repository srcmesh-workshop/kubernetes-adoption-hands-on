# Configuration

## ConfigMap

* nginx.conf

```
server {
    listen 80;
    listen [::]:80;

    access_log /var/log/nginx/reverse-access.log;
    error_log /var/log/nginx/reverse-error.log;

    location / {
        proxy_pass https://google.com;
    }
}
```

1. 請利用以下指令建立一個包含 `nginx.conf` 的 configmap

```
$ kubectl create configmap <name> --from-file=<key1>=</path/to/nginx.conf>

# 你可以用下面指令取得剛建立的 configmap 之內容
$ kubectl get configmap <name> -o yaml
```

2. Nginx 設定檔放置位置為 `/etc/nginx/conf.d`，因此我們要將 configmap 內的 `nginx.conf` 其掛載至 nginx 的 `/etc/nginx/conf.d`

```bash
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
  labels:
    version: "1"
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:latest
```

3. 利用 port-forward 或 curl 驗證 Nginx 是否回傳 google.com 的網頁內容回來

## Secret

1. 請建立一個 secret 包含以下內容
   * `DATABASE_HOST`: `192.168.0.1`
   * `DATABASE_USER`: `user`
   * `DATABASE_PASSWORD`: `password`

* 你可以使用 `echo -n "value" | base64` 取得 `value` 的 base64 編碼
* 你可以使用 `echo -n "dmFsdWU=" | base64 -D` 取得 `dmFsdWU=` 的 base64 解碼內容
    * MacOS: `base64 -D`、Linux: `base64-d`   
* 或者使用 CLI 建立對應 YAML 檔案

```bash
$ kubectl create secret generic <secret-name> \
  --from-literal=<key1>=<value> \
  --from-literal=<key2>=<value> \
  --dry-run=client -o yaml
```

2. 請參考講義，實作以下內容至 Pod YAML 內
    * `DATABASE_HOST` 要以`環境變數`的方式傳入容器內
    * `DATABASE_USER` 與 `DATABASE_PASSWORD` 要以`檔案掛載`的方式掛載至容器內的 `/tmp` 底下

```bash
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
  labels:
    version: "1"
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:latest
```

## Key Projection

範例，不實作

```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: mypod
    image: redis
    volumeMounts:
    - name: foo
      mountPath: "/etc/foo"
      readOnly: true
  volumes:
  - name: foo
    secret:
      secretName: mysecret
      items:
      - key: username
        path: my-group/my-username
```

利用上面的 `items` 可將指定的 `key` 的內容放置容器內的路徑 `/etc/foo/my-group/my-username` 之檔案
