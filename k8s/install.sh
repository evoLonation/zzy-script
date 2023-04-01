#!/bin/bash
user=${1}
if [ -z $1 ]; then 
	echo "usage: ${0} user"
	exit
fi
. ../tool/judge-root.sh
. ./cri-docker-install.sh amd64
. ./kube-let-adm-ctl-install.sh
kubeadm init --config kubeadm-config.yaml
homedir=/home/${user}
su ${user} -c "mkdir -p ${homedir}/.kube"
cp -i /etc/kubernetes/admin.conf ${homedir}/.kube/config
chown $(id -u):$(id -g) ${homedir}/.kube/config

. ./cni-plugin-install.sh amd64

kubectl apply -f kube-flannel.yml