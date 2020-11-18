#
# Copyright (C) 2013-2016 OpenWrt.org
# Copyright (C) 2016 Yousong Zhou
# Copyroght (C) 2020 HandsomeMod Project
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

FAT32_BLOCK_SIZE=1024
FAT32_BLOCKS=$(shell echo $$(($(CONFIG_SUNXI_SD_BOOT_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

KERNEL_LOADADDR:=0x40008000

define Build/sunxi-sdcard
	rm -f $@.boot
	mkfs.fat $@.boot -C $(FAT32_BLOCKS)

	mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.scr ::boot.scr
	mcopy -i $@.boot $(DTS_DIR)/$(SUNXI_DTS).dtb ::dtb
	$(if $(KERNEL_COMPRESS), mcopy -i $@.boot $(KDIR)/zImage ::zImage, \
	    mcopy -i $@.boot $(IMAGE_KERNEL) ::uImage)
	./gen_sunxi_sdcard_img.sh $@ \
		$@.boot \
		$(IMAGE_ROOTFS) \
		$(CONFIG_SUNXI_SD_BOOT_PARTSIZE) \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) \
		$(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot-with-spl.bin
	rm -f $@.boot
endef

define Build/sunxi-spinandboot
	./gen_sunxi_spinand_onlyboot_img.sh $@ \
		$(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot-with-spl.bin
endef

define Build/sunxi-kernelubifs
	./gen_sunxi_kernel_ubifs.sh $(KDIR)/zImage \
		$(DTS_DIR)/$(SUNXI_DTS).dtb \
		$(CONFIG_SUNXI_SPINAND_PAGESIZE) \
		$(CONFIG_SUNXI_SPINAND_BLOCKSIZE)
endef

# why \x00\x00\x00\x00 for zImage-initramfs
define Device/Default
  PROFILES := Default
  DEVICE_VARS := SUNXI_DTS SUNXI_UBOOT
  KERNEL_NAME := zImage
  KERNEL := kernel-bin | uImage none
  IMAGES := sdcard.img.gz
  IMAGE/sdcard.img.gz := sunxi-sdcard | append-metadata | gzip
endef

include cortex-a7.mk
include cortex-a8.mk
include cortex-a53.mk
include arm9.mk
include arm9-nand.mk

$(eval $(call BuildImage))
