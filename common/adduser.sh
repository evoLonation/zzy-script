#!/bin/bash
. ../tool/judge-root.sh
user=$1
password=$2
if [ -z $2 ]  
then 
	echo "usage: ${0} user password"
	exit
fi
# 创建用户
useradd -m -s /bin/bash $user

# 设置密码
echo "${user}:${password}" | chpasswd

# 设置sudo免密和所有权限
# echo "will change user ${user}'s to no password"
sed -i "/${user}/d" /etc/sudoers
echo "${user}	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
