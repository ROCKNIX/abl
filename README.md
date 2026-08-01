# ROCKNIX-ABL

A custom **Qualcomm ABL (Android Bootloader)** designed for Linux-based operating systems and dual-boot handhelds in the emulation community.

ROCKNIX-ABL replaces the stock Qualcomm ABL with a streamlined bootloader focused on fast, flexible booting of custom firmware without requiring GRUB or U-Boot.

---

## Overview

ROCKNIX-ABL provides a modern boot experience for Qualcomm-powered handhelds by making Linux the primary boot target while retaining the ability to boot Android whenever needed.

Whether you're running Linux from internal storage, an SD card, or USB, ROCKNIX-ABL provides a fast and reliable boot process with simple boot selection and recovery options.

---

## Compatible Operating Systems

ROCKNIX-ABL has been tested with the following Linux distributions and custom firmware:

* **ROCKNIX**
* **Batocera**
* **Knulli**
* **Armada**
* **Thorch**
* **MaSi-OS**
* **NovaDeck**

Additional Linux distributions that follow compatible boot layouts may also work.

---

## Features

### Fast Linux Boot

* Boots directly into Linux
* No **GRUB** or **U-Boot** required
* Reduced boot time compared to traditional boot chains

### Multiple Boot Sources

Boot Linux from:

* Internal storage
* SD card
* USB storage

### Android Support

* Boot directly into Android
* Easily switch between Android and Linux

### Configurable Default Boot

Choose the default boot target:

* Linux (Internal, SD card, USB)
* Android

### Configurable Boot Override

Hold **Volume Up** during startup to temporarily override the boot option and choose another boot target.

### USB Boot Support

Boot supported Linux images directly from USB devices.

### Internal Linux Installation

Supports Linux installations stored directly on the device's internal storage.

### Charging Mode

Displays an offline charging screen while the device is powered off.

### System Information

View hardware information during boot, including:

* SoC
* RAM
* Storage (Internal and SD card)
* Display resolution

---

## Intended Use

ROCKNIX-ABL is intended for:

* Qualcomm-powered gaming handhelds
* Dual-boot Android/Linux setups
* Development and testing of custom operating systems

It is **not intended** for:

* Stock Android devices
* Locked consumer devices

---

## Disclaimer

> [!WARNING]
> Flashing a custom ABL modifies a critical component of your device's boot process. Flashing an incompatible image or interrupting the flashing process can leave your device unbootable.

Before flashing:

* Verify the ABL is built for your specific device.
* Ensure you have a working recovery method.
* Back up any important data.
* Understand the recovery process for your hardware.

This project is provided **AS IS**, without warranty of any kind. The authors are not responsible for damage, data loss, or other issues resulting from its use.

---

## Credits

Developed by the **ROCKNIX Team** for the emulation community.

Special thanks to everyone in the Linux handheld and Qualcomm development communities whose research and contributions continue to make projects like this possible.
