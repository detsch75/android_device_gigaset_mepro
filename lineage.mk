# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
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

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from me device
$(call inherit-product, device/gigaset/me/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_me
PRODUCT_DEVICE := me
PRODUCT_MANUFACTURER := Gigaset
PRODUCT_BRAND := Gigaset

PRODUCT_GMS_CLIENTID_BASE := android-gigaset

TARGET_VENDOR_PRODUCT_NAME := ME
TARGET_VENDOR_DEVICE_NAME := ME
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=ME PRODUCT_NAME=ME

BUILD_NUMBER := 138

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="ME-user 5.1.1 LMY47V 138 release-keys"

BUILD_FINGERPRINT := Gigaset/ME/ME:5.1.1/LMY47V/138:user/release-keys

PRODUCT_SYSTEM_PROPERTY_BLACKLIST += ro.product.model

TARGET_VENDOR := gigaset
