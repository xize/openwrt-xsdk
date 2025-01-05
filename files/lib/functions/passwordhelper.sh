#!/bin/sh

genpasswd() {
    local l=$1;
    tr -dc A-Za-z0-9\$\_\.\@ < /dev/urandom | head -c ${l} | xargs
}