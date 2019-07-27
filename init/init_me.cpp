/*
   Copyright (c) 2015, The CyanogenMod Project

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <android-base/properties.h>

#include "property_service.h"
#include "vendor_init.h"

using android::base::GetProperty;
using android::init::property_set;

/*
 * Add by Harry for save mach type
 */
#define MACH_TYPE_PROP "ro.android.machtype"

enum MACH_TYPE
{
  MACH_TYPE_NONE = 0,
  MACH_TYPE_P17421,
  MACH_TYPE_P17427,
  /* Add other mach type here */
  MACH_TYPE_MAX,
};

/**
 * Read in from the command line the property android.version and set the new properties 
 * android.hardware.version
 * android.project.id
 */
void init_hardware_version(void)
{
  int cur_mach_type = 0;

  char cmdline[2048];
  /*char *ptr;*/
  int fd;

  fd = open("/proc/cmdline", O_RDONLY);
  if (fd >= 0)
  {
    int n = read(fd, cmdline, sizeof(cmdline) - 1);
    if (n < 0)
      n = 0;

    if (n > 0 && cmdline[n - 1] == '\n')
      n--;

    cmdline[n] = 0;
    close(fd);
  }
  else
  {
    cmdline[0] = 0;
  }

  if (strstr(cmdline, "android.version=02"))
  { /* 17421 */
    property_set("android.hardware.version", "02");
    property_set("android.project.id", "17421");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else if (strstr(cmdline, "android.version=03"))
  {
    property_set("android.hardware.version", "03");
    property_set("android.project.id", "17421");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else if (strstr(cmdline, "android.version=04"))
  {
    property_set("android.hardware.version", "04");
    property_set("android.project.id", "17421");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else if (strstr(cmdline, "android.version=05"))
  {
    property_set("android.hardware.version", "05");
    property_set("android.project.id", "17421");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else if (strstr(cmdline, "android.version=06"))
  {
    property_set("android.hardware.version", "06");
    property_set("android.project.id", "17421");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else if (strstr(cmdline, "android.version=17"))
  { /* 17427 */
    property_set("android.hardware.version", "17");
    property_set("android.project.id", "17427");
    cur_mach_type = MACH_TYPE_P17427;
  }
  else if (strstr(cmdline, "android.version=18"))
  {
    property_set("android.hardware.version", "18");
    property_set("android.project.id", "17427");
    cur_mach_type = MACH_TYPE_P17427;
  }
  else if (strstr(cmdline, "android.version=19"))
  {
    property_set("android.hardware.version", "19");
    property_set("android.project.id", "17427");
    cur_mach_type = MACH_TYPE_P17427;
  }
  else if (strstr(cmdline, "android.version=20"))
  {
    property_set("android.hardware.version", "20");
    property_set("android.project.id", "17427");
    cur_mach_type = MACH_TYPE_P17427;
  }
  else if (strstr(cmdline, "android.version=21"))
  {
    property_set("android.hardware.version", "21");
    property_set("android.project.id", "17427");
    cur_mach_type = MACH_TYPE_P17427;
  }
  else if (strstr(cmdline, "android.version=33"))
  { /* Sloan L */
    property_set("android.hardware.version", "33");
    property_set("android.project.id", "SloanL");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else if (strstr(cmdline, "android.version=34"))
  {
    property_set("android.hardware.version", "34");
    property_set("android.project.id", "SloanL");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else if (strstr(cmdline, "android.version=35"))
  {
    property_set("android.hardware.version", "35");
    property_set("android.project.id", "SloanL");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else if (strstr(cmdline, "android.version=36"))
  {
    property_set("android.hardware.version", "36");
    property_set("android.project.id", "SloanL");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else if (strstr(cmdline, "android.version=37"))
  {
    property_set("android.hardware.version", "37");
    property_set("android.project.id", "SloanL");
    cur_mach_type = MACH_TYPE_P17421;
  }
  else
  {
    property_set("android.hardware.version", "00");
    property_set("android.project.id", "17421"); /* Default value */
    cur_mach_type = MACH_TYPE_P17421;
  }

  switch (cur_mach_type)
  {
  case MACH_TYPE_P17421:
    property_set(MACH_TYPE_PROP, "P17421");
    break;
  case MACH_TYPE_P17427:
    property_set(MACH_TYPE_PROP, "P17427");
    break;
  default:
    property_set(MACH_TYPE_PROP, "UnKnow");
    break;
  }
}

void init_variant_properties()
{
  std::string platform;

  platform = GetProperty("ro.board.platform", "");
  if (platform != ANDROID_TARGET)
    return;

  init_hardware_version();

  std::string device = GetProperty("ro.lineage.device", "");
  if (device == "me") {
    property_set("ro.product.model", "GS56-6");
  }

  if (device == "mepro") {
    property_set("ro.product.model", "GS57-6");
  }
}

void vendor_load_properties()
{
  init_variant_properties();
}
