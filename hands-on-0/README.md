# Kubernetes Environment Setup

## Install dependencies

* `install.sh`

```
#!/bin/bash
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt update
# Install docker if you don't have it already.
apt install -y docker.io runc
apt install -y kubelet=1.18.17-00 kubeadm=1.18.17-00 kubectl=1.18.17-00 kubernetes-cni=0.8.7-00
```

Execute `install.sh`

```
chmod +x install.sh
sudo ./install.sh
```

## Alter iptable forward chain

This command allows iptables to forward packets.

```
sudo iptables -P FORWARD ACCEPT
```

## Kubernetes Installation

* Run kubeadm to init Kubernetes

```
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```

* Apply CNI (container network interface) plugin `flannel`

```
kubectl create -f https://raw.githubusercontent.com/coreos/flannel/v0.12.0/Documentation/kube-flannel.yml
```

* Mark master node is schedulable

```
kubectl describe node
kubectl taint nodes instance-1 node-role.kubernetes.io/master:NoSchedule-
```