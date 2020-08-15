#
# Copyright (C) 2006-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

WIRELESS_MENU:=Wireless Drivers

define KernelPackage/net-prism54
  SUBMENU:=$(WIRELESS_MENU)
  TITLE:=Intersil Prism54 support
  DEPENDS:=@PCI_SUPPORT +@DRIVER_WEXT_SUPPORT +prism54-firmware
  KCONFIG:=CONFIG_PRISM54
  FILES:= \
	$(LINUX_DIR)/drivers/net/wireless/prism54/prism54.ko@lt4.5 \
	$(LINUX_DIR)/drivers/net/wireless/intersil/prism54/prism54.ko@ge4.5
  AUTOLOAD:=$(call AutoProbe,prism54)
endef

define KernelPackage/net-prism54/description
 Kernel modules for Intersil Prism54 support
endef

$(eval $(call KernelPackage,net-prism54))


define KernelPackage/net-rtl8192su
  SUBMENU:=$(WIRELESS_MENU)
  TITLE:=RTL8192SU support (staging)
  DEPENDS:=@USB_SUPPORT +@DRIVER_WEXT_SUPPORT +kmod-usb-core +rtl8192su-firmware
  KCONFIG:=\
	CONFIG_STAGING=y \
	CONFIG_R8712U
  FILES:=$(LINUX_DIR)/drivers/staging/rtl8712/r8712u.ko
  AUTOLOAD:=$(call AutoProbe,r8712u)
endef

define KernelPackage/net-rtl8192su/description
 Kernel modules for RealTek RTL8712 and RTL81XXSU fullmac support.
endef

$(eval $(call KernelPackage,net-rtl8192su))




define KernelPackage/cfg80211-old
  SUBMENU:=$(WIRELESS_MENU)
  TITLE:=using orginal kernel's cfg80211
  DEPENDS:= +iw +wireless-regdb 
  KCONFIG:=\
	CONFIG_CFG80211_WEXT=y \
	CONFIG_CFG80211_CRDA_SUPPORT=y \
	CONFIG_CFG80211_DEFAULT_PS=y \
	CONFIG_CFG80211
  FILES:= \
	$(LINUX_DIR)/net/wireless/cfg80211.ko
  AUTOLOAD:=$(call AutoProbe,cfg80211)
endef

define KernelPackage/cfg80211-old/description
 Using orginal cfg80211 in kernel (not backport)
endef

$(eval $(call KernelPackage,cfg80211-old))


define KernelPackage/owl-loader
  SUBMENU:=$(WIRELESS_MENU)
  TITLE:=Owl loader for initializing Atheros PCI(e) Wifi chips
  DEPENDS:=@PCI_SUPPORT
  KCONFIG:=CONFIG_OWL_LOADER
  FILES:=$(LINUX_DIR)/drivers/misc/owl-loader.ko
  AUTOLOAD:=$(call AutoProbe,owl-loader)
endef

define KernelPackage/owl-loader/description
  Kernel module that helps to initialize certain Qualcomm
  Atheros' PCI(e) Wifi chips, which have the init data
  (which contains the PCI device ID for example) stored
  together with the calibration data in the file system.

  This is necessary for devices like the Cisco Meraki Z1.
endef

$(eval $(call KernelPackage,owl-loader))
