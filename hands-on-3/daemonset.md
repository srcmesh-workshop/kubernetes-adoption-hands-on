# DaemonSet

* 請為節點加上標籤 `network: 10g`
* 請將 daemonset.yaml 加上以下設定  
    * nodeSelector: 要部署到含有 `network: 10g` 的節點上

# 升級策略

* OnDelete v.s RollingUpdate