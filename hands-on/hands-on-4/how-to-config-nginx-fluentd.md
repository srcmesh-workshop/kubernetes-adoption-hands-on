# 如何設定 NGINX config

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

建立 configmap
```
$ kubectl create configmap <name> --from-file=<key1>=</path/to/bar/file1.txt> --from-file=<key2>=</path/to/bar/file2.txt>
```

* pod.yaml

```
apiVersion: v1
kind: Pod
metadata:
  name: apiserver
  labels:
    app: webserver
    tier: backend
spec:
  containers:
  - name: nginx
    image: nginx:1.13
    ports:
    - containerPort: 80
    volumeMounts:
    - name: nginx-conf-volume
      mountPath: /etc/nginx/conf.d
  volumes:
  - name: nginx-conf-volume
    configMap:
      name: nginx.conf
      items:
      - key: nginx.conf
        path: nginx.conf
```

# 如何設定 Fluentd 去讀 NGINX access.log

* fluentd.conf: `/fluentd/etc/fluent.conf`

```
<source>
  type tail
  path /var/log/nginx/*.log
  tag nginx.access
  format nginx
</source>
```