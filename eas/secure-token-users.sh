#!/bin/bash
# EA-Name: Secure Token Users
# EA-DataType: String
# EA-Description: Local accounts (UID 500 and up) that hold a Secure Token.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

users=""
for u in $(/usr/bin/dscl . -list /Users UniqueID | /usr/bin/awk '$2 >= 500 {print $1}'); do
  if /usr/sbin/sysadminctl -secureTokenStatus "$u" 2>&1 | /usr/bin/grep -q "ENABLED"; then
    users="${users:+$users, }$u"
  fi
done
echo "<result>${users:-None}</result>"
