ifneq (,$(filter astro,$(TARGET_DEVICE)))

LOCAL_PATH := $(call my-dir)

include $(call all-subdir-makefiles)

$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr: $(wildcard $(PRODUCT_VENDOR_KERNEL_HEADERS)/*)
	rm -rf $@
	mkdir -p $@/include
	cp -a $(PRODUCT_VENDOR_KERNEL_HEADERS)/. $@/include

# I'm not sure if we need all this stuff yet
include $(CLEAR_VARS)
LOCAL_MODULE := astro_folders
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)

LOCAL_POST_INSTALL_CMD := mkdir -p \
    $(TARGET_OUT_VENDOR)/etc/sensors/config

include $(BUILD_PHONY_PACKAGE)

endif
