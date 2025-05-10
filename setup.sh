#!/bin/sh

if [ "$1" = "skip" ];
then
  echo "bypassing interraction for luci git submodules ;-)"
  git config --global submodule.recurse true
  git submodule update --init --recursive
  git submodule foreach --recursive git fetch
  git submodule foreach git merge origin master 
  git submodule foreach git merge origin main 
  if [ "$2" = "dumbap" ];
  then
   cd xsdk-uci-defaults
   git checkout dumbap --force
   git pull
   rm -rf ../files
   cp -rf files ../files
  else
   cd xsdk-uci-defaults
   git checkout main --force
   git pull
   rm -rf ../files
   cp -rf files ../files
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

echo "ensure, all git module feeds are setup."
git submodule update --init --recursive
git submodule foreach --recursive git fetch
git submodule foreach git merge origin master
git submodule foreach git merge origin main

if [ "$1" = "dumbap" ];
then
  cd xsdk-uci-defaults
  git checkout dumbap --force
  git pull
  rm -rf ../files
  cp -rf files ../files
else
  cd xsdk-uci-defaults
  git checkout main --force
  git pull
  rm -rf ../files
  cp -rf files ../files
fi

exit 0
