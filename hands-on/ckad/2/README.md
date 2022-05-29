# Cluster

You have to switch to the right cluster before starting the tasks.

```bash
$ kubectl config use-context gke
```


## Point

6

## Tasks

Complete the following tasks under namespace `ckad-2`.

1. Create a deployment named `ckad-2-<user-id>` with 1 init container and 1 application container
2. The init container fetches `index.html` from example.com and put it to the share volume
   * You should only use command `curl http://example.com/index.html -o /tmp/index.html` to complete the task. 
3. The application container mounts the share volume at path `/usr/share/nginx/html` and the application container should be able to read the index.html fetched by init container.

Container Image:
1. Init Container: `busybox:latest`
2. Application Container: `nginx:latest`
