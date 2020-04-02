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


