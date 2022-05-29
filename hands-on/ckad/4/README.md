# Cluster

You have to switch to the right cluster before starting the tasks.

```bash
$ kubectl config use-context gke
```


## Point

3

## Tasks

Complete the following tasks under namespace `ckad-4`.

1. Create a configMap called `ckad-4-options-<user-id>` with the value `var5=val5`. 
2. Create a new nginx pod `ckad-4-nginx-<user-id>` that loads the value from variable `var5` in an env variable called `option`.

Nginx Image: `nginx:latest`
