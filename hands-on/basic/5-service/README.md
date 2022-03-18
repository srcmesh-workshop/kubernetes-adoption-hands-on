# Service YAML

* pods.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: svc-pod-1
  labels:
    version: "1.1.1"
    application: nginx
spec:
  containers:
    - name: nginx
      image: nginx:latest
---
apiVersion: v1
kind: Pod
metadata:
   name: svc-pod-3
   labels:
      version: "3.1.1"
      application: nginx
spec:
   containers:
      - name: nginx
        image: nginx:latest
```

1. 請用上面的 YAML 建立 2 個 Pod (`svc-pod-1`、`svc-pod-2`)
2. 請用下面的 Service YAML 樣板，撰寫兩個 Service
   * Service 1
     * Name: `svc-all`
     * 將流量同時送往 `svc-pod-1` 與 `svc-pod-2`
   * Service 2
     * Name: `svc-to-1`
     * 將流量只送往 `svc-pod-1`
     * 客戶存取此 service 時要能夠用 `12345` 存取
     
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc
spec:
  selector:
    app: nginx
    version: "1"
  ports:
    - port: 12345
      targetPort: 80
  type: ClusterIP
```

3. 你應該要能夠使用以下指令去執行 curl 將流量送到建立好的 service
   * 建立好的 service DNS 為 `<service-name>.<namespace>`

```bash
$ kubectl run --rm -it demo --image=curlimages/curl --restart=Never -- sh
If you don't see a command prompt, try pressing enter.

# 要能夠正確解析為 service 的 cluster IP
/ $ nslookup <service-name>.<namespace>

# 要能夠正確取得網頁內容
/ $ curl http://<service-name>.<namespace>
```

4. 將流量送往不同服務時，檢查對應的 Nginx 的 log 是否如預期更新
   * `kubectl logs -f <pod>`