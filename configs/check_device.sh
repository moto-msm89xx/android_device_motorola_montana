#!/sbin/sh

RADIO=`getprop ro.boot.radio`

mkdir -p /s
mount /dev/block/bootdevice/by-name/system /s
mkdir -p /v
mount /dev/block/bootdevice/by-name/oem /s

rm -rf /s/system/priv-app/MotoDoze
if ["$RADIO" == "Brazil" ] || [ "$RADIO" == "APAC" ] || [ "$RADIO" == "EMEA" ] || [ "$RADIO" == "China" ]; then
    # Remove e-compass file for APAC, Brazil and EMEA RADIOs
    rm /v/etc/permissions/android.hardware.sensor.compass.xml
fi
if [ "$RADIO" == "China" ]; then
    mv /v/etc/libnfc-nxp_retcn.conf /v/etc/libnfc-nxp.conf
    mv /v/etc/thermal-engine-retcn.conf /v/etc/thermal-engine.conf
fi

umount /s
rmdir /s
umount /v
rmdir /v
