All systems have quirks, here's how I solved the ones in my system.

# STLINKv1

## Problem

OpenOCD won't work out of the box with the STM32VLDISCOVERY board beacuse the STLINKv1 programmer
included in it has broken SCSI emulation (it tries to emulate an USB storage device but fails to do
it properly).

## Solution

Disable the broken SCSI emulation.

- Add this modprobe conf file

```
# /etc/modprobe.d/stlink-v1.conf
options usb-storage quirks=483:3744:i
```

- Re-insert the usb-storage module

```
$ sudo modprobe -r usb-storage && sudo modprobe usb-storage
```

## References

- https://github.com/texane/stlink/blob/master/README
- https://github.com/texane/stlink/blob/master/stlink_v1.modprobe.conf

# Missing /dev/nvidia-uvm device node

## Problem

As of nvidia-drivers-358.16 `modprobe nvidia-uvm` doesn't create the '/dev/nvidia-uvm' device node.
Hence all programs that depend on CUDA (e.g. ffmpeg's nvenc codec) fail because of the missing
device node.

## Solution

Create a udev rule to create the device node when `modprobe nvidia-uvm` is called:

- Add the udev rule

```
# /etc/udev/rules.d/99-nvidia.rules
KERNEL=="nvidia_uvm", RUN+="/usr/bin/bash -c '/usr/bin/mknod -m 666 /dev/nvidia-uvm c $(grep nvidia-uvm /proc/devices | cut -d\)'"
```

- Re-insert the nvidia-uvm module

```
$ sudo modprobe -r nvidia-uvm && sudo modprobe nvidia-uvm
```

## References

- https://devtalk.nvidia.com/default/topic/699610/linux/334-21-driver-returns-999-on-cuinit-cuda-/
