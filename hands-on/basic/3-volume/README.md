# Volume YAML

![](assets/pod.png)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-1
  labels:
    version: "1"
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:latest
    - name: busybox
      image: busybox:latest
      # busybox 本身啟動後自行持續運作的 process，
      # 但 container 內需要有個 process 持續執行才能存活
      # 因此這邊用 watch 方式，讓他持續執行 echo 指令
      command:
        - watch
        - echo 'Version 1' > /tmp/index.html
```

# Hands-on

## EmptyDir

請參考講義與上面 YAML 實現以下目標

* Nginx 預設網頁會從 `/usr/share/nginx/html` 讀取 index.html
* 請利用 `emptyDir` 建立一個 shared volume，讓 busybox 與 nginx 能掛載該 volume
* busybox 會印出字串到 shared volume 的 index.html，nginx 則會讀取該檔案內容輸出到網頁

完成後，請進行以下檢查

* 利用 `kubectl exec` 分別進到兩個容器內檢查是否有成功 shared volume 掛載

## HostPath

因學員無法直接存取 Google Kubernetes Engine 的 VM

講師會選擇其中一個節點，並在其上的 `/tmp/foo` 建立範例結構如下的資料夾供學員掛載

```
/tmp/dummy/
|-- bar
|   `-- bar.txt
`-- foo
    `-- foo.txt

# mkdir -p /tmp/dummy/foo
# mkdir -p /tmp/dummy/bar
# echo "hello" > /tmp/dummy/foo/foo.txt
# echo "world" > /tmp/dummy/bar/bar.txt
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-1
  labels:
    version: "1"
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:latest
    - name: busybox
      image: busybox:latest
      command:
        - watch
        - echo 'Version 1' > /tmp/index.html
```

1. 請為上面的 Pod 加上 Node Selector，讓其開在有 `hostPath=true` 標籤的節點上
2. 請參考講義，為上面 Pod 增加如下的 `volumes` 

```yaml
volumes:
- name: demo
  hostPath:
    path: /tmp/foo
```

3. 請為 nginx 利用 `mountPath` 將 volume 掛載至 `/mnt`
4. 請為 busybox 利用 `mountPath` 與 `subPaht` 只將 bar.txt 掛載至 `/mnt`

你應該得到以下結果

```
user-0@instance-1:~$ kubectl exec -it pod-1 -c nginx -- sh
# ls /mnt
bar  foo

user-0@instance-1:~$ kubectl exec -it pod-1 -c busybox -- sh
/ # cat /mnt/bar.txt
world
```