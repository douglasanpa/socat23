#!/usr/bin/env bash

# socat with sslv2 && sslv3 support for proxies
# symlinks the built socat to /usr/local/bin/socat23
#
# 2017 - @leonjza
set -e

# https://en.wikipedia.org/wiki/OpenSSL
#   sslv2 is ripped from 1.1.0 so build latest 1.0.2
opensslversion=1_0_2m
socatversion=1.7.3.4
working_directory=/usr/local/src
mkdir -p /usr/lib/ssl
cd $working_directory
cd openssl-OpenSSL_$opensslversion

./config --prefix=`pwd`/local --openssldir=/usr/lib/ssl enable-ssl2 enable-ssl3-method enable-des enable-rc4 enable-weak-ssl-ciphers enable-ssl3 shared
make depend
make
make -i install

echo "OpenSSL build complete."
