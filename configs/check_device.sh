#!/sbin/sh

SKU=`getprop ro.boot.hardware.sku`

mkdir -p /s
mount /dev/block/bootdevice/by-name/system /s
mkdir -p /v
mount /dev/block/bootdevice/by-name/oem /s

rm -rf /s/system/priv-app/MotoDoze
if [ "$SKU" != "XT1790" ] && [ "$SKU" != "XT1791" ]; then
    rm /v/etc/permissions/android.hardware.sensor.compass.xml
fi
if [ "$SKU" == "XT1799-2" ]; then
    mv /v/etc/libnfc-nxp_retcn.conf /v/etc/libnfc-nxp.conf
    mv /v/etc/thermal-engine-retcn.conf /v/etc/thermal-engine.conf
fi

umount /s
rmdir /s
umount /v
rmdir /v
