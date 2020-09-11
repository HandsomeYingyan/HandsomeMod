# HandsomeYingyan's Mod on Openwrt!
## IOT Freedom For End-user!
### Warning!!
## This Project is unstable and un-fully tested right now!

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


The orginal code come form openwrt 19.07.

https://github.com/openwrt/openwrt

HiSilicon hi35xx support is based on OpenIPC project

https://github.com/OpenIPC/chaos_calmer


#  What is Moded?

- Use mac to distinguish different handsomemod device(wifi ssid).

- Use Nginx instead of uhttpd(Luci).(uhttpd version of luci been renamed as luci-uhttpd)

- Enalbe CAKE Network Queue Management in default config.

- Add https://github.com/Chion82/netfilter-full-cone-nat.git and Enable in default config.

- Use ucl and upx to reduce image size.

- Add some router not yet in openwrt offcial source.

- Change some source mirrors (Build faster in China).

- Add some basic modules to support gpu and drm.

- Add rt-linux patches.

- Add Fbdev Based mali blobs

- Add littlevgl Support .

- Include Socs not yet in mainline(eg. Allwinner V3s F1cx00s and HiSilicon hi35xx).

- Update the kernel backport driver to 5.8(better wifi signal).

- Ipcam soc support(Hi35xx)

- Non-free feeds for Allwinner cedarX and HiSilicon libs and modules.

- Some Tweaks in usb gadget 

- Tweaks to support some device with screen 

- Use eudev instead of the orginal one in openwrt

- Add qt sdl directfb and other funny stuff!

- Connman For Wext-based wifi chips

- Sunxi mail400 kernel module and userspace library

- Linux 5.4 Support!

## Planing... 

- A Offcial Website.

- Hack Tools (Like kali or blackarch) feed And Luci-apps.

- Make Luci more simpier to use.

- Make Mainline Kernel More Friendly To IOT Device.

- Make Hardware Hacking More Friendly In Openwrt.

- A lightweight HandsomeMod Graphics Layer.

- Add wayland support.

- Better Support for allwinner f1c100s and v3s.

- Support the HiSilicon Himpp and rtsp steaming apps.(Hisilicon Support now EOL due to shitty toolchain)

- Opengl for Qt5 .

- Cedrus for sunxi family SOCs.

- Robot Os Support.

- Better Cedarx Support (OMX).

- Better Support For Rapsberry Boards.


Ps:Please Report Bugs at openwrt offcial github site! Or https://bugs.openwrt.org/

I Just A Newbie in Openwrt.. 

Future Release Will Based On Openwrt's Latest Stable Version.

