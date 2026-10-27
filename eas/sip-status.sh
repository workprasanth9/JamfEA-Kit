#!/bin/bash
# EA-Name: SIP Status
# EA-DataType: String
# EA-Description: System Integrity Protection state from csrutil.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

state=$(/usr/bin/csrutil status 2>/dev/null | /usr/bin/awk -F': ' '/System Integrity Protection status/ {print $2; exit}' | /usr/bin/sed -e 's/\.$//' -e 's/^e/E/' -e 's/^d/D/')
echo "<result>${state:-Unknown}</result>"
