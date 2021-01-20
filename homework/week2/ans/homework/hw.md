## mysql
### generate yaml
1. create deployment template
  `kubectl create deployment mysql --dry-run=client --image=mysql:5.6 -o yaml > mysql.yaml`
2. modify yaml
3. apply
   `kubectl apply -f mysql.yaml`

### check svc
1. apply dnsutil
   `kubectl apply -f dnsutil.yaml`
2. get into pod
   `kubectl exec -it dnsutils sh`
3. check nslookup redirect address
   `nslookup mysql-0.mysql-svc`
   ```
   Server:         10.64.0.10
   Address:        10.64.0.10#53

   Name:   mysql-0.mysql-svc.user-6.svc.cluster.local
   Address: 10.60.6.43
   ```
4. check mysql IP
   `kubectl get pod -o wide`
   ```
   NAME       READY   STATUS    RESTARTS   AGE    IP           NODE                                      NOMINATED NODE   READINESS GATES
   dnsutils   1/1     Running   0          66s    10.60.2.17   gke-esun-lecture-1-pool-4-4303c2db-2fvf   <none>           <none>
   mysql-0    1/1     Running   0          4m3s   10.60.6.43   gke-esun-lecture-1-pool-4-4303c2db-lkgs   <none>           <none>
   ```
### check db service
5. check connection
  `kubectl exec mysql-0 -it -- mysql -u root -p`

## wordpress
### generate yaml
1. create deployment template
  `kubectl create deployment wordpress --dry-run=client --image=wordpress:5.6 -o yaml > wordpress.yaml`
2. modify yaml
   - add resources
   - add env
      - WORDPRESS_DB_HOST
      - WORDPRESS_DB_NAME
      - WORDPRESS_DB_USER
      - WORDPRESS_DB_PASSWORD
   - add svc
      - use LoadBalancer
      - wordpress port=80
      - pod port=80
3. apply
   `kubectl apply -f wordpress.yaml`

### check deploy
1. check deploy
  `kubectl get deploy`
  ```
  NAME        READY   UP-TO-DATE   AVAILABLE   AGE
  wordpress   1/1     1            1           111s
  ```

### check wordpress service
1. open browser and check service is alive
  `http://<EXTERNAL-IP>:<PORT>`
  `http://34.92.48.73:80`

## nginx & fluetd
### generate yaml
1. create deployment template
  `kubectl create deployment nginx --dry-run=client --image=nginx:1.19 -o yaml > wordpress.yaml`
2. modify yaml
   - add fluentd side car
   - add resources
   - add volumeMounts
      - log path
      - nginx config path
      - fluentd config path
   - add configmap
   - add svc
      - use LoadBalancer
      - nginx port=80
      - pod port=80
3. apply
   `kubectl apply -f nginx.yaml`

### check deploy
1. check deploy
   `kubectl get deploy`
   ```
   NAME        READY   UP-TO-DATE   AVAILABLE   AGE
   nginx       1/1     1            1           17m
   wordpress   1/1     1            1           17m
   ```

### check wordpress service
1. open browser and check service is alive
  `http://<CLUSTER-IP>:<PORT>`
  `http://10.64.6.56:80`

2. check log parser
   `kubectl logs -f nginx-6744db598-ll9ts fluentd`
   refresh browser, logs will show stdout
   ```
   2021-01-20 07:54:24.000000000 +0000 nginx.access: {"remote":"10.60.0.10","host":"-","user":"-","method":"GET","path":"/","code":"200","size":"3069","referer":"-","agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/84.0.4147.105 Safari/537.36","http_x_forwarded_for":"-"}
   2021-01-20 07:55:43.000000000 +0000 nginx.access: {"remote":"10.60.0.10","host":"-","user":"-","method":"GET","path":"/","code":"200","size":"3069","referer":"-","agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/84.0.4147.105 Safari/537.36","http_x_forwarded_for":"-"}
   ```