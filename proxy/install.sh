#!/bin/bash
. ../tool/judge-root.sh
arch=${1}
user=${2}
if [ -z $2 ]; then 
	echo "usage: ${0} arch user"
	exit
fi
initfile=`. ../tool/getinitfile.sh ${user}`
echo "your architecture: ${arch}"
echo "your user: ${user}"
echo "your initfile: ${initfile}"

echo "uninstall first"
. ./uninstall.sh ${user}

gunzip -k clash-linux-${arch}-v1.13.0.gz
mkdir -p /usr/local/bin
mv -T clash-linux-${arch}-v1.13.0 /usr/local/bin/clash
chmod +x /usr/local/bin/clash
mkdir -p /etc/clash
cp config.yaml /etc/clash/
cp Country.mmdb /etc/clash/
mkdir -p /etc/clash/clash-dashboard
cp -r clash-dashboard /etc/clash/
cp clash.service /etc/systemd/system/
systemctl daemon-reload
systemctl start clash.service
systemctl enable clash.service
cat addin >> ${initfile}
cat addin >> /home/${user}/.bashrc
sed -i '/http_proxy/d' /etc/sudoers
echo "Defaults env_keep += \"http_proxy https_proxy no_proxy\"" >> /etc/sudoers