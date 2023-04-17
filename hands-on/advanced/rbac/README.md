# Kubernetes RBAC 練習

本練習將指導您如何在 Kubernetes 中使用 RBAC 控制對集群資源的訪問權限。

## 練習步驟

1. 請在 `user-<id>` 的 Namespace 創建一個 Role，使其允許在該 Namespace 中讀取 Pod 資訊：

```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: user-<id>
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

3. 創建一個 ServiceAccount 用於綁定剛創建的 Role：

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: pod-reader-sa
  namespace: user-<id>
```

4. 創建一個 RoleBinding，將 ServiceAccount 與 Role 進行綁定：

```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-reader-binding
  namespace: user-<id>
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: pod-reader
subjects:
- kind: ServiceAccount
  name: pod-reader-sa
  namespace: user-<id>
```

5. 使用 `--as` 參數和 `can-i` 子命令以剛創建的 ServiceAccount 身份檢查是否具有在 user-<id> Namespace 中讀取 Pod 的權限：

* `--as` 用於將當前命令以指定的使用者身份執行，以便模擬該使用者的權限並檢查他們對 Kubernetes 資源的訪問能力
* `--as` 的值是 `ServiceAccount` 時，格式為 `system:serviceaccount:<namespace>:<serviceaccount-name>`
* `--as` 的值是一個普通使用者時，格式為 `<user-name>`

```
$ kubectl auth can-i get pods -n user-<id> --as=system:serviceaccount:user-<id>:pod-reader-sa
```

如果具有讀取 Pod 的權限，將顯示 yes。如果權限不足，則顯示 no。

6. 如果上一步驟顯示具有讀取 Pod 的權限，請使用 `--as` 參數以剛創建的 ServiceAccount 身份運行 `kubectl get pods`，查看 `user-<id>` Namespace 中的 Pod：

```
$ kubectl get pods -n user-<id> --as=system:serviceaccount:user-<id>:pod-reader-sa
```

7. 為剛建立的 ServiceAccount (pod-reader-sa) 增加刪除 Pod 的權限，需創建一個新的 Role 與 RoleBinding

* 參照前面 `pod-reader` Role 的 YAML，新增一個叫 `pod-deleter` 的 Role
* 參照前面的 `pod-reader-binding` RoleBinding 的 YAML，新增一個叫 `pod-deleter-binding` 的 RoleBinding，並將 Role 與剛建立的 ServiceAccount 綁定

8. 參考第 `5` 步驟指令檢測是否有刪除 Pod 的權限，並參考第 `6` 步驟指令測試是否可以刪除

完成以上步驟後，您將了解如何在 Kubernetes 中使用 RBAC 來管理對集群資源的訪問權限