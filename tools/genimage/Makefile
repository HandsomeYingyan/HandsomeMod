# 
# Copyright (C) 2020 HandsomeMod Project
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=genimage
PKG_VERSION:=12

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/pengutronix/genimage/releases/download/v$(PKG_VERSION)
PKG_HASH:=2e9b43d1288f4e216d6c79de2a0c53ce1bd41f93cec750d8ab057aa2d0b0ee4a

HOST_BUILD_PARALLEL:=1
HOST_BUILD_DEPENDS:=confuse/host pkg-config/host

include $(INCLUDE_DIR)/host-build.mk

HOSTCC := $(HOSTCC_NOCACHE)
HOSTCXX := $(HOSTCXX_NOCACHE)

define Host/Install
	+$(MAKE) $(HOST_JOBS) -C $(HOST_BUILD_DIR) install
endef

$(eval $(call HostBuild))
