# Cluster

You have to switch to the right cluster before starting the tasks.

```bash
$ kubectl config use-context gke
```


## Point

7

## Tasks

Complete the following tasks under namespace `ckad-7`.

1. Rename two pods in `pod.yaml` with `user-id`. (`nginx-1` to `<user-id>-nginx-1`, `nginx-2` to `<user-id>-nginx-2`).
2. Use `inter-pod anti-affinity` to ensure that two pods are always running on different nodes. 
3. Apply two pods.
