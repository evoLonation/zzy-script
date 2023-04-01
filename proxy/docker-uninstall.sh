#!/bin/bash
# 关闭docker的代理功能
. ../tool/judge-root.sh
rm /etc/systemd/system/docker.service.d/http-proxy.conf
systemctl daemon-reload
systemctl restart docker
systemctl show --property=Environment docker
