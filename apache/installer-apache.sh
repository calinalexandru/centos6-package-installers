#!/usr/bin/env bash

# install package
yum -y install httpd

# start service
service httpd start

# boot
chkconfig httpd on
