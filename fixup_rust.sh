#!/bin/sh
echo fixing rust....
cd dl
tar -xf rustc-*.*.*-src.tar.xz -C ../build_dir/target-*_musl/host/
echo done
exit 0


