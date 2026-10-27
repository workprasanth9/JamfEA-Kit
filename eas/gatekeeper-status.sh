#!/bin/bash
# EA-Name: Gatekeeper Status
# EA-DataType: String
# EA-Description: Gatekeeper assessment state from spctl.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

out=$(/usr/sbin/spctl --status 2>/dev/null)
case "$out" in
  *"enabled"*) state="Enabled" ;;
  *"disabled"*) state="Disabled" ;;
  *) state="Unknown" ;;
esac
echo "<result>${state}</result>"
