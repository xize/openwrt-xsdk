![OpenWrt logo](include/logo.png)

This is a more personalized build with pre-configuration builded in, please assist checking /files/etc/uci-defaults since these images are not feasible for all people, it's for better ease of use for myself to make testing alot more robust.

for lancache (a external server on 10.244.244.5 not in OpenWrt):

rename /etc/dnsmasq.conf.lancache to /etc/dnsmasq.conf

a typical jenkins-ci script runs like:

```
cp profiles/mt6000.profile .config
./setup.sh skip
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
make -r

```