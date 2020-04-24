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
  SUNXI_DTS:=suniv-f1c100s-licheepi-nano-with-lcd
  KERNEL_COMPRESS := Y
endef

TARGET_DEVICES += suniv-f1c100s-licheepi-nano


endif
