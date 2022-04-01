```bash
$ helm create demo
$ tree demo
demo
├── Chart.yaml
├── charts
├── templates
│   ├── NOTES.txt
│   ├── _helpers.tpl
│   ├── deployment.yaml
│   ├── hpa.yaml
│   ├── ingress.yaml
│   ├── service.yaml
│   ├── serviceaccount.yaml
│   └── tests
│       └── test-connection.yaml
└── values.yaml
```


```bash
$ helm install demochart demo
$ helm get all demochart
$ helm list
$ helm template demochart demo --debug
$ helm test demochart
$ helm upgrade demochart demo
$ helm history demochart
$ helm rollback demochart 1
```


```bash
$ helm repo list
$ helm search repo mysql
NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                       
bitnami/mysql           8.8.30          8.0.28          MySQL is a fast, reliable, scalable, and easy t...

$ vim Chart.yaml
dependencies:
- name: mysql
  version: "8.8.30"
  repository: "https://charts.bitnami.com/bitnami"
```