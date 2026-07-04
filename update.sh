#!/bin/bash
set -euo pipefail
REPO="ROCKNIX/abl"

# ---- Version detection ----
if [ $# -ge 1 ]; then
  ABL_VERSION="$1"
else
  echo "Detecting latest release..."
  ABL_VERSION="$(curl -s https://api.github.com/repos/${REPO}/releases/latest | grep '"tag_name"' | cut -d '"' -f4)"
  ABL_VERSION="${ABL_VERSION#v}"
fi

echo "Using version: ${ABL_VERSION}"

. /etc/os-release

BASE_URL="https://github.com/${REPO}/releases/download/v${ABL_VERSION}"
DIR="rocknix-abl-v${ABL_VERSION}"
ARCHIVE="${DIR}.tar.gz"
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

# ---- Download release ----
echo "Downloading release v${ABL_VERSION}..."
curl -s -L -o "${ARCHIVE}" "${BASE_URL}/${ARCHIVE}"

# ---- Extract ----
echo "Extracting archive..."
tar -xf "${ARCHIVE}"

if [ ! -f "${DIR}/${ELF}" ] || [ ! -f "${DIR}/${SHA}" ]; then
  echo "Error: required files not found for device ${HW_DEVICE}"
  exit 1
fi

cd "${DIR}"

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
