#!/bin/bash
set -euo pipefail

. /etc/os-release

BASE_URL="https://github.com/ROCKNIX/abl/raw/refs/heads/master"
ELF="abl_signed-${HW_DEVICE}.elf"
SHA="${ELF}.sha256"

ABL_A="/dev/disk/by-partlabel/abl_a"
ABL_B="/dev/disk/by-partlabel/abl_b"

WORKDIR="$(mktemp -d)"
cleanup() {
  rm -rf "${WORKDIR}"
}
trap cleanup EXIT

echo "Working directory: ${WORKDIR}"
cd "${WORKDIR}"

# ---- Sanity checks ----
if [ ! -b "${ABL_A}" ] || [ ! -b "${ABL_B}" ]; then
  echo "Error: ABL partitions not found"
  exit 1
fi

# ---- Download files ----
echo "Downloading ABL for ${HW_DEVICE}..."
wget -q "${BASE_URL}/${ELF}"
wget -q "${BASE_URL}/${SHA}"

# ---- Verify SHA256 ----
echo "Verifying SHA256 checksum..."
sha256sum -c "${SHA}"

echo "Checksum OK."

# ---- Get sector size ----
SS="$(blockdev --getss "${ABL_A}")"
if [ -z "${SS}" ]; then
  echo "Error: failed to get sector size"
  exit 1
fi

echo "Sector size: ${SS} bytes"

# ---- Flash ----
echo "Updating ABL partitions..."
dd if="${ELF}" of="${ABL_A}" bs="${SS}" conv=fsync,notrunc status=none
dd if="${ELF}" of="${ABL_B}" bs="${SS}" conv=fsync,notrunc status=none

sync

echo "ABL update completed successfully."
