# Cluster

You have to switch to the right cluster before starting the tasks.

```bash
$ kubectl config use-context gke
```


## Point

4

## Tasks

Complete the following tasks under namespace `ckad-3`.

1. Rename the deployment in file `deployment.yaml` to `ckad-3-<user-id>` and apply it.
2. Fix the issues that stops kubernetes from running the pod.
3. Create an `HPA` named `ckad-3-hpa-<user-id>` that scales deployment just created when CPU average utilization is over `60%`.
4. The HPA minimum replicas is `1` and maximum replicas is `2`.
