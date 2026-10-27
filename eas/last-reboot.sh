#!/bin/bash
# EA-Name: Last Reboot
# EA-DataType: Date
# EA-Description: Date and time of the last boot in Jamf date format (YYYY-MM-DD hh:mm:ss).
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

boot=$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null | /usr/bin/awk -F'[ ,]' '{print $4}')
if [ -n "$boot" ]; then
  echo "<result>$(/bin/date -r "$boot" '+%Y-%m-%d %H:%M:%S')</result>"
else
  echo "<result></result>"
fi
