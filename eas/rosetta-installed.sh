#!/bin/bash
# EA-Name: Rosetta Installed
# EA-DataType: String
# EA-Description: Whether Rosetta 2 is installed. Intel Macs report Not Applicable.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

if [ "$(/usr/bin/uname -m)" != "arm64" ]; then
  echo "<result>Not Applicable</result>"
elif /usr/bin/pgrep -q oahd || [ -f /Library/Apple/usr/share/rosetta/rosetta ]; then
  echo "<result>Installed</result>"
else
  echo "<result>Not Installed</result>"
fi
