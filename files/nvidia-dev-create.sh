#!/bin/bash

NVIDIA_DEVICES=$(lspci | grep NVIDIA)

# if there are no devices, silently exit
[[ -z $NVIDIA_DEVICES ]] && exit 0

# ------------------------------------------------------------------------------
# load kernel modules and create devices
# ------------------------------------------------------------------------------

if modprobe nvidia NVreg_EnableMSI=0 ; then
  NVIDIA_3D_CONTROLLER=$(echo "$NVIDIA_DEVICES" | grep -c "3D controller")
  NVIDIA_VGA_CONTROLLER=$(echo "$NVIDIA_DEVICES" | grep -c "VGA compatible controller")

  NVIDIA_DEVICE_ID=$(awk '$2 == "nvidia-frontend" { print $1 }' /proc/devices)

  NVIDIA_N_DEVICES=$(( $NVIDIA_3D_CONTROLLER + $NVIDIA_VGA_CONTROLLER - 1 ))

  for i in $(seq 0 $NVIDIA_N_DEVICES) ; do
    mknod -m 666 /dev/nvidia$i c $NVIDIA_DEVICE_ID $i
  done

  NVIDIA_CONTROLLER_DEVICE_NUMBER=255
  mknod -m 666 /dev/nvidiactl c $NVIDIA_DEVICE_ID $NVIDIA_CONTROLLER_DEVICE_NUMBER
else
  echo "could not successfully load nvidia module" >&2
  exit 1
fi

if modprobe nvidia_uvm ; then
  NVIDIA_UVM_DEVICE_ID=$(awk '$2 == "nvidia-uvm" { print $1 }' /proc/devices)

  mknod -m 666 /dev/nvidia-uvm c $NVIDIA_UVM_DEVICE_ID 0
else
  echo "could not successfully load nvidia_uvm module" >&2
  exit 1
fi

if ! modprobe nvidia_drm ; then
  echo "could not successfully load nvidia_drm module" >&2
  exit 1
fi
