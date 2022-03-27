# Helm

嘗試以 Helm 方式將前面所有的物件寫成 Helm Charts


file structure
demo
  -values.yaml
  -templates
    - xxx.yaml



 helm install -n user-6 --name-template demo

 helm template -n user-6 ./
