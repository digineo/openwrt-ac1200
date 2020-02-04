# OpenWrt for the Digineo AC1200 Pro

This repository contains the material needed to build the official
[OpenWrt][openwrt] firmware image for our [AC1200 Pro router][ac1200pro].

[openwrt]: https://openwrt.org
[ac1200pro]: https://shop.digineo.de

## Obtaining pre-built firmwares

**You'll find the latest firmware images on the [Github releases page][releases].**

You may also use the OpenWrt images found [here][images] (look for the
`zbt-wg3526-32M` files). Please note that these images only contain the
bare essentials, and not all device features may be available without
manually installing further packages.

[releases]: https://github.com/digineo/openwrt-ac1200/releases
[images]: https://downloads.openwrt.org/releases/19.07.1/targets/ramips/mt7621/

## Building firmware manually

To build the firmware image, you need to meet some prerequisites.

- You'll need a Linux machine to perform the build. This can be either a
  physical or a virtual machine.
- Depending on the distribution, you may need to install some dependencies
  (tools/libraries/etc.). Refer to the [OpenWrt wiki][wiki] on how to get
  started.
- The building machine requires approx. 12-15 GB free disk space. A powerful
  CPU and lots of RAM are recommended.

[wiki]: https://openwrt.org/docs/guide-user/additional-software/beginners-build-guide

### Clone this repository

If you start fresh, get a copy of this repository:

```console
$ git clone --recursive https://github.com/digineo/openwrt-ac1200.git .
$ cd openwrt-ac1200
```

If you only need to fetch updates, do the following:

```console
$ cd /path/to/openwrt-1200
$ git pull
$ git submodule update --init
```

### Building the image

In the source checkout directory, run this command:

```console
$ make all
```

When it finishes, you'll find the image files in `./firmware`:

- use `openwrt-ramips-mt7621-zbt-wg3526-32M-initramfs-kernel.bin` to downgrade or perform a factory reset, and
- use `openwrt-ramips-mt7621-zbt-wg3526-32M-squashfs-sysupgrade.bin` to upgrade to a newer version

Warning: Do not use the `sysupgrade` file to perform a version downgrade.
**This is not supported.**

### Flashing the router

#### via LuCI

1. Login to your router (by default http://192.168.1.1)
2. Go to *System* → *Backup/Flash firmware*.
3. Under "Flash new firmware image", select the image file.
4. Click on the "Flash image..." button.
5. Click in "Proceed".
6. Wait for the process to finish. This will take a few minutes.

#### via SSH

Alternatively, you may copy the image file via `scp` onto your device, and
perform a manual sysupgrade:

```console
$ scp /path/to/kernel-or-sysupgrade.bin root@192.168.1.1:/tmp/
$ ssh root@192.168.1.1
# sysupgrade /tmp/kernel-or-sysupgrade.bin
```

This will additionally print some diagnostics, before finally restarting
the device. Do not terminate the SSH connection while sysupgrade is running!

## Legal

The OpenWrt firmware and supplementary packages are licensed unter the
terms of the GNU GPL, Version 2. See [here][openwrt-gpl] for more details.
OpenWrt is a registered trademark owned by Software in the Public Interest, Inc.

LuCI, the OpenWrt Configuration Interface is licensed under the terms of
the Apache License, Version 2. See [here][luci-apache2] for the license
text, and the accompanying [NOTES][luci-notes] file.

This repository is licensed under the terms of the GNU GPL, Version 2.
See the [LICENSE](./LICENSE) file for details.

[openwrt-gpl]: https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=LICENSE
[luci-apache2]: https://git.openwrt.org/?p=project/luci.git;a=blob;f=LICENSE
[luci-notes]: https://git.openwrt.org/?p=project/luci.git;a=blob;f=NOTES
