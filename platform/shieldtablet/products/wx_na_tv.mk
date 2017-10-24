# NVIDIA Tegra5 "Ardbeg Foster TV" development system
#
# Copyright (c) 2013-2016, NVIDIA Corporation.  All rights reserved.

## All essential packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

## SKU specific overrides
include frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk

# Common stuff for tv products

PRODUCT_LOCALES := en_US

# Include drawables for various densities.
PRODUCT_AAPT_CONFIG := normal large xlarge tvdpi hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_PROPERTY_OVERRIDES += \
ro.com.google.clientidbase=android-nvidia

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:system/etc/permissions/android.hardware.hdmi.cec.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# OPENGL AEP permission file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

PRODUCT_COPY_FILES += \
    $(call add-to-product-copy-files-if-exists,frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml)

PRODUCT_CHARACTERISTICS := tv

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=320

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# GMS Google TV Apps
$(call inherit-product, 3rdparty/google/gms-apps/tv/gms.mk)

#DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/../../common/overlay-common/$(PLATFORM_VERSION_LETTER_CODE)
DEVICE_PACKAGE_OVERLAYS := device/nvidia/platform/ardbeg/overlay-tv

$(call inherit-product-if-exists, device/google/atv/products/atv_base.mk)

include $(LOCAL_PATH)/wx_base.mk

## Thse are default settings, it gets changed as per sku manifest properties
PRODUCT_NAME := wx_na_tv
PRODUCT_MODEL := wx_na_tv

## Value of PRODUCT_NAME is mangeled before it can be
## used because of call to inherits, store their values to
## use later in this file below
_product_name := $(strip $(PRODUCT_NAME))

## SKU specific overrides
PRODUCT_PROPERTY_OVERRIDES += ro.radio.noril=true

## common settings for all sku except for diag
include $(LOCAL_PATH)/wx_common_user.mk

## nvidia apps for this sku
$(call inherit-product-if-exists, $(_product_private_path)/$(_product_name).mk)

## Clean local variables
_product_name :=
_product_private_path :=
