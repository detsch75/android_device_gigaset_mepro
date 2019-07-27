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

ifeq ($(TARGET_DEVICE),mepro)

include $(call all-subdir-makefiles,$(LOCAL_PATH))

include $(CLEAR_VARS)

WCNSS_FW := WCNSS_qcom_wlan_nv.bin WCNSS_cfg.dat
WCNSS_FW_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/wlan/qca_cld/,$(notdir $(WCNSS_FW)))
$(WCNSS_FW_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS firmware links: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/etc/wifi/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_FW_SYMLINKS)

WCNSS_CFG := WCNSS_qcom_cfg.ini
WCNSS_CFG_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/,$(notdir $(WCNSS_CFG)))
$(WCNSS_CFG_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS configs and firmware links: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/etc/wifi/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_CFG_SYMLINKS)

WCNSS_MAC_SYMLINK := $(TARGET_OUT_ETC)/firmware/wlan/qca_cld/wlan_mac.bin
$(WCNSS_MAC_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS MAC bin link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /persist/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_MAC_SYMLINK)

MODEM_IMAGES := \
	modem.b00 modem.b01 modem.b03 modem.b04 modem.b05 \
	modem.b06 modem.b07 modem.b08 modem.b09 modem.b10 \
	modem.b11 modem.b12 modem.b13 modem.b14 modem.b18 \
	modem.b19 modem.b20 modem.b22 modem.mdt mba.b00 \
	mba.mdt


MODEM_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(MODEM_IMAGES)))
$(MODEM_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Modem firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(MODEM_SYMLINKS)

ADSP_IMAGES := \
    adsp.b00 adsp.b01 adsp.b02 adsp.b03 adsp.b04 \
	adsp.b05 adsp.b06 adsp.b07 adsp.b08 adsp.b09 \
	adsp.b10 adsp.b11 adsp.b12 adsp.b13 adsp.b14 \
    adsp.mbn adsp.mdt

ADSP_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(ADSP_IMAGES)))
$(ADSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "ADSP firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(ADSP_SYMLINKS)

ACDB_IMAGES := \
	MTP17427_General_cal.acdb MTP17427_Global_cal.acdb \
	MTP17427_Hdmi_cal.acdb MTP17427_Headset_cal.acdb \
	MTP17427_Speaker_cal.acdb

ACDB_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/acdbdata/MTP/,$(notdir $(ACDB_IMAGES)))
$(ACDB_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "ACDB link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/etc/acdbdata/MTP/p17427/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(ACDB_SYMLINKS)

endif
