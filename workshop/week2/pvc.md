# Persistent Volume Claim

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv-claim
  labels:
    app: wordpress
spec:
  #storageClassName: standard
  storageClassName: retain-sc
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi

---

apiVersion: v1
kind: Pod
metadata:
  labels:
    app: wordpress
    tier: mysql
  name: mysql
spec:
  containers:
  - image: mysql:5.6
    name: mysql
    env:
    - name: MYSQL_ROOT_PASSWORD
      value: password
    ports:
    - containerPort: 3306
      name: mysql
    volumeMounts:
    - name: mysql-persistent-storage
      mountPath: /var/lib/mysql
  volumes:
  - name: mysql-persistent-storage
    persistentVolumeClaim:
      claimName: mysql-pv-claim
```

建立測試資料庫

```
# mysql -u <user> -p
> CREATE DATABASE foobar;
> SHOW DATABASES;
```

建立完後刪除 Pod 並重建，應該要能看到剛剛建立的 `foobar` 資料庫存在