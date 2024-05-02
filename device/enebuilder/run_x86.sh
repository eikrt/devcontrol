#!/bin/sh

qemu-system-x86_64 \
    -kernel ./shared/linux-x86_64/bzImage \
    -initrd ./shared/busybox-x86/initramfs-busybox-x86.cpio.gz \
    -nographic -append "console=ttyS0"-enable-kvm
