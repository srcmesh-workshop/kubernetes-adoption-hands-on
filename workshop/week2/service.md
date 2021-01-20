# Service

建立 dnsutils Pod

```
kubectl apply -f v

kubectl exec -i -t dnsutils -- nslookup <svc>.<namespace>
```

1. 測試不同種類的 Service Type
    * ClusterIP
    * ExternalName
    * NodePort
    * LoadBalancer
2. 測試無頭服務
3. Ingress/Ingress Controller Demo