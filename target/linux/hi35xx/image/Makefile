#
# Copyright (C) 2006-2013 OpenWrt.org
# Copyright (C) 2020 HandsomeMod Project
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

KERNEL_LOADADDR = 0x80008000



IMAGE_PROFILE:=$(if $(PROFILE),$(PROFILE),DEFAULT)

LZMA_XZ_OPTIONS := -Xpreset 6 -Xlc 0 -Xlp 2 -Xpb 2
SQUASHFSCOMP := xz $(LZMA_XZ_OPTIONS)

KDIR_TMP:=$(KDIR)/tmp
VMLINUX:=$(BIN_DIR)/$(IMG_PREFIX)-vmlinux
UIMAGE:=$(BIN_DIR)/$(IMG_PREFIX)-uImage

#define Build/prepend-with-elf
#    mv $@ $@.old
#    dd if=$(KDIR)/loader.elf of=$@ bs=131072 conv=sync
#    cat $@.old >> $@
#endef

#define Build/tailed-bin
#    echo $(BIN_TAIL) >> $@
#endef

# Add auto-update image Handsomeyingyan
define Image/mkfs/squashfs
    ( $(STAGING_DIR_HOST)/bin/mksquashfs4 $(TARGET_DIR) $(KDIR)/root.squashfs -nopad -noappend -root-owned -comp $(SQUASHFSCOMP) $(SQUASHFSOPT) -processors $(if $(CONFIG_PKG_BUILD_JOBS),$(CONFIG_PKG_BUILD_JOBS),1) && \
    cp $(KDIR)/root.squashfs $(BIN_DIR)/$(IMG_PREFIX)-default-root.squashfs && \
    mkimage -A $(LINUX_KARCH) -T filesystem -C none -n hirootfs -d $(KDIR)/root.squashfs $(KDIR)/rootfs && \
    cp $(KDIR)/rootfs $(BIN_DIR)/$(IMG_PREFIX)-rootfs-autoupdate)
endef

# Build commands that can be called from Device/* templates
define Build/uImage
    mkimage -A $(LINUX_KARCH) \
        -O linux -T kernel \
        -C $(1) -a $(KERNEL_LOADADDR) -e $(if $(KERNEL_ENTRY),$(KERNEL_ENTRY),$(KERNEL_LOADADDR)) \
        -n '$(IMAGE_HEADER_INFO)' -d $@ $@.new
    @mv $@.new $@
endef

define Image/pad-to
    dd if=$(1) of=$(1).new bs=$(2) conv=sync
    mv $(1).new $(1)
endef

define Build/pad-to
    $(call Image/pad-to,$@,$(1))
endef

#################################################
# Devices
#################################################

DEVICE_VARS += BOARDNAME
DEVICE_VARS += SENSOR
DEVICE_VARS += CPU_MODEL
DEVICE_VARS += UBOOTOFFSET

define Build/sysupgrade-header
    ( printf "CI%08x%08x%32s" \
        $$(($(subst k,* 1024,$(subst m, * 1024k,$(KERNEL_SIZE))))) $$(($(subst k,* 1024,$(subst m, * 1024k,$(ROOT_FS_SIZE))))) \
        $$(md5sum < $@ | awk '{print $$1}') | \
        dd bs=64k conv=sync; \
        cat $@ \
    ) > $@.new 2>/dev/null
    @mv $@.new $@
endef

define Device/hi35xx-default
    IMAGES := sysupgrade.bin factory.bin
    IMAGE_PREFIX := $(IMG_PREFIX)-$(1)
    KERNEL_PREFIX := $(IMG_PREFIX)-$(1)
    KERNEL_NAME = zImage
    KERNEL_SUFFIX := -uImage
    KERNEL_INSTALL := 1
    KERNEL_SIZE:=2048k
    ROOT_FS_SIZE:=5120k
    KERNEL_PAD_SIZE:=2097088
    KERNEL := kernel-bin | uImage none
    KERNEL_INITRAMFS := kernel-bin | uImage none
    BLOCKSIZE := 128k
    FILESYSTEMS = $(filter-out jffs2-%,$(TARGET_FILESYSTEMS)) jffs2-$$(BLOCKSIZE)
    IMAGE/sysupgrade.bin := append-kernel $${KERNEL_SIZE} | pad-to 64k | append-rootfs $${ROOT_FS_SIZE} | sysupgrade-header
    IMAGE/factory.bin := append-kernel $${KERNEL_SIZE} | pad-to 64k | append-rootfs $${ROOT_FS_SIZE} | check-size $$$$(IMAGE_SIZE)
