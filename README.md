# HandsomeMod Alpha
# Devoloping now happen in [HandsomeMod 21.03](https://github.com/HandsomeMod/HandsomeMod)
## IOT Freedom For End-user!
## Development in this branch is now discontinued!
## 19.07 is too old for some features in HandsomeMod.
### Warning!!
## This Project is unstable and un-fully tested right now!
### HandsomeMod is Not A router-only distribution.
### Right Now Router is not Our Mainly Support Target.

This is the buildsystem for the HandsomeMod Linux distribution.

To build your own firmware you need a Linux, BSD or MacOSX system (case
sensitive filesystem required). Cygwin is unsupported.

You need gcc, binutils, bzip2, flex, python, perl, make, find, grep, diff,
unzip, gawk, getopt, subversion, libz-dev and libc headers installed.

1. Run "./scripts/feeds update -a" to obtain all the latest package definitions
defined in feeds.conf / feeds.conf.default

2. Run "./scripts/feeds install -a" to install symlinks for all obtained
packages into package/feeds/

3. Run "make menuconfig" to select your preferred configuration for the
toolchain, target system & firmware packages.

4. Run "make" to build your firmware. This will download all sources, build
the cross-compile toolchain and then cross-compile the Linux kernel & all
chosen applications for your target system.

## Thanks

The orginal code comes form openwrt 19.07.

https://github.com/openwrt/openwrt

## Project Goal

- Create a ready-to-use lightweight linux distribution for single-board computer and IOT devices.

- Bring package-manager to devices that has lower memory.

- Maybe the first mainline-based IOT Solution?

- A Simple distribution for IOT devices with screen.

#  The Main Target Support By HandsomeMod

- Rapsberry pies (BCM27xx)

- Allwinner Socs （Sunxi）

- Freescale I.MX6ULL Family

- Hi35xx (EOF)

- MSM8916 (Planing)

- Samsung Exynos 4412 On samsung i9300(planing)


#  What is Moded?

- Use ucl and upx to reduce image size.

- Change some source mirrors (Build faster in China).

- Add some basic modules to support gpu and drm.

- Add rt-linux patches.

- Add Fbdev Based mali blobs.

- Add lvgl Support.

- Include Socs not yet in mainline(eg. Allwinner V3s F1cx00s and HiSilicon hi35xx).

- Update the kernel backport driver to 5.8(better wifi signal).

- Ipcam soc support(Hi35xx) EOF

- Non-free feeds for Allwinner cedarX and HiSilicon libs and modules.

- Some Tweaks in usb gadget .

- Tweaks to support some device with screen.

- Use eudev instead of the orginal one in openwrt.

- qt5 sdl2 directfb support!

- Connman For Wext-based wifi chips.

- Sunxi mail400 kernel module and userspace library.(Runs Pretty Well With Glmark2 Fbdev)

- Linux 5.4 Support! (4.9 and 4.14 Now Basically EOF)

- CedarX With Openmax Support For Sunxi Mainline(5.4) Devices.

- Sunxi Target With Spi Nand Support(F1cx00s Only Right Now) cant boot into kernel right now.

- Freescale I.MX6ULL Support.

- Mesa And Wayland/Weston Suppport.

- Allwinner Cedrus Support. 

- RetroArch Support.

## Planing... 

- A Offcial Website.

- Hack Tools (Like kali or blackarch) feed And Luci-apps.

- Make Luci more simpier to use.

- Make Mainline Kernel More Friendly To IOT Device.

- Make Hardware Hacking More Friendly In Openwrt.

- A lightweight HandsomeMod Graphics Layer.

- Opengl for Qt5.

- Robot Os Support.

- Better Support For Rapsberry Boards.

- Qualcomm Arm Soc (Like Msm8916) mainline support.

- Samsung Exynos Soc mainline support.

- NetworkManager Support.

Future Release Will Based On Openwrt Latest Stable Version.

