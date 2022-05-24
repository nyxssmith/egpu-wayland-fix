# egpu-wayland-fix

Allows pinning of EGPU to /dev/dri/card# to mutter udev rule

## Why

This is in regards to [this fix](https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1562) that allows mutter to be set to use a specific GPU by its `/dev/dri/card#` ID.

The ID for this is able to change, and does frequently enough for me to have to reboot 8 or so times until the GPU is back at the correct ID. (laptop with integrated intel, dedicated nvidia, and epgu amd gpus)

## How

This repo contains a `systemd` directory that will set a service that runs before `GDM` and will run a command that looks for AMD gpu, and sets the mutter config accordingly.

## Changing the GPU used by Mutter

To change the GPU, in the file `overwrite-mutter-config` change the grep options so that the sub-command `lspci | grep AMD | grep 6700 | cut -d' ' -f1` will output the PCI ID of the card that is desired. In my case, it is an `AMD 6700XT`.

For example, if my config currently is set to:

```
ENV{DEVNAME}=="/dev/dri/card2", TAG+="mutter-device-preferred-primary"
```

Then that means its using `/dev/card2` (found via following command) which is pci ID `0c:00.0` (found via `lspci`)

```
> ls -la /dev/dri/by-path
total 0
drwxr-xr-x. 2 root root 160 May 24 09:01 .
drwxr-xr-x. 3 root root 180 May 24 09:01 ..
lrwxrwxrwx. 1 root root   8 May 24 09:01 pci-0000:00:02.0-card -> ../card1
lrwxrwxrwx. 1 root root  13 May 24 09:01 pci-0000:00:02.0-render -> ../renderD128
lrwxrwxrwx. 1 root root   8 May 24 09:01 pci-0000:01:00.0-card -> ../card0
lrwxrwxrwx. 1 root root  13 May 24 09:01 pci-0000:01:00.0-render -> ../renderD129
lrwxrwxrwx. 1 root root   8 May 24 09:01 pci-0000:0c:00.0-card -> ../card2
lrwxrwxrwx. 1 root root  13 May 24 09:01 pci-0000:0c:00.0-render -> ../renderD130
```

## Install

From the `systemd` directory, run `sudo ./install.sh`
