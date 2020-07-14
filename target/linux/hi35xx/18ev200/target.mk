#
# Copyright (C) 2012 OpenWrt.org
#

SUBTARGET:=18ev200
BOARDNAME:=HI3518EV200 (ARMv5) armv5tej
CPU_TYPE:=arm926ej-s
KERNEL_PATCHVER:=4.9.37
KERNELNAME:=zImage Image dtbs

define Target/Description
	Build firmware images for SoC version kernel 4.9.37. \
	Supported hi3516cv200|hi3518ev200|hi3518ev201.
endef
