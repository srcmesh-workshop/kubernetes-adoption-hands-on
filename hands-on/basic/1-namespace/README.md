# Local Kubernetes Development Environment Setup

* Docker Desktop: https://www.docker.com/products/docker-desktop
* Minikube: https://kubernetes.io/docs/tasks/tools/install-minikube/ 

# Connect to remote server

```bash
$ ssh <user-id>@<server-ip>
```

# Namespace

## 建立專屬 namespace

Namespace 請取為你的使用者帳號名稱

```bash
$ kubectl create namespace <namespace-name-your-user-id>
```

## 更換現在 namespace

* Namespace 預設為 `default`，為避免衝突請切換至剛建立的 NS
* 此處 context 請使用 `kubernetes-adoption-context`

```bash
# 指令
$ kubectl config use-context kubernetes-adoption-context
$ kubectl config set-context --current --namespace=<namespace-name-your-user-id>
```

## 確認是否已經切換成功

```bash
$ kubectl config view --minify | grep namespace:
```