endef

define Device/hi35xx-default-16m
    $(Device/hi35xx-default)
    FLASH_SIZE := 16m
    IMAGE_SIZE := 15872k
endef

define Device/hi35xx-default-8m
    $(Device/hi35xx-default)
    FLASH_SIZE := 8m
    IMAGE_SIZE := 7680k
endef

define NewDevice
  define Device/$(1)
    $$(Device/hi35xx-default-16m)
    BOARDNAME := $(2)
    DEVICE_TITLE := $(3)
    SENSOR := $(4)
    CPU_MODEL := $(5)
    UBOOTOFFSET := $(6)
    DEVICE_PROFILE := $(7)
  endef
  ifeq ($(PROFILE),$(7))
    TARGET_DEVICES += $(1)
  endif # ifeq ($(PROFILE),$(7))
endef

define NewDevice-dts
  define Device/$(1)
    $$(Device/hi35xx-default-16m)
    KERNEL_SIZE:=4096k
    KERNEL := kernel-bin | append-dtb | uImage none
    KERNEL_INITRAMFS := kernel-bin | append-dtb
    BOARDNAME := $(2)
    DEVICE_TITLE := $(3)
    SENSOR := $(4)
    CPU_MODEL := $(5)
    UBOOTOFFSET := $(6)
    DEVICE_PROFILE := $(7)
    DEVICE_DTS := $(8)
  endef
  ifeq ($(PROFILE),$(7))
    TARGET_DEVICES += $(1)
  endif # ifeq ($(PROFILE),$(7))
endef

ifeq ($(SUBTARGET),18ev200)
    $(eval $(call NewDevice-dts,default,DEFAULT,DEFAULT,ALL,HI3518EV200,320k,DEFAULT)) # @flyrouter
    $(eval $(call NewDevice-dts,ctwalker-smc01-wifi,CTWALKER-SMC01,CTWALKER SMC01 WIFI,OV9732,HI3518EV200,320k,CTWALKER_SMC01_WIFI,hi3518ev20x-demb)) # @ussh
    $(eval $(call NewDevice-dts,ctwalker-smc01-4g,CTWALKER-SMC01,CTWALKER SMC01 4G,OV9732,HI3518EV200,320k,CTWALKER_SMC01_4G,hi3518ev20x-demb)) # @ussh
endif # ifeq ($(SUBTARGET),18ev200)

ifeq ($(SUBTARGET),16cv200)
    $(eval $(call NewDevice-dts,default,DEFAULT,DEFAULT,ALL,HI3518EV200,320k,DEFAULT)) # @flyrouter
    $(eval $(call NewDevice-dts,ctwalker-smc02-wifi,CTWALKER-SMC02,CTWALKER SMC02 WIFI,IMX323,HI3516CV200,320k,CTWALKER_SMC02_WIFI,hi3518ev20x-demb)) # @ussh
    $(eval $(call NewDevice-dts,ctwalker-smc02-4g,CTWALKER-SMC02,CTWALKER SMC02 4G,IMX323,HI3516CV200,320k,CTWALKER_SMC02_4G,hi3518ev20x-demb)) # @ussh
endif # ifeq ($(SUBTARGET),18ev200)

define Image/Build/squashfs
	cp $(KDIR)/root.squashfs $(BIN_DIR)/$(IMG_PREFIX)-root.squashfs
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-$(1).img bs=131072 conv=sync
endef



$(eval $(call BuildImage))
