/*
 * Copyright (C) 2018 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "tfa98xx"

#include <time.h>
#include <system/audio.h>
#include <platform.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <ctype.h>
#include <dlfcn.h>
#include <sys/ioctl.h>
#include <log/log.h>
#include <hardware/audio_amplifier.h>
#include <tinyalsa/asoundlib.h>
#include <cutils/properties.h>

#define SPEAKER_CTL "SMARTPA Switch Mute"

// Load all audio param version
#define AUDIO_ADSP_VERSION_PROP "audio.param.adsp.version"
#define AUDIO_SMARTPA_VERSION_PROP "audio.param.smartpa.version"
#define AUDIO_ES704_VERSION_PROP "audio.param.es704.version"

#define AUDIO_ADSP_17421_VERSION_PATH "/etc/acdbdata/MTP/p17421/17421_version.txt"
#define AUDIO_ADSP_17427_VERSION_PATH "/etc/acdbdata/MTP/p17427/17427_version.txt"
#define AUDIO_SMARTPA_17421_VERSION_PATH "/etc/firmware/smartpa/17421_version.txt"
#define AUDIO_SMARTPA_17427_VERSION_PATH "/etc/firmware/smartpa/17427_version.txt"
#define AUDIO_ES704_VERSION_PATH "/sys/bus/slimbus/devices/es704-codec-gen0/fw_version"
#define AUDIO_ES705_VERSION_PATH "/sys/bus/slimbus/devices/es705-codec-gen0/fw_version"

typedef struct amp_device {
    amplifier_device_t amp_dev;
} amp_device_t;

static amp_device_t *amp_dev = NULL;

/*
* Handle different system types
*/
enum MACH_TYPE
{
    MACH_TYPE_NONE = 0,
    MACH_TYPE_P17421,
    MACH_TYPE_P17427,
    /* Add other mach type here */
    MACH_TYPE_MAX,
};

static int get_mach_type(void)
{
    char mach_type[2048];
    property_get("ro.android.machtype", mach_type, "Unknow");
    ALOGD("mach_type = %s", mach_type);
    if (!strncmp(mach_type, "P17427", strlen("P17427")))
    {
        return MACH_TYPE_P17427;
    }
    else if (!strncmp(mach_type, "P17421", strlen("P17421")))
    {
        return MACH_TYPE_P17421;
    }

    return MACH_TYPE_NONE;
}

static void init_audio_param_version(void)
{
    int fd, ret;
    char version[PROP_VALUE_MAX];
    char adsp_path[128];
    int mach_type;

    mach_type = get_mach_type();
    /* Get the ADSP version */
    memset(version, 0, sizeof(version));
    fd = open(AUDIO_ES704_VERSION_PATH, O_RDONLY);
    if (fd < 0)
    {
        ALOGE("%s:Open %s error = %d", __func__, AUDIO_ES704_VERSION_PATH, errno);
    }
    else
    {
        ret = read(fd, version, sizeof(version));
        if (ret > 0)
        {
            ALOGD("%s:%s:version = %s", __func__, AUDIO_ES704_VERSION_PATH, version);
            property_set(AUDIO_ES704_VERSION_PROP, version);
        }
        close(fd);
    }
    fd = open(AUDIO_ES705_VERSION_PATH, O_RDONLY);
    if (fd < 0)
    {
        ALOGE("%s:Open %s error = %d", __func__, AUDIO_ES705_VERSION_PATH, errno);
    }
    else
    {
        ret = read(fd, version, sizeof(version));
        if (ret > 0)
        {
            ALOGD("%s:%s:version = %s", __func__, AUDIO_ES705_VERSION_PATH, version);
            property_set(AUDIO_ES704_VERSION_PROP, version);
        }
        close(fd);
    }

    /* Get ADSP version */
    memset(version, 0, sizeof(version));
    if (mach_type == MACH_TYPE_P17421)
        fd = open(AUDIO_ADSP_17421_VERSION_PATH, O_RDONLY);
    else if (mach_type == MACH_TYPE_P17427)
        fd = open(AUDIO_ADSP_17427_VERSION_PATH, O_RDONLY);
    if (fd < 0)
    {
        ALOGE("%s: error = %d", __func__, errno);
    }
    else
    {
        ret = read(fd, version, sizeof(version));
        if (ret > 0)
        {
            ALOGD("%s:adsp version = %s", __func__, version);
            property_set(AUDIO_ADSP_VERSION_PROP, version);
        }
        close(fd);
    }

    /* Get SmartPA version */
    memset(version, 0, sizeof(version));
    if (mach_type == MACH_TYPE_P17421)
        fd = open(AUDIO_SMARTPA_17421_VERSION_PATH, O_RDONLY);
    else if (mach_type == MACH_TYPE_P17427)
        fd = open(AUDIO_SMARTPA_17427_VERSION_PATH, O_RDONLY);
    if (fd < 0)
    {
        ALOGE("%s: error = %d", __func__, errno);
    }
    else
    {
        ret = read(fd, version, sizeof(version));
        if (ret > 0)
        {
            ALOGD("%s:smartpa version = %s", __func__, version);
            property_set(AUDIO_SMARTPA_VERSION_PROP, version);
        }
        close(fd);
    }
}

