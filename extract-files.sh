#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export BOARD_COMMON=msm8937-common
export DEVICE=montana
export VENDOR=motorola

"./../../${VENDOR}/${BOARD_COMMON}/extract-files.sh" "$@"

DEVICE_BLOB_ROOT="../../../vendor/${VENDOR}/${DEVICE}/proprietary"

sed -i 's|/firmware/image|/vendor/f/image|' "${DEVICE_BLOB_ROOT}/vendor/bin/hw/android.hardware.biometrics.fingerprint@2.1-fpcservice"
sed -i "s|service.bootanim.exit|service.bootanim.hold|g" "${DEVICE_BLOB_ROOT}/vendor/lib/hw/camera.msm8937.so"
patchelf --set-soname camera.msm8937.so "${DEVICE_BLOB_ROOT}/vendor/lib/hw/camera.msm8937.so"
patchelf --remove-needed android.hidl.base@1.0.so "${DEVICE_BLOB_ROOT}/vendor/lib/com.fingerprints.extension@1.0_vendor.so"
sed -i 's|/system/etc/camera/|/vendor/etc/camera/|g' "${DEVICE_BLOB_ROOT}/vendor/lib/libmmcamera2_sensor_modules.so"
sed -i 's|msm8953_mot_sanders_camera.xml|msm8937_mot_montana_camera.xml|g' "${DEVICE_BLOB_ROOT}/vendor/lib/libmmcamera2_sensor_modules.so"
sed -i "s/libgui/libwui/" "${DEVICE_BLOB_ROOT}/vendor/lib/libmmcamera2_stats_modules.so"
patchelf --remove-needed libandroid.so "${DEVICE_BLOB_ROOT}/vendor/lib/libmmcamera2_stats_modules.so"
sed -i "s/libgui/libwui/" "${DEVICE_BLOB_ROOT}/vendor/lib/libmmcamera_ppeiscore.so"
sed -i "s/libgui/libwui/" "${DEVICE_BLOB_ROOT}/vendor/lib/libmmcamera_vstab_module.so"
patchelf --remove-needed libandroid.so "${DEVICE_BLOB_ROOT}/vendor/lib/libmmcamera_vstab_module.so"
sed -i "s/system input/system uhid input/" "${DEVICE_BLOB_ROOT}/vendor/etc/init/android.hardware.biometrics.fingerprint@2.1-service.rc"
sed -i "s/class late_start/class hal/" "${DEVICE_BLOB_ROOT}/vendor/etc/init/android.hardware.biometrics.fingerprint@2.1-service.rc"
