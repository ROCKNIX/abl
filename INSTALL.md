# Installation Guide

This guide explains how to install the **ROCKNIX-ABL** custom Qualcomm ABL using **fastboot**.

:warning: **Warning**: Flashing a custom ABL is risky and can permanently brick your device if done incorrectly. Proceed only if you understand the risks and have recovery options available.

---

## Requirements

Before you begin, ensure you have the following:

* A supported **Qualcomm-based device**
* A **USB cable**
* A PC running **Windows, Linux or macOS**
* The correct **`abl_signed-SMXXXX.elf`** file for your device
* Fastboot installed and working
* Proper USB drivers installed (Windows users)

---

## Step 1: Install Fastboot & Drivers

### Windows

1. Download **Android Platform Tools** from Google
2. Extract the archive
3. Install the appropriate **USB drivers** for your device
4. Ensure `fastboot.exe` is accessible from your command prompt

### Linux

Most distributions include fastboot in their package repositories:

```bash
sudo apt install android-tools-fastboot
```

(or equivalent for your distro)

### macOS

Using Homebrew:

```bash
brew install android-platform-tools
```

---

## Step 2: Reboot Device into Fastboot Mode

Power off your device completely.

Boot into **fastboot mode** using one of the following methods:

* **Hold Power + Volume Down** until fastboot mode appears
* **Or from Android with USB debugging enabled:**

```bash
adb reboot bootloader
```

Verify the device is detected:

```bash
fastboot devices
```

---

## Step 3: Flash the ABL

From the directory containing the ABL file, run:

```bash
fastboot flash abl abl_signed-SMXXXX.elf
```

Wait for the flash process to complete successfully.

---

## Step 4: Reboot

Once flashing is complete, reboot your device:

```bash
fastboot reboot
```

Your device should now boot using **ROCKNIX-ABL**.

---

## Notes

* The default boot mode is **Linux**
* Hold **Volume Up** during boot to force **Android**
* Hold **Volume Down** during boot to enter **ROCKNIX-ABL**

---

## Support

This project is provided **as-is**.

For issues, feedback, or testing reports, please contact the **ROCKNIX Team** through our [#abl](https://discord.com/channels/948029830325235753/1458147167830020127) Discord channel.

Happy gaming! :video_game::fire:
