ifeq ($(SUBTARGET),arm9-nand)

define Device/suniv-widora-tiny200-v2-nand
  DEVICE_TITLE:= Widora Tiny200 V2 (with nand)
  DEVICE_PACKAGES:=kmod-rtc-sunxi
  SUNXI_DTS:=suniv-widora-tiny200-v2
  KERNEL_NAME := zImage
  KERNEL := kernel-bin | uImage none | sunxi-kernelubifs
  IMAGES := ubispinand.img.gz

  MKUBIFS_OPTS := -F -m $(CONFIG_SUNXI_SPINAND_PAGESIZE) -e $(shell echo $$(($(CONFIG_SUNXI_SPINAND_BLOCKSIZE) - (($(CONFIG_SUNXI_SPINAND_PAGESIZE)/1024)*2))))KiB -c 880 -U
  UBINIZE_OPTS := -vv

  BLOCKSIZE := $(CONFIG_SUNXI_SPINAND_BLOCKSIZE)KiB
  PAGESIZE := $(CONFIG_SUNXI_SPINAND_PAGESIZE)
  SUBPAGESIZE := $(CONFIG_SUNXI_SPINAND_PAGESIZE)
  VID_HDR_OFFSET := $(CONFIG_SUNXI_SPINAND_PAGESIZE)
  IMAGE_SIZE := $(CONFIG_TARGET_ROOTFS_PARTSIZE)m
  KERNEL_IN_UBI := 1
  UBOOTENV_IN_UBI := 1
  # UBINIZE_PARTS := dtb=$(DTS_DIR)/$$(SUNXI_DTS).dtb=1
  IMAGE/ubispinand.img.gz := \
      sunxi-spinandboot | \
      pad-to $$(CONFIG_SUNIV_OFFSET_UBI) | \
      append-ubi | \
      gzip
endef

TARGET_DEVICES += suniv-widora-tiny200-v2-nand

define Device/suniv-widora-tiny200-v3-nand
  DEVICE_TITLE:= Widora Tiny200 v3 (with nand)
  DEVICE_PACKAGES:=kmod-rtc-sunxi
  SUNXI_DTS:=suniv-widora-tiny200-v3
  KERNEL_NAME := zImage
  KERNEL := kernel-bin | uImage none | sunxi-kernelubifs
  IMAGES := ubispinand.img.gz

  MKUBIFS_OPTS := -F -m $(CONFIG_SUNXI_SPINAND_PAGESIZE) -e $(shell echo $$(($(CONFIG_SUNXI_SPINAND_BLOCKSIZE) - (($(CONFIG_SUNXI_SPINAND_PAGESIZE)/1024)*2))))KiB -c 880 -U
  UBINIZE_OPTS := -vv

  BLOCKSIZE := $(CONFIG_SUNXI_SPINAND_BLOCKSIZE)KiB
  PAGESIZE := $(CONFIG_SUNXI_SPINAND_PAGESIZE)
  SUBPAGESIZE := $(CONFIG_SUNXI_SPINAND_PAGESIZE)
  VID_HDR_OFFSET := $(CONFIG_SUNXI_SPINAND_PAGESIZE)
  IMAGE_SIZE := $(CONFIG_TARGET_ROOTFS_PARTSIZE)m
  KERNEL_IN_UBI := 1
  UBOOTENV_IN_UBI := 1
  # UBINIZE_PARTS := dtb=$(DTS_DIR)/$$(SUNXI_DTS).dtb=1
  IMAGE/ubispinand.img.gz := \
      sunxi-spinandboot | \
      pad-to $$(CONFIG_SUNIV_OFFSET_UBI) | \
      append-ubi | \
      gzip
endef

TARGET_DEVICES += suniv-widora-tiny200-v3-nand

endif
