# HandsomeYingyan's Mod on Openwrt!

### Warning!!
## This Project is unstable and un-fully tested right now!

This is the buildsystem for the HandsomeMod Linux distribution.

To build your own firmware you need a Linux, BSD or MacOSX system (case
sensitive filesystem required). Cygwin and Wsl is unsupported.

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

- Add Wayland(Not working due to lack of mesa) and Xorg Support (alpha ver).

- Add littlevgl Support (still testing).

- Include Socs not yet in mainline(eg. Allwinner V3s F1cx00s and HiSilicon hi35xx).

- Update the kernel backport driver to 5.4(better wifi signal).

- Ipcam soc support(Hi35xx)

- Non-free feeds for Allwinner cedarX and HiSilicon libs and modules.

## Planing... 

- A Offcial Website.

- A Friendly Guide App For Newbie(Like me) Setting Network.

- Hack Tools (Like kali or blackarch) feed And Luci-apps.

- Make Luci more simpier to use.

- Make Mainline Kernel More Friendly To Old Mips Device.

- Make Hardware Hacking More Friendly In Openwrt.

- Closed Source Binary Driver Feeds For Mainline Kernel(Like qca-wifi or mtk-sdk-openwrt).

- Lighttpd Support for Luci.

- Build Guide In WSL.

- A lightweight HandsomeMod Graphics Layer(non-free right now).

- Update Xorg to current version.

- Make latest mesa working.

- Add Mali gpu blobs.

- Better Support for allwinner f1c100s and v3s.

- Support the HiSilicon Himpp and rtsp steaming apps.

- Luci app for ipcam and hmgl. 




Ps:Please Report Bugs at openwrt offcial github site! Or https://bugs.openwrt.org/

I Just A Newbie in Openwrt.. 

Future Release Will Based On Openwrt's Latest Stable Version.

