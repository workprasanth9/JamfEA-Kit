#!/bin/bash
# EA-Name: Uptime Days
# EA-DataType: Integer
# EA-Description: Whole days since the last boot. Handy for finding Macs that never restart.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

boot=$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null | /usr/bin/awk -F'[ ,]' '{print $4}')
now=$(/bin/date +%s)
if [ -n "$boot" ]; then
  echo "<result>$(( (now - boot) / 86400 ))</result>"
else
  echo "<result></result>"
fi
