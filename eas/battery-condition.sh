#!/bin/bash
# EA-Name: Battery Condition
# EA-DataType: String
# EA-Description: Battery condition and maximum capacity from System Information, or No Battery.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

info=$(/usr/sbin/system_profiler SPPowerDataType 2>/dev/null)
condition=$(echo "$info" | /usr/bin/awk -F': ' '/Condition:/ {print $2; exit}')
capacity=$(echo "$info" | /usr/bin/awk -F': ' '/Maximum Capacity:/ {print $2; exit}')
if [ -z "$condition" ]; then
  echo "<result>No Battery</result>"
elif [ -n "$capacity" ]; then
  echo "<result>${condition} (${capacity})</result>"
else
  echo "<result>${condition}</result>"
fi
