#!/bin/sh

fw_uri="https://www.devolo.global/fileadmin/Web-Content/DE/products/hnw/magic-2-wifi-next/firmware/delos_magic-2-wifi-next_6.0.1_2023-09-06.bin"

if [ ! -e "devolo.bin" -o ! -d ghn ];
then
	echo "devolo.bin not found, downloading now."
	wget -q $fw_uri -O devolo.bin
	if [[ $? -ne 0 ]];
	then
		echo "Error: failed to download devolo.bin, url has been changed?"
		exit 1
	else
		echo "downloaded devolo.bin successfully."
		echo "extracting devolo.bin to ghn."
		./scripts/devolo-extract-ghn-packages devolo.bin ghn
		#cp -rf ghn files/firmware (lets not do this).
	fi
else
	echo "skip downloading devolo firmware, already found locally scoped."
fi


cp profiles/devolo-magic2-next.profile .config

exit 0

