#!/bin/bash
. ../tool/judge-root.sh

if [ -z $1 ]; then 
	echo "usage: ${0} arch"
	exit
fi
arch=$1
wget https://github.com/containernetworking/plugins/releases/download/v1.2.0/cni-plugins-linux-${arch}-v1.2.0.tgz
mkdir -pv /opt/cni/bin
tar -xzf cni-plugins-linux-${arch}-v1.2.0.tgz -C /opt/cni/bin
rm cni-plugins-linux-${arch}-v1.2.0.tgz