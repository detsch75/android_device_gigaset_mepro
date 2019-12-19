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
WCNSS_CFG_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/wlan/qca_cld/,$(notdir $(WCNSS_CFG)))
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

WIFI_IMAGES := \
	bdwlan30.bin otp30.bin utf30.bin

WIFI_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(WIFI_IMAGES)))
$(WIFI_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Wifi firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(MODEM_SYMLINKS)

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

CPE_IMAGES := \
    cpe.b02 cpe.b04 cpe.b05 cpe.b06 cpe.b08 cpe.b10 \
    cpe.b11 cpe.b12 cpe.b14 cpe.b16 cpe.b18 cpe.b20 \
    cpe.b21 cpe.mbn cpe.mdt

CPE_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(CPE_IMAGES)))
$(CPE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "CPE firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(CPE_SYMLINKS)

PLAYREAD_IMAGES := \
    playread.b00 playread.b01 playread.b02 playread.b03 playread.mdt

PLAYREAD_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(PLAYREAD_IMAGES)))
$(PLAYREAD_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Playread firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(PLAYREAD_SYMLINKS)

TQS_IMAGES := \
    tqs.b00 tqs.b01 tqs.b02 tqs.b03 tqs.mdt

TQS_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(TQS_IMAGES)))
$(TQS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "TQS firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(TQS_SYMLINKS)

KEYMASTER_IMAGES := \
    keymaste.b00 keymaste.b01 keymaste.b02 keymaste.b03 keymaste.mdt

KEYMASTER_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(KEYMASTER_IMAGES)))
$(KEYMASTER_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Keymaster firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(KEYMASTER_SYMLINKS)

SAMPLEAP_IMAGES := \
    sampleap.b00 sampleap.b01 sampleap.b02 sampleap.b03 sampleap.mdt

SAMPLEAP_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(SAMPLEAP_IMAGES)))
$(SAMPLEAP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Sampleap firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(SAMPLEAP_SYMLINKS)

SECUREMM_IMAGES := \
    securemm.b00 securemm.b01 securemm.b02 securemm.b03 securemm.mdt

SECUREMM_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(SECUREMM_IMAGES)))
$(SECUREMM_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Securemm firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(SECUREMM_SYMLINKS)

ISDBTMM_IMAGES := \
    isdbtmm.b00 isdbtmm.b01 isdbtmm.b02 isdbtmm.b03 isdbtmm.mdt

ISDBTMM_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(ISDBTMM_IMAGES)))
$(ISDBTMM_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Isdbtmm firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(ISDBTMM_SYMLINKS)

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

AUDIO_PRIMARY_IMAGES := \
	audio.primary.msm8994.so

AUDIO_PRIMARY_SYMLINKS := $(addprefix $(TARGET_OUT)/lib/hw/,$(notdir $(AUDIO_PRIMARY_IMAGES)))
$(AUDIO_PRIMARY_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "audio.primary link: $@"
	@rm -rf $@
	$(hide) ln -sf /system/vendor/lib/hw/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(AUDIO_PRIMARY_SYMLINKS)

endif
