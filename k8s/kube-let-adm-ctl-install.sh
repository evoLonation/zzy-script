#!/bin/bash
. ../tool/judge-root.sh
. ../proxy/judge-proxy.sh

# from https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
apt-get update
apt-get install -y apt-transport-https ca-certificates curl
mkdir -p /etc/apt/keyrings
touch /etc/apt/keyrings/kubernetes-archive-keyring.gpg
curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

closeproxy
