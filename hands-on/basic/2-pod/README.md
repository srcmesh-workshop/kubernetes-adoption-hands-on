# NOTES

`<resource>`: 表示該指令為通用指令，請替換 `<resource>` 為當下練習的 resource name

# CLI 基本操作

## 用 CLI 創建

用 CLI 建立一個 image 為 `nginx:latest` 的 pod

```bash
# 指令
$ kubectl run <pod> --image=<image>

# 範例
$ kubectl run nginx --image=nginx:latest
```

## 用 `get` 查看 pod 資訊

```bash
$ kubectl get pod <pod>

# -o wide 看更多資訊
$ kubectl get pod <pod> -o wide
```

## 用 `describe` 查看 pod 細節

```bash
$ kubectl describe pod <pod>
```

## 測試 `port-forward` 是否成功

* port-forward 透過 kubectl 在本地端建立與遠端 pod 的連線

```bash
# nginx 跑在 80 port
$ kubectl port-forward pod/<pod> <local-port>:<container-port>
```

* 打開瀏覽器，連線至 `127.0.0.1:<local-port>` 查看是否成功

## `exec` 進去 pod 內操作

* binary: `bash`
* 平常可以利用 exec 進到 pod 內除錯

```bash
$ kubectl exec -it <pod> <binary>

> echo 'Hello World' > /usr/share/nginx/html/index.html
```

更新瀏覽器，應該得到不同結果

## 查看 pod log

```bash
$ kubectl logs -f <pod> -c <container>
```

## Delete pod

```bash
# 用物件名刪除
$ kubectl delete <resource> <name>

# 因為有 graceful period，用 --force --grace-period=1 快速刪除 pod
# (--force --grace-period=1 僅作為測試，一般不建議使用)
$ kubectl delete pod <pod> --force --grace-period=0
```

## 上標籤

用 CLI 給 pod 上標籤

```bash
# 指令
$ kubectl label <resource> <name> <key>=<value>
```

用 editor 給 pod 上標籤

```bash
$ kubectl edit <resource> <pod>
```

確認上標籤成功

```bash
$ kubectl get <resource> --show-labels
```

移除標籤

* 最後有個 `-` 代表移除

```bash
$ kubectl label <resource> <name> <key>-
```

# 除錯技巧

假設今天要跑一個除錯用的 pod 且離開後就刪除，可以加上 `--rm -it`

```bash
# 指令
$ kubectl run <pod> --generator=run-pod/v1 --rm -it --image=<image> -- <binary>

# 範例
$ kubectl run foobar --generator=run-pod/v1 --rm -it --image=busybox -- sh
```

進到該 pod 的 shell 後就可以執行 ping 或是 nslookup 相關指令

## 建立常用的除錯 Pod 指令

* busybox

```bash
$ kubectl run --rm -it busybox --image=busybox --restart=Never -- sh
```

* dnsutils

```bash
$ kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
```

* curl

```bash
$ kubectl run --rm -it demo --image=curlimages/curl --restart=Never -- sh
```

# 實作

## 環境變數

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: hands-on
  name: hands-on
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hands-on
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: hands-on
    spec:
      containers:
      - image: nginx:latest
        name: nginx
        resources: {}
```

請修改上面 YAML 並滿足以下條件 (deploy.spec.template 為 pod template)

* 加上你所在 namespace
* 加上 Pod 標籤 (Label) `environment=prod` 與 `version=1.0.0`
* 容器的映像檔為 `nginx:latest`，且容器名稱為 `foobar`
* 帶有環境變數 `DB_HOST=192.168.0.1` 與 `DB_NAME=foobar`
* 宣告容器 `foobar` 監聽的 port 號為 `80`
* 資源使用限制
    * `resource.requests`: CPU `10m` 與 Memory `50m`
    * `resource.limits`: CPU `100m` 與 Memory `128m`
* 增加探針
    * liveness
        * 使用 tcpSocket 方式監控 `port 80`
    * readiness
        * 使用 httpGet 方式監控 `port 80` 並且帶有標頭 `kubelet-probe` 值為 `true`
