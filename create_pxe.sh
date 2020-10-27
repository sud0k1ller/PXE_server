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

## PREPARE BIOS BOOTLOADERS ##
## SOURCE: https://docs.fedoraproject.org/en-US/fedora/rawhide/install-guide/advanced/Network_based_Installations/ 
yum instal syslinux &&
mkdir -p /var/lib/tftpboot/pxelinux.cfg &&
cp /usr/share/syslinux/{pxelinux.0,menu.c32,vesamenu.c32,ldlinux.c32,libcom32.c32,libutil.c32} /var/lib/tftpboot/ &&

## PREPARE UEFI BOOTLOADERS
## Source: https://docs.fedoraproject.org/en-US/fedora/rawhide/install-guide/advanced/Network_based_Installations/ 
yum install shim-x64 grub2-efi-x64 --installroot=/tmp/fedora --releasever 30 &&
mkdir -p /var/lib/tftpboot/uefi &&
cp /tmp/fedora/boot/efi/EFI/fedora/{shimx64.efi,grubx64.efi} /var/lib/tftpboot/uefi/



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
