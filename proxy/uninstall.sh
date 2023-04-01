#!/bin/bash
. ../tool/judge-root.sh
user=${1}
if [ -z $1 ]; then 
	echo "usage: ${0} user"
	exit
fi
initfile=`. ../tool/getinitfile.sh ${user}`
echo "your bash init file: ${initfile}"
systemctl stop clash
rm  /etc/systemd/system/clash.service
systemctl daemon-reload
rm /usr/local/bin/clash
rm -r /etc/clash/
sed -i '/alias openproxy/d'  ${initfile}
sed -i '/alias closeproxy/d'  ${initfile}
sed -i '/openproxy/d'  ${initfile}
sed -i '/alias openproxy/d'  /home/${user}/.bashrc
sed -i '/alias closeproxy/d'  /home/${user}/.bashrc
sed -i '/openproxy/d'  /home/${user}/.bashrc
sed -i '/http_proxy/d' /etc/sudoers