# NVIDIA Tegra5 "Ardbeg" development system
#
# Copyright (c) 2014-2016 NVIDIA Corporation.  All rights reserved.

## Common packages
$(call inherit-product-if-exists, device/nvidia/platform/ardbeg/device-common.mk)
$(call inherit-product-if-exists, vendor/nvidia/tegra/core/android/services/analyzer.mk)
$(call inherit-product-if-exists, vendor/nvidia/tegra/core/android/services/nvcpl.mk)
$(call inherit-product, vendor/nvidia/shieldtech/common/shieldtech.mk)

# Boot Animation
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip

# Need AppWidget permission to prevent from Launcher's crash.
# TODO(pattjin): Remove this when the TV Launcher is used, which does not support AppWidget.
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../../common/init.ray_touch.rc:root/init.ray_touch.rc \
    $(LOCAL_PATH)/init.ray_st8.rc:root/init.ray_st8.rc

# Ardbeg build might be flashed on ST8 device, so copy the signed binaries
ST8_BOOTLOADER_PATH := vendor/nvidia/shieldtablet

PRODUCT_PACKAGES += \
    bpmp \
    tegra_xusb_firmware \
    tegra12x_xusb_firmware

# Wifi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/comms/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    $(LOCAL_PATH)/firmware/fw_bcmdhd_56.bin:system/vendor/firmware/fw_bcmdhd.bin \
    $(LOCAL_PATH)/firmware/nvram.txt:system/etc/nvram.txt \
    $(LOCAL_PATH)/enctune.conf:system/etc/enctune.conf

# Bluetooth
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
    $(LOCAL_PATH)/firmware/BCM20702A0-0a5c-21e8.hcd:system/etc/firmware/brcm/BCM20702A0-0a5c-21e8.hcd \
    $(LOCAL_PATH)/firmware/BCM2045A0-13d3-3488.hcd:system/etc/firmware/brcm/BCM2045A0-13d3-3488.hcd

PRODUCT_COPY_FILES += \
    $(call add-to-product-copy-files-if-exists,\
        $(ST8_BOOTLOADER_PATH)/blob.bin:blob.bin) \
    $(call add-to-product-copy-files-if-exists,\
        $(ST8_BOOTLOADER_PATH)/bootloader_signed.bin:bootloader_signed.bin) \
    $(call add-to-product-copy-files-if-exists,\
        $(ST8_BOOTLOADER_PATH)/flash_e1761_2gb_924_signed.bct:flash_e1761_2gb_924_signed.bct) \
    $(call add-to-product-copy-files-if-exists,\
        $(ST8_BOOTLOADER_PATH)/nvtboot_signed.bin:nvtboot_signed.bin) \
    $(call add-to-product-copy-files-if-exists,\
        $(ST8_BOOTLOADER_PATH)/tos_signed.img:tos_signed.img) \
    $(call add-to-product-copy-files-if-exists,\
        $(ST8_BOOTLOADER_PATH)/warmboot_signed.bin:warmboot_signed.bin)

PRODUCT_PACKAGES += \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
PRODUCT_PACKAGES += \
    com.google.widevine.software.drm.xml \
    com.google.widevine.software.drm \
    libdrmwvmplugin \
    libwvm \
    libWVStreamControlAPI_L1 \
    libwvdrm_L1

#needed by google GMS lib:libpatts_engine_jni_api.so
PRODUCT_PACKAGES += \
    libwebrtc_audio_coding

PRODUCT_PACKAGES += \
    badblocks \
    busybox \
    e2fsck \
    fsck.exfat \
    fsck.f2fs \
    mke2fs \
    make_f2fs \
    mkfs.exfat \
    mkntfs \
    mount.exfat \
    ntfs-3g \
    ntfsfix \
    resize2fs \
    tune2fs

# Leanback Launcher
PRODUCT_PACKAGES += \
    AppDrawer \
    LeanbackLauncher \
    LeanbackCustomize \
    LeanbackIme \
    TvProvider \
    TvSettings \
    tv_input.default \
    TV

PRODUCT_PACKAGES += \
    lights.tegra \
    audio.primary.tegra \
    audio.a2dp.default \
    audio.usb.default \
    libaudiopolicymanager \
    audio.nvwc.tegra \
    power.tegra \
    setup_fs \
    drmserver \
    Gallery2 \
    libdrmframework_jni \
    overlaymon \
    e2fsck \
    charger \
    charger_res_images

#NvEsrd
PRODUCT_PACKAGES += \
    NvEsrd

# Homepage provider APK for Google Chrome browser
PRODUCT_PACKAGES += \
    ChromeCustomizations

# Partner bookmarks provider APK for Google Chrome browser
PRODUCT_PACKAGES += \
    PartnerBookmarksProvider

PRODUCT_PACKAGES += \
    tos \
    keystore.tegra

#TegraOTA
PRODUCT_PACKAGES += \
    TegraOTA

#Stats
ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
    PRODUCT_PACKAGES += \
        Stats
endif

#ControllerMapper
ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
#    PRODUCT_PACKAGES += \
#        ControllerMapper
endif

PRODUCT_PACKAGES += \
    lbh_images

# HDCP SRM Support
PRODUCT_PACKAGES += \
    hdcp1x.srm \
    hdcp2x.srm \
    hdcp2xtest.srm

# Application for sending feedback to NVIDIA
PRODUCT_PACKAGES += \
    nvidiafeedback

## Calibration notifier
PRODUCT_PACKAGES += CalibNotifier
PRODUCT_COPY_FILES += \
    device/nvidia/platform/ardbeg/calibration/calib_cfg.xml:system/etc/calib_cfg.xml

# Paragon filesystem solution binaries
PRODUCT_PACKAGES += \
    mountufsd \
    chkufsd \
    mkexfat \
    chkexfat \
    mkhfs \
    chkhfs \
    mkntfs \
    chkntfs

# Camera app
PRODUCT_PACKAGES += NvCamera

# CEC
PRODUCT_PACKAGES += \
    hdmi_cec.tegra
