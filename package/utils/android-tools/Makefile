#
#
# Copyright (C) 2020 HandsomeMod Project
#
#
include $(TOPDIR)/rules.mk


PKG_NAME:=android-tools
PKG_VERSION:=4.2.2+git20130218

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/HandsomeYingyan/android-tools.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:= 9a1d541442f011d3a3d780ba5a5b650c7d7cad40
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
PKG_MAINTAINER:=HandsomeYingyan <handsomeyingyan@gmail.com>

include $(INCLUDE_DIR)/package.mk


define Package/android-tools/default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Android Debug Tools
  URL:=http://tools.android.com/
  DEPENDS:=+zlib +libopenssl +libpthread
endef

define Package/$(PKG_NAME)/Default/description
 Android Debug Bridge (adb) is a versatile command line tool that lets you communicate with an emulator instance or connected Android-powered device.
endef


define Package/$(PKG_NAME)-adbd
$(call Package/$(PKG_NAME)/default)
	TITLE+= - adbd
endef




# Nothing just to be sure
#define Build/Configure
#endef

define Build/Compile

	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		TARGET=Linux \
		CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		-f $(PKG_BUILD_DIR)/adbd.mk



endef



define Package/$(PKG_NAME)-adbd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/adbd $(1)/usr/bin/
endef




$(eval $(call BuildPackage,$(PKG_NAME)-adbd))

