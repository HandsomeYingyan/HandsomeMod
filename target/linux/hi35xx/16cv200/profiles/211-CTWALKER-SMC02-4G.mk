#
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/CTWALKER_SMC02_4G
  NAME:=CTWALKER-SMC02-4G
  PACKAGES:= \
	kmod-usb-ohci kmod-usb2 kmod-usb-ledtrig-usbport \
	busybox block-mount ca-certificates kmod-nls-base \
	kmod-nls-utf8 dnsmasq resolveip rpcd uboot-hi35xx-18ev200 \
	kmod-scsi-core kmod-fs-vfat kmod-fs-cifs kmod-i2c-core \
	kmod-i2c-algo-bit kmod-i2c-gpio kmod-i2c-gpio-custom \
	kmod-i2c-tiny-usb kmod-hid kmod-hid-generic \
	kmod-input-core kmod-input-evdev \
	kmod-ledtrig-usbdev kmod-nls-cp437 kmod-nls-iso8859-1 \
	kmod-mii kmod-atm kmod-gre kmod-l2tp kmod-iptunnel \
	kmod-ppp kmod-mppe kmod-ppp-synctty kmod-pppoa kmod-pppoe \
	kmod-pppol2tp kmod-pppox kmod-pptp kmod-slhc kmod-tun \
	kmod-udptunnel4 kmod-eeprom-93cx6 kmod-usb-acm kmod-usb-core \
	kmod-usb-net kmod-usb-net-cdc-ether kmod-usb-serial \
	kmod-usb-storage zlib hisi-osdrv2-base hisi-osdrv2-binary \
	hisi-osdrv2-kmod hisi-osdrv2-lib hisi-osdrv2-sensor usb-modeswitch
endef

define Profile/CTWALKER_SMC02_4G/Description
	CT IP camera with 3g/4g, model: SMC02, based on HI3516CV200
endef
$(eval $(call Profile,CTWALKER_SMC02_4G))
