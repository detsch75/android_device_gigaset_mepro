#
# Copyright (C) 2014 The CyanogenMod Project
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
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),me)

include $(call all-subdir-makefiles,$(LOCAL_PATH))

include $(CLEAR_VARS)

WCNSS_FW := WCNSS_qcom_wlan_nv.bin WCNSS_cfg.dat
WCNSS_FW_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/wlan/qca_cld/,$(notdir $(WCNSS_FW)))
$(WCNSS_FW_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS firmware links: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/etc/wifi/$(notdir $@) $@

WCNSS_CFG := WCNSS_qcom_cfg.ini
WCNSS_CFG_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/,$(notdir $(WCNSS_CFG)))
$(WCNSS_CFG_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS configs and firmware links: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/etc/wifi/$(notdir $@) $@

WCNSS_MAC_SYMLINK := $(TARGET_OUT_ETC)/firmware/wlan/qca_cld/wlan_mac.bin
$(WCNSS_MAC_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS MAC bin link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /persist/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_CFG_SYMLINKS) $(WCNSS_MAC_SYMLINK) $(WCNSS_FW_SYMLINKS)

endif
