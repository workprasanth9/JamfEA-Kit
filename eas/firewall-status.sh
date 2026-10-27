#!/bin/bash
# EA-Name: Firewall Status
# EA-DataType: String
# EA-Description: Application Firewall global state: Enabled, Disabled, or Block All.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

out=$(/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate 2>/dev/null)
case "$out" in
  *"enabled"*|*"State = 1"*) state="Enabled" ;;
  *"blocking"*|*"State = 2"*) state="Block All" ;;
  *"disabled"*|*"State = 0"*) state="Disabled" ;;
  *) state="Unknown" ;;
esac
echo "<result>${state}</result>"
