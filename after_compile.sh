#!/bin/sh

# make sure the relative path of staging_dir/host/bin is added to $PATH
# use export PATH="$PATH:/home/youruser/openwrt/staging_dir/host/bin" for apk utility to work.
#
# also add export PATH="$PATH:/home/youruser/openwrt/bin/targets/ipq40xx/generic"

fw_uri="https://www.devolo.global/fileadmin/Web-Content/DE/products/hnw/magic-2-wifi-next/firmware/delos_magic-2-wifi-next_6.0.1_2023-09-06.bin"

if [ ! -e "delos_magic-2-wifi-next_6.0.1_2023-09-06.bin" -o ! -d ghn ];
then
	echo "delos_magic-2-wifi-next_6.0.1_2023-09-06.bin not found, downloading now."
	wget -q $fw_uri
	if [[ $? -ne 0 ]];
	then
		echo "Error: failed to download devolo.bin, url has been changed?"
		exit 1
	else
		echo "downloaded devolo bin successfully."
		echo "extracting devolo bin to ghn."
		./scripts/devolo-extract-ghn-packages delos_magic-2-wifi-next_6.0.1_2023-09-06.bin ghn/
		#cp -rf ghn files/firmware (lets not do this).
	fi
else
	echo "skip downloading devolo firmware, already found locally scoped."
fi

exit 0

