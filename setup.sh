#!/bin/sh

echo "bypassing interraction for luci git submodules ;-)"
   
	if [ "$1" = "dumbap" ];
	then
		rm -rf files
		git clone https://github.com/xize/xsdk-uci-defaults files
		cd files
		git fetch origin
		git checkout dumbap --force
		cd ..
		chmod -R 755 files
	else
		rm -rf files
		git clone https://github.com/xize/xsdk-uci-defaults files
		chmod -R 755 files
	fi
exit 0

