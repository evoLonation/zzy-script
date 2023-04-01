#!/bin/bash
. ../tool/judge-root.sh
token=$2
host=$3
hash=$4
if [ -z $3 ]; then 
	echo "usage: ${0} token master_host ca-cert-hash"
	exit
fi
echo "token : $token"
echo "master_host : $host"
echo "ca-cert-hash : $hash"
. ./cri-docker-install.sh amd64
. ./kube-let-adm-ctl-install.sh
sed -e "s/MASTER_HOST/$host/" -e "s/KUBEADM_TOKEN/$token/" -e "s/CA_CERT_HASH/$hash/" kubeadm-config-join.yaml > kubeadm-config-join-1.yaml
kubeadm join --config kubeadm-config-join-1.yaml
rm kubeadm-config-join-1.yaml
. ./cni-plugin-install.sh amd64

