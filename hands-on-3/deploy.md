# Deployment

* 請將 deploy.yaml 加上以下設定  
    * readiness/liveness probe
    * resources.requests 與 resources.limits 限制

# 測試滾動升級相關指令

* 確認升級狀況

```
$ kubectl rollout status deployment nginx
```

* 暫停升級

```
$ kubectl rollout pause deployment <deployment>
```

* 繼續升級

```
$ kubectl rollout resume deployment <deployment>
```

* 查看升級歷史紀錄

```
$ kubectl rollout history deployment <deployment>
```

* 回滾至特定版本

```
$ kubectl rollout undo deployment <deployment>
$ kubectl rollout undo deployment <deployment> --to-revision=<revision>
```

* 紀錄升級過程，以呈現在 rollout history

```
$ kubectl apply -f <file> --record
```