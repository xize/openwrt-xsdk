![OpenWrt logo](include/logo.png)

This is a more personalized fork of [OpenWrt](https://github.com/openwrt/openwrt) with pre-configuration builded in, please assist checking /files/etc/uci-defaults since these images are not feasible for all people, it's for better ease of use for myself to make testing alot more robust.

This version is for the Devolo with powerline drivers taken from this thread: https://forum.openwrt.org/t/installing-openwrt-on-devolo-magic-2-wifi-next/129725/46

and repo https://github.com/jschwartzenberg/openwrt/tree/devolo-magic
full credits of the extract script belongs to this author jschwartzenberg :).


typical jenkins config:

```
./setup.sh # downloads the original firmware, or keeps it scoped, for a new version delete devolo.bin and ghn folder.)
./scripts/feeds update -a
./scripts/feeds install -a
cp profiles/devolo-magic2-next.profile .config
make defconfig -j8
make download -j8
make toolchain/install
make -j8
```

make however sure that patchelf, and binwalk is installed in apt.
and also make sure that when archiving the artifacts to also add folder ghn in jenkins aswell.

I decided not to add this to /rom because I have no control over the firmware and this target has only 32mb flash!, people have to manually install the ipkgs, there is no possibility to have this platform run APK.

Currently the config is pretty much default, only the ghn interface gets added, but will be in the future changed into a dumbap one but at present I don't have this device with me.


[for OpenWrt direct readme go here](README_OpenWrt.md)
