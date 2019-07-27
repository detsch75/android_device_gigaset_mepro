# Device Tree for Gigaset ME Pro (mepro)

The ME Pro (codenamed _"mepro"_) is a smartphone from Gigaset.
It was released in November 2015.

| Basic                   | Spec Sheet                                                                                                                     |
| -----------------------:|:------------------------------------------------------------------------------------------------------------------------------ |
| CPU                     | Octa-Core (4x ARM Cortex A57 and 4x ARM Cortex A53)                                                                            |
| Chipset                 | Qualcomm MSM8994 Snapdragon 810                                                                                                |
| GPU                     | Qualcomm Adreno 430                                                                                                            |
| Memory                  | 3 GB RAM                                                                                                                       |
| Shipped Android Version | 5.1.1                                                                                                                          |
| Storage                 | 32 GB                                                                                                                          |
| Battery                 | Non-removable Li-Po 3000 mAh battery                                                                                           |
| Display                 | Optic AMOLED, 1080 x 1920 pixels, 16:9 ratio (441 ppi density)                                                                 |
| Camera (Back)           | 4872x3248 (15,8 Megapixel)                                                                                                     |
| Camera (Front)          | 3264x2448 (8,0 Megapixel)                                                                                                      |

![Gigaset ME Pro](https://www.inside-handy.de/img/gigaset-me-pro.jpg "Gigaset ME Pro")

# How to build

The Gigaset ME Pro has almost the same configuration as the Oneplus 2 phone. To setup the build environment, follow the instructions on the Wiki page of the Lineage Oneplus 2. https://wiki.lineageos.org/devices/oneplus2/build

After the setup, you need to do the following additional steps:

## 1. Sync TWRP for recovery

TWRP is used for recovery. To include it in the build, you need to sync the sources. The files need to be in the folder

\<android root\>/bootable/recovery-twrp

Navigate to the folder from which the git command will be executed

```shell
cd bootable
```

The following command will pull the sources

```shell
git clone -b android-8.1 https://github.com/omnirom/android_bootable_recovery.git recovery-twrp
```

## 2. Sync the device configuration sources

The device configuration can be found in the repository https://github.com/detsch75/android_device_gigaset_mepro.git

The source code needs to be placed in the folder

\<android root\>/device/gigaset/mepro

Create the gigaset folder and navigate to it

```shell
mkdir -p device/gigaset
cd device/gigaset
```

The following command will pull the sources

```shell
git clone -b android-8.1 https://github.com/detsch75/android_device_gigaset_mepro.git mepro
```

## 3. Sync the kernel sources

The kernel sources can be found in the repository https://github.com/detsch75/android_kernel_gigaset_msm8994.git

The source code needs to be placed in the folder

\<android root\>/kernel/gigaset/msm8994

Create the gigaset folder and navigate to it

```shell
mkdir -p kernel/gigaset
cd kernel/gigaset
```

The following command will pull the sources

```shell
git clone -b android-8.1 https://github.com/detsch75/android_kernel_gigaset_msm8994.git msm8994
```

## 4. Sync the vendor libraries

For the build of the device, some proprietary libraries are required. They can be found in the repository https://github.com/detsch75/android_vendor_gigaset_mepro.git

The files needs to be placed in the folder

\<android root\>/vendor/gigaset/mepro

Create the gigaset folder and navigate to it

```shell
mkdir -p vendor/gigaset
cd vendor/gigaset
```

The following command will pull the files

```shell
git clone -b android-8.1 https://github.com/detsch75/android_vendor_gigaset_mepro.git mepro
```

## 5. Sync the graphics libraries

For the build of the device, some external proprietary libraries are required. The files are extracted from the Oneplus 2 device. The files can be found in the repository https://github.com/detsch75/android_vendor_gigaset_mepro_graphics.git

The files needs to be placed in the folder

\<android root\>/vendor/gigaset/mepro-graphics

Create the gigaset folder and navigate to it

```shell
mkdir -p vendor/gigaset
cd vendor/gigaset
```

The following command will pull the files

```shell
git clone -b android-8.1 https://github.com/detsch75/android_vendor_gigaset_mepro_graphics.git mepro-graphics
```

## 6. Modify the Oppo Common Android.mk file

During the migration of the device to LineageOS, I used the Oneplus 2 as example. The Oneplus 2 device has a dependency to the device/oppo/common files. To have it also included in the build of the Gigaset ME Pro, the Android.mk file need to be enhance with gigaset as vendor.

You need to replace the content of the file device/oppo/common/Android.mk with

```make
LOCAL_PATH := $(call my-dir)

ifneq ($(filter oppo oneplus gigaset,$(BOARD_VENDOR)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
```

If the file is not available, try to build the Onplus2 first.

## 7. Building the device

**The flashing of your device is at your own risk.**

No you can start building the sources.

First load the new build variant with the command

```shell
source build/envsetup.sh
```

The build it self can be started with the command

```shell
brunch lineage_mepro-userdebug
```

The build result can be found after the successful build in the folder **out/target/product/mepro**