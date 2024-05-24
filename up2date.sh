#!/bin/bash

echo "== 1 == rm -rf /var/lib/dpkg/lock-frontend"
rm -rf /var/lib/dpkg/lock-frontend

echo "== 2== rm -rf /var/lib/dpkg/lock"
rm -rf /var/lib/dpkg/lock

echo "== 3 == apt-get update"
apt-get update

echo "== 4 == apt-get upgrade -y"
apt-get upgrade -y

echo "== 5 == apt-get dist-upgrade -y"
apt-get dist-upgrade -y

echo "== 6 == apt-get autoremove -y"
apt-get autoremove -y

echo "== 7 == apt-get autoclean -y"
apt-get autoclean -y
