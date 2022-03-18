# Pod YAML

```yaml
# pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod-1
spec:
  terminationGracePeriodSeconds: 1
  containers:
  - image: nginx:latest
    imagePullPolicy: Always
    name: nginx
    ports:
    - containerPort: 80
      protocol: TCP
```

可用 `apply` 來部署進 Kubernetes 內，`delete` 刪除

```bash
$ kubectl apply -f pod.yaml
$ kubectl delete -f pod.yaml
```

**NOTE**: Kubernetes 目前不支援重覆 apply Pod 物件，若有修改 Pod YAML 時需先刪除後重新 apply

## 小技巧

`dry-run` 是指送出指令後看伺服器會回傳什麼，但伺服器不會實際修改任何資料

因此我們能利用 `dry-run` 檢測 YAML 是否有錯誤，等正確後再 apply

```bash
kubectl apply -f pod.yaml --dry-run=client
```

# Hands-on

請參考講義，替上面的 YAML 加入以下設定

## Environment Variables

新增兩個環境變數，其設定如下

```bash
DATABASE_HOST=192.168.1.1
DATABASE_NAME=foobar
```

## Resources Requests & Limits

請增加 Nginx Pod 的資源限制如下

* requests
  * cpu: 50m
  * memory: 100Mi
* limits
  * cpu: 500m
  * memory: 500Mi

## Probes

請增加 Nginx Pod 的檢測探針

* readiness
  * 用 httpGet 檢測 `port 80`，檢測路徑為 `/`
* liveness
  * 用 exec 檢測 `nginx` 的 process 是否存活
  * 檢測指令為 `service nginx status|grep running`

若進度較快者，可以嘗試加入

## Node Selector

* 用 `kubectl get node --show-labels` 從中選取一個節點，並根據該節點的標籤來撰寫 Node Selector
* 完成後用 `kubectl get pod -o wide` 確認 Pod 是否有跑在該節點上