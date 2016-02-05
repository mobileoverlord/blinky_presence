# BlinkyPresence

## Install Bake
http://www.bakeware.io

Nerves requires bake to build on your system. for more information see
https://github.com/bakeware/bake

## Bake Firmware

Nerves requires a system and toolchain to compile firmware on your machine. Lets fetch it from bakeware. This project is configured to work with raspberry pi 2 and will be configured automatically by default as listed in the bake file.
```
default_target :rpi2
target :rpi2,
  recipe: {"nerves/rpi2", "~> 0.1"}
```

Fetch the compiled system and toolchain dependencies from bakeware. From your command line...
```
$ bake system get
=> Using project default target: rpi2
=> Get system for target rpi2
==> Downloading system nerves/rpi2-0.3.1
==> System nerves/rpi2-0.3.1 downloaded
==> Unpacking system nerves/rpi2-0.3.1
```
```
$ bake toolchain get
=> Using project default target: rpi2
=> Get toolchain for target rpi2
==> Downloading toolchain for target rpi2
==> Toolchain nerves/arm-unknown-linux-gnueabihf Downloaded
==> Unpacking toolchain nerves/arm-unknown-linux-gnueabihf
```

Finally we can bake the firmware
```
$ bake firmware
=> Using project default target: rpi2
=> Building firmware for target rpi2
==> Using System: nerves/rpi2-0.3.1
==> Using Toolchain: nerves-arm-unknown-linux-gnueabihf-darwin-x86_64-v0.6.0
Shell environment updated for Nerves
... Process OTP Release ...
Updating base firmware image with Erlang release...
Building _images/blinky_presence-rpi2.fw...
```

Burn the firmware to an sd card for use in your device.
```
$ bake burn
=> Using project default target: rpi2
=> Burning firmware blinky_presence-rpi2.fw
==> Using System: nerves/rpi2-0.3.1
==> Using Toolchain: nerves-arm-unknown-linux-gnueabihf-darwin-x86_64-v0.6.0
Use 14.84 GiB memory card found at /dev/rdisk3? [y/N] y
  100%

```

Insert the sd card in to your raspberry pi and boot up the local console


```console
COLOR=blue iex --name blinky@desktop.local --erl "-config rel/sys.config" -S mix
```
