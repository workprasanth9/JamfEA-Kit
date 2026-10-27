#!/bin/bash
# EA-Name: CPU Architecture
# EA-DataType: String
# EA-Description: Apple Silicon or Intel, with the chip name.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

chip=$(/usr/sbin/sysctl -n machdep.cpu.brand_string 2>/dev/null)
if [ "$(/usr/bin/uname -m)" = "arm64" ]; then
  echo "<result>Apple Silicon (${chip:-arm64})</result>"
else
  echo "<result>Intel (${chip:-x86_64})</result>"
fi
