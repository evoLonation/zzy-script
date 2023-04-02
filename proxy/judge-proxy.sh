#!/bin/bash
# 如果代理正常，会开启代理
shopt -s expand_aliases
if alias openproxy >/dev/null 2>&1  ; then true; else  
   alias openproxy="export http_proxy=\"http://127.0.0.1:7890\" https_proxy=\"http://127.0.0.1:7890\" no_proxy=\"localhost,127.0.0.1\""
fi 
if alias closeproxy >/dev/null 2>&1  ; then true; else 
   alias closeproxy="unset http_proxy https_proxy"
fi 
openproxy
if curl --max-time 3 --head www.google.com >/dev/null 2>&1 ;then
   echo $http_proxy
   echo "proxy normally run"
else 
   echo "proxy has problem"
   exit 1
fi