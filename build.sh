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

# OpenSSL first
echo "Preparing working directory..."
mkdir -p $working_directory
cd $working_directory

echo "Downloading OpenSSL $opensslversion..."
curl -L -s -O https://github.com/openssl/openssl/archive/OpenSSL_$opensslversion.tar.gz

echo "Unpacking and building..."
tar xvf OpenSSL_$opensslversion.tar.gz
cd openssl-OpenSSL_$opensslversion

cd $working_directory
echo "Downloading socat..."
curl -s -O http://www.dest-unreach.org/socat/download/socat-$socatversion.tar.gz

echo "Unpacking and building..."
tar xvf socat-$socatversion.tar.gz
cd socat-$socatversion

mkdir -p /usr/lib/ssl
cd $working_directory
cd openssl-OpenSSL_$opensslversion

./config --prefix=`pwd`/local --openssldir=/usr/lib/ssl enable-ssl2 enable-ssl3-method enable-des enable-rc4 enable-weak-ssl-ciphers enable-ssl3 shared
make depend
make
make -i install

echo "OpenSSL build complete."

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
