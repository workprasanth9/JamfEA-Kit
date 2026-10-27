#!/bin/bash
# EA-Name: Last User Login
# EA-DataType: String
# EA-Description: Most recent console or remote login, excluding reboot and shutdown records.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

user=$(/usr/bin/last 2>/dev/null | /usr/bin/awk '$1 !~ /^(reboot|shutdown|wtmp|_mbsetupuser|root)$/ && NF > 0 {print $1; exit}')
echo "<result>${user:-None}</result>"
