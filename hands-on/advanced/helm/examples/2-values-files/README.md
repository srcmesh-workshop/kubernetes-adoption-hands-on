# Values Files

`values.yaml` 會放置`常替換`的變數以利於不同需求的部署

通常來說，`values.yaml` 放置的是此 chart 的預設值，另外會根據`不同環境建立不同 values.yaml`

# 覆蓋預設值

* `--set`
  * `--set-file` 與 `--set-string` 為變體，請參考官網說明

```bash
$ helm template demo . --set replicaCount=50
```

* `--values`

```bash
$ helm template demo . -f values-prod.yaml
```