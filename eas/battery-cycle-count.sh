#!/bin/bash
# EA-Name: Battery Cycle Count
# EA-DataType: Integer
# EA-Description: Battery cycle count reported by the AppleSmartBattery driver. Empty on Macs without a battery.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

cycles=$(/usr/sbin/ioreg -r -c AppleSmartBattery 2>/dev/null | /usr/bin/awk '/"CycleCount" =/ {print $3; exit}')
echo "<result>${cycles}</result>"
