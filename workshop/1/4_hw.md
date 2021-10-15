# Homework

請利用 `Nginx`、`Wordpress`、`Fluentd`、`MySQL` 建立一個在 Kubernetes 上運作的部落格系統

![](./assets/hw.png)

## Container Images

* Nginx Image: https://hub.docker.com/_/nginx
  * 反向代理 (Reverse Proxy) 介紹: https://medium.com/starbugs/web-server-nginx-1-cf5188459108
* MySQL Image: https://hub.docker.com/_/mysql
* Fluentd Image: https://hub.docker.com/_/fluentd
* Wordpress Image: https://hub.docker.com/_/wordpress

## Configuration

### Nginx
  * 設定檔放置位置: `/etc/nginx/nginx.conf`
  * nginx.conf
    * 必須修正設定檔內兩處 `<backend-wordpress-svc-name>` 以便指向正確的 Wordpress Service DNS
```
user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    # Path to access.log & error.log
    access_log /var/log/nginx/access.log  main;
    error_log /var/log/nginx/error.log  warn;

    sendfile        on;
    keepalive_timeout  65;
    gzip  on;

    upstream backend {
        # must match the target service name
        server <backend-wordpress-svc-name>:80;
    }

    server {
        listen       80;
        location / {
            # $http_host is the host name that users seen on the browser URL
            # and it equals to `HTTP_HOST` request header.
            proxy_set_header Host $http_host;

            # You have to change this according to your setup.
            proxy_pass http://<backend-wordpress-svc-name>;

            # Modify `Location` of 301 or 302 HTTP response, so
            # that the browser will follow the correct location.
            proxy_redirect ~^http://[^/]*/(.*) http://$http_host/$1;
        }
    }
}
```

### fluentd:
  * 設定檔放置位置: `/fluentd/etc/fluent.conf`
  * fluend.conf
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

## 作業說明

* 根據上面的示意圖撰寫對應的 YAML，可參考[前次作業的 YAML](https://gist.githubusercontent.com/life1347/b1b41384a3ddcc069dfadc40970ecd66/raw/a5c51c94db10cf6cffeffa13b1de3db10fedf707/gistfile1.txt) 作為藍本

* Configmap 建立，可以參考[這邊教學](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/)的 `--from-file` 方式建立，並且以`檔案形式`掛載進對應的容器內
  * 設定檔請直接參照上面範例即可

* Nginx Pod 的 shared volume
  * Nginx 會把運作時的 Log 寫入到 `/var/log/nginx/` 底下 (`access.log` 與 `error.log`)，你必須將 `emptyDir` type 的 volume 掛載進到 `/var/log/nginx/` 以便 Nginx container 寫入 log
  * Fluentd 會讀取 `/logs` 底下所有 log，你必須將 `emptyDir` type 的 volume 掛載進到 `/logs` 以便 Fluentd 讀取 Nginx 寫入的 log