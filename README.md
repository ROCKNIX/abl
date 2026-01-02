# ROCKNIX-ABL

This repository contains a **custom Qualcomm ABL** created specifically for the **emulation community** and Qualcomm-based devices.

It is designed to provide a simple, flexible boot experience for custom firmware and Linux-based operating systems commonly used in emulation setups.

## Compatible Firmware

This ABL has been tested and is compatible with:

- **ROCKNIX**
- **Batocera**
- **Knulli**

## Features

- **Default boot mode set to Linux**
- **Selectable boot mode**
  - Linux
  - Android
- **Charging while powered off**
- **Boot override support**
  - Hold **Volume Up** during boot to force **Android** when the boot mode is Linux
- **Faster bootup**
  - Boots straight into **GRUB**
  - No **U-Boot** required
- **System Stats**
  - Shows your SoC, RAM and Storage
- **Internal install support**
  - Allows booting Linux from internal storage

## Intended Use

This ABL is intended for:

- Qualcomm-based handhelds and devices used for emulation
- Dual-boot Linux / Android setups
- Users who want a streamlined boot process without U-Boot

It is **not** intended for stock Android environments or locked consumer devices.

## Disclaimer

Flashing a custom ABL carries inherent risk and may result in an unbootable device if used incorrectly.

- You are responsible for any damage caused
- Ensure you have recovery options before flashing
- This project is provided **as-is**, with no warranty

## Credits

Created by the **ROCKNIX Team** for the **emulation community**.
