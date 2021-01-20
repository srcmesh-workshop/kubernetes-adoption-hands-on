## mysql
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
5. check connection
  `kubectl exec mysql-0 -it -- mysql -u root -p`

## wordpress
1. create deployment template
  `kubectl create deployment wordpress --dry-run=client --image=wordpress:5.6 -o yaml > wordpress.yaml`

2. check deploy
  `kubectl get deploy`
  ```
  NAME        READY   UP-TO-DATE   AVAILABLE   AGE
  wordpress   1/1     1            1           111s
  ```
3. check service is alive
  `http://10.60.3.25:80`