static int is_speaker(uint32_t snd_device)
{
    int speaker = 0;
    switch (snd_device)
    {
    case SND_DEVICE_OUT_SPEAKER:
    case SND_DEVICE_OUT_SPEAKER_REVERSE:
    case SND_DEVICE_OUT_SPEAKER_AND_HEADPHONES:
    case SND_DEVICE_OUT_VOICE_SPEAKER:
    case SND_DEVICE_OUT_SPEAKER_AND_HDMI:
    case SND_DEVICE_OUT_SPEAKER_AND_USB_HEADSET:
    case SND_DEVICE_OUT_SPEAKER_AND_ANC_HEADSET:
        speaker = 1;
        break;
    }
    return speaker;
}

static int is_voice_speaker(uint32_t snd_device)
{
    return snd_device == SND_DEVICE_OUT_VOICE_SPEAKER;
}

static int set_speaker_enabled(bool enable)
{
    enum mixer_ctl_type type;
    struct mixer_ctl *ctl;
    struct mixer *mixer = mixer_open(0);

    if (mixer == NULL) {
        ALOGE("%s: Error opening mixer 0'", __func__);
        return -1;
    }

    ctl = mixer_get_ctl_by_name(mixer, SPEAKER_CTL);
    if (ctl == NULL) {
        mixer_close(mixer);
        ALOGE("%s: Could not find %s\n", __func__, SPEAKER_CTL);
        return -ENODEV;
    }

    type = mixer_ctl_get_type(ctl);
    if (type != MIXER_CTL_TYPE_ENUM) {
        ALOGE("%s: %s is not supported\n", __func__, SPEAKER_CTL);
        mixer_close(mixer);
        return -ENOTTY;
    }

    ALOGD("%s: set speaker to %s\n", __func__, enable ? "UnMute" : "Mute");
    if (enable) {
        mixer_ctl_set_enum_by_string(ctl, "UnMute");
    } else {
        mixer_ctl_set_enum_by_string(ctl, "Mute");
    }

    mixer_close(mixer);
    return 0;
}

static int amp_enable_output_devices(__attribute__((unused)) amplifier_device_t *device, uint32_t devices, bool enable)
{
    if (is_speaker(devices))
    {
        set_speaker_enabled(enable);
    } else {
        set_speaker_enabled(false);
    }
    return 0;
}

static int amp_dev_close(hw_device_t *device)
{
    amp_device_t *amp_dev = (amp_device_t*) device;
    if (amp_dev) {
        free(amp_dev);
    }
    return 0;
}

static int amp_init(__attribute__((unused)) amp_device_t *device)
{
    return 0;
}

static int amp_module_open(const hw_module_t *module, __attribute__((unused)) const char *name, hw_device_t **device)
{
    if (amp_dev)
    {
        ALOGE("%s:%d: Unable to open second instance of amplifier\n", __func__, __LINE__);
        return -EBUSY;
    }
    amp_dev = (amp_device_t *)calloc(1, sizeof(amp_device_t));
    if (!amp_dev)
    {
        ALOGE("%s:%d: Unable to allocate memory for amplifier device\n", __func__, __LINE__);
        return -ENOMEM;
    }
    amp_dev->amp_dev.common.tag = HARDWARE_DEVICE_TAG;
    amp_dev->amp_dev.common.module = (hw_module_t *)module;
    amp_dev->amp_dev.common.version = HARDWARE_DEVICE_API_VERSION(1, 0);
    amp_dev->amp_dev.common.close = amp_dev_close;
    amp_dev->amp_dev.enable_output_devices = amp_enable_output_devices;

    *device = (hw_device_t *)amp_dev;
    return 0;
}

static struct hw_module_methods_t hal_module_methods = {
    .open = amp_module_open,
};

amplifier_module_t HAL_MODULE_INFO_SYM = {
    .common = {
        .tag = HARDWARE_MODULE_TAG,
        .module_api_version = AMPLIFIER_MODULE_API_VERSION_0_1,
        .hal_api_version = HARDWARE_HAL_API_VERSION,
        .id = AMPLIFIER_HARDWARE_MODULE_ID,
        .name = "ME audio amplifier HAL",
        .author = "The LineageOS Project",
        .methods = &hal_module_methods,
    },
};
