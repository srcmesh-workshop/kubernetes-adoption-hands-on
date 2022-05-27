# Cluster

You have to switch to the right cluster before starting the tasks.

```bash
$ kubectl config use-context gke
```

## Tasks

Complete the following tasks under namespace `ckad-1`.

1. Create a nginx deployment of 2 replicas named `ckad-1-nginx-<user-id>` with image `nginx:latest`. 
2. Expose the deployment via a `ClusterIP` service named `ckad-1-svc-<user-id>` on port `8080`.
3. Create a NetworkPolicy named `ckad-1-np-<user-id>` that only pods with label `access: granted` can access the deployment.