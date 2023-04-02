#!/bin/bash
if [ ! \( -e ~/.ssh/id_rsa.pub \) ] ;then
rm ~/.ssh/id_rsa
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
echo "pubkey file not exist, id one" 
else 
echo "pubkey file exist"
fi
echo "pubkey:"
echo "`cat ~/.ssh/id_rsa.pub`"