#!/bin/bash

#backup folders
backupDir="backup_$(date +%Y%m%d%H%M%S)"

if [ ! -d $backupDir ]; then
    mkdir $backupDir/;
fi;


#conf folders 
folders=(
/etc/network/
/etc/frr/
/etc/cumulus/acl/*
/etc/lldpd.d/
/etc/ssh/ )

#conf files
files=(
/etc/resolv.conf
/etc/cumulus/ports.conf
/etc/cumulus/switchd.conf
/etc/passwd
/etc/shadow
/etc/group
/etc/lldpd.conf
/etc/nsswitch.conf
/etc/sudoers
/etc/sudoers.d
/etc/ntp.conf
/etc/timezone
/etc/snmp/snmpd.conf
/etc/default/isc-dhcp-relay
/etc/default/isc-dhcp-relay6
/etc/default/isc-dhcp-server
/etc/default/isc-dhcp-server6
/etc/cumulus/ports.conf
/etc/ptp4l.conf
/etc/hostname
/etc/vxsnd.conf
/etc/hosts
/etc/dhcp/dhclient-exit-hooks.d/dhcp-sethostname
/usr/lib/python2.7/dist-packages/cumulus/__chip_config/mlx/datapath.conf
/etc/cumulus/datapath/traffic.conf
/etc/hostapd.conf
/etc/security/limits.conf )

for folder in ${folders[@]}
do
	echo "backing up $folder to $backupDir"
	cp --parents -rv $folder $backupDir/
done

for file in ${files[@]}
do
	echo "backing up $file to  $backupDir"
	cp --parents -fv $file $backupDir/
done

backupfile="backup_compressed_$(date +%Y%m%d%H%M%S).tar"
tar -cvf $backupfile $backupDir && rm -R $backupDir

echo "Backup finished"
