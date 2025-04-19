![OpenWrt logo](include/logo.png)

This is a more personalized fork of [OpenWrt](https://github.com/openwrt/openwrt) with pre-configuration builded in, please assist checking /files/etc/uci-defaults since these images are not feasible for all people, it's for better ease of use for myself to make testing alot more robust.

for lancache (a external server on ``10.244.244.5`` not in OpenWrt):

rename ``/etc/dnsmasq.conf.lancache`` to ``/etc/dnsmasq.conf`` if you don't host a lancache server, do not rename this to ensure connectivity with steam and other services.

a typical jenkins-ci script runs like:

```
cp profiles/mt6000.profile .config
./setup.sh skip
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
make -r

```

I  also wrote a jenkins shell script to add factory configuration to the builds from pesa1234 [for the .config](https://github.com/pesa1234/MT6000_cust_build) and [for the build env](https://github.com/pesa1234/openwrt/tree/next-r4.5.34.rss.mtk).
```
[ -e "bin" ] && rm -rf bin/*
[ ! -e "package/feeds" ] && mkdir package/feeds
[ ! -e "package/feeds/luci" ] && mkdir package/feeds/luci
cd package/feeds/luci
if [ -e "luci-theme-argon" ];
then
#cd luci-theme-argon
#git fetch origin master
#git pull origin master --no-ff
#cd ..
#cd luci-app-argon-config
#git fetch origin master
#git pull origin master --no-ff
#cd ..
git submodule update --remote
else
#git clone https://github.com/jerrykuku/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config
git submodule add -f https://github.com/jerrykuku/luci-theme-argon
git submodule add -f https://github.com/jerrykuku/luci-app-argon-config
fi
cd ../../../
[ -e "openwrt-flint2-testing" ] && rm -rf openwrt-flint2-testing
git clone https://github.com/xize/openwrt-flint2-testing
cp -r openwrt-flint2-testing/files files/
rm -rf openwrt-flint2-testing
[ -e ".config" ] && rm .config
wget https://raw.githubusercontent.com/pesa1234/MT6000_cust_build/refs/heads/main/config_file/.config
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> .config
echo "CONFIG_PACKAGE_luci-proto-gre=y" >> .config
echo "CONFIG_PACKAGE_luci-proto-ipv6=y" >> .config
echo "CONFIG_PACKAGE_luci-proto-ppp=y" >> .config
echo "CONFIG_PACKAGE_luci-proto-vxlan=y" >> .config
echo "CONFIG_PACKAGE_luci-proto-wireguard=y" >> .config
echo "CONFIG_PACKAGE_luci-app-argon-config=y" >> .config
echo "CONFIG_PACKAGE_luci-app-banip=y" >> .config
echo "CONFIG_PACKAGE_luci-app-ddns=y" >> .config
echo "CONFIG_PACKAGE_luci-app-firewall=y" >> .config
echo "CONFIG_PACKAGE_luci-app-irqbalance=y" >> .config
echo "CONFIG_PACKAGE_luci-app-nextdns=y" >> .config
echo "CONFIG_PACKAGE_luci-app-package-manager=y" >> .config
echo "CONFIG_PACKAGE_luci-app-pbr=y" >> .config
echo "CONFIG_PACKAGE_luci-app-sqm=y" >> .config
echo "CONFIG_PACKAGE_luci-app-ddns=y" >> .config
echo "CONFIG_PACKAGE_ddns-scripts-noip=y" >> .config
echo "CONFIG_PACKAGE_luci_mod_dashboard=y" >> .config
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
make -r -j4
```

What I have commented out here is the old working way, but I thought it could be cleaner by using submodules (not fully tested), this could also help others finding a way to compile pesa1234's amazing builds with different packages.

[for OpenWrt direct readme go here](README_OpenWrt.md)
