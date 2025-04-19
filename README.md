![OpenWrt logo](include/logo.png)

This is a more personalized fork of [OpenWrt](https://github.com/openwrt/openwrt) with pre-configuration builded in, please assist checking /files/etc/uci-defaults since these images are not feasible for all people, it's for better ease of use for myself to make testing alot more robust.

for lancache (a external server on ``10.244.244.5`` not in OpenWrt):

rename ``/etc/dnsmasq.conf.lancache`` to ``/etc/dnsmasq.conf`` if you don't host a lancache server, do not rename this to ensure connectivity with steam and other services.

a typical jenkins-ci script runs like:

```bash
cp profiles/mt6000.profile .config
./setup.sh skip
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
make -r

```

I  also wrote a jenkins shell script to add factory configuration to the builds from pesa1234 [for the .config](https://github.com/pesa1234/MT6000_cust_build) and [for the build env](https://github.com/pesa1234/openwrt/tree/next-r4.5.34.rss.mtk).
```bash
# check if bin folder exists, delete if exists we do not want multiple revisions because that creates issues with archiving artifacts.
[ -e "bin" ] && rm -rf bin/*
#  check if the feeds folder and luci feed folder exists to avoid errors which make the jenkins job fail.
[ ! -e "package/feeds" ] && mkdir package/feeds
[ ! -e "package/feeds/luci" ] && mkdir package/feeds/luci
cd package/feeds/luci
# end sanity checks for luci feeds.

# prepare feed to add luci-theme-argon and luci-theme-argon-config
if [ -e "luci-theme-argon" ];
then
# update submodules, if correct this will merge it automaticly (we need to test this).
git submodule update --remote
else
git submodule add -f https://github.com/jerrykuku/luci-theme-argon
git submodule add -f https://github.com/jerrykuku/luci-app-argon-config
fi
# end luci-theme-argon feed logic

#return back to workdir root.
cd ../../../
# end returning to workdir root.

# add factory configuration 1:1 as from xsdk,  this stub can be removed if factory config is not needed.
[ -e "openwrt-flint2-testing" ] && rm -rf openwrt-flint2-testing
git clone https://github.com/xize/openwrt-flint2-testing
cp -r openwrt-flint2-testing/files files/
rm -rf openwrt-flint2-testing
# end factory configuration placement.

# to avoid dupes in the .config, we delete .config with the package metadata and use the clean one from pesa1234's repo then we add our own packages on top of these.
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
echo "CONFIG_PACKAGE_luci-mod-dashboard=y" >> .config
echo "CONFIG_PACKAGE_libcurl=y" >> .config
echo "CONFIG_PACKAGE_drill=y" >> .config
# end adding our own packages to pesa1234 original package list.
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
make -r -j4
```
The resulting size should be around 18mb for the sysupgrade version, if it is lower please verify the ``config.buildinfo`` and check if the luci-proto-* and luci-app-* are set to ``y`` a wrong build results into only compiling bare bone luci with argon theme without the apps and mods or wireless tab only luci-app-argon-config tab is visible.. this is due to a piping issue within the jenkins-ci environment, therefor it is already extremely limited what we can use to update the feeds list or the build fails i.e ``make menuconfig`` and verbose debugging, ``make defconfig`` is supposed to update this but something bugs here, it only adds the proper packages when you recompile it.

What I have commented out here is the old working way, but I thought it could be cleaner by using submodules (not fully tested), this serves as a pointer to also help others finding a way to compile pesa1234's amazing builds with different packages.

[for OpenWrt direct readme go here](README_OpenWrt.md)
