#!/bin/sh

echo "bypassing interraction for luci git submodules ;-)"
   
	if [ "$1" = "dumbap" ];
	then
		rm -rf files
		rm -rf xsdk-uci-defaults
		git clone https://github.com/xize/xsdk-uci-defaults
		cd xsdk-uci-defaults
		cp -rf files ../
		cd ..
		cd files
		git fetch origin dumbap
		git checkout dumbap --force
		cd ..
		chmod -R 755 files
	else
		rm -rf files
		rm -rf xsdk-uci-defaults
		git clone https://github.com/xize/xsdk-uci-defaults
		cd xsdk-uci-defaults
		cp -rf files ../
		chmod -R 755 files
	fi
exit 0

