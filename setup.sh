#!/bin/sh

if [ "$1" = "skip" ];
then
  echo "bypassing interraction for luci git submodules ;-)"
  git config --global submodule.recurse true
  git submodule update --remote --init --recursive
   
  if [ "$2" = "dumbap" ];
  then
   cd xsdk-uci-defaults
   git checkout dumbap --force
   git fetch origin dumbap
   git pull origin dumbap --rebase=false
   rm -rf ../files
   cp -rf files ../files
   chmod -R 755 ../files
  else
   cd xsdk-uci-defaults
   git checkout main --force
   git fetch origin main
   git pull origin main --rebase=false
   rm -rf ../files
   cp -rf files ../files
   chmod -R 755 ../files
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
git submodule update --remote --init --recursive

if [ "$1" = "dumbap" ];
then
  cd xsdk-uci-defaults
  git checkout dumbap --force
  git pull origin dumbap --rebase=false
  rm -rf ../files
  cp -rf files ../files
else
  cd xsdk-uci-defaults
  git checkout origin main --force
  git pull --rebase=false
  rm -rf ../files
  cp -rf files ../files
fi

exit 0
