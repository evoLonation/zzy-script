#!/bin/bash
if [ $USER != "root" ]; then
	echo "this script must executed by root, now is ${USER}"
	exit 1
fi