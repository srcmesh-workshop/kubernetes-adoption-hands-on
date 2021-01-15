# StatefulSet

* 請修改 statefulset.yaml，滿足以下條件
    * `敏感資訊 (i.e 帳密)`以 `Secret` 儲存
    * `DB 連線資訊` 以 `Configmap` 儲存 

# Base64 使用技巧

* 用 base64 encode/decode 資料 
```bash
# encode 
$ echo -n 'password' | base64

# decode
$ echo -n 'cGFzc3dvcmQ=' | base64 -D
```

* 使用 `echo` 注意事項

```bash
# -n 為必要，否則 echo 會印出 \n 導致 encode 結果不同
$ echo -n 'password' | base64
cGFzc3dvcmQ=

$ echo 'password' | base64
cGFzc3dvcmQK
```