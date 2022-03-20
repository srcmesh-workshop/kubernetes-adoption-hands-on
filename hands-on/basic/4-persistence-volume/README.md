# Persistence Volume YAML

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: myclaim
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: myclaim
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 1Gi
```

此處為程式範例由講師進行示範，實際 PV 操作會於 StatefulSet 時進行

有興趣的人可以測試將上面 YAML 跑起來後，進到容器的掛載點新增檔案，並刪掉 Pod 後重建後看檔案是否存在
