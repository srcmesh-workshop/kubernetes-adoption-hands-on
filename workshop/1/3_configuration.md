# Configuration

MySQL Image: https://hub.docker.com/_/mysql

Environment:

* MYSQL_ROOT_PASSWORD
* MYSQL_USER
* MYSQL_PASSWORD
* MYSQL_DATABASE

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: mysql
  name: mysql
spec:
  containers:
  - name: mysql
    image: mysql:5.6
    imagePullPolicy: IfNotPresent
    env:
    - name: MYSQL_ROOT_PASSWORD
      value: password
    - name: MYSQL_USER
      value: user
    - name: MYSQL_PASSWORD
      value: password
    - name: MYSQL_DATABASE
      value: test_database
    ports:
    - containerPort: 3306
      name: mysql
      protocol: TCP
```

Exec 進去 Pod 後可以利用下面指令驗證是否成功

```
# mysql -u <user> -p
```

請參考投影片將 `MYSQL_ROOT_PASSWORD`、`MYSQL_USER`、`MYSQL_PASSWORD` 利用 Secret 方式改寫
請參考投影片將 `MYSQL_DATABASE` 利用 Configmap 方式改寫

# Create configmap from file (same as creating secret from file)

修改下方的 Deployment 將 Fluentd 與 Nginx 放進同個 Pod 內，並利用 volume `emptyDir` 作為 shared volume 供寫入與讀取 Nginx log files。

並且將下面提供的設定檔利用 configmap 以 file 形式掛載進 Nginx 與 Fluentd 內。

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
        - name: log-volume
          mountPath: "/var/log/nginx"
      - name: busybox
        image: busybox
        command: ["sleep", "3600"]
        volumeMounts:
        - name: log-volume
          mountPath: "/logs"
      volumes:
      - name: log-volume
        emptyDir: {}
```

## Nginx
* image: `nginx:1.14.2`
* config path: `/etc/nginx/conf.d/default.conf`

* default.conf
```
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    access_log  /var/log/nginx/access.log;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
```

可以使用下面指令來看看產生的 YAML

```
kubectl create configmap nginx-conf --from-file=default.conf=default.conf -o yaml --dry-run | kubectl apply -f -
```

## Fluentd:
* image: `fluentd:v1.9-1`
* config path: `/fluentd/etc/fluent.conf`

* fluent.conf
```
<source>
  type tail
  path /logs/**/access.log
  tag nginx.access
  format nginx
</source>

<source>
  @type tail
  format /^(?<time>\d{4}/\d{2}/\d{2} \d{2}:\d{2}:\d{2}) \[(?<log_level>\w+)\] (?<pid>\d+).(?<tid>\d+): (?<message>.*)$/
  tag nginx.error
  path /logs/**/error.log
</source>

<match nginx.access>
  @type stdout
</match>

<match nginx.error>
  @type stdout
</match>
```