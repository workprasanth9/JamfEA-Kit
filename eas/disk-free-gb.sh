#!/bin/bash
# EA-Name: Disk Free Space GB
# EA-DataType: Integer
# EA-Description: Free space in GB on the data volume.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

vol="/System/Volumes/Data"
[ -d "$vol" ] || vol="/"
free_kb=$(/bin/df -k "$vol" 2>/dev/null | /usr/bin/awk 'NR==2 {print $4}')
if [ -n "$free_kb" ]; then
  echo "<result>$(( free_kb / 1024 / 1024 ))</result>"
else
  echo "<result></result>"
fi
