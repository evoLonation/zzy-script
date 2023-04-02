#!/bin/bash
if [ ! \( -z $1 \) ]; then
   if [ $1 = "root" ]; then 
      homedir="/root"
   else 
      homedir="/home/${1}"
   fi
else
homedir=~
fi 
if [ -e ${homedir}/.bash_profile ]; then
echo "${homedir}/.bash_profile" "${homedir}/.bashrc" 
elif [ -e ${homedir}/.bash_login ]; then
echo "${homedir}/.bash_login" "${homedir}/.bashrc" 
elif [ -e ${homedir}/.profile ]; then
echo "${homedir}/.profile" "${homedir}/.bashrc" 
else 
echo "all file not exist"
exit 1
fi 