# Cluster

You have to switch to the right cluster before starting the tasks.

```bash
$ kubectl config use-context gke
```


## Point

3

## Tasks

Complete the following tasks under namespace `ckad-5`.

1. List all service accounts in namespace `kube-system` and save the amount of service accounts to file `/home/user-<user-id>/ckad-5-ans.txt`.
2. Create a new serviceaccount called `ckad-5-myuser-<user-id>`.
3. Create an nginx pod that uses `ckad-5-myuser-<user-id>` as a service account.

Nginx Image: `nginx:latest`
