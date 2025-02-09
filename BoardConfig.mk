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

# Device Path
DEVICE_PATH := device/motorola/astro

# AVB
BOARD_AVB_ENABLE := true

# Arch
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := kryo
TARGET_2ND_ARCH_VARIANT := armv8-a

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 \
			earlycon=msm_geni_serial,0x4a90000 \
			androidboot.hardware=qcom \
			androidboot.console=ttyMSM0 \
			androidboot.memcg=1 \
			lpm_levels.sleep_disabled=1 \
			video=vfb:640x400,bpp=32,memsize=3072000 \
			msm_rtb.filter=0x237\
			service_locator.enable=1 \
			loop.maxpart=7 \
			swiotlb=1 \
			firmware_class.path=/vendor/firmware_mnt/image

# SELinux
BOARD_USE_ENFORCING_SELINUX := true
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy

# TODO: Make a kernel repo
# This is a big todo since we don't even have the kernel repo yet

# Dtb/o
ifneq ($(BOARD_PREBUILT_DTBOIMAGE),)
  # We probably just need one dtb, but in any case im going to leave
  # it like this
  BOARD_PREBUILT_DTBIMAGE_DIR := device/motorola/astro-kernel/dtbs
  BOARD_PREBUILT_DTBOIMAGE := device/motorola/astro-kernel/dtbo.img
endif

# Kernel
ifneq ($(TARGET_PREBUILT_KERNEL),)
  TARGET_PREBUILT_KERNEL := device/motorola/astro-kernel/Image.gz

## Modules
  BOARD_VENDOR_KERNEL_MODULES := \
      $(wildcard device/motorola/astro-kernel/modules/*.ko)
endif

# Partition information
TARGET_COPY_OUT_VENDOR := vendor
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_EROFS_PCLUSTER_SIZE := 262144
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_DTBOIMG_PARTITION_SIZE := 8388608

# Build product image
TARGET_COPY_OUT_PRODUCT := product
# DYNAMIC_PARTITIONS_SIZE = (SUPER_PARTITION_SIZE / 2) - 4MB
BOARD_MOT_DYNAMIC_PARTITIONS_SIZE := 4559208448
BOARD_MOT_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    product \
    vendor
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := mot_dynamic_partitions

# SEPolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 80

# VBMeta
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2

# OTA assert
TARGET_OTA_ASSERT_DEVICE := astro

# Include moto-common
include device/motorola/common/CommonConfig.mk
