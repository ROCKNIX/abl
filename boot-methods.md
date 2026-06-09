# ROCKNIX ABL Boot Methods

ROCKNIX ABL provides two methods for booting Linux on Qualcomm-based devices.

## Overview

ROCKNIX ABL can boot Linux using either:

1. An EFI application stored on a FAT partition.
2. An Android boot image containing the Linux kernel, DTBs, and initramfs.

Both methods are supported; however, the Android boot image method is strongly recommended and should be considered the primary boot mechanism.

---

## Method 1: EFI Application Boot

ROCKNIX ABL can load and execute a standard UEFI EFI application from any FAT-formatted partition.

### File Location

The EFI executable must be placed at:

```text
/EFI/BOOT/BOOTAA64.EFI
```

### Example Layout

```text
EFI/
└── BOOT/
    └── BOOTAA64.EFI
```

This method allows the use of common UEFI bootloaders such as GRUB or other EFI-based Linux loaders.

### Advantages

* Compatible with existing UEFI boot workflows.
* Allows use of standard EFI bootloaders and utilities.
* Useful for development and debugging.

### Limitations

On Qualcomm platforms, memory allocated by UEFI Boot Services cannot always be reclaimed by Linux when booting through an EFI application.

As a result, significant amounts of RAM may remain permanently reserved and unavailable to the operating system.

Depending on the SoC, this can result in up to **1.4 GB of memory** being unavailable to Linux.

---

## Method 2: Android Boot Image (Recommended)

The preferred boot method is to provide Linux as an Android boot image.

In this configuration:

* The Linux kernel is included in the boot image.
* Any required Device Tree Blobs (DTBs) are appended to the kernel image.
* An initramfs (ramdisk) may also be included.
* The final image is packaged using `mkbootimg`.

### File Location

The generated Android boot image must be placed at:

```text
/KERNEL
```

on any FAT-formatted partition.

### Example Layout

```text
KERNEL
```

### Additional Requirements

Before booting an Android boot image, select the appropriate device model from the ROCKNIX ABL menu.

This selection is required to ensure the correct hardware configuration is provided to the Linux kernel.

> **Important**
>
> When booting using an Android boot image, you must select the correct device model from the ROCKNIX ABL menu before booting.
>
> The selected device determines which hardware configuration and device tree are used by Linux. Failure to select the correct device model may result in boot failures or non-functional hardware.

### Creating the Boot Image

ROCKNIX ABL expects a standard Android boot image containing:

* A gzip-compressed Linux kernel.
* One or more appended Device Tree Blobs (DTBs).
* A ramdisk image.
* Android boot image headers generated with `mkbootimg`.

The following example demonstrates how ROCKNIX generates a compatible boot image:

```bash
# Compress the kernel
gzip kernel > kernel.gz

# Append all DTBs to the compressed kernel image
for dtb in *.dtb; do
    cat "$dtb" >> kernel.gz
done

# Create a minimal ramdisk placeholder
echo -n "dummy" > ramdisk

# Generate Android boot image
python3 mkbootimg/mkbootimg.py \
    --kernel path/to/kernel.gz \
    --ramdisk path/to/ramdisk \
    --kernel_offset 0x00000000 \
    --ramdisk_offset 0x00000000 \
    --tags_offset 0x00000000 \
    --os_version 12.0.0 \
    --os_patch_level "$(date '+%Y-%m')" \
    --header_version 0 \
    --cmdline "YOUR LINUX COMMAND LINE" \
    -o path/to/FINAL-KERNEL-FILE
```

Copy the generated boot image to:

```text
/KERNEL
```

on any FAT-formatted partition.

> **Note**
>
> ROCKNIX ABL currently expects all required DTBs to be appended directly to the compressed kernel image before packaging with `mkbootimg`.

### Advantages

* Avoids the UEFI Boot Services memory reservation issue.
* Maximizes available system memory.
* Provides more predictable memory layouts across Qualcomm platforms.
* Reduces wasted RAM on devices with large firmware memory allocations.
* Recommended for production deployments.

---

## Why Android Boot Images Are Preferred

Qualcomm platforms reserve a significant amount of memory during the boot process.

When Linux is launched through an EFI application, such as GRUB, UEFI Boot Services cannot be fully shut down before the kernel takes control. Memory allocated by the firmware therefore remains reserved and unavailable to Linux.

On some Qualcomm SoCs this can result in as much as **1.4 GB of RAM** remaining inaccessible after boot.

Booting Linux directly from an Android boot image allows ROCKNIX ABL to transfer control to the kernel without relying on the UEFI Boot Services boot path, avoiding these memory reservation issues and making substantially more RAM available to the operating system.

For this reason, Android boot images stored at `/KERNEL` are the recommended and preferred boot method for all supported Qualcomm devices.

---

## Boot Priority

ROCKNIX ABL searches all FAT-formatted partitions for supported boot targets.

The boot methods are attempted in the following order:

1. `/EFI/BOOT/BOOTAA64.EFI`
2. `/KERNEL`

If a valid EFI application is found, it will be launched immediately.

If no EFI application is found, ROCKNIX ABL will search for an Android boot image at `/KERNEL` and boot it.

> **Note**
>
> Although EFI boot is attempted first for compatibility with existing UEFI boot workflows, the Android boot image method remains the recommended approach due to significantly better memory utilization on Qualcomm platforms.

---

## Summary

| Method             | Location                 | Recommended |
| ------------------ | ------------------------ | ----------- |
| EFI Application    | `/EFI/BOOT/BOOTAA64.EFI` | Supported   |
| Android Boot Image | `/KERNEL`                | Recommended |

For best memory utilization and platform compatibility, use the Android boot image boot method whenever possible.
