#
# Copyright (C) 2013-2016 OpenWrt.org
# Copyright (C) 2018 Fengling
# Copyright (C) 2020 HandsomeMod Project
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
ifeq ($(SUBTARGET),arm9)

define Device/suniv-f1c100s-licheepi-nano
  DEVICE_TITLE:=Lichee Pi Nano
  SUNXI_DTS:=suniv-f1c100s-licheepi-nano
  KERNEL_COMPRESS := Y
endef

TARGET_DEVICES += suniv-f1c100s-licheepi-nano

define Device/suniv-widora-tiny200-v2
  DEVICE_TITLE:=Widora Tiny200 V2
  SUNXI_DTS:=suniv-widora-tiny200-v2
  KERNEL_COMPRESS := Y
endef

TARGET_DEVICES += suniv-widora-tiny200-v2

define Device/suniv-widora-tiny200-v3
  DEVICE_TITLE:=Widora Tiny200 V3
  SUNXI_DTS:=suniv-widora-tiny200-v3
  KERNEL_COMPRESS := Y
endef

TARGET_DEVICES += suniv-widora-tiny200-v3

endif
