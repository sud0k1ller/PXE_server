#!/bin/bash

###############################
## CREATE SCRIPT FOR NEW NIC ##
###############################


###############################
## INSTALL REQUIRED FEATURES ##
###############################
yum update &&
yum install dhcp &&
## HERE COPY DHCPD CONFIG FILE ##
yum install tftp-server &&
yum instal syslinux &&


###############################
##     PREPARE SERVICES      ##
###############################
systemctl stop firewalld
systemctl disable firewalld
systemctl restart NetworkService
systemctl start dhcpd
systenctl enable dhcpd
systemctl start tftp
systemctl enable
