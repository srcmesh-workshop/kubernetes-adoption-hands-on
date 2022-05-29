# Cluster

You have to switch to the right cluster before starting the tasks.

```bash
$ kubectl config use-context gke
```

## Point

8

## Tasks

Complete the following tasks under namespace `ckad-8`.

1. Create a service account `<user-id>-ckad-8`.
2. Create a role named `<user-id>-role` that only allowing `get`, `list` and `watch` resource `Secret`.
3. Rename the pod in `pod.yaml` with your `user-id`. (`nginx-1` to `<user-id>-nginx-1`).
4. The pod uses service account just created. 
5. Apply the pod.
