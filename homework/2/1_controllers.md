# Cloud-Native Architecture Design

嘗試用學到的物件來建構下面流程圖

![](assets/example.png)

舉例

![](assets/example2.png)

# Deployment

1. 利用 Deployment 部署 nginx
* 可以嘗試用 Configmap 來管理 nginx 設定檔
* 利用 type 為 hostPath 的 volume (/tmp/user-<id>) 來當作 log-volume 寫入 log
* replicas: 1

2. 利用 Deployment 部署 wordpress
* 可以嘗試用 Secret 來管理 MySQL 帳密
* replicas: 1

# DaemonSet 

利用 DaemonSet 方式部署 fluentd
* 可以嘗試用 Configmap 來管理 fluentd 設定檔
* 利用 type 為 hostPath 的 volume (/tmp/user-<id>) 來讀取 log-volume 內 Nginx 寫入的 log

# StatefulSet

利用 StatefulSet 方式部署 MySQL
* 可以嘗試用 Secret 來管理 MySQL 帳密
* mysql 存放資料庫的位置是 /var/lib/mysql (所以要將 PV 掛載至該位置)
* replicas: 1

# CronJob

利用 CronJob 固定`每分鐘`存取前方的 Nginx 服務
* crontab.guru: https://crontab.guru/
* 容器可以使用 busybox，容器啟動指令設定成 `curl http://xxxxxxxxxxxxxxxxxxx`
