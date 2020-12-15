#!/sbin/sh

SKU=`getprop ro.boot.hardware.sku`

if [ "$SKU" == "XT1799-2" ]; then
    mv /vendor/etc/libnfc-nxp_retcn.conf /vendor/etc/libnfc-nxp.conf
    mv /vendor/etc/thermal-engine-retcn.conf /vendor/etc/thermal-engine.conf
fi
