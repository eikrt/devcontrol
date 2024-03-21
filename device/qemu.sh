#!/bin/bash

# Define variables
NIXOS_ISO="images/debian-minimal.iso"
VM_NAME="NixOS_VM"
VM_MEMORY="2048"
VM_CPUS="2"
VM_DISK_SIZE="20G"

# Create a disk image
qemu-img create -f qcow2 ${VM_NAME}.qcow2 ${VM_DISK_SIZE}

# Start the VM
qemu-system-x86_64 \
-name ${VM_NAME} \
-m ${VM_MEMORY} \
-smp ${VM_CPUS} \
-drive file=${VM_NAME}.qcow2,format=qcow2 \
-cdrom ${NIXOS_ISO} \
-boot d \
-vga virtio \
-net nic -net user,hostfwd=tcp::2222-:22 \
-display sdl \
-D ./log.txt
