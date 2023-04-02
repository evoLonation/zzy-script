#!/bin/bash
. ../tool/judge-root.sh
. ../proxy/judge-proxy.sh

arch=${1}
if [ -z $arch ]; then 
	echo "usage: ${0} arch"
	exit
fi
if [ $arch != "arm64" -a $arch != "amd64" ]; then 
	echo "arch must be one of arm64 and amd64"
	exit
fi
#if  [[ !((-r cri-docker.service) && (-r cri-docker.socket)) ]]; then
#	echo "need file cri-docker.service ,cri-docker.socket"
#	exit
#fi
installdir=/usr/bin
installpath="${installdir}/cri-dockerd"
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.0/cri-dockerd-0.3.0.${arch}.tgz
tar -zxvf cri-dockerd-0.3.0.${arch}.tgz
rm cri-dockerd-0.3.0.${arch}.tgz
sudo mkdir -p ${installdir}
sudo install -o root -g root -m 0755 cri-dockerd/cri-dockerd ${installpath}
rm -r cri-dockerd

cat > /etc/systemd/system/cri-docker.service <<EOF
[Unit]
Description=CRI Interface for Docker Application Container Engine
Documentation=https://docs.mirantis.com
After=network-online.target firewalld.service docker.service
Wants=network-online.target
Requires=cri-docker.socket

[Service]
Type=notify
ExecStart=/usr/bin/cri-dockerd --container-runtime-endpoint fd://
ExecReload=/bin/kill -s HUP \$MAINPID
TimeoutSec=0
RestartSec=2
Restart=always

# Note that StartLimit* options were moved from "Service" to "Unit" in systemd 229.
# Both the old, and new location are accepted by systemd 229 and up, so using the old location
# to make them work for either version of systemd.
StartLimitBurst=3

# Note that StartLimitInterval was renamed to StartLimitIntervalSec in systemd 230.
# Both the old, and new name are accepted by systemd 230 and up, so using the old name to make
# this option work for either version of systemd.
StartLimitInterval=60s

# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity

# Comment TasksMax if your systemd version does not support it.
# Only systemd 226 and above support this option.
TasksMax=infinity
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
EOF
cat > /etc/systemd/system/cri-docker.socket <<EOF
[Unit]
Description=CRI Docker Socket for the API
PartOf=cri-docker.service

[Socket]
ListenStream=%t/cri-dockerd.sock
SocketMode=0660
SocketUser=root
SocketGroup=docker

[Install]
WantedBy=sockets.target
EOF
#sed -i -e "s,/usr/bin/cri-dockerd,${installdir}," /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable --now cri-docker.service
systemctl enable --now cri-docker.socket

closeproxy