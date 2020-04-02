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

cd $working_directory
cd openssl-OpenSSL_$opensslversion

# set variables to use in socat build
openssl_libs=`pwd`/local/lib
openssl_include=`pwd`/local/include
openssl_rpath="-Wl,-rpath,'\$\$ORIGIN/../openssl-OpenSSL_$opensslversion/local/lib' -Wl,-z,origin"

echo "OpenSSL build complete."

# Next, socat!
cd $working_directory

cd socat-$socatversion

./configure LIBS="-L$openssl_libs" CPPFLAGS="-I$openssl_include" LDFLAGS="$openssl_rpath" --with-openssl-method
make

echo "Creating symlink to new socat for 'socat23'..."
ln -s `pwd`/socat /usr/local/bin/socat23

echo "Done"
