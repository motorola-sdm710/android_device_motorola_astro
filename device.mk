# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Device path
PLATFORM_COMMON_PATH := device/motorola/astro # Probably we not need this
DEVICE_PATH := device/motorola/astro/rootdir

# A/B support
AB_OTA_UPDATER := true
PRODUCT_SHIPPING_API_LEVEL := 29

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    vendor \
    vbmeta \
    product \
    recovery

AB_OTA_POSTINSTALL_CONFIG := \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := 560dpi

# Camera
TARGET_NEEDS_RAW10_BUFFER_FIX := true
TARGET_USES_64BIT_CAMERA := false

PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.camera.tof.direct=1

## Camera Requirements
PRODUCT_PACKAGES += \
    libcamera_shim \
    libgbp_shim \
    libgui_vendor

# Device Characteristics
DEVICE_CHARACTERISTICS += fm erofs

# Device Folders
PRODUCT_PACKAGES += \
    astro_folders

# Dynamic Partitions
TARGET_USES_DYNAMIC_PARTITIONS ?= true

# Fingerprint
TARGET_USES_GOODIX_FINGERPRINT := true

# Gatekeeper
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.gatekeeper.disable_spu=true

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.base@1.0.vendor

# Init
PRODUCT_PACKAGES += \
    init.astro.sh

# Overlays
# We haven't checked if we need any overlays yet
PRODUCT_PACKAGES += \

# Model
PRODUCT_MODEL := Motorola One Fusion

# Platform
BOARD_NAME := sdm710
TARGET_BOARD_PLATFORM := $(BOARD_NAME)
TARGET_KERNEL_VERSION := 4.9
PRODUCT_PLATFORM_MOT := true
PRODUCT_USES_QCOM_HARDWARE := true

# Power
PRODUCT_USES_PIXEL_POWER_HAL := true

# Props
$(call copy-files-recursive,$(PLATFORM_COMMON_PATH)/props,$(TARGET_COPY_OUT_VENDOR))

TARGET_VENDOR_PROP += $(PLATFORM_COMMON_PATH)/props/vendor.prop

# QCOM Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.qcom.bluetooth.soc=cherokee

# Recovery
include $(PLATFORM_COMMON_PATH)/device-recovery.mk
AB_OTA_PARTITIONS += recovery

# Telephony
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=10,10

# Inherit from those products. Most specific first.
$(call inherit-product, device/motorola/common/common.mk)
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)
# include board vendor blobs
$(call inherit-product-if-exists, vendor/motorola/astro/astro-vendor.mk)
