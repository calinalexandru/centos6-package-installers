#!/usr/bin/env bash

# TODO:: advanced repo checkign

# install package
yum -y install httpd

# start service
service httpd start

# boot
chkconfig httpd on
