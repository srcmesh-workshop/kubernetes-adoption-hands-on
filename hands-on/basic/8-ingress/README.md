# Ingress

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minimal-ingress
  annotations:
    # Annotations here is for demostration only
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx-example
  rules:
  - http:
      paths:
      - path: /testpath
        pathType: Prefix
        backend:
          service:
            name: test
            port:
              number: 80
```

1. 請建立 ingress 物件將流量導向至建立好的 Service (先不需要 Host)
    * ingress path 為`/user-<id>/svc-all`
    * ingress path 為`/user-<id>/svc-to-1`

2. 請設定 ingress 的 ingressClass 為 `nginx`
