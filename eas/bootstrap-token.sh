#!/bin/bash
# EA-Name: Bootstrap Token
# EA-DataType: String
# EA-Description: Whether a Bootstrap Token is supported and escrowed to MDM. Needs root, which Jamf provides.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

if [ "$(/usr/bin/id -u)" -ne 0 ]; then
  echo "<result>Requires root</result>"
  exit 0
fi
out=$(/usr/bin/profiles status -type bootstraptoken 2>/dev/null)
if echo "$out" | /usr/bin/grep -q "escrowed to server: YES"; then
  echo "<result>Escrowed</result>"
elif echo "$out" | /usr/bin/grep -q "supported on server: YES"; then
  echo "<result>Supported, Not Escrowed</result>"
elif [ -n "$out" ]; then
  echo "<result>Not Supported</result>"
else
  echo "<result>Unknown</result>"
fi
