#!/bin/sh
#Directory contains the target rootfs
TARGET_ROOTFS_DIR="target-rootfs"

#Directory used to mount the boot partition 
mkdir $TARGET_ROOTFS_DIR/media/BOOT

#Board hostname
filename=$TARGET_ROOTFS_DIR/etc/hostname
echo microZed > $filename

# TODO test
filename=$TARGET_ROOTFS_DIR/etc/securetty
echo ttyPS0 >> $filename

# TODO test this one
filename=$TARGET_ROOTFS_DIR/etc/ssh/sshd_config
echo useDNS no >> $filename

#Default name servers
filename=$TARGET_ROOTFS_DIR/etc/resolv.conf
echo nameserver 8.8.8.8 > $filename
echo nameserver 8.8.4.4 >> $filename

#Default network interfaces
filename=$TARGET_ROOTFS_DIR/etc/network/interfaces
echo auto eth0 >> $filename
echo iface eth0 inet static >> $filename
echo address 192.168.1.103 >> $filename
echo netmask 255.255.255.0 >> $filename
echo gateway 192.168.1.100 >> $filename

# dhcp
#echo allow-hotplug eth0 >> $filename
#echo iface eth0 inet dhcp >> $filename
#eth0 MAC address
#echo hwaddress ether 00:04:25:12:34:56 >> $filename

#Set the the debug port
filename=$TARGET_ROOTFS_DIR/etc/inittab
echo T0:23:respawn:/sbin/getty -L ttyPS0 115200 vt100 >> $filename

#Set rules to change wlan dongles
#filename=$TARGET_ROOTFS_DIR/etc/udev/rules.d/70-persistent-net.rules
#echo SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="*", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="wlan*", NAME="wlan0" > $filename

#microSD partitions mounting
filename=$TARGET_ROOTFS_DIR/etc/fstab
echo /dev/mmcblk0p1 /media/BOOT vfat noatime 0 1 > $filename
echo nodev /sys/kernel/debug	   debugfs   mode=777  0  0  >> $filename

#Add the standard Debian non-free repositories useful to load
#closed source firmware (i.e. WiFi dongle firmware)
filename=$TARGET_ROOTFS_DIR/etc/apt/sources.list
echo deb http://http.debian.net/debian/ wheezy main contrib non-free > $filename



