# NOTES

`<resource>`: 表示該指令為通用指令，請替換 `<resource>` 為當下練習的 resource name

# Local Kubernetes Development Environment Setup

* Docker Desktop: https://www.docker.com/products/docker-desktop
* Minikube: https://kubernetes.io/docs/tasks/tools/install-minikube/ 

# Namespace

## 建立專屬 namespace

```bash
$ kubectl create namespace <ns>
```

## 更換現在 namespace

* 預設為 `default`，為避免衝突請切換至剛建立的 ns

```bash
# 指令
$ kubectl config set-context <context-name>
$ kubectl config use-context <context-name>
$ kubectl config set-context --current --namespace=<ns>

# 範例
$ kubectl config set-context default
$ kubectl config use-context default
$ kubectl config set-context --current --namespace=user-0
```

## 確認是否已經切換成功

```bash
$ kubectl config view --minify | grep namespace:
```

# CLI 基本操作

## 用 CLI 創建

用 CLI 建立一個 image 為 `nginx:latest` 的 pod

```bash
# 指令
$ kubectl run <pod> --generator=run-pod/v1 --image=<image>

# 範例
$ kubectl run <pod> --generator=run-pod/v1 --image=<image>
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

## Delete pod

```bash
# 用物件名刪除
$ kubectl delete <resource> <name>

# 因為有 graceful period，用 --force --grace-period=0 快速刪除 pod
# (--force --grace-period=0 僅作為測試，一般不建議使用)
$ kubectl delete pod <pod> --force --grace-period=0
```

# 除錯小技巧

假設今天要跑一個除錯用的 pod 且離開後就刪除，可以加上 `--rm -it`

```bash
# 指令
$ kubectl run <pod> --generator=run-pod/v1 --rm -it --image=<image>｀ -- <binary>

# 範例
$ kubectl run foobar --generator=run-pod/v1 --rm -it --image=busybox -- sh
```

進到該 pod 的 shell 後就可以執行 ping 或是 nslookup 相關指令

# Misc

* busybox

```bash
$ kuberun -i --tty busybox --image=busybox --restart=Never -- sh
```

* dnsutils

```bash
$ kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
```