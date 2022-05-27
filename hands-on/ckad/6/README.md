# Cluster

You have to switch to the right cluster before starting the tasks.

```bash
$ kubectl config use-context gke
```

## Tasks

Complete the following tasks under namespace `ckad-6`.

1. Modify the `pod.yaml` file so that liveness probe starts kicking in after 5 seconds whereas the interval between probes would be 5 seconds.
2. Rename pod to `ckad-6-pod-<user-id>` and apply it.