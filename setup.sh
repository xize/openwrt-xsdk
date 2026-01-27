#!/bin/sh

if [ "$1" = "skip" ];
then
  echo "bypassing interraction for luci git submodules ;-)"
  git config --global submodule.recurse true
   
  if [ "$2" = "dumbap" ];
  then
   git submodule set-branch -b dumbap xsdk-uci-defaults
   git submodule sync
   git submodule update --init --remote dumbap
   rm -rf files
   cp -rf xsdk-uci-defaults files
   chmod -R 777 files
  else
   git submodule set-branch -b main xsdk-uci-defaults
   git submodule sync
   git submodule update --init --remote main
   rm -rf files
   cp -rf xsdk-uci-defaults files
   chmod -R 777 files
  fi
  exit 0
fi

read -p "Do you want to fetch/pull submodules globally ? (submodule.recurse=true?) Y/n: " yn 

if [ "$yn" = "y" -o "$yn" = "Y" ];
then
	echo "setting to true."
	git config --global submodule.recurse true
else
	echo "settings to false."
	git config --global submodule.recurse false
fi

if [ "$1" = "dumbap" ];
then
	git submodule set-branch -b dumbap
	git submodule sync
	git submodule update --remote --init xsdk-uci-defaults
	rm -rf files
	cp -rf xsdk-uci-defaults files
	chmod -R 777 files
	exit 0
else
	git submodule set-branch -b main
	git submodule sync
	git submodule update --remote --init xsdk-uci-defaults
	rm -rf files
	cp -rf xsdk-uci-defaults files
	chmod -R 777 files
	exit 0
fi

exit 0

