#!/bin/bash
if [ ! \( -z $1 \) ]; then homedir="/home/${1}"
else homedir=~ ; fi 
if [ -e ${homedir}/.bash_profile ]; then
echo "${homedir}/.bash_profile"
elif [ -e ${homedir}/.bash_login ]; then
echo "${homedir}/.bash_login"
elif [ -e ${homedir}/.profile ]; then
echo "${homedir}/.profile"
else 
echo "all file not exist"
fi 