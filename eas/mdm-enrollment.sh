#!/bin/bash
# EA-Name: MDM Enrollment
# EA-DataType: String
# EA-Description: MDM enrollment state, including whether enrollment was user approved or via DEP.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

out=$(/usr/bin/profiles status -type enrollment 2>/dev/null)
dep=$(echo "$out" | /usr/bin/awk -F': ' '/Enrolled via DEP/ {print $2; exit}')
mdm=$(echo "$out" | /usr/bin/awk -F': ' '/MDM enrollment/ {print $2; exit}')
if [ -z "$mdm" ]; then
  echo "<result>Unknown</result>"
else
  echo "<result>MDM: ${mdm}; DEP: ${dep:-No}</result>"
fi
