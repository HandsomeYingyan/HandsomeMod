#!/usr/bin/env bash
#
# Copyright (C) 2019 Benedikt-Alexander Mokroß (iCOGNIZE GmbH)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

set -ex
[ $# -eq 4 ] || [ $# -eq 6 ] || {
    echo "SYNTAX: $0 <outputfile> <u-boot image> <nand page size> <nand block size in KiB> [<spl copies> <u-boot copies>]"
    echo "Given: $@"
    exit 1
}

OUTPUT="$1"
UBOOT="$2"
PAGESIZE="$3"
BLOCKSIZE="$4"
SPLCOPIES="0"
UBOOTCOPIES="0"

[ $# -eq 6 ] && {
	SPLCOPIES=$(($5 - 1))
	UBOOTCOPIES=$(($6 - 1))
}

# SPL-Size is an uint32 at 16 bytes offset contained in the SPL header
SPLSIZE=$(od -An -t u4 -j16 -N4 "$UBOOT" | xargs)
# The u-boot size is at offset 12 (4. 32-bit int) from the start of u-boot, which is padded 0x2000 bytes (observed) after the SPL 
UBOOTSIZE=$(od --endian=big -An -t u4 -j $(($SPLSIZE + 8192 + 12)) -N4 "$UBOOT" | xargs)

ALIGNCHECK=$(($PAGESIZE%1024))
if [ "$ALIGNCHECK" -ne "0" ]; then
	echo "Page-size is not 1k alignable and thus not supported by EGON"
	exit -1
fi

KPAGESIZE=$(($PAGESIZE/1024))
SPLBLOCKS=$(($SPLSIZE/1024))
LOOPSPLBLOCKS=$(($SPLBLOCKS-1))
SPLENTRYSTEPS=$(($KPAGESIZE * 32))
TOTALSPLSIZE=$((($SPLENTRYSTEPS * $SPLCOPIES) + $SPLBLOCKS))
NEXTPEB=$(($TOTALSPLSIZE + $BLOCKSIZE - ($TOTALSPLSIZE % $BLOCKSIZE)))
UBOOTPEBS=$((($UBOOTSIZE/1024) + $BLOCKSIZE - ($UBOOTSIZE/1024) % $BLOCKSIZE))

echo "$@" > $OUTPUT.imgmeta
echo "SPL-size $SPLSIZE">> $OUTPUT.imgmeta
echo "u-boot-size $UBOOTSIZE">> $OUTPUT.imgmeta
echo "block-size 1 KiB" >> $OUTPUT.imgmeta
echo "Page-size $KPAGESIZE KiB">> $OUTPUT.imgmeta
echo "PEB-size $BLOCKSIZE KiB">> $OUTPUT.imgmeta
echo "SPL-count $(($SPLCOPIES + 1))">> $OUTPUT.imgmeta
echo "u-boot-count $(($UBOOTCOPIES + 1))">> $OUTPUT.imgmeta
printf "SPL-entry-steps 0x%x\n" $(($SPLENTRYSTEPS*1024))>> $OUTPUT.imgmeta
echo "SPL-blocks $TOTALSPLSIZE">> $OUTPUT.imgmeta
echo "u-boot-block $UBOOTPEBS">> $OUTPUT.imgmeta
echo "first-u-boot $NEXTPEB">> $OUTPUT.imgmeta
echo "## Layout ##">> $OUTPUT.imgmeta

# The BROM of the SUNXI is only able to load 1k per page from SPI-NAND
# Thus, even if we have an 2k or 4k page-size, we have to chunk the SPL in 1k pieces
#
# Entry-Pages:
#          32,      64,      96,      128,      160,      192,      224
# 1k:  0x8000, 0x10000, 0x18000   0x20000,  0x28000,  0x30000,  0x38000
# 2k: 0x10000, 0x20000, 0x30000,  0x40000,  0x50000,  0x60000,  0x70000
# 4K: 0x20000, 0x40000, 0x60000,  0x80000,  0xA0000,  0xC0000,  0xE0000
# 8K: 0x40000, 0x80000, 0xC0000, 0x100000, 0x140000, 0x180000, 0x1C0000

echo "Generating 0-image for boot part of size $SPLSIZE ($SPLBLOCKS blocks)"
dd if="/dev/zero" of="$OUTPUT" bs=1024 count=$(($SPLBLOCKS * ($SPLCOPIES + 1)))

for splcopy in `seq 0 $SPLCOPIES`;
do
	echo "SPL Copy $splcopy"
	printf "spl-%u 0x%x\n" $splcopy $(($SPLENTRYSTEPS * $splcopy * 1024)) >> $OUTPUT.imgmeta
	echo "Copying block 0 to $(($SPLENTRYSTEPS * $splcopy))"
	dd if="$UBOOT" of="$OUTPUT" bs=1024 count=2 seek=$(($SPLENTRYSTEPS * $splcopy)) skip=0 conv=notrunc

	for from in `seq 1 $LOOPSPLBLOCKS`;
	do
		to=$((($SPLENTRYSTEPS * $splcopy) + ($from*$KPAGESIZE)))
		echo "Copying block $from to $to" 
		dd if="$UBOOT" of="$OUTPUT" bs=1024 count=1 seek=$to skip=$from conv=notrunc
	done

done

# it was observed, that u-boot is padded 0x2000 behind the spl. so add 0x2000 (= 8192 -> 8x1024k blocks) to the splsize to get the uboot-entry
for ubootcopy in `seq 0 $UBOOTCOPIES`;
do
	echo "Appending u-boot to chunked SPL at block $(($NEXTPEB + ($UBOOTPEBS * $ubootcopy))) (origin: $SPLBLOCKS)"
	dd if="$UBOOT" of="$OUTPUT" bs=1024 seek=$(($NEXTPEB + ($UBOOTPEBS * $ubootcopy))) skip=$(($SPLBLOCKS + 8)) conv=notrunc

	printf "u-boot-%u 0x%x\n" $ubootcopy $((($NEXTPEB + ($UBOOTPEBS * $ubootcopy)) * 1024)) >> $OUTPUT.imgmeta
done

